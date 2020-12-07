// pages/teams/teams.js
const app = getApp();
const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
const util = require('../../utils/util.js');
var down; //倒计时
Page({

  /**
   * 页面的初始数据
   */
  data: {
    options: [], //上个页面带过来的参数
    datas: [], //拼团列表内容
    navbar: ['拼团列表', '我的拼团'], //底部分类栏
    address: [], //收货地址列表
    rulePage: false, //规则
    bargain_id: 0,
    currentTab: 0,
    showModalStatus: false,
    hiddenmodalput: true,
    YorN: '',
    page: 1, //当前显示的页面
    hasNextPage: true, //是否还有下一页
    g_order_id: 0, //继续支付的订单g_order_id
    order_num: '', //订单编号
    payment_current:'',
    currentIndex:'',
    list:[]
  },
  navbarTap: function(e) {
    this.setData({
      currentTab: e.currentTarget.dataset.idx
    })
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
    let currentTab;
    if (JSON.stringify(options) !== "{}" && options.currentTab){
      currentTab = options.currentTab
    }else{
      currentTab = 0;
    }
    this.setData({
      options: options,
      currentTab: currentTab,
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1
    });
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  // 查看规则
  rule: function() {
    this.setData({
      rulePage: true,
      YorN: 'hidden',
    })
  },
  // 关闭规则
  know: function() {
    var that = this
    setTimeout(function() {
      that.setData({
        rulePage: false,
        YorN: '',
      })
    }, 100)
  },
  //去拼团
  go_Collage: function(e) {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        var productId = e.currentTarget.dataset.id;
        var groupon_id = e.currentTarget.dataset.groupon_id;
        wx.navigateTo({
          url: '../Collage/Collage?shop_id=' + productId + '&groupon_id=' + groupon_id,
        })
      }
    })
  },
  // 继续付款
  payment: function(e) {
    // 显示遮罩层
    getApp().showModal(this);
    this.setData({
      g_order_id: e.currentTarget.dataset.g_order_id,
      order_num: e.currentTarget.dataset.order_num,
      payment_current: e.currentTarget.dataset.paymenttype,
      currentIndex: e.currentTarget.dataset.index
    });
  },
  // 取消付款
  hide: function() {
    getApp().hideModal(this)
  },
  // 支付方式
  getValue: function(e) {
    let log = "list[" + this.data.currentIndex + "].payment_type";
    if (e.detail.value == 'wechat') {
      this.setData({
        payment_current: 0,
        [log]: 0
      })
    };
    if (e.detail.value == 'balance') {
      this.setData({
        payment_current: 1,
        [log]: 1
      })
    }
  },
  // 确定支付方式
  confirmBtn: function() {
    getApp().hideModal(this);
    var that = this;
    // 微信支付
    if (that.data.payment_current == 0) {
      requ.request({
        url: api.api.grouponOrderPay,
        data: {
          g_order_id: that.data.g_order_id,
          order_num: that.data.order_num,
          payment_type: 0
        },
        success: (res) => {
          wx.requestPayment({
            timeStamp: res.data.timeStamp,
            nonceStr: res.data.nonceStr,
            package: res.data.packageValue,
            signType: res.data.signType,
            paySign: res.data.paySign,
            success: () => {
              wx.navigateTo({
                url: '../invite/invite?g_order_id=' + that.data.g_order_id,
              })
            }
          })
        }
      })
    }
    // 余额支付
    if (that.data.payment_current == 1) {
      wx.showModal({
        title: '',
        content: '是否使用余额支付',
        success: function(res) {
          if (res.confirm) {
            requ.request({
              url: api.api.grouponOrderPay,
              data: {
                g_order_id: that.data.g_order_id,
                order_num: that.data.order_num,
                payment_type: 1
              },
              success: (res) => {
                if (res.code == 0) {
                  wx.navigateTo({
                    url: '../invite/invite?g_order_id=' + that.data.g_order_id,
                  })
                } else {
                  wx.showToast({
                    title: res.message,
                    icon: 'none'
                  })
                }

              }
            })
          } else {
            wx.showToast({
              title: '您取消了本次支付!'
            })
          }
        }
      })
    }
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function() {
    if (wx.getStorageSync('token') != '') {
      var that = this;
      // 拼团列表
      requ.request({
        url: api.api.getShopAllGroupon,
        data: {
          page: that.data.page
        },
        success: function(res) {
          console.log(res);
          that.setData({
            datas: res.data.list,
            // value: that.data.options.value,
            hasNextPage: res.data.hasNextPage
          })
        }
      });
      // 我的拼团列表
      requ.request({
        url: api.api.getMyGroupon,
        success: function(res) {
          let list = res.data.list;
          list.forEach((item) => {
            item.payment_type = 0;
          })
          if (res.data != "" && res.data.list != "") {
            down = setInterval(time, 1000);
            
            function time() {
              for (var i = 0; i < list.length; i++) {
                list[i].hour = util.timeHour(res.data.list[i].end_time - new Date().getTime());
                list[i].minute = util.timeMinute(res.data.list[i].end_time - new Date().getTime());
                list[i].secondr = util.timeSecondr(res.data.list[i].end_time - new Date().getTime());
                
              }
              that.setData({
                list: list,
              })
            }
          }
        }
      });
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
  },
  // 再拼一次
  again: function(e) {
    var groupon_id = e.currentTarget.dataset.groupon_id;
    var product_id = e.currentTarget.dataset.product_id;
    wx.navigateTo({
      url: '../Collage/Collage?shop_id=' + product_id + '&groupon_id=' + groupon_id,
    })
  },
  // 继续拼团
  continues: function(e) {
    var g_order_id = e.currentTarget.dataset.g_order_id
    wx.navigateTo({
      url: '../invite/invite?g_order_id=' + g_order_id,
    })
  },
  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function() {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function() {
    clearInterval(down)
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function() {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function() {
    if (this.data.hasNextPage) {
      var that = this;
      that.setData({
        page: that.data.page + 1
      });
      //拼团列表
      requ.request({
        url: api.api.getShopAllGroupon,
        data: {
          page: that.data.page
        },
        success: function(res) {
          that.setData({
            datas: that.data.datas.concat(res.data.list),
            // value: that.data.value,
            hasNextPage: res.data.hasNextPage
          })
        }
      });
      // 我的拼团列表
      requ.request({
        url: api.api.getMyGroupon,
        success: function(res) {
          if (res.data != "" && res.data.list != "") {
            setInterval(function() {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].hour = util.timeHour(res.data.list[i].end_time - new Date().getTime());
                res.data.list[i].minute = util.timeMinute(res.data.list[i].end_time - new Date().getTime());
                res.data.list[i].secondr = util.timeSecondr(res.data.list[i].end_time - new Date().getTime());
              }
              that.setData({
                datas: that.data.datas.concat(res.data.list),
              })
            }, 1000)
          }
        }
      });
    }
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function() {
    return {
      title: '蜗店',
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  }
})
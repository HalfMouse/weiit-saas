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
    navbar: ['砍价列表', '我的砍价'], //底部分类栏
    address: [], //收货地址列表
    rulePage: false, //规则
    bargain_id: 0,
    currentTab: 0,
    showModalStatus: false,
    hiddenmodalput: true,
    YorN: '',
    value: 'cut', //是砍价或者拼团
    page: 1, //当前显示的页面
    hasNextPage: true, //是否还有下一页
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
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    let currentTab;
    if(options.currentTab){
      currentTab = parseFloat(options.currentTab);
    }else{
      currentTab = 0;
    }
    console.log(currentTab);
    this.setData({
      options: options,
      currentTab: currentTab,
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1
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
  // 去砍价
  go_cut: function(e) {
    this.setData({
      bargain_id: e.currentTarget.dataset.id,
    })
    var index = e.currentTarget.dataset.index;
    var that = this;
    console.log(that.data.datas[index].b_order_id, '77777')
    if (that.data.datas[index].b_order_id == null) {
      app.showModal(this);
      requ.request({
        url: api.api.myAddressList,
        success: function(res) {
          that.setData({
            address: res.data.list,
          })
        }
      });
    } else {
      // 页面跳转拦截
      requ.verify(function(code) {
        if (code == 0) {
          wx.navigateTo({
            url: '../chopPage/chopPage?bargain_id=' + e.currentTarget.dataset.id + '&b_order_id=' + that.data.datas[index].b_order_id,
          })
        }
      })
    }
  },
  // 选择收货地址
  choice: function(e) {
    var index = e.currentTarget.dataset.index;
    var address = this.data.address[index];
    console.log(this.data.bargain_id)
    app.hideModal(this);
    var that = this;
    that.setData({
      hiddenmodalput: false,
      addres: address
    })
  },
  // 取消选择地址
  close: function() {
    app.hideModal(this);
  },

  //确认收货地址
  confirmM: function() {
    var that = this;
    that.setData({
      hiddenmodalput: true
    })
    requ.request({
      url: api.api.bargainOrder,
      data: {
        bargain_id: that.data.bargain_id,
        address_id: that.data.addres.id
      },
      success: function(res) {
        // 页面跳转拦截
        requ.verify(function(code) {
          if (code == 0) {
            wx.navigateTo({
              url: '../chopPage/chopPage?b_order_id=' + res.data.b_order_id + '&bargain_id=' + that.data.bargain_id
            })
          }
        })
      }
    })
  },
  // 取消确认收货地址
  cancelM: function() {
    this.setData({
      hiddenmodalput: true
    })
  },
  // 填写收件人信息
  address: function () {
    // 页面跳转拦截
    let that = this;
    requ.verify(function (code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../address/address?value=helpMe&bargain_id=' + that.data.bargain_id,
        })
      }
    })
  },

  // 我发起的、我参与的
  btn_me: function(e) {

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
    var that = this;
    if (wx.getStorageSync('token') != '') {
      // 设置页面标题
      wx.setNavigationBarTitle({
        title: '砍价'
      });
      // 砍价列表
      requ.request({
        url: api.api.selectBargainList,
        data: {
          page: that.data.page
        },
        success: function(res) {
          console.log(res, '55')
          that.setData({
            datas: res.data.list,
            value: that.data.options.value,
            hasNextPage: res.data.hasNextPage
          })
        }
      });
      // 我的砍价列表
      requ.request({
        url: api.api.userBargain,
        success: function(res) {
          console.log(res, '我的砍价列表')
          if (res.data != "" && res.data.list != "") {
            down = setInterval(time, 1000);

            function time() {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].hour = util.timeHour(res.data.list[i].end_time - new Date().getTime());
                res.data.list[i].minute = util.timeMinute(res.data.list[i].end_time - new Date().getTime());
                res.data.list[i].secondr = util.timeSecondr(res.data.list[i].end_time - new Date().getTime());
              }
              that.setData({
                list: res.data.list,
              })
            }
          }
        }
      });
      // 轮播公告列表
      requ.request({
        url: api.api.bargainMessage,
        success: function(res) {
          that.setData({
            noticeList: res.data
          })
        }
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
  },
  speed: function(e) {
    var b_order_id = e.currentTarget.dataset.b_order_id;
    var bargain_id = e.currentTarget.dataset.bargain_id;
    var state = e.currentTarget.dataset.state;
    if (state == 0) {
      wx.navigateTo({
        url: '../chopPage/chopPage?b_order_id=' + b_order_id + '&bargain_id=' + bargain_id,
      })
    }
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
      // 砍价列表
      requ.request({
        url: api.api.selectBargainList,
        data: {
          page: that.data.page
        },
        success: function(res) {
          console.log(res)
          that.setData({
            datas: that.data.datas.concat(res.data.list),
            value: that.data.value,
            hasNextPage: res.data.hasNextPage
          })
        }
      });
      // 我的砍价列表
      requ.request({
        url: api.api.userBargain,
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
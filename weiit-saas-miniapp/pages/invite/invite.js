const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
const util = require('../../utils/util.js')
const app = getApp()
var down; //倒计时
// pages/invite/invite.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    options: [], //上个页面传的参数
    resultCon: [], //拼团成功数据
    product_id: [], //
    userNum: 0, //拼团需要人数
    buy_num: 1, //初始购买数量
    Stock: 1, //库存数量
    is_choice: [], //
    commodity: [],
    userImg: [], //已经参与拼团用户头像
    load: false, //数据加载完才会显示页面
    Price: 0, //拼团价格
    rulePage:false
  },
  // 底部导航页面跳转
  goPage: function(e) {
    var url = e.currentTarget.dataset.url;
    var target_id = e.currentTarget.dataset.target_id;
    requ.go_page(url, target_id);
  },
  // 查看规则
  rule: function () {
    this.setData({
      rulePage: true,
      YorN: 'hidden',
    })
  },
  // 关闭规则
  know: function () {
    var that = this
    setTimeout(function () {
      that.setData({
        rulePage: false,
        YorN: '',
      })
    }, 100)
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    console.log(options, 'total options');
    if (options.share_user_id) {
      wx.setStorageSync('shareId', options.share_user_id);
    }
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    this.setData({
      options: options,
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
      // content: JSON.parse(options.car_content)
    });
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
    this.setData({
      bottomMenuList: wx.getStorageSync('bottomMenuList'),
      btnColor: wx.getStorageSync('btnColor')
    })
    var that = this;
    if (wx.getStorageSync('token') != '') {
      wx.showLoading({
        title: '加载中',
      })
      requ.request({
        url: api.api.grouponSuccessPage,
        data: {
          g_order_id: that.data.options.g_order_id
        },
        success: function(res) {
          if (res.code == '0') {
            console.log(res);
            that.setData({
              load: true,
              product_id: res.data.productInfo.product_id
            });
            wx.hideLoading();
            if (res.data.headImgList[0].item_id) {
              that.setData({
                ['commodity.item_id']: res.data.headImgList[0].item_id
              })
            }
            if (res.data.productInfo.groupon_number > 10) {
              that.setData({
                resultCon: res.data,
                imgNum: 9 - res.data.headImgList.length,
                more: true,
                times: util.Time(res.data.productInfo.end_time - new Date().getTime()),
                userNum: res.data.productInfo.groupon_number - res.data.headImgList.length
              })
            } else {
              that.setData({
                resultCon: res.data,
                imgNum: res.data.productInfo.groupon_number - res.data.headImgList.length,
                more: false,
                times: util.Time(res.data.productInfo.end_time - new Date().getTime()),
                userNum: res.data.productInfo.groupon_number - res.data.headImgList.length
              })
            }
            if (that.data.userNum > 0) {
              down = setInterval(time, 1000);
            }

            function time() {
              that.setData({
                times: util.Time(res.data.productInfo.end_time - new Date().getTime())
              })
            }
          } else if (res.code == '1001002') {
            wx.hideLoading();
            wx.request({
              url: app.urls + '/api/maLogin',
              method: 'POST',
              header: {
                'content-type': 'application/x-www-form-urlencoded'
              },
              data: {
                appid: app.appid,
                sessionKey: app.globaLogin.sessionKey,
                encryptedData: wx.getStorageSync('encryptedData'),
                ivStr: wx.getStorageSync('iv'),
                wx_open_id: app.globaLogin.openid
              },
              success: res => {
                wx.setStorageSync('token', res.data.data.token);
                wx.setStorageSync('user_id', res.data.data.user_id);
                that.onShow();
              }
            })
          }
        }
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
  },
  hide: function() {
    getApp().hideModal(this);
    // 隐藏遮罩层
  },

  //选择尺码
  size: function(e) {
    var attr_index = e.currentTarget.dataset.index;
    var attr_value = e.currentTarget.dataset.value;
    var attr_id = e.currentTarget.dataset.id
    var row;
    var flag = true;
    for (var i = 0; i < this.data.information.spec_info.length; i++) {
      for (var j = 0; j < this.data.information.spec_info[i].values.length; j++) {
        if (this.data.information.spec_info[i].values[j].spec_value == attr_value) {
          row = i;
          break;
        }
      }
    }
    this.get_null(row)
    var str = 'information.spec_info[' + row + '].values[' + attr_index + '].Choice';
    this.setData({
      [str]: true
    })
    var flag = this.checkSize()
    if (flag) {
      var is_choice = [];
      var spe_content = [];
      for (var m = 0; m < this.data.information.spec_info.length; m++) {
        for (var u = 0; u < this.data.information.spec_info[m].values.length; u++) {
          if (this.data.information.spec_info[m].values[u].Choice == true) {
            is_choice.push(this.data.information.spec_info[m].values[u].spec_value_id);
            spe_content.push(this.data.information.spec_info[m].values[u].spec_value)
          }
        }
      }
    };
    this.setData({
      is_choice: is_choice,
      buy_num: this.data.buy_num
    })
    var that = this;
    requ.request({
      url: api.api.grouponProductSpecCheck,
      data: {
        product_id: that.data.product_id,
        spec_custom: is_choice.join(';')
      },
      success: function(res) {
        that.setData({
          commodity: res.data,
          Stock: res.data.stock,
          Price: res.data.groupon_price,
          spe_con: spe_content
        })
      }
    });
  },
  get_null: function(row) {
    for (var i = 0; i < this.data.information.spec_info[row].values.length; i++) {
      var nulls = 'information.spec_info[' + row + '].values[' + i + '].Choice';
      this.setData({
        [nulls]: false
      })
    }
  },
  checkSize: function() {
    //如果返回true。那么说明都选中
    let flag = true;
    for (let i of this.data.information.spec_info) {
      let item = i;
      let arr = item.values;
      let index = arr.findIndex((ele) => {
        return ele.Choice
      })
      if (index <= -1) {
        flag = false;
        break;
      }
    }
    return flag;
  },
  //增加购买数量
  add_num: function() {
    if (this.data.buy_num < this.data.Stock) {
      this.setData({
        buy_num: this.data.buy_num + 1
      })
    } else {
      wx.showToast({
        title: '最多选择' + this.data.buy_num + '件商品',
        icon: 'none',
        duration: 1000
      })
    }
  },
  //减少购买数量
  reduce_num: function() {
    if (this.data.buy_num > 1) {
      this.setData({
        buy_num: this.data.buy_num - 1
      })
    } else {
      wx.showToast({
        title: '最少选择1件商品',
        icon: 'none',
        duration: 1000
      })
    }
  },
  // 参加拼团
  join: function() {
    if (wx.getStorageSync('token') != '') {
      var that = this;
      requ.request({
        url: api.api.grouponProduct,
        data: {
          product_id: that.data.resultCon.productInfo.product_id,
          groupon_id: that.data.resultCon.headImgList[0].groupon_id,
          user_id: wx.getStorageSync('user_id')
        },
        success: function(res) {
          that.setData({
            information: res.data.productDetail.product_info, //商品详情内容
            Stock: res.data.productDetail.product_info.stock, //商品库存
            Price: res.data.extInfo.groupon_price, //商品价格
          });
        }
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
    getApp().showModal(this);
  },
  // 确定
  confirm: function() {
    getApp().hideModal(this);
    var that = this;
    var data = {
      g_order_id: that.data.options.g_order_id,
      product_id: parseInt(that.data.resultCon.productInfo.product_id),
      groupon_id: parseInt(that.data.resultCon.headImgList[0].groupon_id),
      item_id: that.data.commodity.item_id,
      spec_content: that.data.is_choice.join(';'),
      count: that.data.buy_num,
      title: that.data.information.product_name,
      img: that.data.information.product_img,
      // sale_price: that.data.Price * that.data.buy_num,
      sale_price: that.data.Price,
      value: '参加拼团'
    };
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../cutCar/cutCar?data=' + JSON.stringify(data),
        })
      }
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

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function() {
    var that = this;
    return {
      title: this.data.resultCon.productInfo.product_name,
      path: '/pages/invite/invite?g_order_id=' + that.data.options.g_order_id + '&share_user_id=' + wx.getStorageSync('user_id'),
      success: (res) => {
        console.log(res)
      },
      fail: (res) => {
        console.log(res)
      }
    }
  }
})
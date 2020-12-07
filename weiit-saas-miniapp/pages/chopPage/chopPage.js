// pages/chopPage/chopPage.js
const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
const util = require('../../utils/util.js')
const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    cloce: true,
    rulePage: false,
    payment_type: 0, //支付方式
    options: [], //上个页面带过来的数据
    YorN: '', //页面是否可以滚动
    load: false, //数据加载完显示页面
    payment_method: [{
      is_radio: true,
      imgs: '../../images/wechat.png',
      name: '微信支付',
      title: '推荐安装微信的用户使用'
    }, {
      is_radio: false,
      imgs: '../../images/balance.png',
      name: '余额支付',
      title: '请确保自己账户余额充足'
    }], //支付方式
  },
  // 底部导航页面跳转
  goPage: function(e) {
    var url = e.currentTarget.dataset.url;
    var target_id = e.currentTarget.dataset.target_id;
    requ.go_page(url, target_id);
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
    this.setData({
      options: options,
    });
    if (this.data.options.b_order_id == undefined) {
      this.setData({
        ['options.b_order_id']: ''
      })
    };
    if (this.data.options.bargain_id == undefined) {
      this.setData({
        ['options.bargain_id']: ''
      })
    }
  },
  // 查看规则
  rule: function() {
    this.setData({
      rulePage: true,
      YorN: 'hidden'
    })
  },
  // 关闭规则
  know: function() {
    var that = this
    setTimeout(function() {
      that.setData({
        rulePage: false,
        YorN: ''
      })
    }, 100)
  },
  // 立即购买
  purchase: function() {
    getApp().showModal(this);
  },
  // 取消购买
  hide: function() {
    getApp().hideModal(this)
  },
  // 支付方式
  getValue: function(e) {
    console.log(e.detail.value)
    if (e.detail.value == 'wechat') {
      this.setData({
        payment_type: 0
      })
    };
    if (e.detail.value == 'balance') {
      this.setData({
        payment_type: 1
      })
    }
  },
  // 支付方式
  getValue: function(e) {
    var index = e.currentTarget.dataset.index;
    var is_radio = 'payment_method[' + index + '].is_radio';
    for (var i = 0; i < this.data.payment_method.length; i++) {
      this.data.payment_method[i].is_radio = false;
    }
    this.setData({
      payment_method: this.data.payment_method,
      [is_radio]: true,
      payment_type: index
    })
  },
  // 确定购买
  confirm: function() {
    getApp().hideModal(this);
    var that = this;
    requ.request({
      url: api.api.bargainPage,
      data: {
        b_order_id: that.data.options.b_order_id,
        bargain_id: that.data.options.bargain_id
      },
      success: function(res) {
        var pay_price = Number(res.data.owe)
        // 微信支付
        if (that.data.payment_type == 0) {
          // console.log(res.data.owe)
          wx.showModal({
            title: '',
            content: '是否使用微信支付',
            success: (res) => {
              if (res.confirm) {
                requ.request({
                  url: api.api.bargainPay,
                  data: {
                    payment_type: that.data.payment_type,
                    b_order_id: that.data.options.b_order_id,
                    pay_price: ((pay_price * 100) + (that.data.cutCon.expressPrice * 100)) / 100
                  },
                  success: (res) => {
                    wx.hideLoading();
                    wx.requestPayment({
                      timeStamp: res.data.timeStamp,
                      nonceStr: res.data.nonceStr,
                      package: res.data.packageValue,
                      signType: res.data.signType,
                      paySign: res.data.paySign,
                      success: function() {
                        wx.navigateTo({
                          url: '../buySuccess/buySuccess?payment_type=' + that.data.payment_type + '&pay_price=' + +(((pay_price * 100) + (that.data.cutCon.expressPrice * 100)) / 100),
                        })
                      },
                      fail: () => {
                        wx.navigateBack({})
                      }
                    })
                  },
                })
              } else {
                wx.showToast({
                  title: '您取消了支付',
                  icon: 'none'
                })
              }
            }
          })
        }
        // 余额支付
        if (that.data.payment_type == 1) {
          wx.showModal({
            title: '',
            content: '是否使用余额支付',
            success: (res) => {
              if (res.confirm) {
                requ.request({
                  url: api.api.bargainPay,
                  data: {
                    payment_type: that.data.payment_type,
                    b_order_id: that.data.options.b_order_id,
                    pay_price: ((pay_price * 100) + (that.data.cutCon.expressPrice * 100)) / 100
                  },
                  success: () => {
                    wx.navigateTo({
                      url: '../buySuccess/buySuccess?payment_type=' + that.data.payment_type + '&pay_price=' + +(((pay_price * 100) + (that.data.cutCon.expressPrice * 100)) / 100),
                    })
                  }
                })
              } else {
                wx.showToast({
                  title: '您取消了支付',
                  icon: 'none'
                })
              }
            }
          })
        }
      }
    });
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {

  },
  // 帮忙砍价
  cut: function() {
    console.log(this.data.cutCon.hasBargain)
    if (this.data.cutCon.hasBargain == false) {
      var that = this;
      wx.request({
        url: getApp().urls + '/api/bargain/helpBargain',
        method: 'POST',
        header: {
          'content-type': 'application/x-www-form-urlencoded',
          'token': wx.getStorageSync('token')
        },
        data: {
          b_order_id: that.data.options.b_order_id,
          share_user_id: that.data.options.share_user_id
        },
        success: function(res) {
          console.log(res, '这是砍价后的数据');
          console.log(that.data.options.b_order_id, '111')
          console.log(that.data.options.share_user_id, '222')
          that.onShow();
          wx.showToast({
            title: '砍价成功',
            icon: 'none'
          })
        }
      })
    } else {
      wx.showToast({
        title: '您已经砍过了哦',
        icon: 'none'
      })
    }
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function() {
    if (wx.getStorageSync('token') != '') {
      var that = this;
      wx.showLoading({
        title: '加载中'
      })
      requ.request({
        url: api.api.bargainPage,
        data: {
          b_order_id: that.data.options.b_order_id,
          bargain_id: that.data.options.bargain_id
        },
        success: function(res) {
          console.log(res, '成功请求code')
          if (res.code == '0') {
            wx.hideLoading();
            var downTime = util.Time(res.data.bargainProduct.end_time - new Date().getTime());
            that.setData({
              load: true,
              cutCon: res.data,
              downTime: downTime,
              bottomMenuList: wx.getStorageSync('bottomMenuList'),
              btnColor: wx.getStorageSync('btnColor')
            })
            setInterval(function() {
              var downTime = util.Time(res.data.bargainProduct.end_time - new Date().getTime());
              that.setData({
                downTime: downTime
              })
            }, 1000);
            wx.setNavigationBarColor({
              frontColor: '#ffffff',
              backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
            })
          } else if (res.code = '1001002') {
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
                console.log(res, '二次请求token')
                wx.setStorageSync('token', res.data.data.token);
                wx.setStorageSync('user_id', res.data.data.user_id);
                that.onShow();
              }
            })
          }

        }
      });
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
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
    return {
      title: this.data.cutCon.bargainProduct.product_name,
      path: '/pages/chopPage/chopPage?b_order_id=' + this.data.options.b_order_id + '&share_user_id=' + wx.getStorageSync('user_id') + '&type=' + 'share' + '&bargain_id=' + this.data.options.bargain_id,
      success: (res) => {
        console.log(res)
      },
      fail: (res) => {
        console.log(res)
      }
    };
  },
  close: function() {
    this.setData({
      cloce: false
    })
  },
})
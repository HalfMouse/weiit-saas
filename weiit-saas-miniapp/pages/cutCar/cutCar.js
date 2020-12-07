const requ = require('../../utils/request.js');
const api = require('../../utils/api.js')
// pages/shopCar/shopCar.js
var app = getApp();
const util = require('../../utils/util.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    options: [], //上个页面传的数据
    car_content: [],
    buy_num: 1, //商品数量
    activeIndex: 0,
    coupon: [],
    option: true,
    Delivery_mode: ['送货上门', '货到付款', '上门自提'],
    give_value: '送货上门',
    choice_arr: [], //选中商品ID数组
    sum: 1, //选中商品的总额
    couponId: 0, //选中的优惠券的ID
    get_input: '', //买家留言
    item: [],
    selAddress: [],
    address: [], //地址列表
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
    payment_type: 0, //支付方式
    defaultAdd: [], //选中的收货地址信息
    freight: 0, //初始运费
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
    console.log(options, '拼团')
    this.setData({
      options: options,
      bottomMenuList: wx.getStorageSync('bottomMenuList'),
      btnColor: wx.getStorageSync('btnColor')
    });
    if (wx.getStorageSync('token') != '') {
      var that = this;
      requ.request({
        url: api.api.myAddressList,
        success: function(res) {
          console.log(res, '拼团支付')
          var defaultAdd = '';
          for (var i = 0; i < res.data.list.length; i++) {
            if (res.data.list[i].is_default == 0) {
              defaultAdd = res.data.list[i];
            }
          }
          that.setData({
            defaultAdd: defaultAdd,
            car_content: JSON.parse(that.data.options.data)
          });
          // 计算运费
          requ.request({
            url: api.api.calcExpressPriceForActivity,
            data: {
              product_id: that.data.car_content.product_id,
              count: that.data.car_content.count,
              address_id: that.data.defaultAdd.id
            },
            success: (res) => {
              that.setData({
                freight: res.data.expressPrice
              })
            }
          })
        }
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
  },


  //增加购买数量
  add_num: function(e) {
    if (this.data.car_content.count < 99) {
      var count = this.data.car_content.count + 1;
      this.setData({
        ['car_content.count']: count
      })
      var that = this;
      requ.request({
        url: api.api.calcExpressPriceForActivity,
        data: {
          product_id: that.data.car_content.product_id,
          count: that.data.car_content.count,
          address_id: that.data.defaultAdd.id
        },
        success: (res) => {
          that.setData({
            freight: res.data.expressPrice
          })
        }
      })
    } else {
      wx.showToast({
        title: '本次最多选择' + this.data.buy_num + '件商品',
        icon: 'none',
        duration: 1000
      })
    }
  },
  //减少购买数量
  reduce_num: function() {
    if (this.data.car_content.count > 1) {
      var count = this.data.car_content.count - 1;
      this.setData({
        ['car_content.count']: count
      });
      var that = this;
      requ.request({
        url: api.api.calcExpressPriceForActivity,
        data: {
          product_id: that.data.car_content.product_id,
          count: that.data.car_content.count,
          address_id: that.data.defaultAdd.id
        },
        success: (res) => {
          that.setData({
            freight: res.data.expressPrice
          })
        }
      })
    } else {
      wx.showToast({
        title: '最少选择1件商品',
        icon: 'none',
        duration: 1000
      })
    }
  },


  // 填写收件人信息
  address: function() {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../address/address?pages=' + 'add',
        })
      }
    })
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
  // 提交订单
  sub_order: function() {
    var that = this;
    var sub = JSON.parse(this.options.data);
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        if (that.data.defaultAdd.id) {
          if (that.data.car_content.value == '发起拼团') {
            if (that.data.payment_type == 1) {
              wx.showModal({
                title: '',
                content: '是否使用余额支付',
                success: (res) => {
                  if (res.confirm) {
                    wx.showLoading({
                      title: '支付中...',
                    });
                    requ.request({
                      url: api.api.startGroupon,
                      data: {
                        groupon_id: that.data.car_content.groupon_id,
                        address_id: that.data.defaultAdd.id,
                        payment_type: that.data.payment_type,
                        count: that.data.car_content.count,
                        item_id: that.data.car_content.item_id,
                        product_id: that.data.car_content.product_id,
                        pay_arice: (that.data.car_content.count * that.data.car_content.sale_price) + that.data.freight
                      },
                      success: function(res) {
                        console.log(res, 'emmm')
                        wx.hideLoading();
                        if (parseInt(res.code) != 0) {
                          wx.showToast({
                            title: res.message,
                            icon: 'none'
                          })
                        } else {
                          wx.redirectTo({
                            url: '../invite/invite?g_order_id=' + res.data.g_order_id + '&car_content=' + that.data.options.data,
                          })
                        }
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
            } else {
              requ.request({
                url: api.api.startGroupon,
                data: {
                  groupon_id: that.data.car_content.groupon_id,
                  address_id: that.data.defaultAdd.id,
                  payment_type: that.data.payment_type,
                  count: that.data.car_content.count,
                  item_id: that.data.car_content.item_id,
                  product_id: that.data.car_content.product_id,
                  pay_arice: that.data.car_content.count * that.data.car_content.sale_price
                },
                success: function(res) {
                  var g_order_id = res.data.g_order_id
                  wx.requestPayment({
                    timeStamp: res.data.payInfo.timeStamp,
                    nonceStr: res.data.payInfo.nonceStr,
                    package: res.data.payInfo.packageValue,
                    signType: res.data.payInfo.signType,
                    paySign: res.data.payInfo.paySign,
                    success: function() {
                      wx.navigateTo({
                        url: '../invite/invite?g_order_id=' + res.data.g_order_id + '&car_content=' + that.data.options.data,
                      });
                    },
                    fail: () => {
                      wx.navigateBack({})
                    }
                  })

                }
              })
            }
          };
          if (that.data.car_content.value == '参加拼团') {
            // 余额支付
            if (that.data.payment_type == 1) {
              wx.showModal({
                title: '',
                content: '是否使用余额支付',
                success: (res) => {
                  if (res.confirm) {
                    wx.showLoading({
                      title: '支付中...',
                    });
                    requ.request({
                      url: api.api.joinGroupon,
                      data: {
                        g_order_id: parseInt(that.data.car_content.g_order_id),
                        groupon_id: that.data.car_content.groupon_id,
                        address_id: that.data.defaultAdd.id,
                        payment_type: that.data.payment_type,
                        count: that.data.car_content.count,
                        item_id: that.data.car_content.item_id,
                        product_id: that.data.car_content.product_id
                      },
                      success: function(res) {
                        wx.hideLoading()
                        if (parseInt(res.code) != 0) {
                          wx.showToast({
                            title: res.message,
                            icon: 'none',
                          })
                        } else {
                          wx.redirectTo({
                            url: '../invite/invite?g_order_id=' + res.data.g_order_id + '&car_content=' + that.data.options.data,
                          })
                        }

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
            // 微信支付
            if (that.data.payment_type == 0) {
              wx.showLoading({
                title: '支付中...',
              })
              requ.request({
                url: api.api.joinGroupon,
                data: {
                  g_order_id: that.data.car_content.g_order_id,
                  groupon_id: that.data.car_content.groupon_id,
                  address_id: that.data.defaultAdd.id,
                  payment_type: that.data.payment_type,
                  count: that.data.car_content.count,
                  item_id: that.data.car_content.item_id,
                  product_id: that.data.car_content.product_id
                },
                success: function(res) {
                  wx.hideLoading()
                  var g_order_id = res.data.g_order_id;
                  wx.requestPayment({
                    timeStamp: res.data.payInfo.timeStamp,
                    nonceStr: res.data.payInfo.nonceStr,
                    package: res.data.payInfo.packageValue,
                    signType: res.data.payInfo.signType,
                    paySign: res.data.payInfo.paySign,
                    success: function() {
                      wx.navigateTo({
                        url: '../invite/invite?g_order_id=' + res.data.g_order_id + '&car_content=' + that.data.options.data,
                      });
                    },
                    fail: () => {
                      that.setData({
                        sub: true
                      });
                      wx.redirectTo({
                        url: '../Collage/Collage?shop_id=' + sub.product_id + '&groupon_id=' + sub.groupon_id
                      });
                    }
                  })
                }
              })
            }
          };
        } else {
          wx.showToast({
            title: '请选择收货地址',
            icon: 'none'
          })
        };
      }
    })
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function(res) {
    var that = this;
    var pages = getCurrentPages();
    var currPage = pages[pages.length - 1];
    if (currPage.data.selAddress == "") {
      // that.getUserAddress(that.data.userId);
    } else {
      that.setData({ //将携带的参数赋值
        defaultAdd: currPage.data.item,
        Recipient: true
      });
      var that = this;
      requ.request({
        url: api.api.calcExpressPriceForActivity,
        data: {
          product_id: that.data.car_content.product_id,
          count: that.data.car_content.count,
          address_id: that.data.defaultAdd.id
        },
        success: (res) => {
          that.setData({
            freight: res.data.expressPrice
          })
        }
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
      title: '蜗店',
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  }
})
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
    validate_id_token:'',
    validate_id:0,
    integral:0,
    integralPrice:0,
    goodsPic:'',
    goodsName:'',
    maxLimit:0,
    stock:0,
    count: 0,
    defaultAdd: [], //选中的收货地址信息
    freight:0,
    payment_method: [{
      is_radio: true,
      imgs: '../../images/wechat.png',
      name: '微信支付',
      title: '推荐安装微信的用户使用',
      payAble:true
    }, {
      is_radio: false,
      imgs: '../../images/balance.png',
      name: '余额支付',
      title: '请确保自己账户余额充足',
      payAble: true
    }], //支付方式
    payment_type: 0, //支付方式
    product_id:0,
    address_id:0,
    sub: true, //防止重复提交,
    car_content:[],
    defaultAdd: [] //选中的收货地址信息
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    console.log(wx.getStorageSync('IntegralGoods'))
    var IntegralGoods = wx.getStorageSync('IntegralGoods');
    this.setData({
      validate_id_token: IntegralGoods.validate_id_token,
      validate_id: IntegralGoods.validate_id,
      count: IntegralGoods.count,
      maxLimit: IntegralGoods.integralInfo.max_limit,
      integral: IntegralGoods.integralInfo.integral,
      integralPrice: IntegralGoods.integralInfo.integral_price,
      goodsPic: IntegralGoods.information.product_img,
      goodsName: IntegralGoods.information.product_name,
      stock: IntegralGoods.information.stock,
      product_id: IntegralGoods.information.product_id,
      car_content: IntegralGoods
    })
    if (wx.getStorageSync('token') != '') {
      var that = this;
      requ.request({
        url: api.api.myAddressList,
        success: function (res) {
          if(res.code == "0"){
            var defaultAdd = '';
            if (res.data.list.length > 0){
              for (var i = 0; i < res.data.list.length; i++) {
                if (res.data.list[i].is_default == 0) {
                  defaultAdd = res.data.list[i];
                  console.log(defaultAdd);
                }
              }
              
              that.setData({
                defaultAdd: defaultAdd
              });

              // 计算运费
              requ.request({
                url: api.api.calcExpressPriceForActivity,
                data: {
                  product_id: that.data.product_id,
                  count: that.data.count,
                  address_id: that.data.defaultAdd.id
                },
                success: (res) => {
                  that.setData({
                    freight: res.data.expressPrice
                  })
                }
              })
            }
          }
        }
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
  },
  // 支付方式
  getValue: function (e) {
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
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function (res) {
    var that = this;
    var pages = getCurrentPages();
    var currPage = pages[pages.length - 1];
    this.getBuyType()
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
          product_id: that.data.product_id,
          count: that.data.count,
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
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },
  // 减少商品
  
  reduce_num(){
    if (this.data.count > 1) {
      this.setData({
        count: this.data.count - 1
      })
      var that = this;
      requ.request({
        url: api.api.calcExpressPriceForActivity,
        data: {
          product_id: that.data.product_id,
          count: that.data.count,
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
  // 增加商品
  add_num(){
    if (this.data.maxLimit > 0) {
      if (this.data.count < this.data.maxLimit) {
        this.setData({
          count: this.data.count + 1
        })
        var that = this;
        requ.request({
          url: api.api.calcExpressPriceForActivity,
          data: {
            product_id: that.data.product_id,
            count: that.data.count,
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
          title: '该商品限购' + this.data.maxLimit + '件',
          icon: 'none',
          duration: 1000
        })
      }
    } else {
      if (this.data.stock > 10) {
        if (this.data.count > 10) {
          wx.showToast({
            title: '最多选择10件商品',
            icon: 'none',
            duration: 1000
          })
        } else {
          this.setData({
            count: this.data.count + 1
          })
          var that = this;
          requ.request({
            url: api.api.calcExpressPriceForActivity,
            data: {
              product_id: that.data.product_id,
              count: that.data.count,
              address_id: that.data.defaultAdd.id
            },
            success: (res) => {
              that.setData({
                freight: res.data.expressPrice
              })
            }
          })
        }
      } else {
        if (this.data.count > this.data.stock) {
          wx.showToast({
            title: '最多选择' + this.data.stock + '件商品',
            icon: 'none',
            duration: 1000
          })
        } else {
          this.setData({
            count: this.data.count + 1
          })
          var that = this;
          requ.request({
            url: api.api.calcExpressPriceForActivity,
            data: {
              product_id: that.data.product_id,
              count: that.data.count,
              address_id: that.data.defaultAdd.id
            },
            success: (res) => {
              that.setData({
                freight: res.data.expressPrice
              })
            }
          })
        }
      }
    }
  },
  // 付款
  sub_order(){
    var that = this;
    if (this.data.defaultAdd.length == 0){
      wx.showToast({
        title: '请选择收货地址',
        icon: 'none',
        duration: 1000
      })
    }else{
      if (that.data.sub){
        that.setData({
          sub: false
        })
        if (that.data.payment_type == 1) {
          wx.showModal({
            title: '',
            content: '是否使用余额支付',
            success: (res) => {
              if (res.confirm) {
                wx.showLoading({
                  title: '支付中...',
                  mask: true,
                  success: function () {
                    requ.request({
                      url: api.api.integralOrder,
                      data: {
                        validate_id: that.data.validate_id,
                        validate_id_token: that.data.validate_id_token,
                        address_id: that.data.address_id,
                        count: that.data.count,
                        payment_type: that.data.payment_type
                      },
                      success: function (res) {
                        console.log(res);
                        wx.hideLoading()
                        that.setData({
                          sub: true
                        });
                        if (res.code == 0){
                          wx.navigateTo({
                            url: '../buySuccess/buySuccess?payment_type=' + that.data.payment_type + '&pay_price=' + ((that.data.integralPrice * that.data.count) + that.data.freight)
                          });
                        }else{
                          wx.showToast({
                            title: res.message,
                            icon: 'none'
                          })
                        }
                      }
                    })
                  }
                })
              } else {
                wx.showToast({
                  title: '您取消了支付',
                  icon: 'none',
                  success: () => {
                    that.setData({
                      sub: true
                    });
                  }
                })
              }
            }
          })
        } else if (that.data.payment_type == 0){
          wx.showLoading({
            title: '支付中...',
            mask: true,
            success: function () {
              requ.request({
                url: api.api.addOrder,
                data: {
                  validate_id: that.data.validate_id,
                  validate_id_token: that.data.validate_id_token,
                  address_id: that.data.address_id,
                  count: that.data.count,
                  payment_type: that.data.payment_type
                },
                success: function (res) {
                  console.log(res, '微信支付')
                  wx.requestPayment({
                    timeStamp: res.data.timeStamp,
                    nonceStr: res.data.nonceStr,
                    package: res.data.packageValue,
                    signType: res.data.signType,
                    paySign: res.data.paySign,
                    success: () => {
                      that.setData({
                        sub: true
                      });
                      wx.navigateTo({
                        url: '../buySuccess/buySuccess?payment_type=' + that.data.payment_type + '&pay_price=' + ((that.data.integralPrice * that.data.count) + that.data.freight),
                      });
                      wx.hideLoading()
                    },
                    fail: () => {
                      wx.hideLoading()
                      wx.showToast({
                        title: '支付失败',
                        icon: 'none',
                        success:function(){
                          wx.navigateTo({
                            url: 'pages/IntegralList/IntegralList',
                          })
                        }
                      })
                    }
                  })
                }
              })
            }
          })
        }
      }
    }
  },
  // 选择收货地址
  address: function () {
    // 页面跳转拦截
    requ.verify(function (code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../address/address?pages=' + 'add',
        })
      }
    })
  },
  // 判断购买方式
  getBuyType(){
    var that = this;
    requ.request({
      url: api.api.paymentTypeInfo,
      success: (res) => {
        if(res.code == '0'){
          let balancePayAble = res.data.balancePayAble;
          let wxPayAble = res.data.wxPayAble;
          let payment_method = [...that.data.payment_method];
          payment_method[0].payAble = wxPayAble;
          payment_method[1].payAble = balancePayAble;
          console.log(payment_method);
          that.setData({
            payment_method: payment_method
          })
          
        }
      }
    })
  }
})
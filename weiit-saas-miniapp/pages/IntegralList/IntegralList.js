const util = require('../../utils/util.js');
const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
Page({

  /**
   * 页面的初始数据
   */
  data: {
    IntegralList:[],
    showModalStatus:false,
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
    payment_type: 0, //默认支付方式
    IntegralItem:{},
    hasNextPage:false
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    if (wx.getStorageSync('token') != '') {
      this.getIntegralList();
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

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
    if (this.data.hasNextPage) {
      var that = this;
      that.setData({
        page: that.data.page + 1
      })
      wx.showLoading({
        title: '加载中',
      })
      requ.request({
        url: api.api.selectIntegralProductList,
        data: {
          page: that.data.page,
          rows: that.data.rows
        },
        success: function (res) {
          that.setData({
            intergralGoods: that.data.intergralGoods.concat(res.data.list),
            hasNextPage: res.data.hasNextPage
          });
          wx.hideLoading()
        }
      })
    };
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
  // 获取积分订单列表
  getIntegralList(){
    var that = this;
    requ.request({
      url: api.api.integralOrderList,
      data:{
        page:1,
        rows:8
      },
      success:function(res){
        console.log(res);
        if(res.code == '0'){
          that.setData({
            IntegralList:res.data,
            // hasNextPage:
          })
        }
      }
    })
    
  },
  // 继续支付
  continue:function(e){
    this.setData({
      showModalStatus: true,
      IntegralItem: e.currentTarget.dataset.item
    })

  },
  hide:function(){
    this.setData({
      showModalStatus:false
    })
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
  // 确定支付方式
  confirmBtn: function () {
    getApp().hideModal(this);
    var that = this;
    // 微信支付
    if (that.data.payment_type == 0) {
      requ.request({
        url: api.api.integralPay,
        data: {
          order_num: that.data.IntegralItem.order_num,
          payment_type: that.data.payment_type
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
                url: '../buySuccess/buySuccess?pay_price=' + that.data.IntegralItem.pay_price + '&payment_type=' + that.data.payment_type + '&pageName=' + 'order',
              })
            }
          })
        }
      })
    }
    // 余额支付
    if (that.data.payment_type == 1) {
      wx.showModal({
        title: '',
        content: '是否使用余额支付',
        success: function (res) {
          if (res.confirm) {
            requ.request({
              url: api.api.integralPay,
              data: {
                order_num: that.data.IntegralItem.order_num,
                payment_type: that.data.payment_type
              },
              success: (res) => {
                console.log(res, '继续支付')
                if (res.code == 0) {
                  wx.navigateTo({
                    url: '../buySuccess/buySuccess?pay_price=' + that.data.IntegralItem.pay_price + '&payment_type=' + that.data.payment_type + '&pageName=' + 'order',
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
              title: '您取消了本次支付!',
            })
          }
        }
      })
    }
  },
})
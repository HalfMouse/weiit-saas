// pages/IntegralDetail/IntegralDetail.js
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
var WxParse = require('../../wxParse/wxParse.js')
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    load: false, //数据加载完显示
    options: {}, //上个页面传递过来的参数
    information: {}, //商品详情内容
    integralInfo: {}, //积分信息
    navbar: ['商品详情', '商品属性'], //商品信息以及商品属性分组
    currentTab: 0,
    Stock: 0, //商品库存
    showModalStatus: false,
    buy_num:1,
    maxLimit:0
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

    if (options.share_user_id) {
      wx.setStorageSync('shareId', options.share_user_id);
    }
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    this.setData({
      options: options
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
  onShow: function () {
    if (wx.getStorageSync('token') != ''){
      this.getIntegralDetail()
    }else{
      wx.navigateTo({
        url: '../userInfo/userInfo',
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
    return {
      title: this.data.information.product_name,
      path: '/pages/IntegralDetail/IntegralDetail?validate_id=' + this.data.options.validate_id + '&validate_id_token=' + this.data.options.validate_id_token + '&share_user_id=' + wx.getStorageSync('user_id'),
      success: (res) => {
        console.log(res)
      },
      fail: (res) => {
        console.log(res)
      }
    }
  },

  // 获取积分商品详情
  getIntegralDetail:function(){
    var that = this;
    requ.request({
      url: api.api.integralProductDetail,
      data: {
        validate_id: that.data.options.validate_id,
        validate_id_token: that.data.options.validate_id_token
      },
      success: function (res) {
       console.log(res);
       if(res.code == "0"){
          that.setData({
            load:true,
            Stock: res.data.productDetail.product_info.stock, //商品库存
            Price: res.data.productDetail.product_info.sale_price, //商品价格
            maxLimit: res.data.integralInfo.max_limit, //限购数量
            information: res.data.productDetail.product_info,
            integralInfo: res.data.integralInfo
          })
       }
        
      }
    })
  },
  navbarTap: function (e) {
    this.setData({
      currentTab: e.currentTarget.dataset.index
    });
  },
  // 选择、规格
  choice: function () {
    // 显示遮罩层
    app.showModal(this);
  },
  choice_spce: function (e) {
    this.setData({
      choice: e.currentTarget.dataset.type
    })
    // 显示遮罩层
    app.showModal(this);
  },
  hide:function(){
    this.setData({
      showModalStatus:false
    })
  },
  ADD:function(){
    this.setData({
      showModalStatus: true
    })
  },
  choice_spce:function(){
    this.setData({
      showModalStatus: true
    })
  },
  //增加购买数量
  add_num: function () {
    if (this.data.maxLimit > 0) {
      if (this.data.buy_num < this.data.maxLimit) {
        this.setData({
          buy_num: this.data.buy_num + 1
        })
      } else {
        wx.showToast({
          title: '该商品限购' + this.data.maxLimit + '件',
          icon: 'none',
          duration: 1000
        })
      }
    } else {
      if (this.data.Stock > 10){
        if (this.data.buy_num > 10){
          wx.showToast({
            title: '最多选择10件商品',
            icon: 'none',
            duration: 1000
          })
        }else {
          this.setData({
            buy_num: this.data.buy_num + 1
          })
        }
      }else {
        if (this.data.buy_num > this.data.Stock) {
          wx.showToast({
            title: '最多选择' + this.data.Stock + '件商品',
            icon: 'none',
            duration: 1000
          })
        } else {
          this.setData({
            buy_num: this.data.buy_num + 1
          })
        }
      }
      // if (this.data.buy_num < this.data.Stock) {
      //   this.setData({
      //     buy_num: this.data.buy_num + 1
      //   })
      // } else if (this.data.buy_num > 100){

      // } else {
      //   wx.showToast({
      //     title: '最多选择' + this.data.Stock + '件商品',
      //     icon: 'none',
      //     duration: 1000
      //   })
      // }
    }
  },
  //减少购买数量
  reduce_num: function () {
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
  // 确定购买
  confirm() {
    var IntegralGoods = {
      validate_id: this.data.options.validate_id,
      validate_id_token: this.data.options.validate_id_token,
      count: this.data.buy_num,
      information: this.data.information, //商品详情内容
      integralInfo: this.data.integralInfo //积分信息
    }
    wx.setStorage({
      key: 'IntegralGoods',
      data: IntegralGoods,
    })
    // url: '/pages/IntegralCar/IntegralCar?validate_id=' + this.data.options.validate_id + '&validate_id_token=' + this.data.options.validate_id_token + '&integralPrice=' + this.data.integralInfo.integral_price + '&integral=' + this.data.integralInfo.integral + '&stock=' + this.data.Stock + '&maxLimit=' + this.data.maxLimit + '&count=' + this.data.buy_num + '&goodsPic=' + this.data.information.product_img + '&goodsName=' + this.data.information.product_name + '&freight=' + this.data.information.express_money
    wx.navigateTo({
      url: '/pages/IntegralCar/IntegralCar'
    })
  }
})
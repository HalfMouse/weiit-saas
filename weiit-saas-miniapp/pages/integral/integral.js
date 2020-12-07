// pages/integral/integral.js
const util = require('../../utils/util.js');
const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
Page({

  /**
   * 页面的初始数据
   */
  data: {
    integral: [],//我的积分
    options:[],//
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
    this.setData({ options: options })
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
    if (wx.getStorageSync('token') != '') {
      var that = this;
      requ.request({
        url: api.api.myIntegralLog,
        success: function (res) {
          console.log(res);
          var time = [];
          for (var i = 0; i < res.data.length; i++) {
            time.push(util.getTime(res.data[i].create_time));
          }
          that.setData({
            integral: res.data,
            jifen: that.data.options.integral,
            time: time
          })
        }
      })
    } else {
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
      title: '蜗店',
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  },
  // 前往积分规则
  integralRule:function(){
    wx.navigateTo({
      url: '/pages/IntegralRule/IntegralRule',
    })
  },
  // 前往积分商城
  toExchange:function(){
    wx.navigateTo({
      url: '/pages/IntegralMall/IntegralMall?integral=' + this.data.jifen,
    })
  },
  // 前往积分订单列表
  toIntegralList:function(){
    wx.navigateTo({
      url: '/pages/IntegralList/IntegralList',
    })
  }
})
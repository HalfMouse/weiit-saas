// pages/teams/teams.js
const app = getApp();
const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
const util = require('../../utils/util.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    load: false
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    var that = this;
    wx.showLoading({
      title: '加载中',
    });
    requ.request({
      url: api.api.orderExpress,
      data: {
        express_num: options.order_number,
        express_code: options.order_code
      },
      success: (res) => {
        console.log(res, '物流')
        console.log(JSON.parse(res.data.expressInfo), '物流信息')
        wx.hideLoading();
        that.setData({
          load: true,
          imgs: res.data.expressBaseInfo.express_logo,
          company: res.data.expressBaseInfo.express_name,
          logisticsDetail: JSON.parse(res.data.expressInfo)
        })
      },
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
  onShow: function() {

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

  }
})
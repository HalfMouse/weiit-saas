// pages/Record/Record.js
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
const util = require('../../utils/util.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    navbar: ['全部', '已支出', '已收入'],
    currentTab: 0,
    bill: [], //账单列表
    page: 1, //
  },
  navbarTap: function(e) {
    this.setData({
      currentTab: e.currentTarget.dataset.idx
    });
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
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
    var that = this
    if (wx.getStorageSync('token') != '') {
      requ.request({
        url: api.api.myBalanceLog,
        success: function(res) {
          console.log(res)
          var time = [];
          var expenditure = [],
            income = [],
            come_time = [],
            ex_time = [];
          for (var i = 0; i < res.data.list.length; i++) {
            time.push(util.getTime(res.data.list[i].create_time));
            if (res.data.list[i].balance >= 0) {
              income.push(res.data.list[i]);
            } else {
              expenditure.push(res.data.list[i]);
            }
          };
          for (var j = 0; j < income.length; j++) {
            come_time.push(util.getTime(income[j].create_time))
          };
          for (var k = 0; k < expenditure.length; k++) {
            ex_time.push(util.getTime(expenditure[k].create_time))
          }
          that.setData({
            bill: res.data.list,
            time: time,
            expenditure: expenditure,
            ex_time: ex_time,
            income: income,
            come_time: come_time
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
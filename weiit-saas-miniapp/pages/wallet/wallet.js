const requ = require('../../utils/request.js');
// pages/Withdrawals/Withdrawals.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    money: 0, //我的余额
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
    if (wx.getStorageSync('token') != '') {
      this.setData({
        money: options.money,
        btnColor: wx.getStorageSync('btnColor')
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
  },
  //跳转收支明细页面
  jump_Record: function() {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../Record/Record',
        })
      }
    })
  },
  // 提现
  tixian: function(e) {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        var money = e.currentTarget.dataset.money
        wx.navigateTo({
          url: '../Withdrawals/Withdrawals?money=' + money,
        })
      }
    })
  },
  // 充值
  recharge: function() {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../recharge/recharge',
        })
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
    return {
      title: '蜗店',
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  }
})
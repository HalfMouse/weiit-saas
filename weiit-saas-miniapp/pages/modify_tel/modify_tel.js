const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
// pages/modify_tel/modify_tel.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    time: 60,
    ipt_con: '',
    code: true,
    Verification_code: '',//验证码
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
    if (wx.getStorageSync('token') != '') {
      this.setData({
        tel: options.tel
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
  },
  // 获取验证码
  obtain: function () {
    var that = this;
    requ.request({
      url: api.api.verificationCode,
      data: { user_account: 18374868862 },
      success: function (res) {
        that.setData({
          Verification_code: res.data
        })
      }
    })
    that.setData({
      code: false
    })
    var times = setInterval(
      function () {
        that.setData({
          time: that.data.time - 1,
        })
        if (that.data.time == 0) {
          clearInterval(times);
          that.setData({
            code: true,
            time: 60
          })
        }
      }, 1000
    )
  },
  // 输入验证码
  ipt: function (e) {
    this.setData({
      ipt_con: e.detail.value
    })
  },
  // 下一步
  next: function () {
    // 页面跳转拦截
    requ.verify(function (code) {
      if (code == 0) {
        // if (this.data.Verification_code == this.data.ipt_con) {
        wx.navigateTo({
          url: '../test_tel/test_tel',
        })
        // } else {
        //   wx.showToast({
        //     title: '对不起！您输入的验证码有误',
        //     icon: 'none'
        //   })
        // }
      }
    })
  },
  // 拨号
  dial: function () {
    wx.makePhoneCall({
      phoneNumber: '12345678900',
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
  }
})
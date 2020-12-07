const requ = require('../../utils/request.js');
const api = require('../../utils/api.js')
// pages/Receive_coupons/Receive_coupons.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    hidden: true,
    receiveList: [], //可以领取的优惠券列表
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
    if (wx.getStorageSync('bottomMenuList')) {
      this.setData({
        bottomMenuList: wx.getStorageSync('bottomMenuList')
      })
    }
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {

  },
  //隐藏与显示
  btn: function(e) {
    var index = e.currentTarget.dataset.index
    if (this.data.receiveList[index].hidden == true) {
      this.data.receiveList[index].hidden = false
    } else {
      this.data.receiveList[index].hidden = true
    }
    this.setData({
      receiveList: this.data.receiveList,
    })
  },
  //领取优惠券
  receive: function(e) {
    console.log(e)
    var that = this;
    var coupon_id = e.currentTarget.dataset.id
    requ.request({
      url: api.api.couponGet,
      data: {
        coupon_id: coupon_id
      },
      success: (res) => {
        wx.showToast({
          title: res.message,
          icon: 'none'
        })
      }
    })
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function() {
    if (wx.getStorageSync('token') != '') {
      var that = this;
      requ.request({
        url: api.api.couponList,
        success: function(res) {
          console.log(res, '12122')
          let reg = /\s\d{2}\:\d{2}\:\d{2}\.\d/g;
          for (var i = 0; i < res.data.length; i++) {
            res.data[i].hidden = true;
            res.data[i].time = res.data[i].time.replace(reg, '');
          }
          that.setData({
            receiveList: res.data
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
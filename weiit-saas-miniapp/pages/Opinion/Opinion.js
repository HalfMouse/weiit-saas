const requ = require('../../utils/request.js');
const api = require('../../utils/api.js')
// pages/Opinion/Opinion.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    values: '',
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
    this.setData({
      btnColor: wx.getStorageSync('btnColor')
    });
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  value: function(res) {
    console.log(res)
    this.setData({
      values: res.detail.value
    })
  },
  //提交意见
  sub: function() {
    var that = this
    if (that.data.values != '') {
      requ.request({
        url: api.api.addSuggest,
        data: {
          suggest: that.data.valus
        },
        success: function(res) {
          wx.showToast({
            title: '提交成功',
            success: function() {
              setTimeout(function() {
                wx.navigateBack({
                  delta: 1
                })
              }, 1500)
            }
          })
        }
      })
    } else {
      wx.showToast({
        title: '输入不能为空',
        image: '../../images/error.png'
      })
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
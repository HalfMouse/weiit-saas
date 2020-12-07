const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
// pages/recharge/recharge.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    value: '', //充值金额
    loading: true, //防止重复提交
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id) {
      wx.setStorageSync('shareId', options.share_user_id);
    }
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    this.setData({
      btnColor: wx.getStorageSync('btnColor')
    })
  },
  getValue: function(e) {
    this.setData({
      value: e.detail.value
    })
  },
  next: function() {
    var that = this;
    if (that.data.value != '') {
      if (that.data.loading) {
        that.setData({
          loading: false
        });
        wx.showLoading({
          title: '提交中',
          mask: true
        });
        requ.request({
          url: api.api.balanceRecharge,
          data: {
            money: that.data.value
          },
          success: function(res) {
            if (res.code == 0) {
              wx.requestPayment({
                timeStamp: res.data.timeStamp,
                nonceStr: res.data.nonceStr,
                package: res.data.packageValue,
                signType: res.data.signType,
                paySign: res.data.paySign,
                success: () => {
                  that.setData({
                    value: ''
                  });
                  wx.hideLoading();
                  wx.showToast({
                    title: '充值成功',
                    success: () => {
                      setTimeout(function() {
                        wx.navigateBack({})
                      }, 1500)
                    }
                  })
                },
                fail: () => {
                  that.setData({
                    value: ''
                  });
                  wx.hideLoading();
                  wx.showToast({
                    title: '充值失败',
                    image: '../../images/error.png',
                    success: () => {
                      setTimeout(function() {
                        wx.navigateBack({})
                      }, 1500)
                    }
                  })
                }
              })
            }
          },
        })
      }
    } else {
      wx.showToast({
        title: '请输入要充值的金额',
        icon: 'none'
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
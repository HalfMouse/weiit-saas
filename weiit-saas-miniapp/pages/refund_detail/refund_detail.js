const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
// pages/refund_detail/refund_detail.js
const util = require('../../utils/util.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    refund_id: '',
    options: [], //上个页面带过来的参数
    load: false, //页面数据加载是否完成
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
      btnColor: wx.getStorageSync('btnColor'),
      options: options
    })
  },
  // 查看物流
  look_logistics: function() {
    var that = this;
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../logistics/logistics?order_code=' + that.data.refund_detail.express_code + '&order_number=' + that.data.refund_detail.express_num,
        })
      }
    })
  },
  // 添加物流信息
  add_info: function() {
    // 页面跳转拦截
    var that = this;
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../add_info/add_info?refund_id=' + that.data.refund_id,
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
    if (wx.getStorageSync('token') != '') {
      wx.showLoading({
        title: '加载中',
      });
      var that = this;
      var refund_id = that.data.options.refund_id;
      requ.request({
        url: api.api.orderRefundDetail,
        data: {
          refund_id: refund_id
        },
        success: function(res) {
          res.data.create_time = util.getTime(res.data.create_time);
          switch (res.data.state) {
            case -1:
              res.data.states = '退换关闭'
              break;
            case 0:
              res.data.states = '等待卖家同意'
              break;
            case 1:
              res.data.states = '等待买家补充'
              break;
            case 2:
              res.data.states = '等待卖家退换'
              break;
            case 3:
              res.data.states = '退换完成'
              break;
            case 4:
              res.data.states = '退换驳回'
              break;
          }
          wx.hideLoading();
          that.setData({
            load: true,
            refund_detail: res.data,
            refund_id: that.data.options.refund_id
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
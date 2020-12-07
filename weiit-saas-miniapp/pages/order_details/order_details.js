const requ = require('../../utils/request.js');
const util = require('../../utils/util.js');
const api = require('../../utils/api.js');
const app = getApp();
// pages/order_details/order_details.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    content: [],
    options: [], //上个页面带过来的参数
    order_id: '',
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (wx.getStorageSync('token') != '') {
      this.setData({
        options: options
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
    if (options.share_user_id) {
      wx.setStorageSync('shareId', options.share_user_id);
    }
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    
    
  },
  // 去商品详情
  goto_detail: function(e) {
    if (app.conFig.switchTabUrl != undefined) {
      if (app.conFig.switchTabUrl.indexOf('detail') != -1) {
        app.detailId = e.currentTarget.dataset.product_id;
        wx.reLaunch({
          url: '../detail/detail',
        })
      } else {
        wx.navigateTo({
          url: '../detail/detail?shop_id=' + e.currentTarget.dataset.product_id,
        })
      }
    } else {
      wx.navigateTo({
        url: '../detail/detail?shop_id=' + e.currentTarget.dataset.product_id,
      })
    };
  },
  // 申请售后
  sale: function(e) {
    if (e.currentTarget.dataset.state == undefined) {
      var that = this;
      var id = e.currentTarget.dataset.id;
      var con = JSON.stringify(that.data.content.item[e.currentTarget.dataset.index]);
      // 页面跳转拦截
      requ.verify(function(code) {
        if (code == 0) {
          wx.navigateTo({
            url: '../after_sale/after_sale?id=' + id + '&order_id=' + that.data.order_id + '&con=' + con,
          })
        }
      })
    } else {
      wx.showToast({
        title: '商家正在受理中~',
        icon: 'none'
      })
    }

  },
  // 查看物流
  logistics: function() {
    var that = this;
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../logistics/logistics?order_number=' + that.data.content.express_num + '&order_code=' + that.data.content.express_code,
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
      var that = this;
      requ.request({
        url: api.api.orderDetail,
        data: {
          order_num: that.data.options.order_num
        },
        success: function(res) {
          switch (res.data.state) {
            case -1:
              res.data.state = '交易取消';
              break;
            case 1:
              res.data.state = '待发货';
              break;
            case 2:
              res.data.state = '待收货';
              break;
            case 4:
              res.data.state = '交易完成';
              break;
            case 0:
              res.data.state = '待付款';
              break;
          }
          console.log(res, '订单详情777')
          console.log(that.data.options)
          res.data.create_time = util.getTime(res.data.create_time)
          res.data.deliver_time = util.getTime(res.data.deliver_time)
          that.setData({
            content: res.data,
            // order_id: that.data.options.order_id
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
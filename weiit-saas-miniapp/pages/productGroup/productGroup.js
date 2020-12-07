// pages/productGroup/productGroup.js
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    load: false,
    options: [],
    group_ids: Number, //分组ID
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    this.setData({
      options: options
    })
  },
  go_detail: function(e) {
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
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function() {
    var that = this;
    if (app.conFig.switchTabUrl != undefined) {
      if (app.conFig.switchTabUrl.indexOf('productGroup') != -1) {
        that.setData({
          group_ids: app.conFig.productGroupId,
        });
        if (app.grouping) {
          that.setData({
            group_ids: app.grouping,
          });
        };
        console.log(that.data.group_ids)
      } else {
        that.setData({
          group_ids: that.data.options.group_ids
        })
      }
    } else {
      that.setData({
        group_ids: that.data.options.group_ids
      })
    };
    requ.request({
      url: api.api.getProductByGroupIds,
      data: {
        group_ids: that.data.group_ids
      },
      success: res => {
        console.log(res)
        wx.setNavigationBarTitle({
          title: res.data[0].group_name,
        });
        that.setData({
          load: true,
          productList: res.data[0]
        });
      }
    })
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
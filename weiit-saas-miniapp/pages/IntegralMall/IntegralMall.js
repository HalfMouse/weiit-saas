// pages/Integral_mall/Integral_mall.js
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    Load: false,
    intergralGoods:[],
    page:1,
    rows:6,
    hasNextPage: true,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function () {
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  // 积分商城商品列表
  integralList:function(){
    wx.showLoading({
      title: '加载中',
    })
    var that = this;
    requ.request({
      url: api.api.selectIntegralProductList,
      data: {
        page: that.data.page,
        rows: that.data.rows
      },
      success: function (res) {
        console.log(res, 'list')
        that.setData({
          Load: true,
          intergralGoods: res.data.list,
          hasNextPage: res.data.hasNextPage,
        });
        wx.hideLoading()
      }
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
    if (wx.getStorageSync('token') != '') {
      this.integralList();
      this.getIntegral();
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }
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
  onReachBottom: function (e) {
    if (this.data.hasNextPage) {
      var that = this;
      that.setData({
        page: that.data.page + 1
      })
      wx.showLoading({
        title: '加载中',
      })
      requ.request({
        url: api.api.selectIntegralProductList,
        data: {
          page: that.data.page,
          rows: that.data.rows
        },
        success: function (res) {
          that.setData({
            intergralGoods: that.data.intergralGoods.concat(res.data.list),
            hasNextPage: res.data.hasNextPage
          });
          wx.hideLoading()
        }
      })
    };
  },
  // 跳转到积分商品详情
  go_detail:function(e){
    wx.navigateTo({
      url: '../IntegralDetail/IntegralDetail?validate_id=' + e.currentTarget.dataset.id + '&validate_id_token=' + e.currentTarget.dataset.toke,
    })
  },
  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },
  intergralDetail: function(){
    wx.navigateTo({
      url: '/pages/integral/integral?integral=' + this.data.integral,
    })
  },
  // 获取信息
  getIntegral(){
    var that = this;
    requ.request({
      url: api.api.userInfo,
      success: function (res) {
        if (res.code == 0) {
          that.setData({
            integral: res.data.integral
          });
        }
      }
    })
  }
})
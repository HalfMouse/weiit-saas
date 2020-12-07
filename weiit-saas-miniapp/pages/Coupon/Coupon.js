const requ = require('../../utils/request.js');
const api = require('../../utils/api.js')
// pages/Coupon/Coupon.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    Load: false,
    navbar: ['全部', '已使用', '已过期'],
    currentTab: 0,
    coupon: [], //优惠券
    Use: [], //已经使用的优惠券
    overdue: [], //已经过期的优惠券
    page: 1, //当前显示页面
    hasNextPage: true, //是否还有下一页
    emptys: {
      url: '../../images/youhui.png',
      title: '您还没有优惠券呢',
      btn: '前往领取'
    }, //没有优惠券
  },
  navbarTap: function(e) {
    this.setData({
      currentTab: e.currentTarget.dataset.idx
    });
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id) {
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
  // 去使用优惠券
  Use: function(e) {
    // 页面跳转拦截
    var state = e.currentTarget.dataset.state;
    if (state == 0) {
      requ.verify(function(code) {
        if (code == 0) {
          wx.navigateTo({
            url: '../search/search',
          })
        }
      })
    }
  },
  //领取优惠券
  go_home: function() {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.redirectTo({
          url: '../Receive_coupons/Receive_coupons',
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
    wx.showLoading({
      title: '加载中',
    })
    if (wx.getStorageSync('token') != '') {
      var that = this;
      requ.request({
        url: api.api.myCoupons,
        data: {
          page: that.data.page
        },
        success: function(res) {
          console.log(res, '优惠券')
          if(res.code == 0){
            if(res.data.total > 0){
              var ss = new Array();
              var over = new Array();
              let reg = /\s\d{2}\:\d{2}\:\d{2}\.\d/g;
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].time = res.data.list[i].time.replace(reg, '');
                if (res.data.list[i].state == 1) {
                  ss.push(res.data.list[i])
                } else if (res.data.list[i].state == -1) {
                  over.push(res.data.list[i])
                }
              }
              that.setData({
                Load: true,
                coupon: res.data.list,
                Use: ss, //已经使用的优惠券数据
                overdue: over, //已经过期的优惠券数据
                hasNextPage: res.data.hasNextPage
              });
              wx.hideLoading()
            }else{
              wx.navigateTo({
                url: '/pages/Receive_coupons/Receive_coupons',
              })
            }
          }
          
        },
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
    if (this.data.hasNextPage) {
      wx.showLoading({
        title: '加载中',
      })
      var that = this;
      that.setData({
        page: that.data.page + 1
      })
      requ.request({
        url: api.api.myCoupons,
        data: {
          page: that.data.page
        },
        success: function(res) {
          console.log(res, '优惠券')
          var ss = new Array();
          var over = new Array();
          for (var i = 0; i < res.data.list.length; i++) {
            if (res.data.list[i].state == 1) {
              ss.push(res.data.list[i])
            } else if (res.data.list[i].state == -1) {
              over.push(res.data.list[i])
            }
          }
          that.setData({
            coupon: res.data.list,
            Use: ss, //已经使用的优惠券数据
            overdue: over, //已经过期的优惠券数据
            hasNextPage: res.data.hasNextPage
          });
          wx.hideLoading()
        },
      })
    }
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
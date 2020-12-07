const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
// pages/ReturnGoods/ReturnGoods.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    item: {
      bool: true,
      name: '退货'
    },
    emptys: {
      url: '../../images/tuihuo.png',
      title: '您还没有退货信息',
      btn: '逛逛首页'
    }, //没有退货
    load: false, //页面加载完显示数据
    retreat: [],
    order_num: [], //订单号
    page: 1, //当前显示页面
    hasNextPage: true, //是否有下一页
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
  // 查看退货详情
  look_detail: function(e) {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        var refund_id = e.currentTarget.dataset.cancel_id
        wx.navigateTo({
          url: '../refund_detail/refund_detail?refund_id=' + refund_id,
        })
      }
    })
  },
  // 取消退货
  cacel_btn: function(e) {
    var cancel_id = e.currentTarget.dataset.cancel_id;
    var state = e.currentTarget.dataset.type;
    if (state == '待审核') {
      state = 0
    }
    if (state == '退换中') {
      state = 1
    }
    requ.request({
      url: api.api.orderRefundCancel,
      data: {
        state: state,
        refund_id: cancel_id
      },
    })
  },
  // 逛逛首页
  go_home: function() {
    wx.switchTab({
      url: '../index/index',
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
    var that = this;
    if (wx.getStorageSync('token') != '') {
      wx.showLoading({
        title: '加载中',
      });
      requ.request({
        url: api.api.orderRefundList,
        data: {
          page: 1
        },
        success: function(res) {
          wx.hideLoading();
          res.data.name = '退货';
          that.data.order_num = [];
          for (var i = 0; i < res.data.list.length; i++) {
            res.data.list[i].order_num = res.data.list[i].refund_num
            if (res.data.list[i].refund_type == 1) {
              res.data.list[i].refund_type = '只退款'
            }
            if (res.data.list[i].refund_type == 2) {
              res.data.list[i].refund_type = '退货并退款'
            }
            switch (res.data.list[i].state) {
              case -1:
                res.data.list[i].state = '退换关闭';
                res.data.list[i].bool = false
                break;
              case 0:
                res.data.list[i].state = '等待卖家同意';
                res.data.list[i].bool = true
                break;
              case 1:
                res.data.list[i].state = '等待买家补充';
                res.data.list[i].bool = true
                break;
              case 2:
                res.data.list[i].state = '等待卖家退换';
                res.data.list[i].bool = true
                break;
              case 3:
                res.data.list[i].state = '退换完成';
                res.data.list[i].bool = false
                break;
              case 4:
                res.data.list[i].state = '退换驳回';
                res.data.list[i].bool = true
                break;
            }
          }
          that.setData({
            load: true,
            retreat: res.data.list,
            hasNextPage: res.data.hasNextPage,
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
    if (this.data.hasNextPage) {
      var that = this;
      that.setData({
        page: that.data.page + 1
      })
      wx.showLoading({
        title: '加载中',
      })
      requ.request({
        url: api.api.orderRefundList,
        data: {
          page: that.data.page
        },
        success: function(res) {
          res.data.name = '退货';
          for (var i = 0; i < res.data.list.length; i++) {
            if (res.data.list[i].refund_type == 1) {
              res.data.list[i].refund_type = '只退款'
            }
            if (res.data.list[i].refund_type == 2) {
              res.data.list[i].refund_type = '退货并退款'
            }
            switch (res.data.list[i].state) {
              case -1:
                res.data.list[i].state = '取消退换';
                res.data.list[i].bool = false
                break;
              case 0:
                res.data.list[i].state = '待审核';
                res.data.list[i].bool = true
                break;
              case 1:
                res.data.list[i].state = '退换中';
                res.data.list[i].bool = true
                break;
              case 2:
                res.data.list[i].state = '退换完成';
                res.data.list[i].bool = false
                break;
            }
          };
          that.setData({
            retreat: that.data.retreat.concat(res.data.list),
            hasNextPage: res.data.hasNextPage
          });
          wx.hideLoading()
        }
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
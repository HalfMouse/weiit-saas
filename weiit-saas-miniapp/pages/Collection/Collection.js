// pages/Collection/Collection.js
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    Load: false,
    CollectionList: [], //收藏列表
    delete_id: 0, //商品ID
    page: 1, //当前显示页面
    hasNextPage: true, //总页数
    emptys: {
      url: '../../images/shoucang.png',
      title: '您还没有收藏哦',
      btn: '逛逛首页'
    }, //没有收藏
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
  // 我的收藏列表
  coll: function() {
    wx.showLoading({
      title: '加载中',
    })
    var that = this
    requ.request({
      url: api.api.myCollectionList,
      data: {
        page: that.data.page
      },
      success: function(res) {
        console.log(res, 'list')
        that.setData({
          Load: true,
          CollectionList: res.data.list,
          hasNextPage: res.data.hasNextPage,
        });
        wx.hideLoading()
      }
    })
  },
  // 去首页
  go_home: function() {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.switchTab({
          url: '/pages/index/index',
        })
      }
    })
  },
  // 删除收藏
  detele: function(e) {
    var that = this;
    that.setData({
      delete_id: e.currentTarget.dataset.id
    })
    wx.showModal({
      content: '确认删除此商品？',
      success: function(sm) {
        if (sm.confirm) {
          // 用户点击了确定 可以调用删除方法了
          requ.request({
            url: api.api.myCollectionDelete,
            data: {
              product_id: that.data.delete_id
            },
            success: function(res) {
              that.coll();
            }
          })
        } else if (sm.cancel) {
          console.log('用户点击取消')
        }
      }
    })
  },
  // 去到商品详情页面
  go_detail: function(e) {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        // var product_id = e.currentTarget.dataset.product_id;
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
      this.coll();
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
  onReachBottom: function(e) {
    if (this.data.hasNextPage) {
      var that = this;
      that.setData({
        page: that.data.page + 1
      })
      wx.showLoading({
        title: '加载中',
      })
      requ.request({
        url: api.api.myCollectionList,
        data: {
          page: that.data.page
        },
        success: function(res) {
          that.setData({
            CollectionList: that.data.CollectionList.concat(res.data.list),
            hasNextPage: res.data.hasNextPage
          });
          wx.hideLoading()
        }
      })
    };
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
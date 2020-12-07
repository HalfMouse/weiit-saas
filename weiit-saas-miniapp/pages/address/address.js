const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
// pages/address/address.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    id: 0, //地址ID
    addres: [],
    selAddress: '', //选择地址后返回
    data_pages: '',
    page: 1, //当前显示页数
    hasNextPage: true, //是否有下一页
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
    // this.addressList();
    if (wx.getStorageSync('token') != '') {
      console.log(options);
      this.setData({
        data_pages: options,
        btnColor: wx.getStorageSync('btnColor')
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    };
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  // 收货地址列表
  addressList: function() {
    var that = this;
    requ.request({
      url: api.api.myAddressList,
      data: {
        page: that.data.page
      },
      success: function(res) {
        console.log(res, 'def')
        that.setData({
          addres: res.data.list,
          hasNextPage: res.data.hasNextPage
        })
      }
    })
  },
  // 设为默认地址
  is_default: function(e) {
    console.log(e)
    var id = parseInt(e.detail.value)
    var that = this;
    requ.request({
      url: api.api.myAddressSetDefault,
      data: {
        is_default: that.data.addres.is_default,
        id: id
      },
      success: function(res) {}
    })
  },
  //删除地址
  deletes: function(e) {
    this.setData({
      id: e.currentTarget.dataset.id
    })
    var that = this;
    wx.showModal({
      content: '确认删除该地址？',
      success: function(res) {
        if (res.confirm == true) {
          requ.request({
            url: api.api.myAddressDelete,
            data: {
              id: that.data.id
            },
            success: function(res) {
              that.addressList();
            }
          })
        }
      }
    })
  },
  // 编辑地址
  edit: function(e) {
    var that = this;
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        var index = parseInt(e.currentTarget.dataset.index);
        var con = JSON.stringify(that.data.addres[index]);
        var is_default = that.data.addres[index].is_default
        wx.navigateTo({
          url: '../add_address/add_address?add_content=' + con + '&pages=' + 'add',
        })
      }
    })
  },
  // 新增收货地址
  add: function() {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../add_address/add_address',
        })
      }
    })
  },
  // 选中地址
  Selected: function(e) {
    var that = this;
    if (that.data.data_pages.pages == 'add') {
      var index = e.currentTarget.dataset.index;
      var pages = getCurrentPages(); //当前页面
      var prevPage = pages[pages.length - 2]; //上一页面
      prevPage.setData({ //直接给上一页面赋值
        item: that.data.addres[index],
        selAddress: 'yes'
      });
      wx.navigateBack({})
    };
    if (that.data.data_pages.value == 'helpMe') {
      // 页面跳转拦截
      requ.verify(function(code) {
        if (code == 0) {
          requ.request({
            url: api.api.bargainOrder,
            data: {
              bargain_id: that.data.data_pages.bargain_id,
              address_id: e.currentTarget.dataset.id
            },
            success: function(res) {
              wx.navigateTo({
                url: '../chopPage/chopPage?b_order_id=' + res.data.b_order_id + '&bargain_id=' + that.data.bargain_id
              })
            }
          })
        }
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
  onShow: function () {
    this.addressList();
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
        url: api.api.myAddressList,
        data: {
          page: that.data.page
        },
        success: function(res) {
          that.setData({
            addres: that.data.address.concat(res.data.list),
            hasNextPage: res.data.hasNextPage
          })
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
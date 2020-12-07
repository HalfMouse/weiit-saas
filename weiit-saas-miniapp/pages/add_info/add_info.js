const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
// pages/add_info/add_info.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    array: [],
    ipt_value: '', //快递单号
    refund_id: 0, //退换商品ID
    company_id: [], //快递公司
    express_template_id: 0, //快递公司ID
    loading: true, //防止重复提交
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
    this.setData({
      btnColor: wx.getStorageSync('btnColor'),
      refund_id: options.refund_id
    });
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  // 选择快递
  bindPickerChange: function(e) {
    console.log(e)
    this.setData({
      index: e.detail.value,
      express_template_id: this.data.company_id[e.detail.value].express_template_id
    })
  },
  // 快递单号
  get_value: function(e) {
    this.setData({
      ipt_value: e.detail.value
    })
  },
  // 提交补充信息
  complete: function() {
    var that = this;
    if (that.data.loading) {
      if (that.data.express_template_id != 0 && that.data.ipt_value != '') {
        that.setData({
          loading: false
        });
        requ.request({
          url: api.api.addOrderRefundExpress,
          data: {
            refund_id: that.data.refund_id,
            express_template_id: that.data.express_template_id,
            express_num: that.data.ipt_value
          },
          success: function(res) {
            that.setData({
              loading: true
            });
            wx.showToast({
              title: '成功',
              success: () => {
                setTimeout(function() {
                  wx.navigateBack({})
                }, 1500)
              }
            });
          }
        })
      } else {
        if (that.data.express_template_id == 0) {
          wx.showToast({
            title: '请选择物流公司',
            icon: 'none'
          })
        } else {
          wx.showToast({
            title: '请填写快递单号',
            icon: 'none'
          })
        }
      }
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
    var that = this;
    if (wx.getStorageSync('token') != '') {
      var company = [];
      requ.request({
        url: api.api.expressCompany,
        success: function(res) {
          for (var i = 0; i < res.data.length; i++) {
            company.push(res.data[i].express_company);
          }
          that.setData({
            array: company,
            company_id: res.data
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
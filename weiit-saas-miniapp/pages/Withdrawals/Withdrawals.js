const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
// pages/Withdrawals/Withdrawals.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    selectPerson: true,
    firstPerson: '微信',
    selectArea: false,
    bom: '../../images/bom.png',
    top: '../../images/top.png',
    values: '', //提现金额
    Alipay_val: '', //支付宝账号
    money: 0, //可提现金额
    types: 0, //支付方式
    options: [], //
    sub: true, //防止重复提交
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
    this.setData({
      options: options,
      btnColor: wx.getStorageSync('btnColor')
    });
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  //支付宝账号
  Alipay: function(res) {
    this.setData({
      Alipay_val: Number(res.detail.value)
    })
  },
  //提现金额
  values: function(res) {
    this.setData({
      values: parseFloat(res.detail.value)
    })
  },

  //点击选择类型
  clickPerson: function() {
    var that = this;
    var selectPerson = this.data.selectPerson;
    wx.showActionSheet({
      itemList: ['微信', '支付宝'],
      success: function(res) {
        if (res.tapIndex == 0) {
          that.setData({
            firstPerson: '微信',
            types: 0
          })
        } else {
          that.setData({
            firstPerson: '支付宝',
            types: 1
          })
        }
        that.setData({
          selectArea: false,
          selectPerson: true
        })
      },
    })
    if (selectPerson == true) {
      this.setData({
        selectArea: true,
        selectPerson: false,
      })
    }
  },
  // 跳转提现进展
  Progress: function() {
    if (this.data.sub) {
      this.setData({
        sub: false
      });
      var that = this;
      var Alipay_num = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/; //验证邮箱
      var tel = /^1[3|4|5|8][0-9]\d{8}$/; //验证手机号
      var reg = /^([1-9][0-9]*)+(.[0-9]{1,2})?$/; //验证输入金额
      if (that.data.firstPerson == '支付宝') {
        if (Alipay_num.test(that.data.Alipay_val) || tel.test(that.data.Alipay_val)) {
          console.log('正确')
        } else {
          wx.showToast({
            title: '请输入正确帐户名',
            icon: 'none'
          });
          that.setData({
            sub: true
          })
          return;
        }
      }
      if (reg.test(that.data.values) && that.data.money >= that.data.values) {
        requ.request({
          url: api.api.myBalanceExtract,
          data: {
            cash_money: that.data.values,
            cash_type: that.data.types,
            cash_account: that.data.Alipay_val
          },
          success: function(res) {
            if (res.code == 0) {
              wx.navigateTo({
                url: '../Progress/Progress?cash_money=' + that.data.values + '&account=' + that.data.firstPerson,
              })
            };
            that.setData({
              values: '',
              sub: true
            });
          },
          fail: function(res) {
            wx.showToast({
              title: '提现失败!' + res.message,
              icon: 'none'
            })
            that.setData({
              sub: true
            });
          }
        })

      } else {
        that.setData({
          sub: true
        });
        wx.showToast({
          title: '金额输入不正确',
          icon: 'none'
        })
      }
    } else {
      wx.showToast({
        title: '请不要重复提交',
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
    this.setData({
      money: this.data.options.money
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
    return {
      title: '蜗店',
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  }
})
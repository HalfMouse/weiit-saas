const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
// pages/Set_up/Set_up.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    date: '请选择生日',
    telNum:'',
    isCode:false,
    validateCode:'',
    inputCode:'',
    isbinding:true,
    user_phone:''
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
  },
  // 获取生日
  bindDateChange: function (e) {
    this.setData({
      date: e.detail.value
    });
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
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
      var that = this
      requ.request({
        url: api.api.userInfo,
        success: function (res) {
          console.log(res);
          if(res.code == '0'){
            that.setData({
              content: res.data,
              user_phone: res.data.user_phone
            })
          }
          
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
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
    return {
      title: '蜗店',
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  },
  // 输入手机号
  telInput(e){
    this.setData({
      telNum: e.detail.value
    })
  },
  // 输入验证码
  codeInput(e){
    this.setData({
      inputCode: e.detail.value
    })
  },
  // 获取验证码
  getCode(){
    let tel = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
    var that = this;
    if (tel.test(this.data.telNum)){
      requ.request({
        url: api.api.getValidateCode,
        data:{
          mobilePhone: that.data.telNum
          
        },
        success: function (res) {
          console.log(res);
          if (res.code == '0') {
            that.setData({
              validateCode:''
            })
          }
        }
      })
      this.setData({
        isCode:true
      })
    }else{
      wx.showToast({
        title: '请填写正确电话格式',
        icon: 'none',
        duration: 2000
      })
    }
  },
  // 绑定注册
  
  binding(){
    var that = this;
    requ.request({
      url: api.api.updateUserPhoneInfo,
      data: {
        mobilePhone: that.data.telNum,
        validateCode: that.data.inputCode
      },
      success: function (res) {
        console.log(res);
        if (res.code == '0') {
          wx.showToast({
            title: res.message,
            icon: 'none',
            success:function(){
              wx.showToast({
                title: '绑定成功',
                icon: 'none',
                success:function(){
                  that.setData({
                    inputCode: '',
                    isCode: false,
                    isbinding: true,
                    user_phone: this.data.telNum
                  })
                }
              })
              
            }
          })
          
        }else{
          wx.showToast({
            title: res.message,
            icon: 'none',
            success:function(){
              that.setData({
                inputCode: ''
              })
            }
          })
          
        }
      }
    })
    
  }
})
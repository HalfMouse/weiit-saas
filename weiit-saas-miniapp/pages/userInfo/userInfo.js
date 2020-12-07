// pages/userInfo/userInfo.js
const util = require('../../utils/util.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    // url: 'https://api.woyoulian.com',
    // url: 'http://192.168.0.128:8081',
    backsImg: ''
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    var that = this;
    wx.showLoading({
      title: '加载中',
    })
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }

    wx.request({
      url: getApp().urls + '/api/navShop',
      data: {
        appid: getApp().appid
      },
      success: res => {
        console.log(res)
        // this.globaLogin.navShopPic = res.data.navShopPic;
        // wx.setStorageSync('navShopPic', res.data.navShopPic);
        that.setData({
          backsImg: res.data.navShopPic
        },() => {
          wx.hideLoading();
        })
      }
    })
    
    // 调用公共数据
    wx.request({
      url: getApp().urls + '/api/initParam',
      data: {
        appid: getApp().appid
      },
      success: (res) => {
        console.log(res.data.data, '全局数据');
        // wx.setStorageSync('bottomMenuList', res.data.data.bottomMenuList);
        wx.setStorageSync('btnColor', res.data.data.globalStyle);
        wx.setStorageSync('globalStyle', res.data.data.globalStyle);
        wx.setNavigationBarColor({
          frontColor: '#ffffff',
          backgroundColor: res.data.data.globalStyle.global_bg1,
        });
        var that=this;
        that.setData({
          btnColor: res.data.data.globalStyle.global_bg1
        })
      }
    })
    this.setData({
      pages: getApp().conFig,
      newTime: util.getTime(parseInt(getApp().conFig.commit_time))
    })
  },

  bindGetUserInfo: function(e) {
    var shareId;
    if (wx.getStorageSync('shareId')){
      shareId = wx.getStorageSync('shareId')
    }
    if (e.detail.errMsg == "getUserInfo:ok") {
      var that = this;
      wx.login({
        success: function(res) {
          wx.request({
            url: getApp().urls + '/api/getOpenidForApp',
            data: {
              code: res.code,
              appid: getApp().appid
            },
            header: {
              'content-type': 'application/x-www-form-urlencoded'
            },
            success: (res) => {
              console.log(res, 'userInfor')
              getApp().globaLogin.openid = res.data.data.openid;
              getApp().globaLogin.sessionKey = res.data.data.sessionKey;
              wx.getUserInfo({
                success: function(res) {
                  console.log(res, '信息')
                  // getApp().encryptedData = res.encryptedData;
                  // getApp().iv = res.iv;
                  wx.setStorageSync('encryptedData', res.encryptedData);
                  wx.setStorageSync('iv', res.iv)
                  wx.request({
                    url: getApp().urls + '/api/maLogin',
                    method: 'POST',
                    header: {
                      'content-type': 'application/x-www-form-urlencoded'
                    },
                    data: {
                      appid: getApp().appid,
                      sessionKey: getApp().globaLogin.sessionKey,
                      encryptedData: res.encryptedData,
                      ivStr: res.iv,
                      wx_open_id: getApp().globaLogin.openid,
                      share_user_id: shareId,
                    },
                    success: function(res) {
                      console.log(res, 'mylogin');
                      if (res.data.code == '0'){
                        wx.setStorageSync('user_id', res.data.data.user_id);
                        wx.setStorageSync('token', res.data.data.token);

                        // getApp().iv = res.iv;
                        var pages = getCurrentPages()
                        var previous = pages[pages.length - 2]; //上一页面
                        previous.setData({
                          refresh: true
                        });
                        wx.navigateBack({
                          delta: 1
                        });
                      }
                    }
                  })
                },
                fail: function() {
                  console.log('用户未授权')
                }
              })
            }
          })
        },
      });
    } else {
      wx.navigateBack({
        delta: 1
      });
    }
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {
  },
  onUnload: function() {},
  onShareAppMessage: function() {
    return {
      title: '蜗店',
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  },
  onShow(){
    
  }
})
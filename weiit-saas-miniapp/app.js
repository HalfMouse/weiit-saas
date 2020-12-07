// app.js
//本地地址
// const url = 'http://192.168.0.128:8081';
//测试地址
// const url = 'https://api.woyoulian.com';
// const url = 'https://woyoulian.com';
// var appid = '';
//线上地址
// var url = 'https://api.ustore.wang';
// var appid = 'wx16abeb3ca941a985';
App({
  // appID
  agree: false,
  page: '',
  appid: '',
  urls: '',
  conFig: {},
  encryptedData: '',
  iv: '',
  indexPage: false, //拼团商品详情页面
  indexFirst: false,
  globalStyle: '',
  detailId: '', //商品详情ID
  groupingId: '', //分组ID
  user_phone:'',
  onShow: function() {
    // 获取第三方自定义数据
    
    let extConfig = wx.getExtConfigSync ? wx.getExtConfigSync() : {}
    console.log(extConfig, 'config')
    if (extConfig !== null) {
      this.appid = extConfig.appid;
      this.urls = extConfig.url;
      this.conFig = extConfig;
    }
    wx.login({
      success: res => {
        
        // console.log('2');
        wx.request({
          url: this.urls + '/api/getOpenidForApp',
          header: {
            'content-type': 'application/x-www-form-urlencoded'
          },
          data: {
            code: res.code,
            appid: this.appid
          },
          success: res => {
            
            this.globaLogin.openid = res.data.data.openid;
            this.globaLogin.sessionKey = res.data.data.sessionKey;
          }
        })
      }
    })

  },
  globaLogin: {
    openid: '',
    sessionKey: '',
    userInfo: '',
    navShopPic:''
  },
  // onShow() {
  //   // this.onLaunch();

  //   // 查看是否授权
  //   wx.getSetting({
  //     success: function(res) {
  //       console.log(res, '授权')
  //       if (res.authSetting['scope.userInfo']) {
  //         getApp().agree = res.authSetting['scope.userInfo']
  //         // 已经授权，可以直接调用 getUserInfo 获取头像昵称
  //         wx.login({
  //           success: function(res) {
  //             console.log(res, '登录')
  //             // this.globalData.loginCode = res.code
  //             if (that.loginCodeCallback) {
  //               wx.request({
  //                 url: getApp().urls + '/api/getOpenidForApp',
  //                 data: {
  //                   code: res.code,
  //                   appid: getApp().appid
  //                 },
  //                 header: {
  //                   'content-type': 'application/x-www-form-urlencoded'
  //                 },
  //                 success: (res) => {
  //                   console.log(res, 'openid')
  //                   getApp().globa.openid = res.data.data.openid;
  //                   getApp().globa.sessionKey = res.data.data.sessionKey
  //                   wx.getUserInfo({
  //                     success: function(res) {
  //                       wx.request({
  //                         url: getApp().urls + '/api/maLogin',
  //                         method: 'POST',
  //                         header: {
  //                           'content-type': 'application/x-www-form-urlencoded'
  //                         },
  //                         data: {
  //                           appid: getApp().appid,
  //                           sessionKey: getApp().globa.sessionKey,
  //                           encryptedData: res.encryptedData,
  //                           ivStr: res.iv,
  //                           wx_open_id: getApp().globa.openid
  //                         },
  //                         success: function(res) {
  //                           console.log(res, '获取token')
  //                           wx.setStorageSync('user_id', res.data.data.user_id);
  //                           wx.setStorageSync('token', res.data.data.token)
  //                         }
  //                       })
  //                     },
  //                     fail: function() {
  //                       console.log('用户未授权')
  //                     }
  //                   })
  //                 }
  //               })
  //             }
  //           },
  //         });
  //       }
  //    
  //     },
  //     fail: function(res) {}
  //   });

  // },
  token: '',
  // login: function () {
  //   var that = this;
  //   wx.login({
  //     success: function (res) {
  //       wx.request({
  //         url: 'http://192.168.0.128:8081/weixin/getOpenidForApp',
  //         data: { code: res.code, appid: getApp().appid },
  //         header: {
  //           'content-type': 'application/x-www-form-urlencoded'
  //         },
  //         success: (res) => {
  //           console.log(res, 'uesr')
  //           getApp().globa.openid = res.data.data.openid
  //           that.getuserinfo()
  //           // if (wx.getStorageSync('page') != 'app') {
  //           //   wx.showModal({
  //           //     title: '警告',
  //           //     content: '若不授权微信登录，则无法使用窝店此功能;点击重新获取授权，则可以重新使用；若点击不授权，则需在微信【发现】——【小程序】——删掉【窝店】，重新搜索“窝店”进入授权登录，方可使用。',
  //           //     cancelText: '不授权',
  //           //     confirmText: '授权',
  //           //     success: function (res) {
  //           //       if (res.confirm) {
  //           //         wx.openSetting({
  //           //           success: function (data) {
  //           //             that.getuserinfo()
  //           //           },
  //           //         })
  //           //       }
  //           //     },
  //           //   })
  //           // } else {
  //           //   that.getuserinfo()
  //           // }
  //         }
  //       })
  //     },
  //   });
  // },
  //获取用户授权信息
  // getuserinfo: function () {
  //   wx.getUserInfo({
  //     success: function (res) {
  //       wx.request({
  //         url: 'http://192.168.0.128:8081/api/maLogin',
  //         method: 'POST',
  //         header: {
  //           'content-type': 'application/x-www-form-urlencoded'
  //         },
  //         data: {
  //           user_nike: res.userInfo.nickName,
  //           user_img: res.userInfo.avatarUrl,
  //           user_sex: res.userInfo.gender,
  //           wx_open_id: getApp().globa.openid,
  //           region: res.userInfo.province + res.userInfo.city
  //         },
  //         success: function (res) {
  //           wx.setStorageSync('user_id', res.data.data.user_id);
  //           wx.setStorageSync('token', res.data.data.token)
  //         }
  //       })
  //     },
  //     fail: function () {
  //       console.log('用户未授权')
  //     }
  //   })
  // },

  // ready: function () {
  //   wx.getSetting({
  //     success: function (res) {
  //       if (res.authSetting['scope.userInfo']) {
  //       } else {
  //         app.login()
  //       }
  //     },
  //   })
  // },

  // 立即购买、加入购物车
  showModal: function(that) {
    // 显示遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    that.animation = animation
    animation.translateY(300).step()
    that.setData({
      animationData: animation.export(),
      showModalStatus: true,
    })
    setTimeout(function() {
      animation.translateY(0).step()
      that.setData({
        animationData: animation.export()
      })
    }.bind(that), 0)
  },
  hideModal: function(that) {
    // 隐藏遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    that.animation = animation
    animation.translateY(300).step()
    that.setData({
      animationData: animation.export(),
    })
    setTimeout(function() {
      animation.translateY(0).step()
      that.setData({
        animationData: animation.export(),
        showModalStatus: false
      })
    }.bind(that), 200)
  },
})
// 网络请求
let request = function({
  url,
  data,
  success,
  method = "POST"
}) {
  let server = getApp().urls; //域名
  var that = this;
  var header = {
    'content-type': 'application/x-www-form-urlencoded;charset=utf-8',
    'token': wx.getStorageSync('token')
  };
  wx.request({
    url: server + url,
    method: method,
    data: data,
    header: header,
    success: (res) => {
      let data = res.data;
      res['statusCode'] === 200 ? success(data) : that.fail();
    },
    fail: function(res) {
      wx.showToast({
        title: res.message,
        icon: 'loading',
        duration: 2000
      })
    },
  });
}
// 验证状态
let verify = function(callback) {
  wx.request({
    url: getApp().urls + '/api/firewallForApp',
    header: {
      'content-type': 'application/x-www-form-urlencoded;charset=utf-8',
      'token': wx.getStorageSync('token')
    },
    data: {
      appid: getApp().appid
    },
    success: function(res) {
      callback(res.data.code)
    }
  });
}
// 验证是否登录
let loginState = function(callback) {

  // 查看是否授权
  var that = this;
  wx.getSetting({
    success: function(res) {
      console.log(res, '7787878887')
      if (res.authSetting['scope.userInfo']) {
        callback(res.authSetting['scope.userInfo']);
      } else {
        wx.navigateTo({
          url: '/pages/userInfo/userInfo',
        })
      }
    }
  })
}
// 后台自定义底部链接
let go_page = function(url, target_id) {
  console.log(target_id, '页面ID')
  switch (url) {
    case 'index':
      var urlCopy = 'indexCopy';
      if (target_id == undefined) {
        wx.reLaunch({
          url: '../' + index + '/' + index + '?page=' + '',
        });
      } else {
        wx.navigateTo({
          url: '../' + urlCopy + '/' + urlCopy + '?page=' + target_id,
        });
      }
      break;
    case 'zidingyi':
      wx.navigateTo({
        url: '../indexCopy/indexCopy?linkUrl=' + target_id + '&link=' + url,
      });
      break;
      // 跳购物车
    case 'shopCar':
      if (getApp().conFig.switchTabUrl != undefined) {
        if (getApp().conFig.switchTabUrl.indexOf('shopCar') != -1) {
          wx.reLaunch({
            url: '../' + url + '/' + url,
          })
        } else {
          wx.navigateTo({
            url: '../' + url + '/' + url,
          })
        }
      } else {
        wx.navigateTo({
          url: '../' + url + '/' + url,
        })
      }
      break;
      // 跳优惠券
    case 'Coupon':
      if (getApp().conFig.switchTabUrl != undefined) {
        if (getApp().conFig.switchTabUrl.indexOf('Coupon') != -1) {
          wx.reLaunch({
            url: '../' + url + '/' + url,
          })
        } else {
          wx.navigateTo({
            url: '../' + url + '/' + url,
          })
        }
      } else {
        wx.navigateTo({
          url: '../' + url + '/' + url,
        })
      }
      break;
      // 跳特惠
    case 'category':
      if (getApp().conFig.switchTabUrl != undefined) {
        if (getApp().conFig.switchTabUrl.indexOf('category')) {
          wx.reLaunch({
            url: '../' + url + '/' + url,
          })
        } else {
          wx.navigateTo({
            url: '../' + url + '/' + url,
          })
        }
      } else {
        wx.navigateTo({
          url: '../' + url + '/' + url,
        })
      }
      break;
      // 跳个人中心
    case 'Personal':
      wx.switchTab({
        url: '../' + url + '/' + url,
      });
      break;
      // 跳订单
    case 'Order':
      wx.navigateTo({
        url: '../' + url + '/' + url + '?id=' + (-1),
      });
      break;
      // 跳商品分组
    case 'productGroup':
      if (getApp().conFig.switchTabUrl != undefined) {
        if (getApp().conFig.switchTabUrl.indexOf('productGroup') != -1) {
          getApp().groupingId = id;
          wx.reLaunch({
            url: '../' + url + '/' + url,
          })
        } else {
          wx.navigateTo({
            url: '../' + url + '/' + url + '?group_ids=' + target_id,
          });
        }
      } else {
        wx.navigateTo({
          url: '../' + url + '/' + url + '?group_ids=' + target_id,
        });
      }
      break;
      // 跳商品详情
    case 'detail':
      if (getApp().conFig.switchTabUrl != undefined) {
        if (getApp().conFig.switchTabUrl.indexOf('detail')!=-1) {
          getApp().detailId = target_id;
          wx.reLaunch({
            url: '../detail/detail',
          })
        } else {
          wx.navigateTo({
            url: '../detail/detail?shop_id=' + target_id,
          })
        }
      } else {
        wx.navigateTo({
          url: '../detail/detail?shop_id=' + target_id,
        })
      };
      break;
    default:
      wx.navigateTo({
        url: '../' + url + '/' + url + '?shop_id=' + target_id,
      })
  };
}
// 广告模块、图文导航跳转
let banner = function(url, id) {
  console.log(id,'商品ID')
  let app = getApp();
  switch (url) {
    // 跳购物车
    case 'shopCar':
      if (app.conFig.switchTabUrl != undefined) {
        if (app.conFig.switchTabUrl.indexOf('shopCar') != -1) {
          wx.reLaunch({
            url: '../' + url + '/' + url,
          })
        } else {
          wx.navigateTo({
            url: '../' + url + '/' + url,
          })
        }
      } else {
        wx.navigateTo({
          url: '../' + url + '/' + url,
        })
      }
      break;
      //跳商品列表
    case 'commodityList':
      // 砍价列表
    case 'teams':
      //拼团列表
    case 'collageList':
      //领取优惠券页面
    case 'Coupon':
      if (app.conFig.switchTabUrl != undefined) {
        if (app.conFig.switchTabUrl.indexOf('Coupon') != -1) {
          wx.reLaunch({
            url: '../' + url + '/' + url,
          })
        } else {
          wx.navigateTo({
            url: '../' + url + '/' + url,
          })
        }
      } else {
        wx.navigateTo({
          url: '../' + url + '/' + url,
        })
      }
      break;
      // 跳个人中心
    case 'Personal':
      wx.reLaunch({
        url: '../' + url + '/' + url,
      });
      break;
      // 跳特惠、分类
    case 'category':
      if (app.conFig.switchTabUrl != undefined) {
        if (app.conFig.switchTabUrl.indexOf('category')) {
          wx.reLaunch({
            url: '../' + url + '/' + url,
          })
        } else {
          wx.navigateTo({
            url: '../' + url + '/' + url,
          })
        }
      } else {
        wx.navigateTo({
          url: '../' + url + '/' + url,
        })
      }
      break;
      // 跳微页面
    case 'index':
      var urlCopy = 'indexCopy';
      if (id == undefined) {
        wx.reLaunch({
          url: '../' + index + '/' + index + '?page=' + '',
        });
      } else {
        wx.navigateTo({
          url: '../' + urlCopy + '/' + urlCopy + '?page=' + id,
        });
      }
      break;
      // 跳订单
    case 'Order':
      wx.navigateTo({
        url: '../' + url + '/' + url + '?id=' + (-1),
      });
      break;
      // 跳商品详情
    case 'detail':
      if (app.conFig.switchTabUrl != undefined) {
        if (app.conFig.switchTabUrl.indexOf('detail')!=-1) {
          app.detailId = id;
          wx.reLaunch({
            url: '../detail/detail',
          })
        } else {
          wx.navigateTo({
            url: '../detail/detail?shop_id=' + id,
          })
        }
      } else {
        wx.navigateTo({
          url: '../detail/detail?shop_id=' + id,
        })
      };
      break;
      // 跳商品分组
    case 'productGroup':
      console.log(app.conFig, '商品分组')
      if (app.conFig.switchTabUrl != undefined) {
        console.log(app.conFig.switchTabUrl.indexOf('productGroup'), id)
        if (app.conFig.switchTabUrl.indexOf('productGroup') != -1) {
          app.groupingId = id;
          wx.reLaunch({
            url: '../' + url + '/' + url,
          })
        } else {
          wx.navigateTo({
            url: '../' + url + '/' + url + '?group_ids=' + id,
          });
        }
      } else {
        wx.navigateTo({
          url: '../' + url + '/' + url + '?group_ids=' + id,
        });
      }
      break;
    default:
      console.log(id)
      wx.navigateTo({
        url: '../' + url + '/' + url + '?shop_id=' + id,
      })
  }
}
// 重新获取token
let getToken = function() {
  wx.getUserInfo({
    success: res => {
      wx.request({
        url: getApp().urls + '/api/maLogin',
        method: 'POST',
        header: {
          'content-type': 'application/x-www-form-urlencoded'
        },
        data: {
          appid: getApp().appid,
          sessionKey: getApp().globaLogin.sessionKey,
          encryptedData: getApp().encryptedData,
          ivStr: getApp().iv,
          wx_open_id: getApp().globaLogin.openid
        },
        success: res => {
          wx.setStorageSync('token', res.data.data.token);
          wx.setStorageSync('user_id', res.data.data.user_id);
          // 调用公共数据
          wx.request({
            url: getApp().urls + '/api/initParam',
            data: {
              appid: getApp().appid
            },
            success: (res) => {
              console.log(res.data.data, '全局数据')
              wx.setStorageSync('bottomMenuList', res.data.data.bottomMenuList);
              wx.setStorageSync('btnColor', res.data.data.globalStyle);
              wx.setStorageSync('globalStyle', res.data.data.globalStyle);
              wx.setNavigationBarColor({
                frontColor: '#ffffff',
                backgroundColor: res.data.data.globalStyle.global_bg1,
              })
            }
          })
        }
      })
    }
  })
}
module.exports = {
  request: request,
  verify: verify,
  loginState: loginState,
  go_page: go_page,
  banner: banner,
  getToken: getToken
}
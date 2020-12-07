//index.js
//获取应用实例
const app = getApp();
const util = require('../../utils/util.js');
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');

// 音频播放
const innerAudioContext = wx.createInnerAudioContext();
var downTime;
Page({
  data: {
    load: false,
    pageTitle: '', //页面标题
    page: '', //当前微页面ID
    item: [], //首页数据
    coupon_ids: [], //优惠券
    currentTab: 0,
    cliclIndex: 0,
    collage: [], //拼团列表
    audio: [],
    duration: 0,
    currentTime: 0,
    audioContent: [], //语音
    audioIndex: 0, //正在播放音频的index
    cutContent: [], //砍价信息
    refresh: false, //授权页面回来带的参数
    index: 0,
    seek: 0, //播放位置
    play: '../../images/gif.gif',
    plays: '../../images/play_right.png'
  },
  navbarTap: function (e) {
    // console.log(e);
    this.setData({
      currentTab: e.currentTarget.dataset.idx
    })

  },
  onLoad: function (options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    if (app.conFig.pageId != undefined && app.conFig.pageId) {
      this.setData({
        page: app.conFig.pageId
      })
    } else {
      if (options.page) {
        if (options.page == 'undefined') {
          this.setData({
            page: ''
          })
        } else {
          this.setData({
            page: options.page
          })
        }
      };
    }

  },

  // 去授权
  jump: function () {
    wx.showModal({
      title: '',
      content: '需要先授权，是否去授权',
      success: (res) => {
        if (res.confirm) {
          wx.navigateTo({
            url: '../userInfo/userInfo',
          })
        }
      }
    })
  },


  // 底部导航页面跳转
  goPage: function (e) {
    var url = e.currentTarget.dataset.url;
    var target_id = e.currentTarget.dataset.target_id;
    requ.go_page(url, target_id);
  },
  // slider滑动
  sliders: function (e) {
    // var slidersIndex = e.currentTarget.dataset.index;
    // var slidersId = e.currentTarget.dataset.id;
    this.setData({
      seek: e.detail.value
    });
    var seeks = this.data.duration / (100 / e.detail.value)
    innerAudioContext.seek(seeks)

  },
  // 播放音频
  play: function (e) {
    var that = this;
    var audioId = e.currentTarget.dataset.id;
    var audioIndex = e.currentTarget.dataset.index;
    var audioUrl;
    var audioBool;
    for (var i = 0; i < that.data.audioContent.length; i++) {
      if (that.data.audioContent[i].id == audioId) {
        audioUrl = that.data.audioContent[i].pageParam.voiceData.file_url;
        audioBool = 'audioContent[' + audioIndex + '].play';
        that.setData({
          [audioBool]: !that.data.audioContent[audioIndex].play
        })
      }
    };
    console.log(that.data.audioContent[audioIndex].play)
    if (that.data.audioContent[audioIndex].play) {
      innerAudioContext.autoplay = true;
      innerAudioContext.src = 'http://weiyuntest-1253191691.image.myqcloud.com' + audioUrl;
      if (that.data.audioContent[audioIndex].pageParam.AfterStop == "again" && that.data.audio.progress != undefined) {
        innerAudioContext.seek(that.data.audio.progress)
      } else {
        innerAudioContext.onPlay(() => {
          innerAudioContext.onTimeUpdate(() => {
            var value = util.convert(parseInt(innerAudioContext.duration) - parseInt(innerAudioContext.currentTime));
            var progress = 100 / (parseInt(innerAudioContext.duration) / parseInt(innerAudioContext.currentTime));
            that.setData({
              duration: innerAudioContext.duration,
              ['audio.duration']: value,
              ['audio.progress']: progress
            })
          })
        });
        innerAudioContext.onEnded(() => {
          that.setData({
            [audioBool]: !that.data.audioContent[audioIndex].play,
            ['audio.progress']: 0
          })
        })
      }
    } else {
      if (that.data.audioContent[audioIndex].pageParam.AfterStop == "again") {
        that.setData({
          audio: that.data.audio
        })
      }
      innerAudioContext.stop()
    };
  },
  // 领取优惠券
  // receive: function(e) {
  //   var index = e.currentTarget.dataset.index;
  //   var that = this;
  //   console.log(that.data.coupon[index].receive)
  //   if (that.data.coupon[index].receive) {
  //     requ.request({
  //       url: api.api.couponGet,
  //       data: {
  //         coupon_id: e.currentTarget.dataset.id
  //       },
  //       success: (res) => {
  //         var coupon = 'coupon[' + index + '].imgUrl';
  //         var Receive = 'coupon[' + index + '].receive';
  //         if (res.code == 4000) {
  //           that.setData({
  //             [coupon]: '../../images/coupon1.png',
  //             [Receive]: false
  //           })
  //           wx.showToast({
  //             title: res.message,
  //             icon: 'none'
  //           })
  //         } else {
  //           var coupon = 'coupon[' + index + '].imgUrl'
  //           that.setData({
  //             [coupon]: '../../images/coupon1.png'
  //           });
  //         }
  //       }
  //     })
  //   }
  // },
  // 搜索页
  go_serach: function (e) {
    var that = this;
    // 页面跳转拦截
    requ.verify(function (code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../search/search?content=' + that.data.content,
        })
      }
    })
  },

  // 查看全部砍价、拼团
  look_orr: function (e) {
    var value = e.currentTarget.dataset.value;
    // 页面跳转拦截
    requ.verify(function (code) {
      if (code == 0) {
        if (value == "collage") {
          wx.navigateTo({
            url: '../collageList/collageList',
          })
        }
        if (value == "cut") {
          wx.navigateTo({
            url: '../teams/teams',
          })
        }

      }
    })
  },

  //帮我砍价
  helpMe: function (e) {
    console.log(e, 'formid')
    // 添加formId
    requ.request({
      url: api.api.formID,
      data: {
        openId: app.globaLogin.openid,
        formId: e.detail.formId,
      },
      success: res => console.log(res)
    });
    var id = e.detail.target.dataset.id
    var value = e.detail.target.dataset.value
    // 页面跳转拦截
    requ.verify(function (code) {
      if (code == 0) {
        // 砍价接口
        requ.request({
          url: api.api.isBargain,
          data: {
            bargain_id: e.currentTarget.dataset.id
          },
          success: function (res) {
            if (res.data.isBargain == true) {
              wx.navigateTo({
                url: '../chopPage/chopPage?bargain_id=' + id + '&b_order_id=' + res.data.b_order_id,
              })
            } else {
              wx.navigateTo({
                url: '../address/address?value=' + value + '&bargain_id=' + id,
              })
            }
          }
        })
      }
    })
  },
  // 去商品详情
  go_detail: function (e) {
    console.log(e, 'formid')
    // 添加formId
    requ.request({
      url: api.api.formID,
      data: {
        openId: app.globaLogin.openid,
        formId: e.detail.formId,
      },
      success: res => console.log(res)
    });
    // 页面跳转拦截
    requ.verify(function (code) {
      if (code == 0) {
        if (app.conFig.switchTabUrl != undefined) {
          if (app.conFig.switchTabUrl.indexOf('detail') != -1) {
            app.detailId = e.detail.target.dataset.product_id;
            wx.reLaunch({
              url: '../detail/detail',
            })
          } else {
            wx.navigateTo({
              url: '../detail/detail?shop_id=' + e.detail.target.dataset.product_id,
            })
          }
        } else {
          wx.navigateTo({
            url: '../detail/detail?shop_id=' + e.detail.target.dataset.product_id,
          })
        };

      }
    })
  },
  // 左边分类导航名
  groupBtn: function (e) {
    var index = e.currentTarget.dataset.index;
    var scrollTop;
    if (index > 0) {
      scrollTop = ((this.data.group_con[index - 1].productInfo.length - 1) * 35) + (this.data.group_con[index - 1].productInfo.length * 75) + ((this.data.group_con[index - 1].productInfo.length - 1) * 1)
    } else {
      scrollTop = 0
    }
    this.setData({
      scrollTop: scrollTop,
      cliclIndex: index
    })
    console.log(this.data.group_con)
  },
  // 页面加载
  onShow: function (e) {
    wx.getSetting({
      success: res => {
        if (res.authSetting['scope.userInfo']) {
          this.allData();
          wx.showLoading({
            title: '加载中',
          })
        } else {
          wx.navigateTo({
            url: '../userInfo/userInfo',
          })
        }
      }
    });
  },
  allData: function () {
    var that = this;
    // 所有数据
    requ.request({
      url: api.api.tehuimai,
      success: function (res) {
        if (res.code == '0') {
          var layout = JSON.parse(res.data.page_layout);
          wx.hideLoading()
          var audios = [];
          // 获取商品列表的数组ID
          for (let i = 0; i < layout.length; i++) {
            // banner图
            if (layout[i].type == "advertisement") {
              layout[i].height = 98 / parseFloat((layout[i].pageParam.imgWidth / layout[i].pageParam.imgHeight).toFixed(2))
            };
            // 商品列表
            if (layout[i].type == "Commodity_list") {
              //   var productGetType;
              //   var showNum;
              //   if (layout[i].pageParam.addFun == "automatic") {
              //     productGetType = 1;
              //     showNum = layout[i].pageParam.showNum;
              //   };
              //   if (layout[i].pageParam.addFun == "manual") {
              //     productGetType = 0;
              //     showNum = ''
              //   };
              //   requ.request({
              //     url: api.api.getProductListByIds,
              //     data: {
              //       productIds: layout[i].pageParam.productIds,
              //       productGetType: productGetType,
              //       showNum: showNum
              //     },
              //     success: function(res) {
              //       that.setData({
              //         list: res.data.productInfo,
              //         scroll_width: res.data.length * 33,
              //       });
              //       for (var j = 0; j < layout.length; j++) {
              //         if (layout[j].type == "Commodity_list") {
              //           if (layout[j].pageParam.listStyle == "zigzag") {
              //             that.setData({
              //               list: res.data.productInfo.slice(0, 3)
              //             })
              //           }
              //         }
              //       }
              //     }
              //   });
            };
            // 商品分组
            if (layout[i].type == "Commodity_sort") {
              if (layout[i].pageParam.group_ids != "") {
                layout[i].choice = false;
                layout[i].indexs = i
                // requ.request({
                //   url: api.api.getProductByGroupIds,
                //   data: {
                //     group_ids: layout[i].pageParam.group_ids,
                //     sortOrder: layout[i].pageParam.sortOrder
                //   },
                //   success: function(res) {
                //     // console.log(res, '商品分组1')
                //     that.setData({
                //       group_con: res.data,
                //       navWidth: 100 / res.data.length
                //     })
                //   }
                // })
              }
            };
            // 拼团
            if (layout[i].type == "fight") {

            };
            // 砍价
            if (layout[i].type == "bargain") {

            }
            // 优惠券
            if (layout[i].type == "coupon") {
              that.setData({
                coupon_ids: layout[i].pageParam.coupon_ids
              });
              // 优惠券
              // var couponGetType;
              // var showNum = '';
              // if (layout[i].pageParam.addFun == "automatic") {
              //   couponGetType = 1;
              //   showNum = layout[i].pageParam.showNum === undefined || layout[i].pageParam.showNum === null ? 0 : layout[i].pageParam.showNum;
              // };
              // if (layout[i].pageParam.addFun == "manual") {
              //   couponGetType = 0;
              //   showNum = ''
              // }
              // requ.request({
              //   url: api.api.couponListByIds,
              //   data: {
              //     coupon_ids: that.data.coupon_ids,
              //     couponGetType: couponGetType,
              //     showNum: showNum
              //   },
              //   success: function(res) {
              //     for (var i = 0; i < res.data.length; i++) {
              //       res.data[i].imgUrl = '../../images/coupon2.png';
              //       res.data[i].receive = true;
              //     }
              //     console.log(res, '优惠券列表')
              //     if (res.data.length < 3) {
              //       that.setData({
              //         coupon: res.data,
              //         voucherWidth: 100,
              //       })
              //     } else {
              //       that.setData({
              //         coupon: res.data,
              //         voucherWidth: res.data.length * 50,
              //       })
              //     }
              //   }
              // })
            };
            // 图文导航
            if (layout[i].type == "nav") {
              that.setData({
                moduWidth: 100 / layout[i].pageParam.navList.length,
              })
            };
            // 音频
            if (layout[i].type == "voice") {
              var audios;
              audios.push(layout[i]);
              for (var x = 0; x < audios.length; x++) {
                audios[x].play = false;
                audios[x].index = x
              }
              console.log(audios, '音频')
              that.setData({
                audioContent: audios
              })
            };
          };
          wx.hideLoading();
          that.setData({
            pageTitle: res.data.page_name,
            layout: JSON.parse(res.data.page_layout),
            load: true,
            // bottomMenuList: wx.getStorageSync('bottomMenuList'),
            btnColor: wx.getStorageSync('btnColor')
          });
          // 设置页面标题
          wx.setNavigationBarTitle({
            title: res.data.page_name
          });
        } else if (res.code == '1001002') {
          requ.getToken();
          that.onShow();
        }
      }
    })
  },
  onUnload: function () { },
  // 页面分享
  onShareAppMessage: function () {
    return {
      title: this.data.pageTitle,
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  }
})
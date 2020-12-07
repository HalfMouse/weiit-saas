// pages/detail/detail.js
var WxParse = require('../../wxParse/wxParse.js');
var util = require('../../utils/util.js');
const requ = require('../../utils/request.js')
const api = require('../../utils/api.js')
var app = getApp();
var down; //倒计时
Page({

  /**
   * 页面的初始数据
   */
  data: {
    datas: [],
    discount_price: 0, //拼团价格
    Load: false, //数据加载完显示
    countDown: 0, //倒计时
    Collection: false, //是否收藏
    options: [], //商品ID
    product_id: 0, //商品ID
    imgs_url: [], //轮播图图片数组
    color: ['军绿', '深蓝', '黑色'],
    size: ['35', '36', '37', '38', '39', '40', '41', '42', '43', '44', ],
    buy_num: 1, //购买商品数量
    Stock: 0, //商品库存
    Price: 0, //商品价格
    choic: '', //选择、规格
    commodity: [], //选择的商品的信息
    spe_con: [], //商品规格信息文字版
    message: '', //提示信息
    complete: false, //选择尺码接口执行完毕与否
    showModalStatus: false,
    modalFlag: true,
    information: [], //商品详情内容
    collageList: [], //拼单列表
    value: '', //判断是单独购买还是拼团
    isHidden: true, //是否隐藏去拼单弹出层
    maxLength: 8, //显示当前参加拼单用户的最大数量
    g_order_id: 0, //发起拼团的拼团ID
    navbar: ['商品详情', '商品属性'], //商品信息以及商品属性分组
    currentTab: 0,
  },
  navbarTap: function(e) {
    this.setData({
      currentTab: e.currentTarget.dataset.index
    });
  },
  // 底部导航页面跳转
  goPage: function(e) {
    var url = e.currentTarget.dataset.url;
    var target_id = e.currentTarget.dataset.target_id;
    requ.go_page(url, target_id);
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
    });
  },
  // 预览
  preview: function() {
    wx.previewImage({
      urls: this.data.imgs_url,
    })
  },
  // 去首页
  go_index: function() {
    wx.reLaunch({
      url: '../index/index',
    })
  },
  // 去购物车
  go_car: function() {
    wx.navigateTo({
      url: '../car/car',
    })
  },
  // 收藏
  Collection: function() {
    var that = this;
    // 未收藏时
    if (that.data.Collection == false) {
      requ.request({
        url: api.api.addProductCollection,
        data: {
          product_id: that.data.product_id
        },
        success: function(res) {
          that.setData({
            Collection: true
          })
        }
      })
      // 已经收藏
    } else if (that.data.Collection == true) {
      requ.request({
        url: api.api.myCollectionDelete,
        data: {
          product_id: that.data.product_id
        },
        success: function(res) {
          that.setData({
            Collection: false
          })
        }
      })
    }
  },

  // 单独购买
  alone: function() {
    var user_id = wx.getStorageSync('user_id')
    if (user_id == "") {
      app.login()
    } else {
      this.setData({
        discount_price: this.data.information.sale_price
      })
      // 显示遮罩层
      app.showModal(this);
      this.setData({
        value: '单独购买'
      })
    }
  },
  // 发起拼团
  launch: function() {
    var user_id = wx.getStorageSync('user_id')
    if (user_id == "") {
      app.login()
    } else {
      this.setData({
        discount_price: this.data.datas.groupon_price
      })
      // 显示遮罩层
      app.showModal(this);
      this.setData({
        value: '发起拼团'
      })
    }
  },
  choice_spce: function(e) {
    this.setData({
      choic: e.currentTarget.dataset.type
    })
    // 显示遮罩层
    app.showModal(this);
  },
  hide: function() {
    app.hideModal(this);
    if (this.data.information.spec_info) {
      for (var i = 0; i < this.data.information.spec_info.length; i++) {
        for (var j = 0; j < this.data.information.spec_info[i].values.length; j++) {
          this.data.information.spec_info[i].values[j].Choice = false
        }
      };
    }
    this.setData({
      information: this.data.information,
      spe_con: [],
      choic: ''
    })
    // 隐藏遮罩层
  },

  //选择尺码
  size: function(e) {
    this.setData({
      complete: false, //防止选择规格与提交规格不同
    });
    var attr_index = e.currentTarget.dataset.index;
    var attr_value = e.currentTarget.dataset.value;
    var attr_id = e.currentTarget.dataset.id
    var row;
    var flag = true;
    for (var i = 0; i < this.data.information.spec_info.length; i++) {
      for (var j = 0; j < this.data.information.spec_info[i].values.length; j++) {
        if (this.data.information.spec_info[i].values[j].spec_value == attr_value) {
          row = i;
          break;
        }
      }
    }
    this.get_null(row)
    var str = 'information.spec_info[' + row + '].values[' + attr_index + '].Choice';
    this.setData({
      [str]: true
    })
    var flag = this.checkSize()
    if (flag) {
      var is_choice = [];
      var spe_content = [];
      for (var m = 0; m < this.data.information.spec_info.length; m++) {
        for (var u = 0; u < this.data.information.spec_info[m].values.length; u++) {
          if (this.data.information.spec_info[m].values[u].Choice == true) {
            is_choice.push(this.data.information.spec_info[m].values[u].spec_value_id);
            spe_content.push(this.data.information.spec_info[m].values[u].spec_value)
          }
        }
      }
      var that = this;
      if (that.data.value == '发起拼团' || that.data.value == '参加拼团') {
        requ.request({
          url: api.api.grouponProductSpecCheck,
          data: {
            product_id: that.data.product_id,
            spec_custom: is_choice.join(';')
          },
          success: function(res) {
            // 如果选择尺码前选择的商品数量大于选择尺码后剩余库存数量，那么选中的数量将改编为剩余库存数量
            if (res.code == '0') {
              if (that.data.buy_num > res.data.stock) {
                that.setData({
                  nuy_num: res.data.stock
                })
              };
              that.setData({
                commodity: res.data,
                Stock: res.data.stock,
                discount_price: res.data.groupon_price,
                spe_con: spe_content,
                complete: true, //选择尺码执行完毕
              })
            } else {
              that.setData({
                message: res.message
              })
            }

          }
        });
      } else {
        requ.request({
          url: api.api.productSpecCheck,
          data: {
            product_id: that.data.product_id,
            spec_custom: is_choice.join(';')
          },
          success: function(res) {
            // 如果选择尺码前选择的商品数量大于选择尺码后剩余库存数量，那么选中的数量将改编为剩余库存数量
            if (res.code == '0') {
              if (that.data.buy_num > res.data.stock) {
                that.setData({
                  nuy_num: res.data.stock
                })
              };
              that.setData({
                commodity: res.data,
                Stock: res.data.stock,
                discount_price: res.data.sale_price,
                spe_con: spe_content,
                complete: true, //选择尺码执行完毕
              })
            } else {
              that.setData({
                message: res.message
              })
            }
          }
        })
      }
    }
  },
  get_null: function(row) {
    for (var i = 0; i < this.data.information.spec_info[row].values.length; i++) {
      var nulls = 'information.spec_info[' + row + '].values[' + i + '].Choice';
      this.setData({
        [nulls]: false
      })
    }
  },
  checkSize: function() {
    //如果返回true。那么说明都选中
    let flag = true;
    for (let i of this.data.information.spec_info) {
      let item = i;
      let arr = item.values;
      let index = arr.findIndex((ele) => {
        return ele.Choice
      })
      if (index <= -1) {
        flag = false;
        break;
      }
    }
    return flag;
  },
  //增加购买数量
  add_num: function() {
    if (this.data.information.max_limit > 0) {
      if (this.data.buy_num < this.data.information.max_limit) {
        this.setData({
          buy_num: this.data.buy_num + 1
        })
      } else {
        wx.showToast({
          title: '该商品限购' + this.data.information.max_limit + '件',
          icon: 'none',
          duration: 1000
        })
      }
    } else {
      if (this.data.buy_num < this.data.Stock) {
        this.setData({
          buy_num: this.data.buy_num + 1
        })
      } else {
        wx.showToast({
          title: '最多选择' + this.data.Stock + '件商品',
          icon: 'none',
          duration: 1000
        })
      }
    }
  },
  //减少购买数量
  reduce_num: function() {
    if (this.data.buy_num > 1) {
      this.setData({
        buy_num: this.data.buy_num - 1
      })
    } else {
      wx.showToast({
        title: '最少选择1件商品',
        icon: 'none',
        duration: 1000
      })
    }
  },
  // 确认
  confirm: function(e) {
    var that = this;
    if (that.data.choic) {
      that.setData({
        value: e.currentTarget.dataset.value,
        choic:''
      })
    };
    if (that.data.message) {
      wx.showToast({
        title: that.data.message,
        icon: 'none'
      })
    } else {
      if (that.data.information.spec_config == 0) {
        app.hideModal(that);
        that.setData({
          spe_con: ''
        });
        var data;
        if (that.data.value == '单独购买') {
          requ.request({
            url: api.api.addUserCart,
            data: {
              product_id: parseInt(that.data.information.product_id),
              item_id: that.data.information.item_id,
              spec_content: '',
              count: that.data.buy_num
            },
            success: function(res) {
              if (res.code == 0) {
                wx.navigateTo({
                  url: '../car/car',
                })
              } else {
                wx.showToast({
                  title: '操作失败！' + res.message,
                  icon: 'none'
                })
              }
            }
          })

        }
        if (that.data.value == '发起拼团') {
          if (that.data.message) {
            wx.showToast({
              title: that.data.message,
              icon: 'none'
            })
          } else {
            if (that.data.Stock > that.data.content.extInfo.allInGroupon) {
              data = {
                product_id: parseInt(that.data.options.shop_id),
                groupon_id: parseInt(that.data.options.groupon_id),
                item_id: that.data.information.item_id,
                spec_content: '',
                count: that.data.buy_num,
                title: that.data.information.product_name,
                img: that.data.information.product_img,
                sale_price: that.data.Price,
                value: that.data.value
              };
              // 页面跳转拦截
              requ.verify(function(code) {
                if (code == 0) {
                  wx.navigateTo({
                    url: '../cutCar/cutCar?data=' + JSON.stringify(data),
                  })
                }
              })
            } else {
              wx.showToast({
                title: '对不起,此商品库存不足以完成本次拼团，如要购买请选择单独购买',
                icon: 'none'
              })
            }
          }
        }
        if (that.data.value == '参加拼团') {
          data = {
            g_order_id: that.data.g_order_id,
            product_id: parseInt(that.data.options.shop_id),
            groupon_id: parseInt(that.data.options.groupon_id),
            item_id: that.data.information.item_id,
            spec_content: '',
            count: that.data.buy_num,
            title: that.data.information.product_name,
            img: that.data.information.product_img,
            sale_price: that.data.Price,
            value: that.data.value
          };
          // 页面跳转拦截
          requ.verify(function(code) {
            if (code == 0) {
              wx.navigateTo({
                url: '../cutCar/cutCar?data=' + JSON.stringify(data),
              })
            }
          })
        }
      } else {
        if (that.data.complete) {
          // if (that.data.spe_con == '') {
          //   wx.showToast({
          //     title: '请选择规格参数',
          //     icon: 'none'
          //   });
          // } else {

          app.hideModal(that);
          var data;
          if (that.data.value == '单独购买') {
            requ.request({
              url: api.api.addUserCart,
              data: {
                product_id: parseInt(that.data.commodity.product_id),
                item_id: that.data.commodity.item_id,
                spec_content: that.data.spe_con.join(';'),
                count: that.data.buy_num
              },
              success: function(res) {
                wx.navigateTo({
                  url: '../car/car',
                })
              }
            })
          }
          if (that.data.value == '发起拼团') {
            if (that.data.Stock > that.data.content.extInfo.allInGroupon) {
              data = {
                product_id: parseInt(that.data.options.shop_id),
                groupon_id: parseInt(that.data.options.groupon_id),
                item_id: that.data.commodity.item_id,
                spec_content: that.data.spe_con.join(';'),
                count: that.data.buy_num,
                title: that.data.information.product_name,
                img: that.data.information.product_img,
                sale_price: that.data.commodity.groupon_price,
                value: that.data.value
              };
              // 页面跳转拦截
              requ.verify(function(code) {
                if (code == 0) {
                  wx.navigateTo({
                    url: '../cutCar/cutCar?data=' + JSON.stringify(data),
                  })
                }
              })
            } else {
              wx.showToast({
                title: '库存不足',
                icon: 'none'
              })
            }

          }
          if (that.data.value == '参加拼团') {
            data = {
              g_order_id: that.data.g_order_id,
              product_id: parseInt(that.data.options.shop_id),
              groupon_id: parseInt(that.data.options.groupon_id),
              item_id: that.data.commodity.item_id,
              spec_content: that.data.spe_con.join(';'),
              count: that.data.buy_num,
              title: that.data.information.product_name,
              img: that.data.information.product_img,
              sale_price: that.data.commodity.groupon_price,
              value: that.data.value
            };
            // 页面跳转拦截
            requ.verify(function(code) {
              if (code == 0) {
                wx.navigateTo({
                  url: '../cutCar/cutCar?data=' + JSON.stringify(data),
                })
              }
            })
          }
          // }
        } else {
          wx.showToast({
            title: '请选择规格参数',
            icon: 'none'
          });
        }
      }
    }
  },
  // 更多拼团
  more: function() {
    this.setData({
      modalFlag: false
    })
  },
  //隐藏更多拼团
  colose: function() {
    this.setData({
      modalFlag: true
    })
  },
  // 去拼单
  go_team: function(e) {
    this.setData({
      modalFlag: true
    })
    var id = e.currentTarget.dataset.id;
    var user_id = e.currentTarget.dataset.userid;
    var that = this;
    if (user_id == wx.getStorageSync('user_id')) {
      wx.showToast({
        title: '对不起,不可以参加自己的拼团',
        icon: 'none'
      })
    } else {
      requ.request({
        url: api.api.getJoinGrouponInfo,
        data: {
          g_order_id: id,
          groupon_id: that.data.options.groupon_id
        },
        success: function(res) {
          if (res.data.user_img.length > 8) {
            that.setData({
              maxLength: 8
            })
          } else {
            that.setData({
              maxLength: res.data.groupon_number
            })

          }
          that.setData({
            g_order_id: id,
            isHidden: false,
            content: res.data
          })
        }
      })
    }
  },
  // 隐藏去拼单弹出层
  cancel: function() {
    this.setData({
      isHidden: true
    })
  },
  // 参加拼单
  yes: function(e) {
    if (this.data.content.isJoin) {
      wx.showToast({
        title: '对不起,您已经参与过该拼团了',
        icon: 'none'
      })
    } else {
      this.setData({
        isHidden: true,
        value: e.currentTarget.dataset.value,
        showModalStatus: true,
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
    // if (wx.getStorageSync('token') != '') {
    // 查看是否授权
    wx.getSetting({
      success: res => {
        var that = this;
        if (res.authSetting['scope.userInfo']) {
          wx.showLoading({
            title: '加载中',
          })
          wx.setStorageSync('page', 'detail')
          requ.request({
            url: api.api.grouponProduct,
            data: {
              product_id: that.data.options.shop_id,
              groupon_id: that.data.options.groupon_id,
              user_id: wx.getStorageSync('user_id')
            },
            success: function(res) {
              console.log(res, '商品详情')
              if (res.code == '0') {
                var imgs = [];
                var article = res.data.productDetail.product_info.product_desc;
                var temp = WxParse.wxParse('article', 'html', article, that, 0);
                // 是否是单规格商品
                if (res.data.productDetail.product_info.is_collection == '0') { //是否收藏
                  that.setData({
                    Collection: false
                  })
                } else {
                  that.setData({
                    Collection: true
                  })
                }
                // 轮播图预览图片集
                for (var i = 0; i < res.data.productDetail.product_info.product_imgs.length; i++) {
                  imgs.push('http://wstore-1255653546.image.myqcloud.com' + res.data.productDetail.product_info.product_imgs[i].product_img);
                };
                // 选择商品属性
                if (res.data.productDetail.product_info.spec_info) {
                  for (var i = 0; i < res.data.productDetail.product_info.spec_info.length; i++) {
                    for (var j = 0; j < res.data.productDetail.product_info.spec_info[i].values.length; j++) {
                      res.data.productDetail.product_info.spec_info[i].values[j].Choice = false
                    }
                  };
                }
                //倒计时时间
                for (var i = 0; i < res.data.inProcessGroupon.length; i++) {
                  res.data.inProcessGroupon[i].countDown = util.Time(res.data.inProcessGroupon[i].end_time - new Date().getTime());
                  that.setData({
                    ['collageList[' + i + '].countDown']: res.data.inProcessGroupon[i].countDown, //拼单列表
                    ['list[' + i + '].countDown']: res.data.inProcessGroupon[i].countDown, //拼单列表
                  })
                }
                down = setInterval(time, 1000)

                function time() {
                  for (var i = 0; i < res.data.inProcessGroupon.length; i++) {
                    res.data.inProcessGroupon[i].countDown = util.Time(res.data.inProcessGroupon[i].end_time - new Date().getTime());
                    that.setData({
                      ['collageList[' + i + '].countDown']: res.data.inProcessGroupon[i].countDown, //拼单列表
                      ['list[' + i + '].countDown']: res.data.inProcessGroupon[i].countDown, //拼单列表
                    })
                  }
                }
                that.setData({
                  Load: true, //页面加载完毕
                  content: res.data,
                  datas: res.data.extInfo,
                  information: res.data.productDetail.product_info, //商品详情内容
                  collageList: res.data.inProcessGroupon, //拼单列表
                  Price: res.data.extInfo.groupon_price, //价格
                  Stock: res.data.productDetail.product_info.stock, //商品库存
                  article: temp, //富文本
                  product_id: that.data.options.shop_id, //商品ID
                  imgs_url: imgs, //轮播图图集（预览用）
                  bottomMenuList: wx.getStorageSync('bottomMenuList'),
                  btnColor: wx.getStorageSync('btnColor')
                });
                wx.hideLoading();
                wx.setNavigationBarColor({
                  frontColor: '#ffffff',
                  backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
                })
              } else if (res.code == '1001002') {
                wx.hideLoading();
                wx.request({
                  url: app.urls + '/api/maLogin',
                  method: 'POST',
                  header: {
                    'content-type': 'application/x-www-form-urlencoded'
                  },
                  data: {
                    appid: app.appid,
                    sessionKey: app.globaLogin.sessionKey,
                    encryptedData: wx.getStorageSync('encryptedData'),
                    ivStr: wx.getStorageSync('iv'),
                    wx_open_id: app.globaLogin.openid
                  },
                  success: res => {
                    wx.setStorageSync('token', res.data.data.token);
                    wx.setStorageSync('user_id', res.data.data.user_id);
                    that.onShow();
                  }
                })
              }
            },
            fail: res => {
              console.log(res, '错误原因')
            }
          })
        } else {
          wx.navigateTo({
            url: '../userInfo/userInfo',
          })
        }
      }
    });

    // } else {
    //   wx.navigateTo({
    //     url: '../userInfo/userInfo',
    //   })
    // }
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
    clearInterval(down)
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
      title: this.data.information.product_name,
      path: '/pages/Collage/Collage?shop_id=' + this.data.options.shop_id + '&groupon_id=' + this.data.options.groupon_id + '&share_user_id=' + wx.getStorageSync('user_id'),
      success: (res) => {
        console.log(res)
      },
      fail: (res) => {
        console.log(res)
      }
    }
  }
})
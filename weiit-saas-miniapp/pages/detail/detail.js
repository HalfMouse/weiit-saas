// pages/detail/detail.js
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
var WxParse = require('../../wxParse/wxParse.js')
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    load: false, //数据加载完显示
    options: [], //上个页面传递过来的参数
    Collection: false, //是否收藏
    product_id: 0, //商品ID
    shop_id: Number, //传值商品ID
    imgs_url: [], //轮播图图片数组
    color: ['军绿', '深蓝', '黑色'],
    size: ['35', '36', '37', '38', '39', '40', '41', '42', '43', '44', ],
    buy_num: 1, //购买商品数量
    Stock: 0, //商品库存
    Price: 0, //商品价格
    message: '', //提示语
    get_btnValue: '', //是购买按钮还是加入购物车按钮
    commodity: [], //选择的商品的信息
    choice: '', //是否是选择规格按钮
    spe_con: [], //商品规格信息文字版
    complete: false, //选择尺码接口是否执行完成
    showModalStatus: false,
    modalFlag: true,
    information: [], //商品详情内容
    numbers: 0,
    navbar: ['商品详情', '商品属性'], //商品信息以及商品属性分组
    currentTab: 0
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
    console.log(options, 'con')
    //缓存全局保存
    if (options.share_user_id) {
      wx.setStorageSync('shareId', options.share_user_id);
    }

    this.setData({
      options: options
    })
    // var that = this;
    // requ.request({
    //   url: api.api.productSpecCheck,
    //   data: { product_id: options.shop_id, spec_custom: '' },
    //   success: function (res) {
    //     console.log(res,'c尺码')
    //     that.setData({
    //       commodity: res.data,
    //       Stock: res.data.stock,
    //       Price: res.data.sale_price,
    //       spe_con: spe_content
    //     })
    //   }
    // })
  },
  // 预览
  preview: function() {
    wx.previewImage({
      urls: this.data.imgs_url,
    })
  },
  // 去首页
  go_index: function() {
    app.indexPage = true,
      wx.switchTab({
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
          });
          wx.showToast({
            title: '收藏成功',
            icon: 'none'
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
          });
          wx.showToast({
            title: '取消收藏成功',
            icon: 'none'
          })
        }
      })
    }
  },
  // 选择、规格
  choice: function() {
    // 显示遮罩层
    app.showModal(this);
  },
  choice_spce: function(e) {
    this.setData({
      choice: e.currentTarget.dataset.type
    })
    // 显示遮罩层
    app.showModal(this);
  },
  // 立即购买、加入购物车
  ADD: function(e) {
    var user_id = wx.getStorageSync('user_id')
    if (user_id == "") {
      app.login()
    } else {
      this.setData({
        get_btnValue: e.currentTarget.dataset.value
      })
      // 显示遮罩层
      app.showModal(this);
    }

  },
  hide: function() {
    app.hideModal(this);
    // 隐藏遮罩层
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
      choice: ''
    })
  },

  //选择尺码
  size: function(e) {
    this.setData({
      complete: false
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
      requ.request({
        url: api.api.productSpecCheck,
        data: {
          product_id: that.data.product_id,
          spec_custom: is_choice.join(';')
        },
        success: function(res) {
          if (res.code == '0') {
            // 如果选择尺码前选择的商品数量大于选择尺码后剩余库存数量，那么选中的数量将改编为剩余库存数量
            if (that.data.buy_num > res.data.stock) {
              that.setData({
                buy_num: res.data.stock
              })

            }
            that.setData({
              commodity: res.data,
              Stock: res.data.stock,
              Price: res.data.sale_price,
              spe_con: spe_content,
              complete: true, //选择尺码执行完，可以提交到购物车
            })
          } else {
            that.setData({
              message: res.message
            })
          }
        }
      })
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
    console.log(e, '添加购物车')
    var that = this;
    if (that.data.choice) {
      that.setData({
        get_btnValue: e.currentTarget.dataset.value
      })
    };
    if (that.data.message) {
      wx.showToast({
        title: that.data.message,
        icon: 'none'
      })
    } else {
      if (that.data.information.spec_config == 0) {
        that.setData({
          spe_con: ''
        });
        requ.request({
          url: api.api.addUserCart,
          data: {
            product_id: that.data.information.product_id,
            item_id: that.data.information.item_id,
            spec_content: that.data.spe_con,
            count: that.data.buy_num
          },
          success: function(res) {
            console.log(res, '777')
            that.hide()
            that.setData({
              choice: ''
            })
            if (res.code == 0) {
              if (that.data.get_btnValue == 'add_car') {
                if (res.code == '1008') {
                  wx.showToast({
                    title: res.message,
                    icon: 'none'
                  })
                } else {
                  wx.showToast({
                    title: res.message,
                    icon: 'none'
                  })
                }
              } else {
                wx.navigateTo({
                  url: '../car/car',
                })
              }
            } else {
              wx.showToast({
                title: '操作失败!' + res.message,
                icon: 'none'
              })
            }
          }
        })
      } else {
        if (that.data.complete) {
          // if (that.data.spe_con == '') {
          //   wx.showToast({
          //     title: '请选择规格参数',
          //     icon: 'none'
          //   })
          // } else {
          requ.request({
            url: api.api.addUserCart,
            data: {
              product_id: that.data.information.product_id,
              item_id: that.data.commodity.item_id,
              spec_content: that.data.spe_con.join(';'),
              count: that.data.buy_num
            },
            success: function(res) {
              that.hide()
              that.setData({
                choice: ''
              });
              if (that.data.get_btnValue == 'add_car') {
                wx.showToast({
                  title: '加入购物车成功',
                  icon: 'none'
                })
              } else {
                wx.navigateTo({
                  url: '../car/car',
                })
              }
            }
          })
          // }
        } else {
          wx.showToast({
            title: '请选择规格参数',
            icon: 'none'
          })
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
      if (app.conFig.switchTabUrl != undefined) {
        if (app.conFig.switchTabUrl.indexOf('detail') != -1) {
          console.log('包含')
          this.setData({
            shop_id: app.conFig.detailId,
          });
          if (app.detailId != '') {
            this.setData({
              shop_id: app.detailId,
            })
          };
        } else {
          this.setData({
            shop_id: this.data.options.shop_id
          })
        }
      } else {
        this.setData({
          shop_id: this.data.options.shop_id
        })
      };
      // 检验是否登录
      wx.setStorageSync('page', 'detail')
      var that = this;
      if (that.data.imgs_url.length == 0) {
        wx.showLoading({
          title: '加载中',
        })
      };
      requ.request({
        url: api.api.productDetail,
        data: {
          product_id: that.data.shop_id,
          user_id: wx.getStorageSync('user_id')
        },
        success: function(res) {
          console.log(res, 'details')
          if (res.code == '0') {
            wx.setNavigationBarColor({
              frontColor: '#ffffff',
              backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
            })
            that.setData({
              btnColor: wx.getStorageSync('btnColor')
            })
            var imgs = [];
            var article = res.data.product_info.product_desc;
            var temp = WxParse.wxParse('article', 'html', article, that, 0);
            if (res.data.product_info.is_collection == '0') { //是否收藏
              that.setData({
                Collection: false
              })
            } else {
              that.setData({
                Collection: true
              })
            }
            // 轮播图预览图片集
            for (var i = 0; i < res.data.product_info.product_imgs.length; i++) {
              imgs.push('http://wstore-1255653546.image.myqcloud.com' + res.data.product_info.product_imgs[i].product_img);
            }
            // 选择商品属性
            if (res.data.product_info.spec_info) {
              for (var i = 0; i < res.data.product_info.spec_info.length; i++) {
                for (var j = 0; j < res.data.product_info.spec_info[i].values.length; j++) {
                  res.data.product_info.spec_info[i].values[j].Choice = false
                }
              };
            }
            that.setData({
              load: true,
              information: res.data.product_info, //商品详情内容
              Stock: res.data.product_info.stock, //商品库存
              Price: res.data.product_info.sale_price, //商品价格
              article: temp, //富文本
              product_id: that.data.shop_id, //商品ID
              imgs_url: imgs, //轮播图图集（预览用）
            });
            wx.hideLoading();
            app.detailId = '';
          } else if (res.code == '1001002') {
            wx.hideLoading();
            requ.getToken();
            that.onShow();
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
      title: this.data.information.product_name,
      path: '/pages/detail/detail?shop_id=' + this.data.options.shop_id + '&share_user_id=' + wx.getStorageSync('user_id'),
      success: (res) => {
        console.log(res)
      },
      fail: (res) => {
        console.log(res)
      }
    }
  }
})
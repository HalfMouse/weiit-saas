const requ = require('../../utils/request.js');
const api = require('../../utils/api.js')
// pages/Order/Order.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    Load: false,
    navbar: ['全部', '待付款', '待发货', '待收货'],
    options: [], //
    currentTab: 0,
    page: 1, //当前显示页码(全部数据)
    paymentPage: 1, //待付款显示页面
    dGPgage: 1, //待发货显示页面
    cGPage: 1, //待收货显示页面
    hasNextPage: true, //是否还有下一页
    payment_method: [{
      is_radio: true,
      imgs: '../../images/wechat.png',
      name: '微信支付',
      title: '推荐安装微信的用户使用'
    }, {
      is_radio: false,
      imgs: '../../images/balance.png',
      name: '余额支付',
      title: '请确保自己账户余额充足'
    }], //支付方式
    payment_type: 0, //默认支付方式
    order_num: '', //继续支付的订单的订单编号
    pay_price: '', //继续付款的金额
    emptys: {
      url: '../../images/shop.svg',
      title: '您还没有该状态订单哦',
      btn: '逛逛首页'
    }, //没有订单
  },
  navbarTap: function(e) {
    this.setData({
      page: 1,
      paymentPage: 1,
      dGPgage: 1,
      cGPage: 1
    })
    if (e.currentTarget.dataset.idx != this.data.currentTab) {
      var that = this;
      switch (e.currentTarget.dataset.idx) {
        // 全部订单
        case 0:
          if (that.data.Load == false || that.data.order_list == undefined) {
            wx.showLoading({
              title: '加载中',
            })
          }
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.page
            },
            success: function(res) {
              that.loop(res);
              that.setData({
                order_list: res.data.list,
              });
              wx.hideLoading()
            }
          })
          break;
          // 待付款订单
        case 1:
          if (that.data.Load == false || that.data.payment == undefined) {
            wx.showLoading({
              title: '加载中',
            })
          }
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.paymentPage,
              state: 0
            },
            success: function(res) {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].state = '待付款';
                res.data.list[i].total = 0;
                if (res.data.list[i].express_money == null) {
                  res.data.list[i].express_money = 0
                };
                for (var j = 0; j < res.data.list[i].item.length; j++) {
                  res.data.list[i].total += res.data.list[i].item[j].count
                  res.data.list[i].item[j].order_num = res.data.list[i].order_num
                }
              }
              that.setData({
                payment: res.data.list,
                paymentLastPage: res.data.hasNextPage
              });
              wx.hideLoading()
            }
          })
          break;
          // 待发货订单
        case 2:
          if (that.data.Load == false || that.data.Deliver_goods == undefined) {
            wx.showLoading({
              title: '加载中',
            })
          }
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.dGPgage,
              state: 1
            },
            success: function(res) {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].state = '待发货';
                res.data.list[i].total = 0;
                if (res.data.list[i].express_money == null) {
                  res.data.list[i].express_money = 0
                };
                for (var j = 0; j < res.data.list[i].item.length; j++) {
                  res.data.list[i].total += res.data.list[i].item[j].count;
                  res.data.list[i].item[j].order_num = res.data.list[i].order_num
                }
              }
              that.setData({
                Deliver_goods: res.data.list,
                dGLastPage: res.data.hasNextPage
              });
              wx.hideLoading()
            }
          })
          break;
          // 待收货订单
        case 3:
          if (that.data.Load == false || that.data.receipt == undefined || (that.data.receipt != undefined && that.data.receipt.length == 0)) {
            wx.showLoading({
              title: '加载中',
            })
          }
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.cGPage,
              state: 2
            },
            success: function(res) {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].state = '待收货';
                res.data.list[i].index = i;
                res.data.list[i].total = 0;
                if (res.data.list[i].express_money == null) {
                  res.data.list[i].express_money = 0
                };
                for (var j = 0; j < res.data.list[i].item.length; j++) {
                  res.data.list[i].total += res.data.list[i].item[j].count
                  res.data.list[i].item[j].order_num = res.data.list[i].order_num
                }
              }
              that.setData({
                receipt: res.data.list,
                receiptLastPage: res.data.hasNextPage
              });
              wx.hideLoading()
            }
          })
          break;
      }
    } else {
      wx.pageScrollTo({
        scrollTop: 0,
        duration: 0
      })
    }
    this.setData({
      currentTab: e.currentTarget.dataset.idx
    });
  },
  go_home: function() {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.switchTab({
          url: '/pages/index/index',
        })
      }
    })
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
  // 循环
  loop: function(res) {
    for (var i = 0; i < res.data.list.length; i++) {
      res.data.list[i].index = i;
      res.data.list[i].total = 0
      if (res.data.list[i].express_money == null) {
        res.data.list[i].express_money = 0
      };
      for (var j = 0; j < res.data.list[i].item.length; j++) {
        res.data.list[i].total = res.data.list[i].total + res.data.list[i].item[j].count
        res.data.list[i].item[j].order_num = res.data.list[i].order_num
      }
      switch (res.data.list[i].state) {
        case -1:
          res.data.list[i].state = '交易取消';
          break;
        case 1:
          res.data.list[i].state = '待发货';
          break;
        case 2:
          res.data.list[i].state = '待收货';
          break;
        case 4:
          res.data.list[i].state = '交易完成';
          break;
        case 0:
          res.data.list[i].state = '待付款';
          break;
      }
    }
  },
  // 订单详情
  go_orderdetail: function(e) {
    console.log(e, '订单详情')
    var index = e.currentTarget.dataset.index
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../order_details/order_details?order_num=' + index,
        })
      }
    })
  },
  // 查看物流
  look_logistics: function(e) {
    var index = e.currentTarget.dataset.index;
    var that = this;
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        if (that.data.currentTab == 3) {
          wx.navigateTo({
            url: '../logistics/logistics?order_code=' + that.data.receipt[index].express_code + '&order_number=' + that.data.receipt[index].express_num,
          })
        } else if (that.data.currentTab == 0) {
          wx.navigateTo({
            url: '../logistics/logistics?order_code=' + that.data.order_list[index].express_code + '&order_number=' + that.data.order_list[index].express_num,
          })
        }
      }
    })
  },
  // 确认收货
  confirm: function(e) {
    var id = e.currentTarget.dataset.id
    var that = this;
    console.log(id)
    wx.showModal({
      title: '',
      content: '请确认已收到货',
      success: (res) => {
        console.log(res)
        if (res.confirm) {
          requ.request({
            url: api.api.updateOrderState,
            data: {
              order_num: id
            },
            success: (res) => {
              console.log(res, '确认收货')
              that.onShow();
            }
          })
        }
      }
    })
  },
  // 继续付款
  payment: function(e) {
    // 显示遮罩层
    getApp().showModal(this);
    this.setData({
      order_num: e.currentTarget.dataset.id,
      pay_price: e.currentTarget.dataset.money
    });
  },
  // 取消付款
  hide: function() {
    getApp().hideModal(this)
  },
  // 支付方式
  getValue: function(e) {
    var index = e.currentTarget.dataset.index;
    var is_radio = 'payment_method[' + index + '].is_radio';
    for (var i = 0; i < this.data.payment_method.length; i++) {
      this.data.payment_method[i].is_radio = false;
    }
    this.setData({
      payment_method: this.data.payment_method,
      [is_radio]: true,
      payment_type: index
    })
  },
  // 确定支付方式
  confirmBtn: function() {
    getApp().hideModal(this);
    var that = this;
    // 微信支付
    if (that.data.payment_type == 0) {
      requ.request({
        url: api.api.orderPay,
        data: {
          order_num: that.data.order_num,
          payment_type: that.data.payment_type
        },
        success: (res) => {
          wx.requestPayment({
            timeStamp: res.data.timeStamp,
            nonceStr: res.data.nonceStr,
            package: res.data.packageValue,
            signType: res.data.signType,
            paySign: res.data.paySign,
            success: () => {
              wx.navigateTo({
                url: '../buySuccess/buySuccess?pay_price=' + that.data.pay_price + '&payment_type=' + that.data.payment_type + '&pageName=' + 'order',
              })
            }
          })
        }
      })
    }
    // 余额支付
    if (that.data.payment_type == 1) {
      wx.showModal({
        title: '',
        content: '是否使用余额支付',
        success: function(res) {
          if (res.confirm) {
            requ.request({
              url: api.api.orderPay,
              data: {
                order_num: that.data.order_num,
                payment_type: that.data.payment_type
              },
              success: (res) => {
                console.log(res, '继续支付')
                if (res.code == 0) {
                  wx.navigateTo({
                    url: '../buySuccess/buySuccess?pay_price=' + that.data.pay_price + '&payment_type=' + that.data.payment_type + '&pageName=' + 'order',
                  })
                } else {
                  wx.showToast({
                    title: res.message,
                    icon: 'none'
                  })
                }

              }
            })
          } else {
            wx.showToast({
              title: '您取消了本次支付!',
            })
          }
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
  onShow: function() {
    var that = this;
    if (wx.getStorageSync('token') != '') {
      that.setData({
        currentTab: parseInt(that.data.options.id) + 1,
      })
      wx.showLoading({
        title: '加载中',
      })
      switch (that.data.options.id) {
        case '-1':
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.page
            },
            success: function(res) {
              console.log(res, '订单1')
              that.loop(res);
              that.setData({
                Load: true,
                order_list: res.data.list,
                hasNextPage: res.data.hasNextPage,
              })
              wx.hideLoading()
            }
          });
          break;
        case '0':
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.paymentPage,
              state: 0
            },
            success: function(res) {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].state = '待付款';
                if (res.data.list[i].express_money == null) {
                  res.data.list[i].express_money = 0
                };
                for (var j = 0; j < res.data.list[i].item.length; j++) {
                  res.data.list[i].item[j].order_num = res.data.list[i].order_num
                }
              };
              that.setData({
                Load: true,
                payment: res.data.list,
                paymentLastPage: res.data.hasNextPage
              });
              wx.hideLoading()
            }
          })
          break;
        case '1':
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.dGPgage,
              state: 1
            },
            success: function(res) {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].state = '待发货';
                if (res.data.list[i].express_money == null) {
                  res.data.list[i].express_money = 0
                };
                for (var j = 0; j < res.data.list[i].item.length; j++) {
                  res.data.list[i].item[j].order_num = res.data.list[i].order_num
                }
              };
              that.setData({
                Load: true,
                Deliver_goods: res.data.list,
                dGLastPage: res.data.hasNextPage
              });
              wx.hideLoading()
            }
          })
          break;
        case '2':
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.cGPage,
              state: 2
            },
            success: function(res) {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].state = '待收货';
                res.data.list[i].index = i;
                if (res.data.list[i].express_money == null) {
                  res.data.list[i].express_money = 0
                };
                for (var j = 0; j < res.data.list[i].item.length; j++) {
                  res.data.list[i].item[j].order_num = res.data.list[i].order_num
                }
              }
              that.setData({
                Load: true,
                receipt: res.data.list,
                receiptLastPage: res.data.hasNextPage
              });
              wx.hideLoading()
            }
          })
          break;
      }
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
    var index = this.data.currentTab;
    var that = this;
    switch (index) {
      case 0:
        if (this.data.hasNextPage) {
          that.setData({
            page: that.data.page + 1
          });
          wx.showLoading({
            title: '加载中',
          });
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.page
            },
            success: function(res) {
              that.loop(res);
              that.setData({
                order_list: that.data.order_list.concat(res.data.list),
                // currentTab: that.data.currentTab,
                hasNextPage: res.data.hasNextPage
              })
              wx.hideLoading()
            }
          })
        }
        break;
      case 1:
        if (that.data.paymentLastPage) {
          that.setData({
            paymentPage: that.data.paymentPage + 1
          });
          wx.showLoading({
            title: '加载中',
          });
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.paymentPage,
              state: 0
            },
            success: function(res) {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].state = '待付款';
                if (res.data.list[i].express_money == null) {
                  res.data.list[i].express_money = 0
                };
                for (var j = 0; j < res.data.list[i].item.length; j++) {
                  res.data.list[i].item[j].order_num = res.data.list[i].order_num
                }
              }
              that.setData({
                payment: that.data.payment.concat(res.data.list),
                paymentLastPage: res.data.hasNextPage
              });
              wx.hideLoading()
            }
          })
        }
        break;
      case 2:
        if (that.data.dGLastPage) {
          that.setData({
            dGPgage: that.data.dGPgage + 1
          });
          wx.showLoading({
            title: '加载中',
          })
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.dGPgage,
              state: 1
            },
            success: function(res) {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].state = '待发货';
                res.data.list[i].index = i;
                if (res.data.list[i].express_money == null) {
                  res.data.list[i].express_money = 0
                };
                for (var j = 0; j < res.data.list[i].item.length; j++) {
                  res.data.list[i].item[j].order_num = res.data.list[i].order_num
                }
              }
              that.setData({
                Deliver_goods: that.data.Deliver_goods.concat(res.data.list),
                dGLastPage: res.data.hasNextPage
              });
              wx;
              wx.hideLoading()
            }
          })
        }
        break;
      case 3:
        if (that.data.receiptLastPage) {
          that.setData({
            cGPage: that.data.cGPage + 1
          });
          wx.showLoading({
            title: '加载中',
          })
          requ.request({
            url: api.api.orderList,
            data: {
              page: that.data.cGPage,
              state: 2
            },
            success: function(res) {
              for (var i = 0; i < res.data.list.length; i++) {
                res.data.list[i].state = '待收货';
                if (res.data.list[i].express_money == null) {
                  res.data.list[i].express_money = 0
                };
                for (var j = 0; j < res.data.list[i].item.length; j++) {
                  res.data.list[i].item[j].order_num = res.data.list[i].order_num
                }
              }
              that.setData({
                receipt: that.data.receipt.concat(res.data.list),
                receiptLastPage: res.data.hasNextPage
              });
              wx.hideLoading()
            }
          })
        }
        break;
    }

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
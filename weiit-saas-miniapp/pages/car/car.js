const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
// pages/shopCar/shopCar.js
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    load: false, //当数据加载完才显示
    sub: true, //防止重复提交
    car_content: [],
    buy_num: 1, //商品数量
    express_money: 0, //运费
    activeIndex: 0,
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
    coupon: [], //优惠券列表
    availableCoupon: [], //可用优惠券列表
    unavailableCoupon: [], //不可用优惠券列表
    option: true,
    Delivery_mode: ['送货上门', '货到付款', '上门自提'],
    give_value: '送货上门',
    choice_arr: [], //选中商品ID数组
    product_arr: [], //选中商品ID
    commodity_arr: [], //选中的商品信息
    sum: 0, //选中商品的总额
    sums: 0, //未计算过的商品价格
    copySum: 0, //总价格的副本
    num_index: 0, //商品下标
    selectCoupon: [], //选中优惠券的信息
    get_input: '', //买家留言
    payment_type: 0, //支付方式
    item: [],
    selAddress: [],
    address: [],
    selAddress: '', //选择地址后返回
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options){
      if (options.share_user_id){
        wx.setStorageSync('shareId', options.share_user_id);
      } 
      
    }
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
    if (wx.getStorageSync('token') != '') {
      wx.showLoading({
        title: '加载中',
      })
      var that = this
      requ.request({
        url: api.api.userCart,
        success: function(res) {
          // console.log(res, 'gouwuche')
          if (res.data != "" && res.data.cart_info != '') {
            for (var i = 0; i < res.data.cart_info.length; i++) {
              res.data.cart_info[i].checked = true
            }
          };
          that.setData({
            btnColor: wx.getStorageSync('btnColor'),
            express_money: res.data.express_money,
            car_content: res.data,
            address: res.data.user_address_info
          });
          that.data.choice_arr = [];
          that.data.product_arr = [];
          that.data.commodity_arr = [];
          var num_money = [];
          that.data.sum = 0; //总额
          that.data.sums = 0; //总额
          for (var i = 0; i < that.data.car_content.cart_info.length; i++) {
            if (that.data.car_content.cart_info[i].checked == true) {
              that.data.choice_arr.push(that.data.car_content.cart_info[i].cart_id);
              that.data.product_arr.push(that.data.car_content.cart_info[i].product_id);
              that.data.commodity_arr.push(that.data.car_content.cart_info[i]);
              num_money.push(that.data.car_content.cart_info[i].sale_price * that.data.car_content.cart_info[i].count)
            };
            that.setData({
              num_money: num_money
            })
          };

          for (var j = 0; j < num_money.length; j++) {
            that.data.sum += num_money[j];
            that.data.sums += num_money[j]
          }
          // 筛选合适的优惠券
          requ.request({
            url: api.api.getUserCouponListForCart,
            data: {
              cart_ids: that.data.choice_arr.join(',')
            },
            success: (res) => {
              let reg = /\s\d{2}\:\d{2}\:\d{2}\.\d/g;
              var available = [],
                unavailable = [];
              for (var i = 0; i < res.data.coupons.length; i++) {
                res.data.coupons[i].time = res.data.coupons[i].time.replace(reg, '');
                res.data.coupons[i].pages = 'car';
                res.data.coupons[i].index = i;
                res.data.coupons[i].coupon_content = Number(res.data.coupons[i].coupon_content);
                res.data.coupons[i].CouponIndex = false;
                res.data.coupons[i].product_ids = res.data.coupons[i].product_ids.split(',');
                if (res.data.coupons[i].condition == "无限制") {
                  res.data.coupons[i].satisfy = '无限制'
                } else {
                  res.data.coupons[i].satisfy = Number(res.data.coupons[i].condition.slice(1))
                };
                if (res.data.coupons[i].type == 2 && res.data.coupons[i].coupon_content == 0) {
                  res.data.coupons[i].coupon_content = 10
                };
                if (res.data.coupons[i].type == 1) {
                  res.data.coupons[i].coupon_content = parseFloat(res.data.coupons[i].coupon_content)
                };
                if (res.data.coupons[i].is_useable) {
                  available.push(res.data.coupons[i])
                } else {
                  unavailable.push(res.data.coupons[i])
                }
              };
              that.setData({
                coupon: res.data.coupons,
                availableCoupon: available,
                unavailableCoupon: unavailable
              });
            }
          })
          that.setData({
            load: true,
            sum: parseFloat(that.data.sum.toFixed(2)),
            sums: parseFloat(that.data.sums.toFixed(2)),
            copySum: parseFloat(that.data.sum.toFixed(2))
          })
          // 停止加载动画
          wx.hideLoading();
          // 停止刷新动画
          wx.stopPullDownRefresh()
        }

      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    }

  },
  // 选中radio
  Choice: function(e) {
    var that = this;
    var choice_index = e.currentTarget.dataset.index;
    var str = 'car_content.cart_info[' + choice_index + '].checked'
    if (that.data.car_content.cart_info[choice_index].checked == false) {
      that.setData({
        [str]: true
      })
    } else {
      that.setData({
        [str]: false
      })
    };
    that.data.choice_arr = [];
    that.data.product_arr = [];
    that.data.commodity_arr = [];
    var num_money = [];
    that.data.sum = 0; //总额
    that.data.sums = 0;
    for (var i = 0; i < that.data.car_content.cart_info.length; i++) {
      if (that.data.car_content.cart_info[i].checked == true) {
        that.data.choice_arr.push(that.data.car_content.cart_info[i].cart_id);
        that.data.product_arr.push(that.data.car_content.cart_info[i].product_id);
        that.data.commodity_arr.push(that.data.car_content.cart_info[i]);
        num_money.push(that.data.car_content.cart_info[i].sale_price * that.data.car_content.cart_info[i].count)
      }
      that.setData({
        num_money: num_money
      })
    };
    // 选中优惠券后取消了选中的可以用特定优惠券的商品
    if (that.data.selectCoupon.product_ids != undefined) {
      if (that.data.selectCoupon.product_range_type == "2") {
        var arr = [];
        for (var i = 0; i < that.data.product_arr.length; i++) {
          for (var j = 0; j < that.data.selectCoupon.product_ids.length; j++) {
            if (that.data.product_arr[i] == that.data.selectCoupon.product_ids[j]) {} else {
              arr.push(that.data.product_arr[i])
            }
          };
        };
        if ((that.data.product_arr.sort()).join() == (arr.sort()).join()) {
          console.log(that.data.car_content)
          that.setData({
            selectCoupon: [],
            CouponIndex: -1,
            option: true
          })
        }
      };
    }
    if (that.data.product_arr != '') {
      // 筛选合适的优惠券
      requ.request({
        url: api.api.getUserCouponListForCart,
        data: {
          cart_ids: that.data.choice_arr.join(',')
        },
        success: (res) => {
          let reg = /\s\d{2}\:\d{2}\:\d{2}\.\d/g;
          var available = [],
            unavailable = [];
          for (var i = 0; i < res.data.coupons.length; i++) {
            res.data.coupons[i].time = res.data.coupons[i].time.replace(reg, '');
            res.data.coupons[i].pages = 'car';
            res.data.coupons[i].index = i;
            res.data.coupons[i].coupon_content = Number(res.data.coupons[i].coupon_content);
            res.data.coupons[i].CouponIndex = false;
            res.data.coupons[i].product_ids = res.data.coupons[i].product_ids.split(',');
            if (res.data.coupons[i].condition == "无限制") {
              res.data.coupons[i].satisfy = '无限制'
            } else {
              res.data.coupons[i].satisfy = Number(res.data.coupons[i].condition.slice(1))
            };
            if (res.data.coupons[i].type == 2 && res.data.coupons[i].coupon_content == 0) {
              res.data.coupons[i].coupon_content = 10
            };
            if (res.data.coupons[i].type == 1) {
              res.data.coupons[i].coupon_content = parseFloat(res.data.coupons[i].coupon_content)
            };
            if (res.data.coupons[i].is_useable) {
              available.push(res.data.coupons[i])
            } else {
              unavailable.push(res.data.coupons[i])
            }
          };
          this.setData({
            coupon: res.data.coupons,
            availableCoupon: available,
            unavailableCoupon: unavailable
          });
        }
      })
    } else {
      this.setData({
        coupon: [],
        availableCoupon: [],
        unavailableCoupon: []
      });
    }

    // 计算商品邮费
    if (that.data.car_content.user_address_info.province) {
      if (that.data.choice_arr.join(',') != '') {
        requ.request({
          url: api.api.calcPostage,
          data: {
            cart_ids: that.data.choice_arr.join(','),
            address_id: that.data.address.id
          },
          success: (res) => {
            that.setData({
              express_money: res.data.expressPrice
            })
          }
        })
      } else {
        that.setData({
          express_money: that.data.car_content.express_money
        })
      }
    };
    // 算选中商品的总价格
    for (var j = 0; j < num_money.length; j++) {
      that.data.sum += num_money[j];
      that.data.sums += num_money[j]
    };
    // 当没有选择商品时选中的优惠券也要取消
    if (num_money.length < 1) {
      that.setData({
        selectCoupon: [],
        option: true
      })
    };
    // 当选中的商品金额不满足选中的优惠券条件时取消优惠券额度
    if (that.data.sum < that.data.selectCoupon.satisfy) {
      that.setData({
        selectCoupon: [],
        CouponIndex: -1,
        option: true
      })
    };
    // 判断有没有满足条件的优惠券
    if (that.data.selectCoupon == "") {
      that.setData({
        sum: parseFloat(that.data.sum.toFixed(2)),
        sums: parseFloat(that.data.sums.toFixed(2)),
        copySum: parseFloat(that.data.sum.toFixed(2))
      })
    } else {
      // 判断优惠券类型
      if (that.data.selectCoupon.type == 1) {
        that.setData({
          sum: parseFloat((parseFloat(that.data.sum.toFixed(2)) - that.data.selectCoupon.coupon_content).toFixed(2)),
          sums: parseFloat((parseFloat(that.data.sums.toFixed(2))).toFixed(2)),
          copySum: parseFloat((parseFloat(that.data.sum.toFixed(2)) - that.data.selectCoupon.coupon_content).toFixed(2))
        })
      }
      if (that.data.selectCoupon.type == 2) {
        // 特定优惠券折扣算总价格
        if (that.data.selectCoupon.product_range_type == "2") {
          var arr1 = [];
          if (typeof(that.data.selectCoupon.product_ids) == "string") {
            arr1 = (that.data.selectCoupon.product_ids).split(",")
          } else {
            arr1 = that.data.selectCoupon.product_ids;
          }
          var specialId = [];
          for (var i = 0; i < arr1.length; i++) {
            for (var j = 0; j < that.data.commodity_arr.length; j++) {
              if (parseInt(arr1[i]) == that.data.commodity_arr[j].product_id) {
                specialId.push(that.data.commodity_arr[j])
              }
            }
          };
          var discount = 0;
          var price = 0;
          for (var i = 0; i < specialId.length; i++) {
            discount += (specialId[i].count * specialId[i].sale_price) * (that.data.selectCoupon.coupon_content / 10)
          }
          var sums = parseFloat((parseFloat(that.data.sums.toFixed(2))).toFixed(2));
          if (specialId.length < that.data.commodity_arr.length) {
            price = sums - (discount / (that.data.selectCoupon.coupon_content / 10))
            this.setData({
              sum: discount + price,
              sums: sums
            })
          } else {
            this.setData({
              sum: discount,
              sums: sums
            })
          }
        } else {
          that.setData({
            sum: parseFloat((parseFloat(that.data.sum.toFixed(2)) * (that.data.selectCoupon.coupon_content / 10)).toFixed(2)),
            sums: parseFloat((parseFloat(that.data.sums.toFixed(2))).toFixed(2)),
            copySum: parseFloat((parseFloat(that.data.sum.toFixed(2)) * (that.data.selectCoupon.coupon_content / 10)).toFixed(2))
          })
        }
      };
    };
    // 取消radio选中状态
    if (that.data.sum == 0) {
      console.log(123)
      that.setData({
        CouponIndex: -1,
        express_money: 0
      })
    };
  },
  // 删除商品
  deletes: function(e) {
    var delete_id = e.currentTarget.dataset.car_id
    var that = this
    wx.showModal({
      content: '确认删除此商品？',
      success: function(res) {
        if (res.confirm) {
          requ.request({
            url: api.api.delUserCartProduct,
            data: {
              cart_id: delete_id
            },
            success: function(res) {
              that.onLoad();
              that.setData({
                selectCoupon: [],
                CouponIndex: -1,
                option: true,
                sum: 0,
                sums: 0,
                express_money: 0
              })
            }
          })
        }
      }
    })

  },
  //增加购买数量
  add_num: function(e) {
    var that = this;
    var choice_id = e.currentTarget.dataset.id;
    var num_index = e.currentTarget.dataset.index;
    var con = 'car_content.cart_info[' + num_index + '].count';
    if (that.data.car_content.cart_info[num_index].max_limit != 0 && that.data.car_content.cart_info[num_index].count >= that.data.car_content.cart_info[num_index].max_limit) {
      wx.showToast({
        title: '该商品限购' + that.data.car_content.cart_info[num_index].max_limit + '件',
        icon: 'none'
      })
    } else {
      if (that.data.car_content.cart_info[num_index].count < that.data.car_content.cart_info[num_index].stock) {
        that.setData({
          [con]: that.data.car_content.cart_info[num_index].count + 1
        });
        if (that.data.car_content.cart_info[num_index].checked) {
          // 判断有没有满足条件的优惠券
          if (that.data.selectCoupon == "") {
            that.setData({
              sum: parseFloat((parseFloat(that.data.sum.toFixed(2)) + that.data.car_content.cart_info[num_index].sale_price).toFixed(2)),
              sums: parseFloat((parseFloat(that.data.sums.toFixed(2)) + that.data.car_content.cart_info[num_index].sale_price).toFixed(2)),
            });
          } else {
            // 判断优惠券类型
            if (that.data.selectCoupon.type == 1) {
              var sums = parseFloat((parseFloat(that.data.sums.toFixed(2)) + that.data.car_content.cart_info[num_index].sale_price).toFixed(2));
              var sum = sums - that.data.selectCoupon.coupon_content
              that.setData({
                sum: sum,
                sums: sums
              })
            }
            if (that.data.selectCoupon.type == 2) {
              // 特定优惠券折扣算总价格
              if (that.data.selectCoupon.product_range_type == "2") {
                var arr1 = [];
                if (typeof(that.data.selectCoupon.product_ids) == "string") {
                  arr1 = (that.data.selectCoupon.product_ids).split(",")
                } else {
                  arr1 = that.data.selectCoupon.product_ids;
                }
                var specialId = [];
                for (var i = 0; i < arr1.length; i++) {
                  for (var j = 0; j < that.data.commodity_arr.length; j++) {
                    if (parseInt(arr1[i]) == that.data.commodity_arr[j].product_id) {
                      specialId.push(that.data.commodity_arr[j])
                    }
                  }
                };
                var discount = 0;
                var price = 0;
                for (var i = 0; i < specialId.length; i++) {
                  discount += (specialId[i].count * specialId[i].sale_price) * (that.data.selectCoupon.coupon_content / 10)
                }
                var sums = parseFloat((parseFloat(that.data.sums.toFixed(2)) + that.data.car_content.cart_info[num_index].sale_price).toFixed(2));
                if (specialId.length < that.data.commodity_arr.length) {
                  price = sums - (discount / (that.data.selectCoupon.coupon_content / 10))
                  this.setData({
                    sum: discount + price,
                    sums: sums
                  })
                } else {
                  this.setData({
                    sum: discount,
                    sums: sums
                  })
                }

              } else {
                var sums = parseFloat((parseFloat(that.data.sums.toFixed(2)) + that.data.car_content.cart_info[num_index].sale_price).toFixed(2));
                var sum = sums * (that.data.selectCoupon.coupon_content / 10)
                that.setData({
                  sum: parseFloat(sum.toFixed(2)),
                  sums: sums,
                })
              }

            }
          };
        }
        requ.request({
          url: api.api.addUserCartCount,
          data: {
            cart_id: choice_id,
            count: that.data.car_content.cart_info[num_index].count
          },
          success: () => {
            // 筛选合适的优惠券
            requ.request({
              url: api.api.getUserCouponListForCart,
              data: {
                cart_ids: that.data.choice_arr.join(',')
              },
              success: (res) => {
                let reg = /\s\d{2}\:\d{2}\:\d{2}\.\d/g;
                var available = [];
                var unavailable = []
                for (var i = 0; i < res.data.coupons.length; i++) {
                  res.data.coupons[i].time = res.data.coupons[i].time.replace(reg, '');
                  if (res.data.coupons[i].is_useable) {
                    available.push(res.data.coupons[i])
                  } else {
                    unavailable.push(res.data.coupons[i])
                  }
                }
                that.setData({
                  coupon: res.data.coupons,
                  availableCoupon: available,
                  unavailableCoupon: unavailable
                })
              }
            });
            // 计算商品邮费
            if (that.data.car_content.cart_info[num_index].checked) {
              if (that.data.car_content.user_address_info.province) {
                if (that.data.choice_arr.join(',') != '') {
                  requ.request({
                    url: api.api.calcPostage,
                    data: {
                      cart_ids: that.data.choice_arr.join(','),
                      address_id: that.data.address.id
                    },
                    success: (res) => {
                      that.setData({
                        express_money: res.data.expressPrice
                      })
                    }
                  })
                } else {
                  that.setData({
                    express_money: that.data.car_content.express_money
                  })
                }
              };
            }
          }
        })
      } else {
        wx.showToast({
          title: '最多选择' + that.data.buy_num + '件商品',
          icon: 'none',
          duration: 1000
        })
      }
    }
  },
  //减少购买数量
  reduce_num: function(e) {
    var that = this;
    var choice_id = e.currentTarget.dataset.id;
    var num_index = e.currentTarget.dataset.index;
    var con = 'car_content.cart_info[' + num_index + '].count';
    if (that.data.car_content.cart_info[num_index].count > 1) {
      that.setData({
        [con]: that.data.car_content.cart_info[num_index].count - 1
      });
      if (that.data.car_content.cart_info[num_index].checked) {
        // 判断有没有满足条件的优惠券
        if (that.data.selectCoupon == "") {
          that.setData({
            sum: parseFloat((parseFloat(that.data.sum.toFixed(2)) - that.data.car_content.cart_info[num_index].sale_price).toFixed(2)),
            sums: parseFloat((parseFloat(that.data.sums.toFixed(2)) - that.data.car_content.cart_info[num_index].sale_price).toFixed(2)),
          });
        } else {
          // 判断优惠券类型
          if (that.data.selectCoupon.type == 1) {
            var sums = parseFloat((parseFloat(that.data.sums.toFixed(2)) - that.data.car_content.cart_info[num_index].sale_price).toFixed(2));
            var sum = sums - that.data.selectCoupon.coupon_content
            that.setData({
              sum: parseFloat(sum.toFixed(2)),
              sums: sums
            })
          }
          if (that.data.selectCoupon.type == 2) {
            // 特定优惠券折扣算总价格
            if (that.data.selectCoupon.product_range_type == "2") {
              var arr1 = [];
              if (typeof(that.data.selectCoupon.product_ids) == "string") {
                arr1 = (that.data.selectCoupon.product_ids).split(",")
              } else {
                arr1 = that.data.selectCoupon.product_ids;
              }
              var specialId = [];
              for (var i = 0; i < arr1.length; i++) {
                for (var j = 0; j < that.data.commodity_arr.length; j++) {
                  if (parseInt(arr1[i]) == that.data.commodity_arr[j].product_id) {
                    specialId.push(that.data.commodity_arr[j])
                  }
                }
              };
              var discount = 0;
              var price = 0;
              for (var i = 0; i < specialId.length; i++) {
                discount += (specialId[i].count * specialId[i].sale_price) * (that.data.selectCoupon.coupon_content / 10)
              }
              var sums = parseFloat((parseFloat(that.data.sums.toFixed(2)) - that.data.car_content.cart_info[num_index].sale_price).toFixed(2));
              if (specialId.length < that.data.commodity_arr.length) {
                price = sums - (discount / (that.data.selectCoupon.coupon_content / 10))
                this.setData({
                  sum: discount + price,
                  sums: sums
                })
              } else {
                this.setData({
                  sum: discount,
                  sums: sums
                })
              }
            } else {
              var sums = parseFloat((parseFloat(that.data.sums.toFixed(2)) - that.data.car_content.cart_info[num_index].sale_price).toFixed(2));
              var sum = sums * (that.data.selectCoupon.coupon_content / 10)
              that.setData({
                sum: parseFloat(sum.toFixed(2)),
                sums: sums
              })
            }
          }
        };
      }
      requ.request({
        url: api.api.addUserCartCount,
        data: {
          cart_id: choice_id,
          count: that.data.car_content.cart_info[num_index].count
        },
        success: () => {
          // 筛选合适的优惠券
          requ.request({
            url: api.api.getUserCouponListForCart,
            data: {
              cart_ids: that.data.choice_arr.join(',')
            },
            success: (res) => {
              let reg = /\s\d{2}\:\d{2}\:\d{2}\.\d/g;
              var available = [];
              var unavailable = []
              for (var i = 0; i < res.data.coupons.length; i++) {
                res.data.coupons[i].time = res.data.coupons[i].time.replace(reg, '');
                if (res.data.coupons[i].is_useable) {
                  available.push(res.data.coupons[i])
                } else {
                  unavailable.push(res.data.coupons[i])
                }
              }
              this.setData({
                coupon: res.data.coupons,
                availableCoupon: available,
                unavailableCoupon: unavailable
              })
            }
          });
          // 计算商品邮费
          if (that.data.car_content.cart_info[num_index].checked) {
            if (that.data.car_content.user_address_info.province) {
              if (that.data.choice_arr.join(',') != '') {
                requ.request({
                  url: api.api.calcPostage,
                  data: {
                    cart_ids: that.data.choice_arr.join(','),
                    address_id: that.data.address.id
                  },
                  success: (res) => {
                    that.setData({
                      express_money: res.data.expressPrice
                    })
                  }
                })
              } else {
                that.setData({
                  express_money: that.data.car_content.express_money
                })
              }
            };
          }
        }
      })
    } else {
      wx.showToast({
        title: '最少选择1件商品',
        icon: 'none',
        duration: 1000
      })
    }
  },
  // 选择配送方式
  mode: function() {
    app.showModal(this);
    this.setData({
      ModalStatus: true
    })
  },
  hide: function() {
    app.hideModal(this);
    this.setData({
      ModalStatus: false
    })
  },
  get_index: function(e) {
    this.setData({
      give_value: e.currentTarget.dataset.value,
      activeIndex: e.currentTarget.dataset.index
    });
    this.setData({
      ModalStatus: false
    })
  },
  // 选择优惠券
  Choice_Coupon: function() {
    app.showModal(this);
    this.setData({
      showModal: true
    });
  },
  // 取消优惠券选择
  closeCoupon: function() {
    // app.showModal(this);
    this.setData({
      showModal: false,
    });
  },
  // 选中的优惠券信息
  option_coupon: function(e) {
    app.hideModal(this);
    var that = this;
    that.setData({
      CouponIndex: e.currentTarget.dataset.index,
      selectCoupon: that.data.availableCoupon[e.currentTarget.dataset.index],
      showModal: false,
      option: false
    });
    if (that.data.selectCoupon.type == 1) {
      that.setData({
        sum: parseFloat((parseFloat(that.data.sums.toFixed(2)) - that.data.selectCoupon.coupon_content).toFixed(2)),
      })
    };
    if (that.data.selectCoupon.type == 2) {
      // 特定优惠券折扣算总价格
      if (that.data.selectCoupon.product_range_type == "2") {
        var arr1 = [];
        if (typeof(that.data.selectCoupon.product_ids) == "string") {
          arr1 = (that.data.selectCoupon.product_ids).split(",")
        } else {
          arr1 = that.data.selectCoupon.product_ids;
        }
        var specialId = []; //符合打折要求的信息
        for (var i = 0; i < arr1.length; i++) {
          for (var j = 0; j < that.data.commodity_arr.length; j++) {
            if (parseInt(arr1[i]) == that.data.commodity_arr[j].product_id) {
              specialId.push(that.data.commodity_arr[j])
            }
          }
        };
        var discount = 0;
        var price = 0;
        for (var i = 0; i < specialId.length; i++) {
          discount += (specialId[i].count * specialId[i].sale_price) * (that.data.selectCoupon.coupon_content / 10)
        }
        if (specialId.length < that.data.commodity_arr.length) {
          price = that.data.sums - (discount / (that.data.selectCoupon.coupon_content / 10))
          this.setData({
            sum: discount + price
          })
        } else {
          this.setData({
            sum: discount
          })
        }
      } else {
        // 不是指定优惠券算总价格
        that.setData({
          sum: parseFloat((parseFloat(that.data.sums.toFixed(2)) * (that.data.selectCoupon.coupon_content / 10)).toFixed(2))
        })
      }
    };
  },

  // 填写收件人信息
  address: function() {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../address/address?pages=' + 'add',
        })
      }
    })
  },
  // 买家留言
  get_input: function(e) {
    this.setData({
      get_input: e.detail.value
    })
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
  // 提交订单
  sub_order: function() {
    var that = this;
    if (that.data.sub) {
      that.setData({
        sub: false
      });
      if (that.data.selectCoupon.coupon_id == undefined) {
        that.setData({
          ['selectCoupon.coupon_id']: ''
        })
      }
      var express_type;
      switch (that.data.give_value) {
        case '送货上门':
          express_type = 0
          break;
        case '货到付款':
          express_type = 1
          break;
        case '上门自提':
          express_type = 2
          break;
      }
      // 当没有选择商品时
      if (that.data.choice_arr.join(',') === '') {
        wx.showToast({
          title: '请选择需要购买的商品',
          icon: 'none'
        });
        that.setData({
          sub: true
        });
      };
      // 当没有收货地址时
      if (that.data.address === null) {
        wx.showToast({
          title: '请选择收货地址',
          icon: 'none',
        });
        that.setData({
          sub: true
        });
      };
      if (that.data.choice_arr.join(',') !== '' && that.data.address.id) {
        // 余额支付
        if (that.data.payment_type == 1) {
          console.log('余额支付')
          wx.showModal({
            title: '',
            content: '是否使用余额支付',
            success: (res) => {
              if (res.confirm) {
                wx.showLoading({
                  title: '支付中...',
                  mask: true,
                  success: function() {
                    if (that.data.selectCoupon.id == undefined) {
                      that.data.selectCoupon.id = ''
                    };
                    requ.request({
                      url: api.api.addOrder,
                      data: {
                        cart_ids: that.data.choice_arr.join(','),
                        address_id: that.data.address.id,
                        payment_type: that.data.payment_type,
                        remark: that.data.get_input,
                        express_type: express_type,
                        express_money: that.data.express_money,
                        coupon_id: that.data.selectCoupon.id,
                        pay_price: that.data.sum
                      },
                      success: function(res) {
                        wx.hideLoading()
                        that.setData({
                          sub: true
                        });
                        if (res.code != 0) {
                          wx.showToast({
                            title: '支付失败',
                            icon: 'none',
                            success: () => {
                              setTimeout(function() {
                                wx.navigateBack({})
                              }, 2000)
                            }
                          });
                        } else {
                          wx.navigateTo({
                            url: '../buySuccess/buySuccess?payment_type=' + that.data.payment_type + '&pay_price=' + (that.data.sum + that.data.express_money),
                          });
                        }
                      }
                    })
                  }
                })
              } else {
                wx.showToast({
                  title: '您取消了支付',
                  icon: 'none',
                  success: () => {
                    that.setData({
                      sub: true
                    });
                  }
                })
              }
            }
          })
        }
        // 微信支付
        if (that.data.payment_type == 0) {
          wx.showLoading({
            title: '支付中...',
            mask: true,
            success: () => {
              if (that.data.selectCoupon.id == undefined) {
                that.data.selectCoupon.id = ''
              };
              requ.request({
                url: api.api.addOrder,
                data: {
                  cart_ids: that.data.choice_arr.join(','),
                  address_id: that.data.address.id,
                  payment_type: that.data.payment_type,
                  remark: that.data.get_input,
                  express_type: express_type,
                  express_money: that.data.car_content.express_money,
                  coupon_id: that.data.selectCoupon.id,
                  pay_price: that.data.sum
                },
                success: function(res) {
                  console.log(res, 'fanhuide ')
                  wx.hideLoading()
                  wx.requestPayment({
                    timeStamp: res.data.timeStamp,
                    nonceStr: res.data.nonceStr,
                    package: res.data.packageValue,
                    signType: res.data.signType,
                    paySign: res.data.paySign,
                    success: (res) => {
                      that.setData({
                        sub: true
                      });
                      wx.navigateTo({
                        url: '../buySuccess/buySuccess?payment_type=' + that.data.payment_type + '&pay_price=' + (that.data.sum + that.data.express_money),
                      });
                    },
                    fail: () => {
                      wx.showToast({
                        title: '支付失败',
                        icon: 'none',
                        success: () => {
                          var id = (-1)
                          wx.navigateTo({
                            url: '../Order/Order?id=' + id,
                          })
                        }
                      })
                    }
                  })
                }
              })
            }
          })
        }
      }
    } else {
      wx.showToast({
        title: '请不要重复点击',
        icon: 'none'
      })
    }
  },
  // 随便逛逛
  go_home: function() {
    wx.switchTab({
      url: '/pages/index/index',
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
    var that = this;
    var pages = getCurrentPages();
    var currPage = pages[pages.length - 1];
    that.setData({
      selAddress: currPage.data.selAddress
    })
    if (that.data.selAddress == "") {
      // that.getUserAddress(that.data.userId);
      this.onLoad();
      this.setData({
        selectCoupon: [],
        CouponIndex: -1,
        option: true,
        sum: 0,
        sums: 0,
        express_money: 0
      });
    } else {
      that.setData({ //将携带的参数赋值
        address: currPage.data.item,
        Recipient: true
      });
      // 计算商品邮费
      if (that.data.car_content.user_address_info.province) {
        if (that.data.choice_arr.join(',') != '') {
          requ.request({
            url: api.api.calcPostage,
            data: {
              cart_ids: that.data.choice_arr.join(','),
              address_id: that.data.address.id
            },
            success: (res) => {
              that.setData({
                express_money: res.data.expressPrice
              })
            }
          })
        } else {
          that.setData({
            express_money: that.data.car_content.express_money
          })
        }
      };
    };
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
  // onPullDownRefresh: function() {
  //   // this.onLoad();
  //   // this.setData({
  //   //   selectCoupon: [],
  //   //   CouponIndex: -1,
  //   //   option: true,
  //   //   sum: 0,
  //   //   sums: 0,
  //   //   express_money: 0
  //   // });
  // },

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
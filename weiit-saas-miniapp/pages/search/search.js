const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
const app = getApp();
// pages/search/search.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    navbar: [{
      name: '默认',
      sorts: true
    }, {
      name: '价格',
      sorts: true
    }, {
      name: '销量',
      sorts: true
    }],
    price: false, //价格排序
    sales: false, //销量排序
    sortType: 'desc', //价格排序类型
    salesBool: 'desc', //销量默认降序
    currentTab: 0,
    content: [], //搜索框内容
    page: 1, //默认派新显示页面
    pricePage: 1, //价格排序显示页面
    salesPage: 1, //销量排序显示页面
    hasNextPage: true, //显示默认排序是否有下一页
    priceHasNextPage: true, //价格页面是否还有下一页
    salesHasNextPage: true, //销量排序是否还有下一页
    searchList: [], //搜索结果
    priceList: [], //价格列表
    salesList: [], //销量列表
  },
  navbarTap: function(e) {
    var index = e.currentTarget.dataset.idx;
    this.setData({
      currentTab: index,
      page: 1,
      pricePage: 1,
      salesPage: 1
    });
    var that = this;
    switch (index) {
      case 0:
        this.setData({
          price: false,
          sales: false
        })
        break;
      case 1:
        var nav = 'navbar[' + index + '].sorts';
        that.setData({
          sales: false
        });
        if (that.data.price) {
          if (that.data.navbar[index].sorts) {
            that.setData({
              sortType: 'asc',
              [nav]: false,
            })
          } else {
            that.setData({
              sortType: 'desc',
              [nav]: true
            })
          };
          requ.request({
            url: api.api.search,
            data: {
              key: that.data.content,
              page: that.data.pricePage,
              sort: that.data.sortType,
              type: 3
            },
            success: function(res) {
              that.setData({
                priceList: res.data.list,
                priceHasNextPage: res.data.hasNextPage
              })
            }
          });
        } else {
          that.setData({
            price: true
          });
          if (that.data.priceList.length == 0) {
            wx.showLoading({
              title: '加载中',
            });
            requ.request({
              url: api.api.search,
              data: {
                key: that.data.content,
                page: that.data.pricePage,
                sort: that.data.sortType,
                type: 3
              },
              success: function(res) {
                wx.hideLoading();
                that.setData({
                  priceList: res.data.list,
                  priceHasNextPage: res.data.hasNextPage
                })
              }
            });
          }
        }
        break;
      case 2:
        var nav = 'navbar[' + index + '].sorts';
        that.setData({
          price: false
        });
        if (that.data.sales) {
          if (that.data.navbar[index].sorts) {
            that.setData({
              salesBool: 'asc',
              [nav]: false
            })
          } else {
            that.setData({
              salesBool: 'desc',
              [nav]: true
            })
          };
          requ.request({
            url: api.api.search,
            data: {
              key: that.data.content,
              page: that.data.salesPage,
              sort: that.data.salesBool,
              type: 2
            },
            success: function(res) {
              that.setData({
                salesList: res.data.list,
                salesHasNextPage: res.data.hasNextPage
              })
            }
          })
        } else {
          that.setData({
            sales: true
          });
          if (that.data.salesList.length == 0) {
            wx.showLoading({
              title: '加载中',
            });
            requ.request({
              url: api.api.search,
              data: {
                key: that.data.content,
                page: that.data.salesPage,
                sort: that.data.salesBool,
                type: 2
              },
              success: function(res) {
                wx.hideLoading();
                that.setData({
                  salesList: res.data.list,
                  salesHasNextPage: res.data.hasNextPage
                })
              }
            })
          }
        }
        break;
    }
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {

    if (options.share_user_id) {
      wx.setStorageSync('shareId', options.share_user_id);
    }
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  // 监听导航栏到顶部距离
  aaaa: function(e) {
    console.log(e)
  },
  //获取搜索框内容
  get_value: function(e) {
    this.setData({
      content: e.detail.value
    })
  },
  // 搜索按钮
  search_Result: function() {
    this.setData({
      page: 1
    });
    var that = this
    requ.request({
      url: api.api.search,
      data: {
        key: that.data.content
      },
      success: function(res) {
        console.log(res.data.list)
        that.setData({
          searchList: res.data.list,
          hasNextPage: res.data.hasNextPage,
        })
      }
    })
  },
  bor: function(e) {
    console.log(e)
  },
  // 跳转商品详情页
  go_detail: function(e) {
    console.log('123')
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        if (app.conFig.switchTabUrl != undefined) {
          console.log('456')
          if (app.conFig.switchTabUrl.indexOf('detail') != -1) {
            app.detailId = e.currentTarget.dataset.id
            wx.reLaunch({
              url: '../detail/detail',
            })
          } else {
            wx.navigateTo({
              url: '../detail/detail?shop_id=' + e.currentTarget.dataset.product_id,
            })
          }
        } else {

          console.log('789')
          wx.navigateTo({
            url: '../detail/detail?shop_id=' + e.currentTarget.dataset.product_id,
          })
        }
      }
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
      var that = this;
      if (that.data.content.length > 0) {} else {
        wx.showLoading({
          title: '加载中',
        });
        requ.request({
          url: api.api.search,
          data: {
            key: '',
          },
          success: function(res) {
            wx.hideLoading();
            that.setData({
              searchList: res.data.list,
              hasNextPage: res.data.hasNextPage,
            })
          }
        });
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
    var that = this;
    switch (that.data.currentTab) {
      case 0:
        if (this.data.hasNextPage) {
          that.setData({
            page: that.data.page + 1
          })
          requ.request({
            url: api.api.search,
            data: {
              key: that.data.content,
              page: that.data.page
            },
            success: function(res) {
              that.setData({
                searchList: that.data.searchList.concat(res.data.list),
                hasNextPage: res.data.hasNextPage,
              })
            }
          })
        }
        break;
      case 1:
        if (that.data.priceHasNextPage) {
          that.setData({
            pricePage: that.data.pricePage + 1
          })
          requ.request({
            url: api.api.search,
            data: {
              key: that.data.content,
              page: that.data.pricePage,
              type: 3
            },
            success: function(res) {
              that.setData({
                priceList: that.data.priceList.concat(res.data.list),
                priceHasNextPage: res.data.hasNextPage,
              })
            }
          })
        }
        break;
      case 2:
        if (that.data.salesHasNextPage) {
          that.setData({
            salesPage: that.data.salesPage + 1
          })
          requ.request({
            url: api.api.search,
            data: {
              key: that.data.content,
              page: that.data.salesPage,
              type: 2
            },
            success: function(res) {
              that.setData({
                salesList: that.data.salesList.concat(res.data.list),
                salesHasNextPage: res.data.hasNextPage,
              })
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
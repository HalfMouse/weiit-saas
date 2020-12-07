const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
// pages/after_sale/after_sale.js
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    option: [],
    // bool: false,
    img_arr: [],
    state: '请选择',
    types: '请选择',
    goods: {
      title: '货品状态',
      list: [{
          listTitle: '未收到货',
          bool: false
        },
        {
          listTitle: '已收到货',
          bool: false
        },
      ]
    }, //货品状态
    sales: {
      title: '售后类型',
      list: [{
          listTitle: '仅退款',
          listMin: '未收到货(包括未签收),或卖家协商同意前提下',
          bool: false
        },
        {
          listTitle: '退货退款',
          listMin: '已收到货，需要退换已收到的货物',
          bool: false
        },
      ]
    }, //货品状态
    order_id: '', //订单ID
    pay_price: '', //订单价格
    id: '', //订单详情ID
    con: [], //订单详情内容
    name: '',
    refund_type: '',
    Explain: '', //退换说明、备注
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
    if (wx.getStorageSync('token') != '') {
      this.setData({
        order_id: options.id,
        // id: options.product_id,
        con: JSON.parse(options.con)
      })
    } else {
      wx.navigateTo({
        url: '../userInfo/userInfo',
      })
    };
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  // 备注原因、说明
  get_value: function(e) {
    console.log(e)
    this.setData({
      Explain: e.detail.value
    })
  },
  // 上传图片
  sub_img: function() {
    var that = this;
    wx.chooseImage({
      count: 3,
      success: function(res) {
        var tempFilePaths = res.tempFilePaths;
        that.data.img_arr = [];
        for (var i = 0; i < tempFilePaths.length; i++) {
          wx.uploadFile({
            url: 'https://www.woyoulian.com/api/uploadImg',
            filePath: tempFilePaths[i],
            name: 'file',
            formData: {
              'user': 'test'
            },
            success: function(res) {
              that.data.img_arr.push(JSON.parse(res.data).data[0].img_url);
            }
          })
        }
        that.setData({
          img_list: res.tempFilePaths
        })
      },
    })
  },
  // 提交
  sub: function() {
    var that = this;
    var pic_str = (that.data.img_arr).join(',')
    if (that.data.refund_type && that.data.order_id) {
      requ.request({
        url: api.api.addOrderRefund,
        data: {
          refund_imgs: pic_str,
          id: that.data.order_id,
          // order_item_id: that.data.id,
          remark: that.data.Explain,
          refund_type: that.data.refund_type,
          // refund_reason: that.data.Explain,
          // refund_money: that.data.con.pay_price
        },
        success: () => {
          wx.showToast({
            title: '提交成功',
            success: () => {
              setTimeout(function() {
                wx.navigateBack({})
              }, 1000)
            }
          })
        }
      })
    } else {
      wx.showToast({
        title: '信息不完整',
        icon: 'none'
      })
    }
  },
  // 货品状态
  state: function(e) {
    this.goodModal();
  },
  // 货品状态
  radioType: function(e) {
    var index = e.currentTarget.dataset.index;
    var radio = 'goods.list[' + index + '].bool';
    for (var i = 0; i < this.data.goods.list.length; i++) {
      this.data.goods.list[i].bool = false
    };
    this.setData({
      goods: this.data.goods,
      [radio]: true
    });
    for (var i = 0; i < this.data.goods.list.length; i++) {
      if (this.data.goods.list[i].bool) {
        this.setData({
          state: this.data.goods.list[i].listTitle
        })
      }
    };
    this.goodsModal();
  },
  // 售后类型
  types: function(e) {
    this.saleModal();
  },
  // 售后类型
  saleType: function(e) {
    var index = e.currentTarget.dataset.index;
    var radio = 'sales.list[' + index + '].bool';
    for (var i = 0; i < this.data.sales.list.length; i++) {
      this.data.sales.list[i].bool = false
    };
    this.setData({
      sales: this.data.sales,
      [radio]: true
    });
    for (var i = 0; i < this.data.sales.list.length; i++) {
      if (this.data.sales.list[i].bool) {
        this.setData({
          types: this.data.sales.list[i].listTitle
        });
        if (this.data.sales.list[i].listTitle == '退货退款') {
          this.setData({
            refund_type: 2
          })
        } else {
          this.setData({
            refund_type: 1
          })
        }
      }
    };
    this.salesModal()
  },
  // 货品状态
  goodModal: function() {
    // 显示遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(300).step()
    this.setData({
      animationData: animation.export(),
      goodsModalStatus: true
    })
    setTimeout(function() {
      animation.translateY(0).step()
      this.setData({
        animationData: animation.export()
      })
    }.bind(this), 0)
  },
  goodsModal: function() {
    // 隐藏遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(300).step()
    this.setData({
      animationData: animation.export(),
    })
    setTimeout(function() {
      animation.translateY(0).step()
      this.setData({
        animationData: animation.export(),
        goodsModalStatus: false,
        bool: false
      })
    }.bind(this), 200)
  },
  // 售后类型
  saleModal: function() {
    // 显示遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(300).step()
    this.setData({
      animationData: animation.export(),
      showModalStatus: true
    })
    setTimeout(function() {
      animation.translateY(0).step()
      this.setData({
        animationData: animation.export()
      })
    }.bind(this), 0)
  },
  salesModal: function() {
    // 隐藏遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(300).step()
    this.setData({
      animationData: animation.export(),
    })
    setTimeout(function() {
      animation.translateY(0).step()
      this.setData({
        animationData: animation.export(),
        showModalStatus: false,
        bool: false
      })
    }.bind(this), 200)
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
      title: '蜗店',
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  }
})
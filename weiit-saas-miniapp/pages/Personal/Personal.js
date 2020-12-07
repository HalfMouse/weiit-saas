const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
const app = getApp();
// pages/Personal/Personal.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    options: [], //上个页面带过来的数据
    personal: ["我的订单", "我的钱包", "我的积分"],
    num: 0, //我的点单、钱包、积分数量
    load: false, //页面数据是否加载完成,
    isShow:false,
    menus: [{
        icon: "icon-zhifu",
        name: "待支付"
      },
      {
        icon: "icon-fahuo",
        name: "待发货"
      },
      {
        icon: "icon-shouhuo",
        name: "待收货"
      },
      {
        icon: "icon-tuihuodan",
        name: "退货管理"
      }
    ], //支付选项块
    option_btn: [{
        icon: "../../images/Coupon.png",
        name: "优惠券"
      },
      // {
      //   icon: "../../images/vip.png",
      //   name: "会员卡"
      // },
      {
        icon: "../../images/vip.png",
        name: "积分商城"
      },
      {
        icon: "../../images/address.png",
        name: "收货地址"
      },
      {
        icon: "../../images/Collection.png",
        name: "我的收藏"
      },
      {
        icon: "../../images/Opinion.png",
        name: "意见反馈"
      },
      {
        icon: "../../images/service.png",
        name: "在线客服(9:00~21:00）"
      }
    ], //功能选项块
    content: [], //个人信息
    haveFight:false,    //是否有我的拼团入口
    haveCut: false    //是否有我的砍价入口
  },
  option_btns(e){
    const type = e.currentTarget.dataset.type;
    if (type == 'fight'){
      wx.navigateTo({
        url: '../collageList/collageList?currentTab=1'
      })
    }else{
      wx.navigateTo({
        url: '../teams/teams?currentTab=1'
      })
    }
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    if (options.share_user_id){
      wx.setStorageSync('shareId', options.share_user_id);
    }
    this.setData({
      options: options
    });
    wx.setNavigationBarColor({
      frontColor: '#ffffff',
      backgroundColor: wx.getStorageSync('globalStyle').global_bg1,
    })
  },
  // 个人信息
  setup: function() {
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        wx.navigateTo({
          url: '../Set_up/Set_up',
        })
      }
    })
  },
  // 我的钱包
  my_btn: function(e) {
    var that = this;
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        var index = e.currentTarget.dataset.index;
        switch (index) {
          case '0': //我的订单
            wx.navigateTo({
              url: '../Order/Order?id=' + (-1),
            })
            break;
          case "1": //我的钱包
            wx.navigateTo({
              url: '../wallet/wallet?money=' + that.data.content.balance
            })
            break;
          case "2": //我的积分
            wx.navigateTo({
              url: '../integral/integral?integral=' + that.data.content.integral
            })
            break;
        }
      }
    })
  },
  option_btn: function(e) {
    var that = this;
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
    requ.verify(function(code) {
      if (code == 0) {
        var index = e.detail.target.dataset.id;
        
        switch (index) {
          case 0: // 优惠券
            wx.navigateTo({
              url: '../Coupon/Coupon?index=' + index,
            })
            break;
          // case 1: // 会员卡
          //   // wx.navigateTo({
          //   //   url: '../VIP/VIP?index=' + index,
          //   // })
          //   wx.showToast({
          //     title: '该功能暂未开放！敬请期待',
          //     icon: 'none'
          //   })
          //   break;
          case 1: // 积分商城
            wx.navigateTo({
              url: '../IntegralMall/IntegralMall?index=' + index + '&integral=' + that.data.content.integral,
            })
            break;
          case 2: // 收货地址
            wx.navigateTo({
              url: '../address/address?index=' + index,
            })
            break;
          case 3: // 我的收藏
            wx.navigateTo({
              url: '../Collection/Collection?index=' + index,
            })
            break;
          case 4: //意见反馈
            wx.navigateTo({
              url: '../Opinion/Opinion?idnex=' + index,
            })
            break;
          case 5: //在线客服
            that.getTel();
            break;
        }
      }
    })
  },
  // 待支付、发货...
  click_menu: function(e) {
    console.log(e, 'formId')
    // 页面跳转拦截
    requ.verify(function(code) {
      if (code == 0) {
        var click_id = parseInt(e.detail.target.dataset.id)
        switch (click_id) {
          case 0:
          case 1:
          case 2:
            wx.navigateTo({
              url: '../Order/Order?id=' + click_id,
            })
            break;
          default:
            wx.navigateTo({
              url: '../ReturnGoods/ReturnGoods?id=' + click_id,
            })
        }
      }
    })
  },
  // 跳转到转发页面
  toForward:function(e){
    wx.navigateTo({
      url: '/pages/Forward/Forward',
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
      if (this.data.content == '') {
        wx.showLoading({
          title: '加载中',
        })
      }
      var that = this
      this.getEnterPoint();
      requ.request({
        url: api.api.userInfo,
        success: function(res) {
          if (res.code == 0) {
            that.setData({
              content: res.data,
              load: true
            });
            wx.hideLoading()
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
      title: '蜗店',
      path: 'pages/index/index?page=' + getApp().page + '&share_user_id=' + wx.getStorageSync('user_id')
    }
  },
  // 获取客服电话
  getTel(){
    requ.request({
      url: api.api.getShopInfo,
      success: function (res) {
        console.log(res)
        if (res.code == 0) {
          wx.makePhoneCall({
            phoneNumber: res.data.shop_tel
          })
        }else{
          wx.showToast({
            title: res.message,
            icon: 'none',
          })
        }
      }
    })
  },
  // 获取入口配置
  getEnterPoint(){
    const that = this;
    requ.request({
      url: api.api.enterPointConfig,
      success:function(res){
        console.log(res);
        if(res.code == '0'){
          res.data.forEach((item) => {
            if (item.item_desc == '我的拼团') {
              that.setData({
                haveFight: true
              })
            }
            if (item.item_desc == '我的砍价') {
              that.setData({
                haveCut: true
              })
            }
          })
          
        }
      }
    })
  }
})
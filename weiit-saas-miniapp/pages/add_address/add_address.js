const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
// pages/add_address/add_address.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    add_name: '', //新增收货人姓名
    name: true, //姓名验证
    add_tel: '', //新增收货人手机号码
    phone: true, //手机号码
    region: [], //新增收货人省、市、县
    add_ads: '', //新增收货人详细地址
    address: true, //详细地址
    is_default: 0, //是否设置为默认地址
    complete: true, //防止重复点击
    add_content: [],
    add: true,
    options: [],
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
  //收货人姓名
  name: function(e) {
    // let name = /^[\u4E00-\u9FA5\uf900-\ufa2d]{2,4}$/;
    // if (name.test(e.detail.value)) {
      this.setData({
        // name: true,
        add_name: e.detail.value
      })
    // } else {
    //   this.setData({
    //     name: false
    //   })
    // }



  },
  //收货人手机号
  tel: function(e) {
    let tel = /^1[0-9]{10}$/;
    if (tel.test(e.detail.value)) {
      this.setData({
        phone: true,
        add_tel: e.detail.value
      })
    } else {
      this.setData({
        phone: false
      })
    }


  },
  //收货人省、市、县
  bindRegionChange: function(e) {
    this.setData({
      region: e.detail.value,
      add: false
    })
  },
  //收货人详细地址
  ads: function(e) {
    let ads = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
    if (ads.test(e.detail.value)) {
      this.setData({
        address: true,
        add_ads: e.detail.value
      });
    } else {
      this.setData({
        address: false
      })
    }

  },
  // 是否默认地址
  switch: function(res) {
    if (res.detail.value == true) {
      this.setData({
        is_default: 0
      })
    } else {
      this.setData({
        is_default: -1
      })
    }
  },
  // 保存收货信息
  Preservation: function(e) {
    var that = this;
    if (that.data.add_name != '' && that.data.add_tel != '' && that.data.region.length > 0 && that.data.add_ads != '') {
      if (that.data.complete) {
        that.setData({
          complete: false
        });
        requ.request({
          url: api.api.myAddressSave,
          data: {
            consignee: that.data.add_name, //收件人姓名
            province: that.data.region[0],
            city: that.data.region[1],
            district: that.data.region[2],
            address_detail: that.data.add_ads,
            phone: that.data.add_tel,
            is_default: that.data.is_default
          },
          success: function(res) {
            that.setData({
              complete: true
            });
            wx.navigateBack({})
          }
        })
      } else {
        wx.showToast({
          title: '请不要重复点击',
          icon: 'none'
        })
      }
    } else {
      wx.showToast({
        title: '请确保格式正确',
        icon: 'none'
      })
    }


  },
  // 修改收货地址
  modify: function() {
    if (this.data.complete) {
      this.setData({
        complete: false
      });
      var add_name, add_tel, region = [],
        add_ads;
      if (this.data.add_name == '') {
        add_name = this.data.add_content.consignee
      } else {
        add_name = this.data.add_name
      };
      if (this.data.add_tel == '') {
        add_tel = this.data.add_content.phone
      } else {
        add_tel = this.data.add_tel
      };
      if (this.data.region == '') {
        region = [this.data.add_content.province, this.data.add_content.city, this.data.add_content.district];
      } else {
        region = [this.data.region[0], this.data.region[1], this.data.region[2]]
      };
      if (this.data.add_ads == '') {
        add_ads = this.data.add_content.address_detail
      } else {
        add_ads = this.data.add_ads
      }
      var that = this;
      requ.request({
        url: api.api.myAddressUpdate,
        data: {
          consignee: add_name, //收件人姓名
          province: region[0],
          city: region[1],
          district: region[2],
          address_detail: add_ads,
          phone: add_tel,
          is_default: that.data.is_default,
          id: that.data.add_content.id
        },
        success: function(res) {
          that.setData({
            complete: true
          })
          wx.navigateBack({})
        }
      })
    } else {
      wx.showToast({
        title: '请不要重复点击',
        icon: 'none'
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
    if (wx.getStorageSync('token') != '') {
      if (this.data.options.pages == 'add') {
        this.setData({
          add_content: JSON.parse(this.data.options.add_content),
          is_default: parseInt(JSON.parse(this.data.options.add_content).is_default)
        })
      };
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
  }
})
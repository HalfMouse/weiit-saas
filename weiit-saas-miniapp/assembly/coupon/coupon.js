const app = getApp();
const util = require('../../utils/util.js');
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
Component({

  behaviors: [],

  properties: {
    pageParam: Object,
  },
  data: {
    coupon: []
  },

  created: function(e) {},
  attached: function() {
    console.log(this.data.pageParam,'微页面优惠券')
    var that = this;
    var couponGetType;
    var showNum = '';
    if (that.data.pageParam.addFun == "automatic") {
      couponGetType = 1;
      showNum = that.data.pageParam.showNum === undefined || that.data.pageParam.showNum === null ? 0 : that.data.pageParam.showNum;
    };
    if (that.data.pageParam.addFun == "manual") {
      couponGetType = 0;
      showNum = ''
    }
    requ.request({
      url: api.api.couponListByIds,
      data: {
        coupon_ids: that.data.pageParam.coupon_ids,
        couponGetType: couponGetType,
        showNum: showNum
      },
      success: function(res) {
        for (var i = 0; i < res.data.length; i++) {
          res.data[i].imgUrl = '../../images/coupon2.png';
          res.data[i].receive = true;
        }
        console.log(res, '优惠券列表111')
        if (res.data.length < 3) {
          that.setData({
            coupon: res.data,
            voucherWidth: 100,
          })
        } else {
          that.setData({
            coupon: res.data,
            voucherWidth: res.data.length * 50,
          })
        }
      }
    })
  },
  moved: function() {},
  detached: function() {},

  methods: {
    // 领取优惠券
    receives: function(e) {
      var index = e.detail.target.dataset.index;
      var that = this;
      if (that.data.coupon[index].receive) {
        requ.request({
          url: api.api.couponGet,
          data: {
            coupon_id: e.detail.target.dataset.id
          },
          success: (res) => {
            var coupon = 'coupon[' + index + '].imgUrl';
            var Receive = 'coupon[' + index + '].receive';
            if (res.code == 4000) {
              that.setData({
                [coupon]: '../../images/coupon1.png',
                [Receive]: false
              })
              wx.showToast({
                title: res.message,
                icon: 'none'
              })
            } else {
              var coupon = 'coupon[' + index + '].imgUrl'
              that.setData({
                [coupon]: '../../images/coupon1.png'
              });
            }
          }
        })
      }
    },
  }
})
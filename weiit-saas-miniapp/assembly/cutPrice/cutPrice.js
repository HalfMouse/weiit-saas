//获取应用实例
const app = getApp();
const util = require('../../utils/util.js');
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
Component({

  behaviors: [],

  properties: {
    pageParam: Object
  },
  data: {

  },

  created: function(e) {

  },
  attached: function() {
    console.log(this.data, '这是砍价');
    var that = this;
    var bargainGetType;
    if (that.data.pageParam.addFun == "automatic") {
      bargainGetType = 1
    };
    if (that.data.pageParam.addFun == "manual") {
      bargainGetType = 0
    }
    requ.request({
      url: api.api.getProductByBargainIds,
      data: {
        bargain_ids: that.data.pageParam.bargain_ids,
        bargainGetType: bargainGetType
      },
      success: function(res) {
        console.log(res, '砍价列表')
        that.setData({
          cutContent: res.data,
        })
      }
    })
  },
  moved: function() {},
  detached: function() {},

  methods: {
    //帮我砍价
    helpMe: function(e) {
      var id = e.currentTarget.dataset.id
      var value = e.currentTarget.dataset.value
      // 页面跳转拦截
      requ.verify(function(code) {
        if (code == 0) {
          // 砍价接口
          requ.request({
            url: api.api.isBargain,
            data: {
              bargain_id: e.currentTarget.dataset.id
            },
            success: function(res) {
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
    // 更多砍价
    look_orr: function(e) {
      var value = e.currentTarget.dataset.value;
      wx.navigateTo({
        url: '../teams/teams?currentTab=0',
      })
    }
  }

})
//获取应用实例
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
    list: []
  },

  created: function(e) {

  },
  attached: function() {
    console.log(this.data.pageParam, '商品列表')
    var that = this;
    var productGetType;
    var productIds = that.data.pageParam.productIds;
    var showNum;
    if (that.data.pageParam.addFun == "automatic") {
      productGetType = 1;
      showNum = that.data.pageParam.showNum;
    };
    if (that.data.pageParam.addFun == "manual") {
      productGetType = 0;
      showNum = ''
    };
    if (productIds.length > 0){
      
      requ.request({
        url: api.api.getProductListByIds,
        data: {
          productIds: productIds,
          productGetType: productGetType,
          showNum: showNum
        },
        success: function (res) {
          console.log(res, '商品')
          that.setData({
            list: res.data.productInfo,
            scroll_width: res.data.length * 33,
          });
          if (that.data.pageParam.listStyle == "zigzag") {
            that.setData({
              list: res.data.productInfo.slice(0, 3)
            })
          }
        }
      });
    }
  },
  moved: function() {},
  detached: function() {},

  methods: {
    // 去商品详情
    go_detail: function(e) {
      console.log(e, 'formid')
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
          if (app.conFig.switchTabUrl != undefined) {
            if (app.conFig.switchTabUrl.indexOf('detail') != -1) {
              app.detailId = e.detail.target.dataset.product_id;
              wx.reLaunch({
                url: '../detail/detail',
              })
            } else {
              wx.navigateTo({
                url: '../detail/detail?shop_id=' + e.detail.target.dataset.product_id,
              })
            }
          } else {
            wx.navigateTo({
              url: '../detail/detail?shop_id=' + e.detail.target.dataset.product_id,
            })
          };

        }
      })
    }
  }
  
})
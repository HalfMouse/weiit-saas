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
  data: {},

  created: function(e) {
    // console.log(this.data, '这是拼团')
  },
  attached: function() {
    console.log(this.data.pageParam, '这是拼团')
    var that = this;
    var grouponGetType;
    var showNum;
    var fightTitle = this.data.pageParam.fightTitle == '' ? '组团拼团' : this.data.pageParam.fightTitle;
    this.setData({
      fightTitle: fightTitle
    })
    if (that.data.pageParam.addFun == "automatic") {
      grouponGetType = 1;
      showNum = that.data.pageParam.showNum
    };
    if (that.data.pageParam.addFun == "manual") {
      grouponGetType = 0;
      showNum = ''
    }
    requ.request({
      url: api.api.grouponListByIds,
      data: {
        groupon_ids: that.data.pageParam.groupon_ids,
        grouponGetType: grouponGetType,
        showNum: showNum
      },
      success: function(res) {
        console.log(res.data, '拼团数据')
        // groupon_number
        that.setData({
          collage: res.data,
        })
      }
    })
  },
  moved: function() {},
  detached: function() {},

  methods: {
    // 拼团
    collage: function(e) {
      console.log(e, 'formID')
      // 添加formId
      requ.request({
        url: api.api.formID,
        data: {
          openId: app.globaLogin.openid,
          formId: e.detail.formId,
        },
        success: res => console.log(res)
      })
      var productId = e.detail.target.dataset.id;
      var groupon_id = e.detail.target.dataset.index;
      // 页面跳转拦截
      requ.verify(function(code) {
        console.log(code)
        if (code == 0) {
          wx.navigateTo({
            url: '../Collage/Collage?shop_id=' + productId + '&groupon_id=' + groupon_id,
          })
        }
      })
    },
    // 查看全部砍价、拼团
    look_orr: function(e) {
      var value = e.currentTarget.dataset.value;
      // 页面跳转拦截
      requ.verify(function(code) {
        if (code == 0) {
          wx.navigateTo({
            url: '../collageList/collageList?currentTab=0',
          })
        }
      })
    },
  }

})
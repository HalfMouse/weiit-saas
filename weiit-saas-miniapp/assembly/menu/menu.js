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
  data: {},

  created: function(e) {
    // console.log(this.data, '这是砍价')
  },
  attached: function() {},
  moved: function() {},
  detached: function() {},

  methods: {
    //图文导航跳转
    nav_jump: function(e) {
      console.log(e)
      // 添加formId
      requ.request({
        url: api.api.formID,
        data: {
          openId: app.globaLogin.openid,
          formId: e.detail.formId,
        },
        success: res => console.log(res)
      });
      var url = e.detail.target.dataset.url;
      var pageId = e.detail.target.dataset.pageid;
      console.log(e);
      // 页面跳转拦截
      requ.verify(function(code) {
        app.indexFirst = true;
        if (code == 0) {
          requ.banner(url, pageId)
        }
      })
    },
  }

})
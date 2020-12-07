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
    haveBlock:'yes'
  },

  created: function(e) {
    // console.log(this.data, '这是广告模块')
  },

  methods: {
    // 广告模块跳转
    bannerJump: function(e) {
      var url = e.currentTarget.dataset.pageurl;
      var validate_id = e.currentTarget.dataset.validate_id;
      app.indexFirst = true;
      requ.banner(url, validate_id)
    },
  }

})
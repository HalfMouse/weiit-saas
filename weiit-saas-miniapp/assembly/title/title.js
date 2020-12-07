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
    go_page: function(e) {
      var url = e.currentTarget.dataset.url;
      var validate_id = e.currentTarget.dataset.validate_id;
      requ.banner(url, validate_id)
    },
  }

})
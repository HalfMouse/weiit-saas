//获取应用实例
const app = getApp();
const util = require('../../utils/util.js');
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
const WxParse = require('../../wxParse/wxParse.js');
Component({

  behaviors: [],

  properties: {
    pageParam: Object,
  },
  data: {},

  created: function(e) {},
  attached: function() {
    console.log(this.data, '富文本')
    const article = this.data.pageParam.content;
    var that=this;
    WxParse.wxParse('article', 'html', article, that, 5);
  },
  moved: function() {},
  detached: function() {},

  methods: {}

})
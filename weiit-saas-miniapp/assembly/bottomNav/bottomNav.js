//获取应用实例
const app = getApp();
const util = require('../../utils/util.js');
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
Component({

  behaviors: [],

  properties: {
  },
  data: {
    // bottomMenuList: [],
  },

  created: function(e) {},
  attached: function() {
    // this.setData({
    //   bottomMenuList: wx.getStorageSync('bottomMenuList')
    // })
  },
  moved: function() {},
  detached: function() {},

  methods: {
    // 底部导航页面跳转
    // goPage: function(e) {
    //   console.log(e,'111')
    //   var url = e.currentTarget.dataset.url;
    //   var target_id = e.currentTarget.dataset.target_id;
    //   requ.go_page(url, target_id);
    // },
  }

})
//获取应用实例
const app = getApp();
const util = require('../../utils/util.js');
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
Component({

  behaviors: [],

  properties: {
    content: Object
  },
  data: {},

  created: function(e) {
    // console.log(this.data, '客服电话')
  },
  attached: function() {},
  moved: function() {},
  detached: function() {},

  methods: {
    tel: function() {
      wx.makePhoneCall({
        phoneNumber: this.data.content.custom_tel,
      })
    }
  }

})
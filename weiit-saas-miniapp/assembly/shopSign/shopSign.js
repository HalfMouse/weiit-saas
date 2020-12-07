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
    shop_logo:''
  },

  created: function (e) {
    // console.log(this.data, '这是砍价')
    this.getLogo();
  },
  attached: function () { },
  moved: function () { },
  detached: function () { },

  methods: {
    getLogo(){
      const that = this;
      requ.request({
        url: api.api.shopLogo,
        method:'GET',
        success:function(res){
          console.log(res);
          if (res.shopInfo.shop_logo){
            that.setData({
              shop_logo: res.shopInfo.shop_logo
            })
          }else{
            that.setData({
              shop_logo: '/images/logo1.png'
            })
          }
          
        }
      })
    }
  }

})
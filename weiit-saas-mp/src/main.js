// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import MintUI from 'mint-ui'
import '../node_modules/mint-ui/lib/style.css'
import axios from 'axios'
import fastclick from 'fastclick'
import qs from 'qs'
import config from './lib/config/config.js'
import 'vant/lib/index.css'
import { Swipe, SwipeItem, Toast, Loading, Tab, Tabs, NoticeBar} from 'vant';
Vue.use(Swipe).use(SwipeItem).use(Toast).use(Loading).use(Tab).use(Tabs).use(NoticeBar);


Vue.use(config);

Vue.use(MintUI);

import '../static/js/rem';
import '../static/css/base.scss';
import '../static/css/mymint.scss';
import {getQueryString} from '../static/js/getQueryString'
import $url from './lib/config/config'
import cookie from '../static/js/cookies'


// 线上地址
let onLineUrl = 'https://api.ustore.wang'; 
// 测试地址
// let testUrl = 'https://api.woyoulian.com';
axios.defaults.baseURL = onLineUrl;
// axios.defaults.baseURL = testUrl;
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';

// 将fastclick挂载到body上，解决所有元素的点击事件的300ms延迟问题
fastclick.attach(document.body)

let appid = localStorage.getItem('appid');
if(appid){
  axios.post('/api/initParam',qs.stringify({
      appid:appid
  })).then(res => {
      if(res.data.code == '0'){
          let navMenu = res.data.data.bottomMenuList;
          let globalStyle = res.data.data.globalStyle;
          localStorage.setItem('bottomMenuList',JSON.stringify(navMenu));
          localStorage.setItem('bg1',globalStyle.global_bg1);
          localStorage.setItem('bg2',globalStyle.global_bg2);
      }
  }).catch(err => {
      console.log(err)
  }) 
}
// 发送申请前设定token值
axios.interceptors.request.use(
  config => {
      let Token = cookie.get('token');
      config.headers['token'] = Token;
      config.headers['content-type'] = 'application/x-www-form-urlencoded';
      return config
  },
  err => {
      return Promise.reject(err)
  }
)



Vue.config.productionTip = false;

router.beforeEach((to, from, next) => {
  /* 路由发生变化修改页面title */
  if (to.meta.title) {
    document.title = to.meta.title
  }
  next()
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})

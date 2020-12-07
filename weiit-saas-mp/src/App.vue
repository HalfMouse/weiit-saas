<template>
  <div id="app">
    <keep-alive>
      <router-view v-if="$route.meta.keepAlive"></router-view>
    </keep-alive>
    <router-view v-if="!$route.meta.keepAlive"></router-view>
  </div>
</template>

<script>
import cookie from '../static/js/cookies';
import axios from 'axios';
import qs from 'qs';
export default {
  name: 'App',
  created(){
    
    this.$router.beforeEach((to, from, next) => {
      /* 路由发生变化修改页面title */
      // cookie.set('token', '', -1);
      if (to.meta.title) {
        document.title = to.meta.title
      }
      next()
    })
  }
}
</script>

<style>
#app{
  position: relative;
  height: 100%;
  width: 100%;
  overflow-x: hidden;
  /* overflow-x: hidden; */
  -webkit-overflow-scrolling: touch;
}
</style>

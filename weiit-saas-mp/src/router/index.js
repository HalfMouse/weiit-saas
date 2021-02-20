import Vue from 'vue'
import Router from 'vue-router'
// 引入首页
import Home from '@/views/home'
// 引入领取优惠券
import receive from '@/views/home/receive'
// 分类组件引入
import category from '@/views/sort/category';
// 搜索组件引入
import search from '@/views/sort/search';
// 购物车路由
import shopcart from '@/views/shopCart';
// 引入个人中心
import person from '@/views/person';
// 引入退货管理
import returnGoods from '@/views/person/returnGoods'
// 引入退款详情
import viewDetails from '@/views/person/viewDetails'
// 引入订单详情
import order from '@/views/person/order'
// 引入我的收藏
import collection from '@/views/person/collection'
// 引入收件地址管理
import address from '@/views/person/address'
// 引入添加地址
import addSite from '@/views/person/addSite'
// 引入我的钱包
import wallet from '@/views/person/wallet'
// 引入我的积分
import integral from '@/views/person/integral'
// 引入提现
import postal from '@/views/person/postal'
// 引入充值
import recharge from '@/views/person/recharge'
// 引入充值详情
import rechargeDetail from '@/views/person/rechargeDetail'
// 引入意见反馈
import feedback from '@/views/person/feedback'
// 引入提现确认
import confirm from '@/views/person/confirm'
// 引入会员卡
import member from '@/views/person/member'
// 引入会员详情
import memberDetails from '@/views/person/memberDetails'
// 引入优惠券
import coupon from '@/views/person/coupon'
// 引入收支 明细
import payments from '@/views/person/payments'
// 引入商品详情
import goodsDetail from '@/views/sort/goodsDetail'
// 引入砍价列表
import bargain from '@/views/active/bargain'
// // 引入拼图列表
// import fightList from '@/views/active/fightList'
// 引入砍价免费拿
import freeGet from '@/views/home/freeGet'
// 引入订单详情页
import orderDetails from '@/views/person/orderDetails'
// 引入申请售后页
import afterSales from '@/views/person/afterSales'
// 引入订单物流页
import logistics from '@/views/person/logistics'
// 引入个人信息设置页
import setPerson from '@/views/person/setPerson'
// 引入新手机验证
import verification from '@/views/person/verification'
// 引入补充物流信息
import addLogistics from '@/views/person/addLogistics'
// 引入积分商城
import IntegralMall from '@/views/person/IntegralMall'
// 引入积分规则
import IntegralRule from '@/views/person/IntegralRule'
// 引入积分商品详情
import IntegralDetail from '@/views/person/IntegralDetail'
// 引入积分商品列表
import IntegralList from '@/views/person/IntegralList'
// 引入积分商品付费
import IntegralCar from '@/views/person/IntegralCar'
// 引入拼团商品详情
import fightGoodsDetail from '@/views/active/fightGoodsDetail'
// 引入发起拼团组件
import fightShop from '@/views/active/fightShop';
// 引入发起拼团/参加拼团成功组件
import Invitation from '@/views/active/invitation';
// 引入我的拼团商品详情
// import fightDetail from '@/views/active/fightDetail';
// 引入地址页选择
import addressBox from '@/views/active/addressBox';
// 引入购买成功
import buySuccess from '@/views/active/buySuccess';
import formData from '@/components/formData'
import error from '@/components/error'

// 引入axios
import axios from 'axios';
// 引入qs
import qs from 'qs';
import cookie from '../../static/js/cookies';
import {getQueryString} from '../../static/js/getQueryString';

Vue.use(Router)

const router = new Router({
  mode:'history',
  routes: [{
    path: '/',
    name: 'home',
    // component: Home,
    component: resolve => require(['@/views/home'],resolve),
    meta:{
      keepAlive: false
    }
  },{
    path: '/:page_id(\\d+)',
    name: 'home1',
    // component: Home,
    component: resolve => require(['@/views/home'],resolve),
    meta:{
      keepAlive: false
    }
  },{
    path: '/Receive_coupons',
    name: 'Receive_coupons',
    // component: receive,
    component: resolve => require(['@/views/home/receive'],resolve),
    meta:{
      title:'领取优惠券',
      keepAlive: false
    }
  },{
    path: '/category',
    name: 'category',
    // component: Item,
    component: resolve => require(['@/views/sort/category'],resolve)
  },{
    path:'/search',
    name:'search',
    // component:search,
    component: resolve => require(['@/views/sort/search'],resolve),
    meta:{
      title:'搜索',
      keepAlive: false
    }
  },{
    path: '/shopCar',
    name: 'shopCar',
    // component: shopcart,
    component: resolve => require(['@/views/shopCart'],resolve),
    meta:{
      title:'购物车',
      keepAlive: true
    }
  },{
    path: '/Personal',
    name: 'Personal',
    // component: person,
    component: resolve => require(['@/views/person'],resolve),
    meta:{
        title:'个人中心',
        keepAlive: false
    }
  },{
    path: '/returnGoods',
    name: 'returnGoods',
    // component: returnGoods,
    // component: r => require.ensure([], () => r(require('../views/person/returnGoods')), 'returnGoods'),
    component: resolve => require(['@/views/person/returnGoods'],resolve),
    meta:{
        title:'退货管理',
        keepAlive: false
    }
  },{
    path: '/viewDetails',
    name: 'viewDetails',
    // component: viewDetails,
    // component: r => require.ensure([], () => r(require('../views/person/viewDetails')), 'viewDetails'),
    component: resolve => require(['@/views/person/viewDetails'],resolve),
    meta:{
        title:'退款详情',
        keepAlive: false
    }
  },{
    path: '/wallet',
    name: 'wallet',
    // component: wallet,
    // component: r => require.ensure([], () => r(require('../views/person/wallet')), 'wallet'),
    component: resolve => require(['@/views/person/wallet'],resolve),
    meta:{
        title:'我的钱包',
        keepAlive: false
    }
  },
  {
    path: '/integral',
    name: 'integral',
    // component: integral,
    // component: r => require.ensure([], () => r(require('../views/person/integral')), 'wallet'),
    component: resolve => require(['@/views/person/integral'],resolve),
    meta:{
        title:'我的积分',
        keepAlive: false
    }
  },
  {
    path: '/Order',
    name: 'Order',
    component: resolve => require(['@/views/person/orderShow'],resolve),
    meta:{
        title:'我的订单',
        keepAlive: false
    },
    children:[{
      path:'',
      component: resolve => require(['@/views/person/order'],resolve),
      meta:{
        title:'我的订单',
        keepAlive: false
      },
    }]
  },
  // {
  //   path: '/Order',
  //   name: 'Order',
  //   component: resolve => require(['@/views/person/order1'],resolve),
  //   meta:{
  //       title:'我的订单',
  //       keepAlive: false
  //   }
  // },
  {
    path:'/Collection',
    name:'Collection',
    // component:collection,
    // component: r => require.ensure([], () => r(require('../views/person/collection')), 'collection'),
    component: resolve => require(['@/views/person/collection'],resolve),
    meta:{
        title:'我的收藏',
        keepAlive: false
    }
  },{
    path:'/address',
    name:'address',
    // component:address,
    // component: r => require.ensure([], () => r(require('../views/person/address')), 'address'),
    component: resolve => require(['@/views/person/address'],resolve),
    meta:{
        title:'收件地址管理',
        keepAlive: false
    }
  },{
    path:'/addSite',
    name:'addSite',
    // component:addSite,
    // component: r => require.ensure([], () => r(require('../views/person/addSite')), 'addSite'),
    component: resolve => require(['@/views/person/addSite'],resolve),
    meta:{
        title:'新增地址',
        keepAlive: false
    }
  },{
    path:'/postal',
    name:'postal',
    // component:postal,
    // component: r => require.ensure([], () => r(require('../views/person/postal')), 'postal'),
    component: resolve => require(['@/views/person/postal'],resolve),
    meta:{
        title:'提现',
        keepAlive: false
    }
  },{
    path:'/Opinion',
    name:'Opinion',
    // component:feedback,
    // component: r => require.ensure([], () => r(require('../views/person/feedback')), 'feedback'),
    component: resolve => require(['@/views/person/feedback'],resolve),
    meta:{
        title:'意见反馈',
        keepAlive: false
    }
  },{
    path:'/Progress',
    name:'Progress',
    // component:confirm,
    // component: r => require.ensure([], () => r(require('../views/person/confirm')), 'confirm'),
    component: resolve => require(['@/views/person/confirm'],resolve),
    meta:{
        title:'提现确认',
        keepAlive: false
    }
  },{
    path:'/member',
    name:'member',
    // component:member,
    // component: r => require.ensure([], () => r(require('../views/person/member')), 'member'),
    component: resolve => require(['@/views/person/member'],resolve),
    meta:{
        title:'会员卡',
        keepAlive: false
    }
  },{
    path:'/memberDetails',
    name:'memberDetails',
    // component:memberDetails,
    // component: r => require.ensure([], () => r(require('../views/person/memberDetails')), 'member'),
    component: resolve => require(['@/views/person/memberDetails'],resolve),
    meta:{
        title:'会员详情',
        keepAlive: false
    }
  },{
    path:'/Coupon',
    name:'Coupon',
    // component:coupon,
    // component: r => require.ensure([], () => r(require('../views/person/coupon')), 'coupon'),
    component: resolve => require(['@/views/person/coupon'],resolve),
    meta:{
        title:'我的优惠券',
        keepAlive: false
    }
  },{
    path:'/payments',
    name:'payments',
    // component:payments,
    // component: r => require.ensure([], () => r(require('../views/person/payments')), 'payments'),
    component: resolve => require(['@/views/person/payments'],resolve),
    meta:{
        title:'收支明细',
        keepAlive: false
    }
  },{
    path:'/detail',
    name:'detail',
    // component:goodsDetail,
    // component: r => require.ensure([], () => r(require('../views/sort/goodsDetail')), 'goodsDetail'),
    component: resolve => require(['@/views/sort/goodsDetail'],resolve),
    meta:{
      title:'商品详情',
      keepAlive: false
    }
  },{
    path:'/fightDetail',
    name:'fightDetail',
    // component:fightGoodsDetail,
    // component: r => require.ensure([], () => r(require('../views/active/fightGoodsDetail')), 'fightGoodsDetail'),
    component: resolve => require(['@/views/active/fightGoodsDetail'],resolve),
    meta:{
      title:'拼团商品详情',
      keepAlive: false
    }
  },{
    path:'/teams',
    name:'teams',
    // component:bargain,
    // component: r => require.ensure([], () => r(require('../views/active/bargain')), 'bargain'),
    component: resolve => require(['@/views/active/bargain'],resolve),
    meta:{
      title:'砍价',
      keepAlive: false
    }
  },
// {
//     path:'/collageList',
//     name:'collageList',
//     // component:bargain,
//     // component: r => require.ensure([], () => r(require('../views/active/bargain')), 'bargain'),
//     component: resolve => require(['@/views/active/fightList'],resolve),
//     meta:{
//       title:'拼团',
//       keepAlive: false
//     }
//   },
{
    path:'/freeGet',
    name:'freeGet',
    // component:freeGet,
    // component: r => require.ensure([], () => r(require('../views/home/freeGet')), 'bargain'),
    component: resolve => require(['@/views/home/freeGet'],resolve),
    meta:{
      title:'砍价免费拿',
      keepAlive: false
    }
  },{
    path:'/orderDetails',
    name:'orderDetails',
    // component:orderDetails,
    // component: r => require.ensure([], () => r(require('../views/person/orderDetails')), 'bargain'),
    component: resolve => require(['@/views/person/orderDetails'],resolve),
    meta:{
      title:'订单详情',
      keepAlive: false
    }
  },{
    path:'/afterSales',
    name:'afterSales',
    // component:afterSales,
    // component: r => require.ensure([], () => r(require('../views/person/afterSales')), 'afterSales'),
    component: resolve => require(['@/views/person/afterSales'],resolve),
    meta:{
      title:'申请售后',
      keepAlive: false
    }
  },{
    path:'/logistics',
    name:'logistics',
    // component:logistics,
    // component: r => require.ensure([], () => r(require('../views/person/logistics')), 'logistics'),
    component: resolve => require(['@/views/person/logistics'],resolve),
    meta:{
      title:'物流详情',
      keepAlive: false
    }
  },{
    path:'/setPerson',
    name:'setPerson',
    // component:setPerson,
    // component: r => require.ensure([], () => r(require('../views/person/setPerson')), 'setPerson'),
    component: resolve => require(['@/views/person/setPerson'],resolve),
    meta:{
      title:'设置',
      keepAlive: false
    }
  },{
    path:'/verification',
    name:'verification',
    // component:verification,
    // component: r => require.ensure([], () => r(require('../views/person/verification')), 'setPerson'),
    component: resolve => require(['@/views/person/verification'],resolve),
    meta:{
      title:'新手机验证',
      keepAlive: false
    }
  },{
    path:'/addLogistics',
    name:'addLogistics',
    // component:addLogistics,
    // component: r => require.ensure([], () => r(require('../views/person/addLogistics')), 'addLogistics'),
    component: resolve => require(['@/views/person/addLogistics'],resolve),
    meta:{
      title:'物流信息',
      keepAlive: false
    }
  },{
    path:'/fightShop',
    name:'fightShop',
    // component:fightShop,
    // component: r => require.ensure([], () => r(require('../views/active/fightShop')), 'addLogistics'),
    component: resolve => require(['@/views/active/fightShop'],resolve),
    meta:{
      title:'发起拼团',
      keepAlive: true
    }
  },{
    path:'/invitation',
    name:'invitation',
    // component:Invitation,
    // component: r => require.ensure([], () => r(require('../views/active/invitation')), 'invitation'),
    component: resolve => require(['@/views/active/invitation'],resolve),
    meta:{
      title:'邀请好友',
      keepAlive: false
    }
  },
  // {
  //   path:'/fightGoodDetail',
  //   name:'fightGoodDetail',
  //   // component:fightDetail,
  //   // component: r => require.ensure([], () => r(require('../views/active/fightDetail')), 'fightDetail'),
  //   component: resolve => require(['@/views/active/fightDetail'],resolve),
  //   meta:{
  //     title:'拼团订单详情',
  //     keepAlive: false
  //   }
  // },
  {
    path:'/joinFight',
    name:'joinFight',
    // component:Invitation,
    // component: r => require.ensure([], () => r(require('../views/active/invitation')), 'invitation'),
    component: resolve => require(['@/views/active/invitation'],resolve),
    meta:{
      title:'邀请好友',
      keepAlive: false
    }
  },{
    path:'/addressBox',
    name:'addressBox',
    // component:addressBox,
    // component: r => require.ensure([], () => r(require('../views/active/addressBox')), 'addressBox'),
    component: resolve => require(['@/views/active/addressBox'],resolve),
    meta:{
      title:'',
      keepAlive: false
    }
  },{
    path:'/recharge',
    name:'recharge',
    // component: r => require.ensure([], () => r(require('../views/person/recharge')), 'recharge'),
    component: resolve => require(['@/views/person/recharge'],resolve),
    meta:{
      title:'充值',
      keepAlive: false
    }
  },{
    path:'/rechargeDetail',
    name:'rechargeDetail',
    // component: r => require.ensure([], () => r(require('../views/person/rechargeDetail')), 'rechargeDetail'),
    component: resolve => require(['@/views/person/rechargeDetail'],resolve),
    meta:{
      title:'充值详情',
      keepAlive: false
    }
  },{
    path:'/buySuccess',
    name:'buySuccess',
    // component: r => require.ensure([], () => r(require('../views/active/buySuccess')), 'buySuccess'),
    component: resolve => require(['@/views/active/buySuccess'],resolve),
    meta:{
      title:'购买成功',
      keepAlive: false
    }
  },{
    path:'/formData',
    name:'formData',
    // component: r => require.ensure([], () => r(require('../components/formData')), 'formData'),
    component: resolve => require(['@/components/formData'],resolve),
    meta:{
      keepAlive: false
    }
  },{
    path:'/commodityList',
    name:'commodityList',
    // component: r => require.ensure([], () => r(require('../views/sort/commodityList')), 'commodityList'),
    component: resolve => require(['@/views/sort/commodityList'],resolve),
    meta:{
      title:'商品列表',
      keepAlive: false
    }
  },{
    path:'/IntegralMall',
    name:'IntegralMall',
    // component: r => require.ensure([], () => r(require('../views/sort/commodityList')), 'commodityList'),
    component: resolve => require(['@/views/person/IntegralMall'],resolve),
    meta:{
      title:'积分商城',
      keepAlive: false
    }
  },{
    path:'/IntegralRule',
    name:'IntegralRule',
    // component: r => require.ensure([], () => r(require('../views/sort/commodityList')), 'commodityList'),
    component: resolve => require(['@/views/person/IntegralRule'],resolve),
    meta:{
      title:'积分规则',
      keepAlive: false
    }
  },{
    path:'/IntegralDetail',
    name:'IntegralDetail',
    // component: r => require.ensure([], () => r(require('../views/sort/commodityList')), 'commodityList'),
    component: resolve => require(['@/views/person/IntegralDetail'],resolve),
    meta:{
      title:'商品详情',
      keepAlive: false
    }
  },{
    path:'/IntegralList',
    name:'IntegralList',
    // component: r => require.ensure([], () => r(require('../views/sort/commodityList')), 'commodityList'),
    component: resolve => require(['@/views/person/IntegralList'],resolve),
    meta:{
      title:'我的积分订单列表',
      keepAlive: false
    }
  },{
    path:'/IntegralCar',
    name:'IntegralCar',
    // component: r => require.ensure([], () => r(require('../views/sort/commodityList')), 'commodityList'),
    component: resolve => require(['@/views/person/IntegralCar'],resolve),
    meta:{
      title:'积分商品支付',
      keepAlive: true
    }
  },{
    path:'/productGroup',
    name:'productGroup',
    // component: r => require.ensure([], () => r(require('../views/sort/productGroup')), 'productGroup'),
    component: resolve => require(['@/views/sort/productGroup'],resolve),
    meta:{
      title:'商品分组',
      keepAlive: false
    }
  },{
    path:'*',
    component: error,
    meta:{
      title:'404未找到'
    }
  }]
})

// 设置全局路由守卫
router.beforeEach((to,from,next) => {
  // cookie.set('token', "", -1);
  localStorage.removeItem('token');
  if(to.fullPath.indexOf('share_user_id') != -1){
    var share_user_id;
    if(to.path == '/'){
      share_user_id = to.fullPath.split('=')[1].split('&')[0];
    }else{
      share_user_id= getQueryString('share_user_id');
    }
    // console.log(share_user_id)
    localStorage.setItem('userId',share_user_id);
  }
  if(!cookie.get('token') && to.path != '/formData'){

    localStorage.setItem('fromUrl',to.fullPath);
    next('/formData');
    return false
  }
  next()
});



export default router

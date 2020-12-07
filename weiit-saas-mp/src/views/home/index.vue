<template>
    <div class="home">
        <loading v-show="isLoding"></loading>
        <div v-show="!isLoding">
            <ul class="showList">
                <li :key="index" v-for="(item, index) in pageLayout">
                    <show-table :item="item" :keyWords="item.type" :pageParam="item.pageParam"></show-table>
                </li>
            </ul>
            <text-nav></text-nav>
            <nav-footer :parents="'home'"></nav-footer>
        </div>           
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios' 
    // 引入qs
    import qs from 'qs'
    //引入列表标题组件
    import navTitle from '@/components/title' 
    // 引入单个商品列表
    import goodSimple from '@/components/goodSimple'
    // 引入 Swipe, SwipeItem
    import { Swipe, SwipeItem } from 'mint-ui';
    // 引入搜索框
    import searchBox from '@/components/searchBox'
    // 引入展示模板
    import showTable from '@/views/show/showTable'
    import NavFooter from '@/components/footer'
    import textNav from '@/components/textNav'
    import loading from '@/components/loading'
    export default {
        data(){
           return {
               msg:'this is home',
               obj:{
                    create_time:1520843948000,
                    express_config:-1,
                    express_money:null,
                    express_template_id:0,
                    integral:null,
                    product_id:60,
                    product_img:"/aigou/shop/20170317/b45de7df-3115-4844-af0f-c91b83632e36.jpg",
                    product_name:"iphone6手机壳 苹果6plus硅胶套 6s卡通透明保护套4.",
                    product_num:"152084396382047513",
                    purchase:0,sale_count:0,
                    sale_price:13,
                    shop_id:16,
                    smarket_price:0,
                    stock:750,
                    update_time:1520843948000
               },
               styleList:{},
               pageLayout:[],
               page_id:this.$route.params.page_id ? this.$route.params.page_id : null,
               isLoding:true,
               page_desc:''
           }
        },
        components:{
            searchBox,
            goodSimple,
            navTitle,
            showTable,
            NavFooter,
            textNav,
            loading
        },
        methods:{
            // 跳转到搜索页面
            searchGoods(){
                this.$router.push({
                    path:'/seach',
                    name:'search'
                })
            },
            // 跳转到商品详情页面
            toGoods(){
                this.$router.push({
                    path:'/detail',
                    name:'detail',
                    params:{
                        detailsRootly:'home'
                    }
                })
            },
            // 获取全部数据
            getData(){
                axios.post('/api/page/pageInfo',qs.stringify({
                    page_id:this.page_id
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.styleList = res.data.data;
                        this.pageLayout = JSON.parse(this.styleList.page_layout);
                        this.page_desc = this.styleList.page_desc;
                        this.isLoding = false;
                        console.log(this.pageLayout);
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 分享给好友
            share(){
                let host = document.location.hostname;
                let protocol = document.location.protocol;  
                let user_id = localStorage.getItem('user_id');
                let currentUrl = `${protocol}//${host}`; 
                let title = localStorage.getItem('shop_name');
                let imgUrl = this.$url + localStorage.getItem('shop_logo');
                let url = currentUrl + '?share_user_id=' + user_id;
                let desc = this.page_desc
                wx.ready(function(res) {
                    wx.onMenuShareAppMessage({
                        title: title,
                        desc: desc,
                        link: url,
                        imgUrl: imgUrl
                    });
                    wx.onMenuShareTimeline({
                        title: title,
                        desc: desc,
                        link: url,
                        imgUrl: imgUrl
                    });
                });
            }
        },
        
        created(){
            this.getData();
            this.share();
            document.title = localStorage.getItem('shop_name') || '';
            
        },

        watch: {
            '$route' (to, from) {
                this.$router.go(0);
            }
        },
        beforeRouteEnter:(to,from,next)=>{
            // var u = navigator.userAgent;
            // //ios终端
            // var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
            // // XXX: 修复iOS版微信HTML5 History兼容性问题
            // if (isiOS && to.path !== location.pathname) {
            //     // 此处不可使用location.replace
            //     location.assign(to.fullPath)
            // } else {
            //     next()
            // }      
             axios.post('/weixin/JSSDKWxConfig',qs.stringify({
                    currentUrl:location.href.split('#')[0],
                    appid:localStorage.getItem('appid')
                })).then((res) => {
                    wx.config({
                        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                        appId: res.data.data.appId, // 必填，公众号的唯一标识
                        timestamp: res.data.data.timeStamp, // 必填，生成签名的时间戳
                        nonceStr: res.data.data.nonceStr, // 必填，生成签名的随机串
                        signature: res.data.data.signature,// 必填，签名
                        jsApiList: [
                                    "onMenuShareTimeline",//分享朋友圈接口
                                    "onMenuShareAppMessage",//分享给朋友接口  
                                    "chooseWXPay"
                        ] // 必填，需要使用的JS接口列表
                    });
                }).catch((err) => {
                    console.log(err);
                })
            next();
        }
    }
</script>

<style scoped lang="scss">
    .home{
        position: relative;
        padding-bottom: 1rem;
    }
    .showList{
    	min-height: 9.3rem;
    }
</style>
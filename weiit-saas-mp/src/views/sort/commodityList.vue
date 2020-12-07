<template>
    <div class="main">
        <!-- 选择搜索方式 -->
        <mt-navbar v-model="selected" class="filter_nav">
            <mt-tab-item id="default">默认</mt-tab-item>
            <mt-tab-item id="price">
                <div @click="getPriceGoods()" class="goodsNav">
                    <span>价格</span>
                    <i class="icon iconfont icon-xiangxiajiantou"></i>
                </div>
            </mt-tab-item>
            <mt-tab-item id="volume">
                <div @click="getVolumeGoods()" class="goodsNav">销量</div>
            </mt-tab-item>
        </mt-navbar>

            <!-- tab-container -->
            
        <mt-tab-container v-model="selected" class="goods">
            <!-- 全部搜索商品 -->
            <mt-tab-container-item id="default">
                <div class="goodList">
                    <mt-loadmore :bottom-method="loadBottom1" :bottomDropText="bottomText" :bottom-all-loaded="allLoaded1" :auto-fill="false" ref="loadmore1">
                        <ul class="clearfix">
                            <li v-for="(item, index) in goodsList" @click="detail(item.product_id)">
                                <good-simple :item="item"></good-simple>
                            </li>
                        </ul>
                    </mt-loadmore>
                    <loading v-show="isLoading1"></loading>
                </div>
                
            </mt-tab-container-item>
            <!-- 商品根据价格排序 -->
            <mt-tab-container-item id="price">
                    <div class="goodList">
                    <mt-loadmore :bottom-method="loadBottom2" :bottomDropText="bottomText" :bottom-all-loaded="allLoaded2" :auto-fill="false" ref="loadmore2">
                        <ul class="clearfix">
                            <li v-for="(item, index) in priceGoods" @click="detail(item.product_id)">
                                <good-simple :item="item"></good-simple>
                            </li>
                        </ul>
                    </mt-loadmore>
                    <loading v-show="isLoading2"></loading>
                </div>
                
            </mt-tab-container-item>
            <!-- 商品根据销量排序 -->
            <mt-tab-container-item id="volume">
                <div class="goodList">
                    <mt-loadmore :bottom-method="loadBottom3" :bottomDropText="bottomText" :bottom-all-loaded="allLoaded3" :auto-fill="false" ref="loadmore3">
                        <ul class="clearfix">
                            <li v-for="(item, index) in volumeGoods" @click="detail(item.product_id)">
                                <good-simple :item="item"></good-simple>
                            </li>
                        </ul>
                    </mt-loadmore>
                    <loading v-show="isLoading3"></loading>
                </div>
                    
            </mt-tab-container-item>
        </mt-tab-container>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 从mint-ui中引入Navbar, TabItem
    import { Navbar, TabItem, InfiniteScroll,Loadmore } from 'mint-ui';
    // 引入单个商品列表
    import goodSimple from '@/components/goodSimple'
    // 引入加载组件
    import loading from '@/components/loading'
    export default {
        data(){
            return {
                selected:'default',
                priceGoods:[],
                volumeGoods:[],
                goodsList:[],
                pageNo1:1,
                pageNo2:1,
                pageNo3:1,
                isLoading1:false,
                isLoading2:false,
                isLoading3:false,
                bottomText:'加载中~',
                allLoaded1:false,
                allLoaded2:false,
                allLoaded3:false,
                isPass:true
            }
        },
        components:{
            goodSimple,
            loading
        },
        methods:{
            // 获取价格排序商品
            getAllGoods(){
                // 搜索商品
                this.isLoading1 = true;
                    axios.post('/api/product/search',qs.stringify({
                        key:'',
                        type:'3',
                        page:this.pageNo1
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.goodsList = res.data.data.list;
                            this.isLoading1 = false
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                
            },
            // 获取价格排序商品
            getPriceGoods(){
                // 搜索商品
                this.isLoading2 = true;
                axios.post('/api/product/search',qs.stringify({
                    key:'',
                    type:'3',
                    page:this.pageNo2
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.priceGoods = res.data.data.list;
                        this.isLoading2 = false
                    }
                }).catch((err) => {
                    console.log(err);
                })
                
            },
            // 获取商品销量排序商品  
            getVolumeGoods(){
                // 搜索商品
                this.isLoading3 = true;
                axios.post('/api/product/search',qs.stringify({
                    key:'',
                    type:'2',
                    page:this.pageNo3
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.volumeGoods = res.data.data.list;
                        this.isLoading3 = false
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 跳转
            detail(id){
                this.$router.push({
                    path:'/detail',
                    name:'detail',
                    query:{
                        product_id:id
                    }
                })
            },
            // 上拉加载
            loadBottom1() {
                this.more1();// 上拉触发的分页查询
                this.$refs.loadmore1.onBottomLoaded();// 固定方法，查询完要调用一次，用于重新定位
                this.isPass = false;
            },
            loadBottom2() {
                this.more2();// 上拉触发的分页查询
                this.$refs.loadmore2.onBottomLoaded();// 固定方法，查询完要调用一次，用于重新定位
                this.isPass = false;
            },
            loadBottom3() {
                this.more3();// 上拉触发的分页查询
                this.$refs.loadmore3.onBottomLoaded();// 固定方法，查询完要调用一次，用于重新定位
                this.isPass = false;
            },
            // 添加数据
            more1(){
                this.pageNo1 = parseInt(this.pageNo1) + 1;
                axios.post('/api/product/search',qs.stringify({
                    key:'',
                    page:this.pageNo1
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.goodsList = this.goodsList.concat(res.data.data.list);
                        this.isPass = true;
                        if(!res.data.data.hasNextPage){
                            this.allLoaded1 = true;
                        }
                    }
                })
                .catch((err) => {
                    console.log(err)
                })
            },
            more2(){
                this.pageNo2 = parseInt(this.pageNo2) + 1;
                axios.post('/api/product/search',qs.stringify({
                    key:'',
                    type:'3',
                    page:this.pageNo2
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.priceGoods = this.priceGoods.concat(res.data.data.list);
                        this.isPass = true;
                        if(!res.data.data.hasNextPage){
                            this.allLoaded2 = true;
                        }
                    }
                })
                .catch((err) => {
                    console.log(err)
                })
            },
            more3(){
                this.pageNo3 = parseInt(this.pageNo3) + 1;
                axios.post('/api/product/search',qs.stringify({
                    key:'',
                    type:'2',
                    page:this.pageNo3
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.priceGoods = this.priceGoods.concat(res.data.data.list);
                        this.isPass = true;
                        if(!res.data.data.hasNextPage){
                            this.allLoaded3 = true;
                        }
                    }
                })
                .catch((err) => {
                    console.log(err)
                })
            }
        },
        mounted(){
            this.getAllGoods();
        }
    }
</script>

<style scoped lang="scss">
    .main{
        height: calc(100% - 0.6rem);
        .filter_nav{
            margin-bottom: 0.2rem;
            .goodsNav{
                position: relative;
                z-index: 50;
            }
        }
        .goods{
            height: calc(100% - 0.68rem);
            overflow-y: scroll;
        }
        .goodList{
            ul{
                li{
                    position: relative;
                    float: left;
                    width: 3.4rem;
                    height: 4.26rem;
                    background-color: #fff;
                    margin-right: 0.1rem;
                    margin-bottom: 0.1rem;
                    padding:0.1rem 0.15rem;
                    padding-bottom: 0;
                    &:nth-of-type(even){
                        margin-right: 0;
                    }
                    
                }
            }
        }
    }
</style>
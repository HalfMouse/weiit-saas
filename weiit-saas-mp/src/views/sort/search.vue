<template>
    <div class="search">
        <div class="search_top">
            <input type="text" placeholder="搜索品牌，商家或商品" v-model="searchTxt" ref="searchTxt">
            <a href="javascript:;" class="search_btn" @click="search()">搜索</a>
            <i class="icon iconfont icon-sousuo"></i>
        </div>
        <div class="main">
            <!-- 选择搜索方式 -->
            <mt-navbar v-model="selected" class="filter_nav">
                <mt-tab-item id="default">
                    <div @click="getAll()" class="goodsNav">
                        默认
                    </div>
                </mt-tab-item>
                <mt-tab-item id="price">
                    <div @click="getPriceGoods()" class="goodsNav">
                        <span>价格</span>
                        <i class="icon iconfont" :class="isSort ? 'icon-xiangshangjiantou' : 'icon-xiangxiajiantou'"></i>
                    </div>
                </mt-tab-item>
                <mt-tab-item id="volume">
                    <div @click="getVolumeGoods()" class="goodsNav">
                        <span>销量</span>
                        <i class="icon iconfont" :class="isSale ? 'icon-xiangshangjiantou' : 'icon-xiangxiajiantou'"></i>
                    </div>
                </mt-tab-item>
            </mt-navbar>
                
            <mt-tab-container v-model="selected" class="goods">
                <!-- 全部搜索商品 -->
                <mt-tab-container-item id="default">
                    <div class="goodList">
                        <div style="height:100%;">
                            <ul
                                v-infinite-scroll="loadMore1"
                                infinite-scroll-disabled="isLoading1"
                                infinite-scroll-distance="10" class="clearfix">
                                <li :key="index" v-for="(item, index) in goodsList" @click="detail(item,item.product_id)">
                                    <good-simple :item="item"></good-simple>
                                </li>
                            </ul>
                            <loading v-show="loading1"></loading>
                            <noMore v-if="allLoaded1"></noMore>
                        </div>
                    </div>
                </mt-tab-container-item>
                <!-- 商品根据价格排序 -->
                <mt-tab-container-item id="price">
                    <div class="goodList">
                        <div style="height:100%;">
                            <ul
                                v-infinite-scroll="loadMore2"
                                infinite-scroll-disabled="isLoading2"
                                infinite-scroll-distance="10" class="clearfix">
                                <li :key="index" v-for="(item, index) in priceGoods" @click="detail(item,item.product_id)">
                                    <good-simple :item="item"></good-simple>
                                </li>
                            </ul>
                            <loading v-show="loading2"></loading>
                            <noMore v-if="allLoaded2"></noMore>
                        </div>
                    </div>
                </mt-tab-container-item>
                <!-- 商品根据销量排序 -->
                <mt-tab-container-item id="volume">
                    <div class="goodList">
                        <div style="height:100%;">
                            <ul
                                v-infinite-scroll="loadMore3"
                                infinite-scroll-disabled="isLoading3"
                                infinite-scroll-distance="10" class="clearfix">
                                <li :key="index" v-for="(item, index) in volumeGoods" @click="detail(item,item.product_id)">
                                    <good-simple :item="item"></good-simple>
                                </li>
                            </ul>
                            <loading v-show="loading3"></loading>
                            <noMore v-if="allLoaded3"></noMore>
                        </div>
                    </div>
                </mt-tab-container-item>
            </mt-tab-container>
        </div>
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
    import noMore from '@/components/noMore'
    export default {
        data(){
            return {
                selected:'default',    
                priceGoods:[],         //价格排序商品
                volumeGoods:[],        //销量排序商品
                searchTxt:'',          //搜索关键词
                goodsList:[],          //所有商品
                pageNo1:1,
                pageNo2:1,
                pageNo3:1,
                isLoading1:true,
                isLoading2:true,
                isLoading3:true,
                loading1:true,
                loading2:true,
                loading3:true,
                bottomText:'加载中~',
                allLoaded1:false,
                allLoaded2:false,
                allLoaded3:false,
                isSort:true,           
                isPass:true,
                isSale:true,
                isPrice:false,
                isVolume:false
            }
        },
        components:{
            goodSimple,
            loading,
            noMore
        },
        methods:{
            // 查询商品
            search(){
                let sort = 'desc';
                this.pageNo1 = 1;
                this.pageNo2 = 1;
                this.pageNo3 = 1;
                this.isLoading1 = true;
                this.isLoading2 = true;
                this.isLoading3 = true;
                this.loading1 = true;
                this.loading2 = true;
                this.loading3 = true;
                this.allLoaded1 = false;
                this.allLoaded2 = false;
                this.allLoaded3 = false;
                this.priceGoods = []         //价格排序商品
                this.volumeGoods = []        //销量排序商品
                this.goodsList = []  
                if(this.selected == 'default'){
                    this.getAllGoods();
                }else if(this.selected == 'price'){
                    this.addPriceGood(sort);
                }else if(this.selected == 'volume'){
                    this.addVolumeGoods(sort);
                }
                // this.getAllGoods();
                // this.addPriceGood(sort);
                // this.addVolumeGoods(sort);
            },
            getAllGoods(){
                let searchTxt = this.searchTxt ? this.searchTxt : '';
                this.isPass = false;
                this.allLoaded1 = false;
                axios.post('/api/product/search',qs.stringify({
                    key:searchTxt,
                    page:this.pageNo1
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach((item) => {
                            this.goodsList.push(item)
                        })
                        
                        this.loading1 = false
                        if(!res.data.data.hasNextPage){
                            this.isLoading1 = true;
                            this.allLoaded1 = true;

                        }else{
                            this.isLoading1 = false;
                            this.allLoaded1 = false;
                        }
                        this.isPass = true;
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 排序商品
            getPriceGoods(){
                let sort;
                this.isVolume = false;
                
                if(this.priceGoods.length == 0){
                    this.addPriceGood(sort);
                }
                if(this.isPrice){
                    if(this.isSort){
                        // 降序 
                        sort = 'desc';
                        this.isSort = !this.isSort;
                        this.pageNo2 = 1;
                        this.loading2 = true;
                    }else{
                        // 升序 
                        sort = 'asc';
                        this.isSort = !this.isSort;
                        this.pageNo2 = 1;
                        this.loading2 = true;
                    } 
                    this.priceGoods = [];
                    this.addPriceGood(sort);
                }else{
                    this.isPrice = true;
                }
               
            },
            // 获取价格排序商品
            addPriceGood(sort){
                // 关键词
                let searchTxt = this.searchTxt ? this.searchTxt : '';
                this.isPass = false;
                this.allLoaded2 = false;
                axios.post('/api/product/search',qs.stringify({
                    key:searchTxt,
                    type:'3',
                    page:this.pageNo2,
                    sort:sort
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach((item) => {
                            this.priceGoods.push(item)
                        })
                        this.loading2 = false
                        if(!res.data.data.hasNextPage){
                            this.isLoading2 = true;
                            this.allLoaded2 = true;
                        }else{
                            this.isLoading2 = false;
                            this.allLoaded2 = false;
                        }
                        this.isPass = true;
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 获取商品销量排序商品  
            getVolumeGoods(){
                // 搜索商品
                let sort;
                this.isPrice = false;
                this.allLoaded3 = false;
                if(this.volumeGoods.length == 0){
                    this.addVolumeGoods(sort)
                }
                if(this.isVolume){
                    if(this.isSale){
                        // 降序 
                        sort = 'desc';
                        this.isSale = !this.isSale;
                        this.pageNo3 = 1;
                        this.loading3 = true;
                    }else{
                        // 升序 
                        sort = 'asc';
                        this.isSale = !this.isSale;
                        this.pageNo3 = 1;
                        this.loading3 = true;
                    } 
                    this.volumeGoods = [];
                    this.addVolumeGoods(sort);
                }else{
                    this.isVolume = true;
                }
                
            },
            addVolumeGoods(sort){
                let searchTxt = this.searchTxt ? this.searchTxt : '';
                this.isPass = false;
                axios.post('/api/product/search',qs.stringify({
                    key:searchTxt,
                    type:'2',
                    page:this.pageNo3,
                    sort:sort
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach((item) => {
                            this.volumeGoods.push(item)
                        })
                        this.loading3 = false
                        if(!res.data.data.hasNextPage){
                            this.isLoading3 = true;
                            this.allLoaded3 = true;
                        }else{
                            this.isLoading3 = false;
                            this.allLoaded3 = false;
                        }
                        this.isPass = true;
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 跳转
            detail(item,id){
                if(this.isPass){
                    localStorage.setItem('shareGoodImage', item.product_img);
                    localStorage.setItem('shareGoodName', item.product_name);
                    this.$router.push({
                        path:'/detail',
                        name:'detail',
                        query:{
                            product_id:id
                        }
                    })
                }
                
            },
            loadMore1() {
                this.pageNo1++;
                this.isLoading1 = true;
                this.getAllGoods();
            },
            loadMore2() {
                this.pageNo2++;
                this.isLoading2 = true;
                this.addPriceGood();
            },
            loadMore3() {
                this.pageNo3++;
                this.isLoading3 = true;
                this.addVolumeGoods();
            },
            getAll(){
                if(this.goodsList.length == 0){
                    this.getAllGoods();
                }
                this.isPrice = false;
                this.isVolume = false;
            }
        },
        mounted(){
            this.getAllGoods();
        }
    }
</script>

<style scoped lang="scss">
    .search{
        padding-top: 1rem;
        height: calc(100% - 1rem);
        .search_top{
            position: fixed;
            background-color: #f5f5f5;
            left: 50%;
            top: 0.2rem;
            z-index: 999;
            width: 96%;
            height: 0.8rem;
            transform: translateX(-50%);
            input{
                width: 75%;
                float: left;
                height: 0.6rem;
                line-height: 0.6rem;
                font-size: 0.28rem;
                padding-left: 0.6rem;
                border-radius: 0.1rem;
                &.new_search{
                    width: 6.4rem;
                }
            }
            .search_btn{
                float: right;
                font-size: 0.3rem;
                font-family:'MicrosoftYaHei';
                color: #666;
                border:none 0;
                line-height: 0.6rem;
                margin-right: 0.2rem;
                background: #f5f5f5;
                text-align: center;
            }
            .icon{
                position: absolute;
                top: 0.15rem;
                font-size: 0.3rem;
                color: #333;
                left: 0.13rem;
            }
        }
        .main{
            height: calc(100% - 0.6rem);
            .filter_nav{
                .goodsNav{
                    position: relative;
                    z-index: 50;
                }
            }
            .goods{
                height: calc(100% - 0.4rem);
                overflow-y: scroll;
            }
            .goodList{
                height: calc(100% - 0.15rem);
                padding-top: 0.15rem;
                ul{
                    li{
                        position: relative;
                        float: left;
                        width: 3.4rem;
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
    }
</style>
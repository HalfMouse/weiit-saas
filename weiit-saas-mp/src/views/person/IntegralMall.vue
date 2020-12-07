<template>
    <div class="integral_mall">
        <header class="fn-clear">
            <span class="head-title">积分兑换专区</span>
            <span class="scores" @click="toIntegral()">我的积分:{{integralScore}}</span>
        </header>
        <div class="integral-goods-list">
            <ul class="fn-clear" v-infinite-scroll="loadMore"
                infinite-scroll-disabled="loading"
                infinite-scroll-distance="10">
                <li v-for="(item, index) in intergralGoods" :key="index" @click="go_detail(item)">
                    <a href="javascript:;">
                        <div class="good-img">
                            <img :src="$url + item.product_img" alt="">
                        </div>
                        <p class="good-name">{{item.product_name}}</p>
                        <div class="good-mations fn-clear">
                            <span class="goods-price">￥{{item.integral_price}}</span>
                            <i class="goods-integral">{{item.integral}}积分</i>
                        </div>
                    </a>
                </li>
            </ul>
            <no-more v-if="allLoaded && intergralGoods.length > 0"></no-more>
        </div>
        <loading v-show="isLoading"></loading>

    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 引入加载组件
    import loading from '@/components/loading'
    import noMore from '@/components/noMore';
    export default {
        data() {
            return {
                intergralGoods: [],
                integralScore: localStorage.getItem('integral'),
                pageNo:1,
                isLoading:true,
                loading:true,
                isPass:true,
                allLoaded:false
            }
        },
        mounted() {
            this.getMallGoods();
        },
        methods: {
            getMallGoods() {
                console.log(1);
                axios.post('/api/integral/selectIntegralProductList',qs.stringify({
                    page:this.pageNo,
                    rows:6
                })).then((res) => {
                    console.log(res);
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        
                        list.forEach(item => {
                            this.intergralGoods.push(item);
                        })
                        this.hasNextPage = res.data.data.hasNextPage;
                        
                        if(!this.hasNextPage){
                            this.loading = true;
                            this.allLoaded = true
                        }else{
                            this.loading = false;
                        }
                        this.isLoading = false;
                        this.isPass = true;
                    }
                })
                .catch((err) => {
                    console.log(err);
                })
            },
            go_detail(item){
                this.$router.push({
                    path:'/IntegralDetail',
                    name:'IntegralDetail',
                    query:{
                        validate_id: item.validate_id,
                        validate_id_token: item.validate_id_token
                    }
                })
            },
            loadMore(){
                this.pageNo++;
                this.isPass = false;
                this.getMallGoods();
            },
            toIntegral() {
                this.$router.push({
                    path: '/integral',
                    name: 'integral'
                })
            }
        },
        components:{
            loading,
            noMore
        }
    }
</script>

<style scoped lang="scss">
    .integral_mall{
        header{
            background-color: #fff;
             padding: 0.2rem;
            span{
                font-size: 0.3rem;
                &.head-title{
                    float: left;
                }
                &.scores{
                    float: right;
                }
            }
        }
        .integral-goods-list{
            ul{
                li{
                    position: relative;
                    float: left;
                    width: 48vw;
                    margin: 1vw;
                    overflow: hidden;
                    background-color: #fff;
                    a{
                        display: block;
                        .good-img{
                            width: 100%;
                            height: 48vw;
                            img{
                                display: block;
                                width: 100%;
                                height: 100%;
                            }
                        }
                        .good-name{
                            padding: 0.1rem;
                            font-size: 0.3rem;
                            word-break: break-all;
                            overflow : hidden;
                            text-overflow: ellipsis;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            /*! autoprefixer: off */
                            -webkit-box-orient: vertical;
                            /* autoprefixer: on */
                            line-height: 0.48rem;
                            height: 0.8rem;
                        }
                        .good-mations{
                            padding: 0.1rem;
                            .goods-price{
                                float:left;
                                font-size:0.3rem;
                                color:#bbb;
                            }
                            .goods-integral{
                                float:right;
                                color:#ff4c6b;
                                font-size:0.3rem;  
                                font-style: normal;
                            }
                        }
                    }
                }
            }
        }
    }
</style>
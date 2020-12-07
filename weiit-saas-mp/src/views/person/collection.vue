<template>
    <div class="my_collections">
        <div v-show="!isLoading" class="collection_list">
            <ul
                v-infinite-scroll="loadMore"
                infinite-scroll-disabled="loading"
                infinite-scroll-distance="10" class="clearfix">
                <li :key="index" v-for="(item,index) in collections" @click="lookItem(item.product_id)">
                    <div class="fn-clear">
                        <div class="collection_img">
                            <img :src="$url + item.product_img" alt="">
                        </div>
                        <div class="colletion_txt">
                            <h4 class="collection_goods_name">{{item.product_name}}</h4>
                            <div class="collection_goods_money clearfix">
                                <span class="new_money">￥{{item.sale_price}}</span>
                                <!-- <div class="discount">
                                    <span class="discount_num">0.0折</span>
                                    <span class="discount_money">￥{{item.smarket_price}}</span>
                                </div> -->
                            </div>
                        </div>
                    </div>
                    <i class="icon iconfont icon-shanchu-copy" @click="confirmDeletion(index,item,$event)"></i>
                </li>
            </ul>
            <no-more v-if="allLoaded && collections.length > 0"></no-more>
        </div>
        <loading v-show="isLoading"></loading>
        <empty :fatherComponent="fatherComponent" v-if="collections.length == 0 && !isLoading"></empty>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    // 引入没有更多组件
    import noMore from '@/components/noMore';
    // 从mint-ui中引入MessageBox
    import { MessageBox,Loadmore } from 'mint-ui';
    // 引入当内容为空时出现的组件
    import empty from '@/components/empty';
    // 引入loading
    import loading from '@/components/loading';
    export default {
        data(){
            return {
                collections:[],
                fatherComponent:'collection',
                topStatus: '',
                isLoading:true,
                loading:true,
                allLoaded: false, //是否可以上拉属性，false可以上拉，true为禁止上拉，就是不让往上划加载数据了
                pageNo:1,
                hasNextPage:true
            }
        },
        methods:{
            // 删除目前对应的收藏
            delColletions(index,item){   
                axios.post('/api/user/myCollectionDelete',qs.stringify({
                        product_id:item.product_id
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.collections.splice(index,1);
                        }
                    })
            },
            // 确认是否删除弹出框
            confirmDeletion(index,item,e){
                // let htmls = `<div style="color:#333;font-weight:bold;margin-top:2rem;margin-bottom:0.8rem;">确认删除此商品?</div>`;
                MessageBox.confirm('',{
                    width:500,
                    height:600,
                    message:'确认删除此商品?',
                    cancelButtonClass:'cancelButton',
                    confirmButtonClass:'confirmButton',
                    confirmButtonText:'确认',
                    cancelButtonText:'取消'
                }).then((action) => {
                    if (action == 'confirm') {
                        this.delColletions(index,item);
                    }
                }).catch((err) => {
                    if (err == 'cancel') {

                    }
                });
                e.stopPropagation();
            },
            // 获取收藏栏数据
            getCollections(){
                this.isPass = false;
                axios.post('/api/user/myCollectionList',qs.stringify({
                    page:this.pageNo
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach(item => {
                            this.collections.push(item);
                        })
                        this.hasNextPage = res.data.data.hasNextPage;
                        if(!this.hasNextPage){
                            this.loading = true;
                            this.allLoaded = true
                        }else{
                            this.loading = false;
                        }
                        this.isLoading = false;
                        this.isPass = true
                    }
                })
                .catch((err) => {
                    console.log(err)
                })
            },
            // 查看商品详情
            lookItem(product_id){
                if(this.isPass){
                    this.$router.push({
                        path:'/detail',
                        name:'detail',
                        query:{
                            product_id:product_id
                        }
                    })
                }
            },
            loadMore(){
                this.pageNo++;
                this.isPass = false;
                this.getCollections();
            }
        },
        components:{
           empty,
           noMore,
           loading
        },
        mounted(){
            this.getCollections();
        }
    }
</script>

<style scoped lang="scss">
    .my_collections{
        width: 100%;
        height: 100%;
        .collection_list{
            min-height: 9.5rem;
            .top_tip{
                position: absolute;
                top: -0.8rem;
                left: 0;
                z-index: 1;
                width: 100%;
                height: 0.4rem;
                line-height: 0.4rem;
                color: #555;
                text-align: center;
                font-size: 0.3rem;
            }
        }
        ul{
            li{
                margin-bottom: 0.2rem;
                background-color:#fff;
                overflow: hidden;
                position: relative;
                .collection_img{
                    float: left;
                    width: 2rem;
                    height: 2rem;
                    margin-left: 0.4rem;
                    margin-top: 0.3rem;
                    margin-bottom: 0.4rem;
                    img{
                        width: 100%;
                        height: 100%;
                    }
                }
                .colletion_txt{
                    float: left;
                    width: 4.7rem;
                    margin-top: 0.26rem;
                    margin-left: 0.2rem;
                    .collection_goods_name{
                        color:#333;
                        font-size: 0.28rem;
                        font-weight: Medium;
                        line-height: 0.4rem;
                        margin-right: 0.1rem;
                        display: -webkit-box;
                        /*! autoprefixer: off */
                        -webkit-box-orient: vertical;
                        /* autoprefixer: on */
                        -webkit-line-clamp: 2;
                        overflow: hidden;
                        margin-top: 0.05rem;
                    }
                    .collection_goods_money{
                        position: absolute;
                        left:2.6rem;
                        bottom: 0.4rem;
                        .new_money{
                            float: left;
                            font-size: 0.32rem;
                            color: #EC534E;
                            line-height: 0.28rem;
                            margin-right: 0.2rem;
                        }
                        .discount{
                            float: left;
                            height: 0.4rem;
                            margin-top: -0.05rem;
                            .discount_num{
                                float: left;
                                padding:0 0.1rem;
                                background: #FFDC4B;
                                color: #fff;
                                font-size:0.28rem;
                                line-height: 0.4rem;
                                border-radius: 0.2rem 0 0 0.2rem;
                            }
                            .discount_money{
                                float: left;
                                padding:0 0.1rem;
                                box-sizing: border-box;
                                font-size: 0.3rem;
                                line-height: 0.36rem;
                                border:1px solid #FFDC4B;
                                border-radius: 0 0.2rem 0.2rem 0;
                                color: #999;
                                text-decoration: line-through;
                            }
                        }
                    } 
                }
                .icon{
                    position: absolute;
                    font-size: 0.4rem;
                    right: 0.2rem;
                    bottom: 0.4rem;
                    color: #898989;
                    z-index: 5;
                }
            }
        }
        .alert{
            position: fixed;
            top: 0.55rem;
            left: 0;
            z-index: 2;
            width: 100%;
            height: 0.35rem;
            line-height: 0.35rem;
            font-size: 0.3rem;
            color: #555;
            text-align: center;
        }
    }
</style>
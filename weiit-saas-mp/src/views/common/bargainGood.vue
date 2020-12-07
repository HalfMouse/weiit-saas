<template>
    <div class="goods">
        <div class="bargain_good fn-clear" v-if="goods.goodStyle == 'detail'">
            <div class="goods_list">
                <ul>
                    <li v-for="(item,index) in bargainGoods" class="fn-clear" @click="launchPrice(item)">
                        <div class="goods_pic">
                            <img :src="$url + item.product_img" alt="">
                        </div>
                        <div class="goods_mations">
                            <!-- <div class="time fn-clear" v-if="goods.countDown">
                                <span>2</span>
                                <span>2</span>
                                <span>天</span>
                                <span class="symbol">:</span>
                                <span>2</span>
                                <span>3</span>
                                <span class="symbol">:</span>
                                <span>5</span>
                                <span>9</span>
                            </div> -->
                            <p class="des">{{item.bargain_name}}</p>
                            <div class="goods_content fn-clear">
                                <span class="good_price">￥{{item.max_price}}</span>
                                <span class="good_stock" v-if="goods.stock">剩余{{item.stock}}件</span>
                            </div>
                        </div>
                        <a href="javascript:;" class="help" v-if="goods.bargainBtn && goods.btnStyle == 'style1'">发起砍价</a>
                        <a href="javascript:;" class="help help1" v-if="goods.bargainBtn && goods.btnStyle == 'style2'">发起砍价</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="bargain_good1 fn-clear" v-if="goods.goodStyle == 'big'">
            <!-- <div class="remaining_time">
                <p class="time_title">距离本场砍价结束还剩</p>
                <p class="times"><i class="icon iconfont icon-shijian"></i>2天10时10分10秒</p>
            </div> -->
            <div class="goods_list1">
                <ul class="fn-clear">
                    <li v-for="(item,index) in bargainGoods" class="fn-clear" @click="launchPrice(item)">
                        <div class="goodsPic">
                            <img :src="$url + item.product_img" alt="">
                        </div>
                        <p>{{item.product_name}}</p>
                        <div class="goods_content fn-clear">
                            <span class="good_price">￥{{item.max_price}}</span>
                            <span class="good_stock" v-if="item.stock > 999">剩余999件</span>
                            <span class="good_stock" v-if="item.stock <= 999 && goods.stock">剩余{{item.stock}}件</span>
                        </div>
                        <a href="javascript:;" class="help" v-if="goods.bargainBtn && goods.btnStyle == 'style1'">砍价</a>
                        <a href="javascript:;" class="help help1" v-if="goods.bargainBtn && goods.btnStyle == 'style2'">砍价</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 引入 Swipe, SwipeItem, Popup, Toast
    import { Toast } from 'mint-ui';
    export default {
        data(){
            return{
            }
        },
        props:['goods','bargainGoods'],
        methods: {
            launchPrice(item) {
                if(item.stock > 0){
                    axios.post('/api/bargain/isBargain',qs.stringify({
                        bargain_id:item.bargain_id
                    })).then((res) => {
                        if(res.data.code == 0){
                            localStorage.setItem('shareBargainGoodImage', item.product_img);
                            localStorage.setItem('shareBargainGoodName', item.product_name);
                            if(res.data.data.isBargain){
                                this.$router.push({
                                    path:'/freeGet',
                                    name:'freeGet',
                                    params:{
                                        order_id:res.data.data.b_order_id,
                                        bargain_id:item.bargain_id
                                    }
                                })
                            }else{
                                this.$router.push({
                                    path:'/addressBox',
                                    name:'addressBox',
                                    params:{
                                    	bargain_id:item.bargain_id
                                    }
                                })
                            }
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }else{
                    Toast('库存不足，请选择其他商品~')
                }
                
                
            }   
        }
    }
</script>

<style scoped>
    .bargain_good{
        background-color: #fff;
        padding: 0 0.12rem;
        font-size: 0.3rem;
    }
    .goods_pic,
    .goods_mations{
        float: left;
    }
    .help{
        float: right;
    }
    /* 商品图片 */
    .goods_pic{
        width: 1.4rem;
        height: 1.4rem;
    }
    .goods_pic img{
        width: 100%;
        height: 100%;
    }
    /* 商品主要信息 */
    .goods_mations{
        width: 4.2rem;
        margin-left:0.4rem;
    }
    .goods_mations .time{
        display: table;
        margin: 0 auto;
    }
    .goods_mations .time span{
        float: left;
        width: 0.36rem;
        height: 0.4rem;
        line-height: 0.4rem;
        text-align: center;
        background-color: #000;
        color: #fff;
        margin-right: 0.06rem;
        border-radius: 0.06rem;
    }
    .goods_mations .time span.symbol{
        background-color: #fff;
        color: #000;
        width: 0.16rem;
    }
    .goods_mations p.des{
        text-overflow:ellipsis;
        white-space:nowrap;
        overflow:hidden;
        margin:0.32rem 0 0.05rem;
    }
    .goods_content span{
        float: left;
        margin-right: 0.15rem;
        font-size: 0.28rem;
    }
    .goods_content .good_price{
        color: #ec534e;
    }
    .goods_content .good_stock{
        color: #999; 
    }
    /* 帮忙砍价 */
    .goods_list1 ul li,
    .goods_list ul li{
        margin-top: 0.3rem;
    }
    .goods_list ul li:first-child{
        margin-top: 0;
    }
    .goods_list ul li .help{
        width: 1rem;
        height: 1rem;
        text-align: center;
        padding: 0.08rem;
        background-color: #ff5151;
        border-radius: 0.08rem;
        color: #fff;
        font-size: 0.3rem;
        margin-top: 0.42rem;
        box-sizing: border-box;
        border: 1px solid #ff5151;
        line-height: 0.38rem;
    }
    .goods_list ul li .help1{
        background-color:#fff;
        color: #ff5151;
    }
    /* 详情列表 */
    .bargain_good1{
        background-color: #fafafa;
        padding: 0 0.12rem;
    }
    .remaining_time{
        margin-top: 0.2rem;
        text-align: center;
        margin-bottom: 0.4rem;
    }
    .time_title{
        font-size: 0.28rem;
        color: #999;
        margin-bottom: 0.1rem;
    }
    .times{
        font-size: 0.32rem;
        color: #666;
        line-height: 0.4rem;
    }
    .times .icon{
        font-size: 0.4rem;
        display: inline-block;
        margin-right: 0.1rem;
        color: #666;
    }
    .goods_list1 ul{
        margin-right: -0.1rem;
    }
    .goods_list1 ul li{
        float: left;
        position: relative;
        width: 3.55rem;
        background-color: #fff;
        padding-bottom: 0.2rem;
        margin-right: 0.2rem;
        height: 4.3rem;
    }
    .goods_list1 ul li:nth-child(even){
        margin-right: 0;
    }
    .goods_list1 ul li .goodsPic{
        height: 2.9rem;
        margin:0 auto;
    }
    .goods_list1 ul li .goodsPic img{
        width: 100%;
        height: 100%;
    }
    .goods_list1 ul li .goods_content{
        position: absolute;
        bottom: 0.2rem;
    }
    .goods_list1 ul li p{
        overflow : hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        /*! autoprefixer: off */
        -webkit-box-orient: vertical;
        /* autoprefixer: on */
        color: #333;
        font-size: 0.28rem;
        margin-top: 0.2rem; 
        margin-bottom: 0.1rem;
    }
    .goods_list1 ul li .help{
        position: absolute;
        right: 0px;
        bottom: 0.14rem;
        height: 0.5rem;
        color: #fff;
        font-size: 0.28rem;
        line-height: 100%;
        box-sizing: border-box;
        border: 1px solid #ff5151;
        background-color: #ff5151;
        line-height: 0.44rem;
        padding: 0 0.1rem;
    }
    .goods_list1 ul li .help1{
        background-color: #fff;
        color: #ff5151;
    }
</style>
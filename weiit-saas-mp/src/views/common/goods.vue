<template>
    <div class="goods fn-clear">
        <div class="goods_pic">
            <img :src="$url+goods.product_img" alt="">
        </div>
        <div class="goods_infor">
            <h6>{{goods.product_name}}</h6>
            <span>￥{{goods.sale_price}}</span>
        </div>
        <!-- <div class="add_icon">
            <i class="icon iconfont icon-wuuiconxiangjifangda"></i>
        </div> -->
    </div>
</template>

<script>

    export default {
        props:['goods'],
        data(){
            return{
            }
        }
    }
</script>

<style scoped>
    .goods{
        position: relative;
        padding: 0.2rem 0;
        padding-left: 0.2rem;
        background-color: #fff;
    }
    .goods_pic{
        float: left;
        width: 1.2rem;
        height: 1.2rem;
    }
    .goods_pic img{
        width: 100%;
        height: 100%;
    }
    .goods_infor{
        float: left;
        margin-left: 0.2rem;
    }
    .goods_infor h6{
        font-size: 0.28rem;
         width: 3.8rem;
        color: #333;
        line-height: 0.32rem;
        padding-left: 0.08rem;
        overflow : hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        /*! autoprefixer: off */
        -webkit-box-orient: vertical;
        /* autoprefixer: on */
    }
    .goods_infor span{
        display: block;
        margin-top: 0.32rem;
        font-size: 0.32rem;
        color: #f44;
    }
    .add_icon{
       position:absolute;
       right: 0.26rem;
       bottom: 0.26rem;
       width: 0.44rem;
       height: 0.44rem;;
    }
    .add_icon .icon{
        font-size: 0.44rem;
        color: #f44;
        display: block;
    }
</style>
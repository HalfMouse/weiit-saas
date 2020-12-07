<template>
    <div class="goods">
        <div class="good_box fn-clear" :class="[{'big_good':goods.goodStyle == 'big'},{'matrix_good':goods.goodStyle == 'matrix'},{'list_good':goods.goodStyle == 'list'}]">
            <div class="goodShow">
                <img :src="$url+item.product_img" alt="">
            </div>
            <div class="good_infor">
                <p class="title" v-if="goods.checkedGoodName">{{item.product_name}}</p>
                <p class="price" v-if="goods.checkedPrice">
                    <span>￥{{item.sale_price}}</span>
                </p>
            </div>
            <!-- <div class="shop" v-if="goods.checkedBuyBtn && goods.btnStyle == 'button1'">
                <i class="icon iconfont icon-gouwuche"></i>
            </div>
            <div class="shop" v-if="goods.checkedBuyBtn && goods.btnStyle == 'button2'">
                <i class="icon iconfont icon-jia"></i>
            </div>
            <div class="shop1" v-if="goods.checkedBuyBtn && goods.btnStyle == 'button3'">
                {{goods.btnTxt3}}
            </div>
            <div class="shop2" v-if="goods.checkedBuyBtn && goods.btnStyle == 'button4'">
                {{goods.btnTxt4}}
            </div> -->
        </div>
    </div>
</template>

<script>
    export default {
        props:['goods','item'],
        data(){
            return{
            }
        }
    }
</script>

<style scoped>
    .big_good{
        box-sizing: border-box;
        border:1px solid #ddd;
        
    }
    .good_box{
        position: relative;
        margin-bottom: 0.1rem;
        background-color: #fff;
    }
    .goodShow img{
        width: 100%;
        display: block;
    }
    .good_infor{
        min-height:0.3rem;
        padding-bottom: 0.05rem;
    }
    .good_infor p{
        margin-top: 0.06rem;
        font-size: 0.28rem;
        color: #333;
        padding-left: 0.1rem;
        overflow : hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        /*! autoprefixer: off */
        -webkit-box-orient: vertical;
        /* autoprefixer: on */
    }
    .good_infor p span{
        color: #f44;
    }
    .shop{
        position: absolute;
        border: 1px solid #f44;
        width: 0.24rem;
        height: 0.24rem;
        border-radius: 50%;
        text-align: center;
        line-height: 0.24rem;
    }
    .shop .icon{
        display: block;
        font-size: 0.32rem;
        color: #f44;
    }
    /* 大图 */
    .big_good .shop{
        right: 0.1rem;
        bottom: 0.1rem;
    }
    .big_good .goodShow{
        width: 100%
    }
    /* 距正 */
    .matrix_good{
        position: relative;
        padding: 0.1rem 0;
        height: 4.5rem;
    }
    .matrix_good .goodShow{
        width: 3.3rem;
        margin: 0 auto;
    }
    .matrix_good .shop{
        right: 0.04rem;
        bottom: 0.03rem;
    }
    .matrix_good .good_infor .price{
        position: absolute;
        bottom: 0.1rem;
    }
    /* 列表 */
    .list_good .goodShow{
        float: left;
        width: 2rem;
        margin-right: 0.15rem;
    }
    .list_good .goodShow{
        display: block;
    }
    .list_good .good_infor{
        float: left;
        padding-bottom: 0.1rem;
        width: 4.5rem;
        padding-top: 0.2rem;
        

    }
    .list_good .good_infor .price{
        margin-top: 0.45rem;
    }
    .list_good .shop{
        right: 0.12rem;
        bottom: 0.07rem;
    }
    .shop1,.shop2{
        position:absolute;
        right: 0.06rem;
        bottom: 0.06rem;
        line-height: 0.4rem;
        padding: 0 0.1rem;
        cursor: pointer;
        background-color: #f44;
        color: #fff;
        border-radius: 0.1rem;
    }
    .shop2{
        background-color: #fff;
        line-height: 0.4rem;
        border-radius: 0;
        border: 1px solid #f44;
        color: #f44;
    }
</style>
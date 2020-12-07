<template>
    <div class="goods">
        <div class="good_box fn-clear" :class="[{'big_good':goods.goodStyle == 'big'},{'matrix_good':goods.goodStyle == 'matrix'},{'list_good':goods.goodStyle == 'list'}]">
            <div class="goodShow">
                <img src="static/images/goods.png" alt="" draggable="false" v-if="item == 'none'">
                <img :src="imageDomaia + item.product_img" alt="" draggable="false" v-else>
            </div>
            <div class="good_infor">
                <p class="title" v-if="goods.checkedGoodName && item == 'none'">此处显示商品名称</p>
                <p class="title" v-if="goods.checkedGoodName && item != 'none'">{{item.product_name}}</p>
                <p class="price" v-if="goods.checkedPrice && item == 'none'">
                    <span>￥999.00</span>
                </p>
                <p class="price" v-if="goods.checkedPrice && item != 'none'">
                    <span>￥{{item.smarket_price}}</span>
                </p>
            </div>
            <!--<div class="shop" v-if="goods.checkedBuyBtn && goods.btnStyle == 'button1'">
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
            </div>-->
        </div>
    </div>
</template>

<script>
    export default {
        props:['goods', 'item'],
        data(){
        	return {
        		imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
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
        margin-bottom: 10px;
        background-color: #fff;
    }
    .goodShow img{
        width: 100%;
    }
    .good_infor{
        min-height:30px;
        padding-bottom: 5px;
    }
    .good_infor p{
        margin-top: 6px;
        font-size: 14px;
        color: #333;
        padding-left: 10px;
    }
    .matrix_good .good_infor p{
    	padding-left: 5px;
    }
    .list_good  .good_infor p{
    	width: 175px;
    	padding-left: 3px;
    }
    .good_infor p.title{
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
        width: 24px;
        height: 24px;
        border-radius: 50%;
        text-align: center;
        line-height: 24px;
    }
    .shop .icon{
        font-size: 16px;
        color: #f44;
    }
    /* 大图 */
    .big_good .shop{
        right: 10px;
        bottom: 4px;
    }
    .big_good .goodShow{
        width: 100%
    }
    /* 距正 */
    .matrix_good .goodShow{
        width: 142px;
        margin: 0 auto;
    }
    .matrix_good .shop{
        right: 4px;
        bottom: 3px;
    }
    /* 列表 */
    .list_good .goodShow{
        float: left;
        width: 98px;
        margin-right: 15px;
    }
    .list_good .goodShow{
        display: block;
    }
    .list_good .good_infor{
        float: left;
        padding-bottom: 5px;
    }
    .list_good .good_infor .price{
        margin-top: 29px;
    }
    .list_good .shop{
        right: 12px;
        bottom: 7px;
    }
    .shop1,.shop2{
        position:absolute;
        right: 6px;
        bottom: 6px;
        font-size: 12px;
        line-height: 20px;
        padding: 0 5px;
        cursor: pointer;
        background-color: #f44;
        color: #fff;
        border-radius: 10px;
    }
    .shop2{
        background-color: #fff;
        line-height: 20px;
        border-radius: 0;
        border: 1px solid #f44;
        color: #f44;
    }
</style>
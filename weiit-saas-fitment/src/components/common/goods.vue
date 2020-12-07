<template>
    <div class="goods fn-clear">
        <div class="goods_pic">
            <img src="static/images/goods.png" alt="" draggable="false" v-if="item == 'none'">
            <img :src="imageDomaia + item.product_img" alt="" draggable="false" v-else>
        </div>
        <div class="goods_infor">
            <h6 v-if="item == 'none'">此处显示商品名称</h6>
            <h6 v-if="item != 'none'">{{item.product_name}}</h6>
            <span v-if="item == 'none'">￥1.50</span>
            <span v-if="item != 'none'">￥{{item.smarket_price}}</span>
        </div>
        <!--<div class="add_icon">
            <i class="icon iconfont icon-wuuiconxiangjifangda"></i>
        </div>-->
    </div>
</template>

<script>
    export default {
        props:['item'],
        data(){
        	return {
        		imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
        	}
        }
    }
</script>

<style scoped>
    .goods{
        position: relative;
        padding: 10px 0;
        background-color: #fff;
    }
    .goods_pic{
        float: left;
        width: 60px;
        height: 60px;
    }
    .goods_pic img{
        width: 100%;
        height: 100%;
    }
    .goods_infor{
        float: left;
        margin-left: 10px;
    }
    .goods_infor h6{
    	width: 145px;
        font-size: 14px;
        color: #333;
        font-weight: 700;
        line-height: 16px;
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
        margin-top: 8px;
        font-size: 16px;
        line-height: 18px;
        color: #f44;
    }
    .add_icon{
       position:absolute;
       right: 0;
       bottom: 13px;
       width: 22px;
       height: 22px;
    }
    .add_icon .icon{
        font-size: 22px;
        color: #f44;
    }
</style>
<template>
    <div class="goods">
        <div class="good_box fn-clear" :class="[{'big_good':fights.goodStyle == 'big'},{'matrix_good':fights.goodStyle == 'matrix'},{'list_good':fights.goodStyle == 'list'}]"  v-if="item == ''">
            <div class="goodShow">
                <img src="static/images/goods.png" alt="" draggable="false">
            </div>
            <div class="good_infor">
                <p :class="{'title':fights.goodStyle == 'list'}" v-if="fights.goodName">此处显示商品名称</p>
                <p v-if="fights.goodStyle == 'list'" class="des">香糯可口 农家好粽</p>
                <p class="price" v-if="fights.goodStyle != 'list'">
                    <span>￥999.00</span>
                    <span class="haveFight" v-if="fights.fightNum">已拼9.9万件</span>
                </p>
                <p class="spec fn-clear" v-if="fights.goodStyle == 'list'">
                    <span class="original_price">原价: 29.9</span>
                    <span class="size">规格: 8个装</span>
                </p>
                <p class="start_fight fn-clear" v-if="fights.goodStyle == 'list'">
                    <span class="group_fee">三人团：19.9元</span>
                    <span class="go_fight">去开团</span>
                </p>
            </div>
            <div class="shop" v-if="fights.goodStyle == 'big'">
                <button>去拼团</button>
            </div>
        </div>
        <div class="good_box fn-clear" :class="[{'big_good':fights.goodStyle == 'big'},{'matrix_good':fights.goodStyle == 'matrix'},{'list_good':fights.goodStyle == 'list'}]"  v-else>
            <div class="goodShow">
                <img :src="imageDomaia + item.product_img" alt="" draggable="false">
            </div>
            <div class="good_infor">
                <p :class="{'title':fights.goodStyle == 'list'}" v-if="fights.goodName">{{item.product_name}}</p>
                <p v-if="fights.goodStyle == 'list'" class="des">香糯可口 农家好粽</p>
                <p class="price" v-if="fights.goodStyle != 'list'">
                    <span>￥{{item.groupon_price}}</span>
                    <span class="haveFight" v-if="fights.fightNum">已拼{{item.sale_count}}万件</span>
                </p>
                <p class="spec fn-clear" v-if="fights.goodStyle == 'list'">
                    <span class="original_price">原价: {{item.sale_price}}</span>
                    <span class="size">规格: 8个装</span>
                </p>
                <p class="start_fight fn-clear" v-if="fights.goodStyle == 'list'">
                    <span class="group_fee">三人团：{{item.groupon_price}}元</span>
                    <span class="go_fight">去开团</span>
                </p>
            </div>
            <div class="shop" v-if="fights.goodStyle == 'big'">
                <button>去拼团</button>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props:['fights','item'],
        data() {
            return {
                // 图片前缀地址
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
            }
        },
    }
</script>

<style scoped>
    .big_good{
        box-sizing: border-box;
        border:1px solid #ddd;
    }
    .good_box{
        position: relative;
        padding-bottom: 10px;
        margin-top: 10px;
        background-color: #fff;
    }
    .goodShow img{
        width: 100%;
    }
    .good_infor p{
        font-size: 14px;
        color: #333;
        padding-left: 10px;
        text-overflow:ellipsis; 
        white-space:nowrap; 
        overflow:hidden;
    }
    .good_infor p span{
        color: #f44;
    }
    .good_infor p span.haveFight{
        font-size: 12px;
        color: #666;
    }
    .shop{
        position: absolute;
    }
    /* 大图 */
    .big_good .shop{
        right: 10px;
        bottom: 6px;
    }
    .big_good .goodShow{
        width: 100%
    }
    .big_good .shop button{
        display: block;
        width: 73px;
        height: 26px;
        box-sizing: border-box;
        border: 2px solid #ffdc48;
        background-color: #fff;
        color: #333;
        font-size: 14px;
        border-radius: 10px;
    }
    
    /* 距正 */
    .matrix_good .goodShow{
        width: 150px;
    }
    .matrix_good .shop{
        right: 4px;
        bottom: 3px;
    }
    .matrix_good .goodShow img{
        width: 150px;
        height: 150px;
    }
    /* 列表 */
    .list_good{
        padding-top: 10px;
    }
    .list_good .goodShow{
        float: left;
        width: 98px;
        margin-right: 15px;
    }
    .list_good .good_infor{
        float: left;
        width: 175px;
    }
    .list_good .good_infor .title{
        font-size: 16px;
        color: #333;
        font-weight: 700;
    }
    .list_good .good_infor .des{
        color: #666;
        font-size: 12px;
        margin-top: 5px;
    }
    .list_good .good_infor .spec{
        font-size: 12px;
        margin-top: 5px;
    }
    .list_good .good_infor .spec .original_price{
        float: left;
        color: #666;
    }
    .list_good .good_infor .spec .size{
        float: right;
        color: #666;
    }
    .list_good .shop{
        right: 12px;
        bottom: 7px;
    }
    
    .start_fight{
        width: 161px;
        height: 21px;
        background-image: url('../../../static/images/fight_tips.png');
        background-size: 100% 100%;
        margin-left: 7px;
        margin-top: 6px;
    }
    .list_good .good_infor .start_fight .group_fee,
    .list_good .good_infor .start_fight .go_fight{
        color: #fff;
        font-size: 12px;
        float: left;
        line-height: 21px;
    }
    .list_good .good_infor .start_fight .go_fight{
        color: #333;
        float: right;
        margin-right: 10px;
    }
</style>
<template>
    <div class="goods">
        <div class="good_box fn-clear" :class="[{'big_good':fights.goodStyle == 'big'},{'matrix_good':fights.goodStyle == 'matrix'},{'list_good':fights.goodStyle == 'list'}]">
            <div class="goodShow">
                <img :src="$url + item.product_img" alt="">
            </div>
            <div class="good_infor">
                <p :class="{'title':fights.goodStyle == 'list' || fights.goodStyle == 'matrix'}" v-if="fights.goodName">{{item.groupon_name}}</p>
                <!-- <p v-if="fights.goodStyle == 'list'" class="des">香糯可口 农家好粽</p> -->
                <p class="price" v-if="fights.goodStyle != 'list'">
                    <span>￥{{item.groupon_price}}</span>
                    <span class="haveFight" v-if="fights.fightNum">已拼{{item.groupon_number}}件</span>
                </p>
                <p class="spec fn-clear" v-if="fights.goodStyle == 'list'">
                    <span class="original_price">原价: {{item.sale_price}}</span>
                    <!-- <span class="size">规格: 8个装</span> -->
                </p>
                <p class="start_fight fn-clear" v-if="fights.goodStyle == 'list'">
                    <span class="group_fee">{{item.groupon_number}}人团：{{item.groupon_price}}元</span>
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
            }
        },
        mounted(){
            console.log(this.item)
        }
    }
</script>

<style scoped>
    .big_good{
        box-sizing: border-box;
        height: 8.5rem;
    }
    .good_box{
        position: relative;
        background-color: #fff;
        padding: 0 0.2rem;
    }
    .good_box .good_infor{
        padding: 0.05rem 0;
    }
    .goodShow img{
        width: 100%;
        display: block;
    }
    .good_infor p{
        font-size: 0.28rem;
        color: #333;
        padding-left: 0.05rem;
        margin-bottom: 0.1rem;
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
    .good_infor p.price{
        position: absolute;
        bottom: 0.05rem;
    }
    .good_infor p span{
        color: #f44;
    }
    .good_infor p span.haveFight{
        font-size: 0.24rem;
        color: #666;
    }
    .shop{
        position: absolute;
    }
    .good_infor p.start_fight{
        padding-left: 0.1rem;
    }
    /* 大图 */
    .big_good .shop{
        right: 0.2rem;
        bottom: 0.04rem;
    }
    .big_good .goodShow{
        width: 100%
    }
    .big_good .shop button{
        display: block;
        width: 1.3rem;
        height: 0.52rem;
        box-sizing: border-box;
        border: 2px solid #ffdc48;
        background-color: #fff;
        color: #333;
        font-size: 14px;
        border-radius: 0.1rem;
    }
    
    /* 距正 */
    .matrix_good{
        position: relative;
        width: 48vw;
        margin: 0 auto;
        height: 5rem;
        padding: 0;
    }
    .matrix_good .goodShow{
        width: 100%;
    }
    .matrix_good .shop{
        right: 4px;
        bottom: 3px;
    }
    .matrix_good .goodShow img{
        display: block;
        width: 100%
    }
    /* 列表 */
    .list_good{
        padding: 0.1rem 0.2rem;
    }
    .list_good .goodShow{
        float: left;
        width: 2rem;
        margin-right: 0.3rem;
        height: 2rem;
    }
    .list_good .good_infor{
        float: left;
        width: 4rem;
    }
    .list_good .good_infor .title{
        font-size: 0.3rem;
        color: #333;
        font-weight: 700;
    }
    .list_good .good_infor .des{
        color: #666;
        font-size: 0.3rem;
        margin-top: 0.1rem;
    }
    .list_good .good_infor .spec{
        font-size: 0.3rem;
        margin-top: 0.4rem;
        margin-bottom: 0.3rem;
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
        right: 0.24rem;
        bottom: 0.14rem;
    }
    
    .start_fight{
        width: 4rem;
        height: 0.42rem;
        background-image: url('../../../static/images/fight_tips.png');
        background-size: 100% 100%;
        margin-left: 7px;
        margin-top: 6px;
    }
    .list_good .good_infor .start_fight .group_fee,
    .list_good .good_infor .start_fight .go_fight{
        color: #fff;
        font-size: 0.28rem;
        float: left;
        line-height: 0.48rem;
    }
    .list_good .good_infor .start_fight .go_fight{
        color: #333;
        float: right;
        margin-right: 0.2rem;
    }
</style>
<template>
   <div class="goods_information clearfix">
        <div class="goods_pic">
            <img :src="$url + good.product_img" alt="">
        </div>
        <div class="goods_txt">
            <h4 class="name">{{good.product_name}}</h4>
            <p>
                <span class="size">{{good.spec_content}}</span> 
            </p>
            <span class="price" v-if="facomponent == 'shopCart'">￥458.5</span>
        </div>
    </div>
</template>

<script>
    export default {
        props:['facomponent','good']
    }
</script>

<style scoped lang="scss">
    .goods_information{
        padding:0.2rem 0;
        .goods_pic{
            float: left;
            width: 2rem;
            height: 2rem;
            box-sizing: border-box;
            margin-right: 0.16rem;
            margin-left: 0.4rem;
            border: 1px solid #d5d5d5;
            img{
                width: 100%;
                height: 100%;
            }
        }
        .goods_txt{
            width: 4.8rem;
            float: left;
            h4{
                font-size: 0.28rem;
                color: #333;
                display: -webkit-box;
                /*! autoprefixer: off */
                -webkit-box-orient: vertical;
                /* autoprefixer: on */
                -webkit-line-clamp: 2;
                overflow: hidden;
            }
            p{
                color: #666;
                font-size: 0.28rem;
                margin-top: 0.06rem;
                span{
                    display: inline-block;
                    margin-right: 0.1rem;
                }
            }
            .price{
                display: block;
                margin-top: 0.08rem;
                color: #EC534E;
                font-size: 0.24rem;
            }
        }
    }
</style>
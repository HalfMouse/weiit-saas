<template>
    <div class="goodSimple">
        <div class="good_img">
            <img :src="$url + item.product_img" alt="">
        </div>
        <p class="good_name">{{item.product_name}}</p>
        <p class="good_money">
            ￥{{item.sale_price}}
            <span v-if="item.smarket_price != item.sale_price">￥{{item.smarket_price}}</span>
        </p>
        <!-- <div class="cart">
            <i class="icon iconfont icon-gouwuche"></i>
        </div> -->
    </div>
</template>

<script>
    export default {
        props:['item']
    }
</script>

<style scoped lang="scss">
    .goodSimple{
        .good_img{
            width: 3rem;
            height: 3rem;
            text-align: center;
            margin:0 auto 0.08rem;
            img{
                width: 100%;
                height: 100%;
            }
        }
        .good_name{
            font-size: 0.28rem;
            color: #333;
            font-family: 'MicrosoftYaHei';
            overflow : hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            /*! autoprefixer: off */
            -webkit-box-orient: vertical;
            /* autoprefixer: on */
        }
        .good_money{
            font-size: 0.28rem;
            font-family: 'MicrosoftYaHei';
            color: #ec534e;
            span{
                color: #999;
                text-decoration: line-through;
                font-size: 0.24rem;
            }
        }
        .cart{
            position: absolute;
            width: 0.6rem;
            height: 0.6rem;
            box-sizing: border-box;
            border: 1px solid #AAAAAA;
            border-radius: 50%;
            right: 0.15rem;
            bottom: 0.15rem;
            text-align: center;
            line-height: 0.6rem;
            .icon{
                display: block;
                font-size:0.4rem;
                color: #999;
            }
        }
    }

</style>
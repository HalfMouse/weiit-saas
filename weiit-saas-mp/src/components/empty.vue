<template>
    <div class="empty_box">
        <!-- 收藏页如果没有数据 -->
        <div v-if="fatherComponent == 'collection'" class="empty">
            <i class="icon icon_collection"></i>
            <p class="empty_txt">您还没有收藏哦~</p>
            <router-link class="go_home_btn" to="/">逛逛首页</router-link>
        </div>
        <!-- 订单页如果没有数据 -->
        <div v-if="fatherComponent == 'order'" class="empty">
            <i class="icon icon_order"></i>
            <p class="empty_txt">您还没有订单哦~</p>
            <router-link class="go_home_btn" to="/">逛逛首页</router-link>
        </div>
        <!-- 退货管理页如果没有数据 -->
        <div v-if="fatherComponent == 'return'" class="empty">
            <i class="icon icon_return"></i>
            <p class="empty_txt">您还没有退货哦~</p>
            <router-link class="go_home_btn" to="/">逛逛首页</router-link>
        </div>
        <!-- 我的优惠券页如果没有数据 -->
        <div v-if="fatherComponent == 'coupon'" class="empty coupon_empty">
            <i class="icon icon_coupon"></i>
            <p class="empty_txt">您还没有优惠券呢</p>
            <router-link class="go_home_btn" to="/Receive_coupons">前往领取</router-link>
        </div>
    </div>
</template>

<script>
    export default {
        props:['fatherComponent']
    }
</script>

<style scoped lang="scss">
.empty_box{
    width: 7.5rem;
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    left: 0;
}
    .empty{
        text-align: center;
        .icon{
            display: block;
            width: 2rem;
            height: 2rem;
            margin:0 auto;
            background-size: 100% 100%;
            &.icon_collection{
                background-image: url('../../static/images/collection.svg')
            }
            &.icon_order{
                background-image: url('../../static/images/shop.svg')
            }
            &.icon_return{
                background-image: url('../../static/images/return.svg')
            }
            &.icon_coupon{
                width: 4rem;
                height: 2.76rem;
                background-image:url('../../static/images/coupon.svg');
            }
        }
        .empty_txt{
            color: #333;
            font-size: 0.28rem;
            margin-bottom: 0.7rem;
        }
        &.coupon_empty{
            .empty_txt{
                margin-top: -0.6rem;
            }
        }
        .go_home_btn{
            display: block;
            width: 6.91rem;
            height: 0.89rem;
            border-radius: 0.2rem;
            background-color: #FFDC4B;
            color: #333;
            border:none 0;
            font-size: 0.32rem;
            margin: 0 auto;
            line-height: 0.89rem;
        }
    }
</style>
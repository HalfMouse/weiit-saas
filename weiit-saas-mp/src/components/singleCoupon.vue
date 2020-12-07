<template>
    <div class="singleCoupon">
        <div class="user_coupon clearfix">
            <div class="coupon_mation">
                <h3>{{coupons.product}}</h3>
                <p>有效期:{{coupons.time}}</p>
                <i class="icon iconfont icon-xiangxiajiantou" :class="{'icon-xiangshangjiantou' : isHave}" @click="isHave = !isHave"></i>
            </div>
            <div class="coupon_price">
                <p class="money" v-if="coupons.type == 1 || coupons.type == 3">￥<span>{{coupons.coupon_price}}</span></p>
                <p class="money" v-if="coupons.type == 2"><span>{{coupons.coupon_price}}</span>折</p>
                <p class="condition">{{coupons.condition}}</p>
                <button class="draw" @click="drawCoupon()">领取</button>
            </div>
        </div>
        <div v-show="isHave" class="effective_time">
            *{{coupons.coupon_desc}}
        </div>
    </div>
</template>

<script>
    //引入axios 
    import axios from 'axios';
    // 引入qs
    import qs from 'qs'
    export default {
        props:['coupons'],
        data(){
            return {
                isHave:false,
                isFlag:true
            }
        },
        methods:{
            drawCoupon(){
                if(this.isFlag){
                    let coupon_id = this.coupons.coupon_id;
                    this.isFlag = false;
                    axios.post('/api/activity/couponGet',qs.stringify({
                        coupon_id:coupon_id
                    })).then((res) => {
                        this.isFlag = true
                        this.$router.push({
                            path:'/Coupon',
                            name:'Coupon'
                        })
                    }).catch((err) => {
                        console.log(err)
                    })
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .singleCoupon{
        width: calc(96% - 0.6rem);
        background-image: url('../../static/images/coupon.png');
        background-size: 100% 100%;
        margin: 0 auto;
        color: #F5C662;
        padding: 0.3rem 0.3rem 0.2rem;
        .user_coupon{
            .coupon_mation{
                float: left;
                width: 65%;
                h3{
                    font-size: 0.38rem;
                    font-weight: bold;
                    font-family:'PingFang-SC-Bold';
                    line-height: 0.3rem;
                }
                p{
                    font-size: 0.28rem;
                    line-height: 0.3rem;
                    margin-top: 0.12rem;
                    margin-bottom: 0.1rem;
                }
                .icon{
                    display: inline-block;
                    font-size: 0.3rem;
                    color: #ddd;
                    margin-top: 0.28rem;
                }
            }
            .coupon_price{
                float: right;
                text-align: right;
                .money{
                    font-size: 0.32rem;
                    span{
                        font-size: 0.64rem;

                    }
                }
                .condition{
                    font-size: 0.28rem;
                    line-height: 0.3rem;
                }
                .draw{
                    display: inline-block;
                    background-color: #F5C662;
                    color: #fff;
                    border: none 0;
                    line-height: 0.4rem;
                    padding:0 0.3rem;
                    border-radius: 0.2rem;
                    font-size: 0.22rem;
                }
            }
        }
        .effective_time{
            border-top: 2px solid #F5C662;
            line-height: 0.4rem;
            font-size: 0.28rem;
        }
    }
</style>
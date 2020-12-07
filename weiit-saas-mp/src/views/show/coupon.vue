<template>
    <div class="showBox">
        <div class="coupon blankShow">
            <div class="coupon_box">
                <div class="couponList fn-clear" ref="couponList">
                    <div :key="index" class="cap-coupon__item fn-clear" v-for="(item, index) in showGoods" ref="coupons" @click="drawCoupon(item.coupon_id,item)" :class="{'has_receive':!item.isReceive}" v-if="item.isReceive && hideCoupon">
                        <div class="coupon_main">
                            <div class="cap-coupon__price" v-if="item.type == 1">
                                <span>￥</span>
                                <span class="couponPrice">{{item.coupon_price}}</span>
                                <span>元</span>
                            </div>
                            <div v-if="item.type == 2" class="discountBox">
                                <span class="discountNum">{{item.coupon_discount}}</span>
                                <span>折</span>
                            </div>
                            <div class="cap-coupon__desc" v-if="item.is_condition == -1">
                                <div>无门槛使用</div>
                            </div>
                            <div class="cap-coupon__desc" v-if="item.is_condition == 1">
                                <div>满{{item.condition_price}}元减</div>
                            </div>
                        </div>
                        <div class="receive">领取</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    import qs from 'qs'
    // 从mint-ui中调用Popup,MessageBox
    import {Toast} from 'mint-ui';
    export default {
        props:['pageParam'],
        data(){
            return {
                addFun:'',
                showGoods:[],
                coupon_ids:[],
                isFlag:true,
                showNum:'',
                hideCoupon:false
            }
        },
        methods: {
            // 进入时初始化样式
            original(){
                this.addFun = this.pageParam.addFun;
                this.coupon_ids = this.pageParam.coupon_ids;
                this.showNum = this.pageParam.showNum ? this.pageParam.showNum : 0;
                this.hideCoupon = this.pageParam.hideCoupon;
                if(this.pageParam.coupon_ids.length > 0 && this.addFun == 'manual'){
                    let coupon_ids = this.pageParam.coupon_ids.join(',');
                    axios.post('/api/activity/couponListByIds',qs.stringify({
                        couponGetType:0,
                        coupon_ids:coupon_ids
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.showGoods = res.data.data;
                            this.showGoods.forEach((item) => {
                                this.$set(item, 'isReceive', true)
                            })
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
                }else if(this.addFun == 'automatic'){
                    axios.post('/api/activity/couponListByIds',qs.stringify({
                        couponGetType:1,
                        showNum:this.showNum
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.showGoods = res.data.data;
                            this.showGoods.forEach((item) => {
                                this.$set(item, 'isReceive', true)
                            })
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
                }
            },
            // 领取优惠券
            drawCoupon(coupon_id,item){
                if(this.isFlag){
                    if(item.isReceive){
                        this.isFlag = false;
                        axios.post('/api/activity/couponGet',qs.stringify({
                            coupon_id:coupon_id
                        })).then((res) => {
                            Toast(res.data.message);
                            this.isFlag = true;
                            item.isReceive = false;
                        }).catch((err) => {
                            console.log(err)
                        })
                    }
                    
                }
                
            }
        },
        mounted(){
            this.original();
            
            // this.$nextTick(() => {
                
            // })
            // this.scroll = new BScroll(this.$refs.picWrapper,{
            //     scrollX:true,
            //     eventPassthrough:'vertical'
            //     })
            // })
            // this.$refs.coupons.style.width = width;
        },
        updated(){
            let picWidth = 3.45;
            let margin = 0.1;
            let padding = 0.1;
            let width = (picWidth + margin) * this.showGoods.length - margin + padding;
            this.$refs.couponList.style.width = width + 'rem';
        }
    }
</script>

<style scoped lang="scss">
    .coupon{
        width: calc(100% - 0.4rem);
        padding: 0.2rem;
        overflow: hidden;
        .coupon_box{
            width: 100%;
            overflow-x: scroll;
            .couponList{
                .cap-coupon__item{
                    position: relative;
                    float: left;
                    width: 3.45rem;
                    height: 1.21rem;
                    margin-right: 0.1rem;
                    background-image: url('../../../static/images/coupon2.png');
                    background-size: 100% 100%;
                    color: #fff;
                    font-size: 0.28rem;
                    &.has_receive{
                        background-image: url('../../../static/images/coupon1.png');
                    }
                    .coupon_main{
                        position: absolute;
                        left: 0;
                        top: 50%;
                        transform: translateY(-50%);
                        width: 2.66rem;
                        text-align: center;
                        .discountNum{
                            font-size: 0.48rem;
                        }
                        .couponPrice{
                            font-size: 0.48rem;
                        }
                        .discountBox{
                            text-align: center;
                        }
                        .cap-coupon__desc{
                            text-align: center;
                        }
                    }
                    .receive{
                        position: absolute;
                        top: 50%;
                        transform: translateY(-50%);
                        right: 0.24rem;
                        width: 0.32rem;
                        text-align: center;
                        font-size: 0.32rem;
                        font-weight: bold;
                    }
                }
            }
        }
    }
</style>
<template>
    <div class="receive">
        <ul class="coupon_list">
            <li v-for="(item, index) in couponList">
                <single-coupon :coupons="item"></single-coupon>
            </li>
        </ul>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    //引入singleCoupon组件，每个优惠券情况
    import singleCoupon from '@/components/singleCoupon'
    export default {
        data(){
            return {
                couponList:[]
            }
        },
        components:{
            singleCoupon
        },
        methods:{
            // 获取优惠券列表
            getCouponList(){
                axios.post('/api/activity/couponList',null)
                    .then((res) => {
                        if(res.data.code == '0'){
                            this.couponList = res.data.data;
                            // this.couponList.forEach((item,index) => {
                            //     if(item.coupon_price.lenth.indexOf('-')){
                            //         this.couponList[index].coupon_price = item.coupon_price
                            //     } 
                            // })
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            }
        },
        mounted(){
            this.getCouponList();
        }
    }
</script>

<style scoped lang="scss">
    .receive{
        padding-top: 0.1rem;
    }
</style>
<template>
    <div>
        <div class="recharge_detail">
            <div class="recharge_info">
                <div class="tips">
                    <i class="icon iconfont icon-iconcorrect"></i>
                    <span>购买成功</span>
                </div>
                <p class="total_price">￥{{goodPrice}}</p>
                <p class="order_price">订单金额：{{goodPrice}}</p>
                <ul class="recharge_list">
                    <li class="fn-clear">
                        <span class="name">创建时间</span>
                        <span class="value">{{timer}}</span>
                    </li>
                    <li class="fn-clear">
                        <span class="name">付款方式</span>
                        <span class="price_type">{{buy_type}}</span>
                        <span class="value">￥{{goodPrice}}</span>
                    </li>
                </ul>
            </div>
            <a href="javascript:;" @click="ensure()" class="ensure" :style="{background:color1,color:'#fff'}">确定</a>
        </div>
    </div>
</template>

<script>
    import {time} from '../../../static/js/getTime'
    export default {
        data() {
            return {
                goodPrice: this.$route.query.goodPrice,
                buy_type: this.$route.query.buy_type,
                timer: '',
                color1:localStorage.getItem('bg1'),
                color2:localStorage.getItem('bg2')
            }
        },
        methods: {
            // 确认返回
            ensure(){
                this.$router.push({
                    path:'/33',
                    name:'home'
                })
            }
        },
        mounted(){
            var date = new Date();
            let Y = date.getFullYear() + '-';
            let M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
            let D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
            let h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
            let m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
            let s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds()); 
            this.timer = Y+M+D+h+m+s;
        },
        computed:{
            priceGood(){
                return parseFloat(this.goodPrice).toFixed(2);
            }
        }
    }
</script>

<style scoped lang="scss">
    .recharge_detail{
        min-height: 9.5rem;
        .recharge_info{
            background-color: #fff;
            padding-top: 0.2rem;
            .tips{
                display: table;
                margin: 0 auto;
                text-align: center;
                color: #09BB07;
                i{
                    display: block;
                    font-size: 1.5rem;
                }
                span{
                    display: table;
                    margin: 0 auto;
                    font-size: 0.28rem;
                    font-weight: 500;
                }
            }
            .recharge_list{
                li{
                    padding: 0.2rem 0.15rem;
                    border-bottom: 1px solid #e6e6e6;
                    &:first-child{
                        border-top: 1px solid #e6e6e6;
                    }
                    span{
                        float: left;
                        font-size: 0.28rem;
                        color: #666;
                        &.price_type{
                            margin-left: 0.2rem;
                            color: #999
                        }
                        &.value{
                            float: right;
                            color: #999;
                        }
                    }
                }
            }
            p{
                text-align: center;
                &.total_price{
                    font-size: 0.9rem;
                    color: #000;
                }
                &.order_price{
                    font-size: 0.28rem;
                    color: #808080;
                    margin-bottom: 0.5rem;
                }
            }
        }
        .ensure{
            display: block;
            width: 6.9rem;
            line-height: 0.89rem;
            text-align: center;
            background-color: #ffdc4b;
            border-radius: 0.2rem;
            margin: 0.5rem auto;
            font-size: 0.32rem;
        }
    }
</style>
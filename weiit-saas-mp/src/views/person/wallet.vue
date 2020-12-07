<template>
    <div class="wallet_box">
        <div class="balance">
            <div class="yue"></div>
            <span class="my_balance">我的余额</span>
            <p class="balance_num">￥{{moneyNum}}</p>
        </div>
        <button class="withdrawals" @click="toPostal()">提现</button>
        <button class="recharge" @click="toTecharge()">充值</button>
        <div class="payments">
            <a href="javascript:;" class="balance_payments" @click="toPayments()">收支明细</a>
        </div>
        <explain :item='item'></explain>
    </div>
</template>

<script>
    // 引入底部解释
    import explain from '@/components/explain'
    export default {
        data(){
            return {
                item:'wallet',
                moneyNum:localStorage.getItem('balance')
            }
        },
        components:{
            explain   
        },
        methods:{
            // 跳转到提现页面
            toPostal(){
                this.$router.push({
                    path:'/postal',
                    name:'postal',
                    params:{
                        name:'postal',
                        money:this.moneyNum
                    }
                })
            },
            // 跳转到收支明细页面
            toPayments(){
                this.$router.push({
                    path:'/payments',
                    name:'payments'
                })
            },
            // 跳转到充值页面
            toTecharge(){
                this.$router.push({
                    path:'/recharge',
                    name:'recharge'
                })
            }
        }
    }
</script>

<style scoped lang="scss">
    .wallet_box{
        padding-top: 1rem;
        .yue{
            margin: 0 auto;
            width: 1.62rem;
            height: 1.68rem;
            background-image: url('../../../static/images/wallet.svg');
            background-size: 100% 100%; 
            margin-bottom: 0.28rem;
        }
        .my_balance{
            display: block;
            text-align: center;
            font-size: 0.28rem;
            color: #333;
        }
        .balance_num{
            text-align: center;
            font-size:0.3rem;
            color:rgba(51,51,51,1);
            margin-top: 0.08rem;
        }
        button{
            display: block;
            width: 6.91rem;
            height: 0.89rem;
            border-radius: 0.19rem;
            border: none 0;
            font-size: 0.32rem;
            color:#333;
            margin: 0 auto;
            &.withdrawals{
                background-color: #FFDC4B;
                margin-top: 0.5rem;
            }
            &.recharge{
                background-color: #E5E5E5;
                margin-top: 0.2rem;
            }
        }
        .payments{
            text-align: center;
            margin-top: 0.34rem;
            .balance_payments{
                display: block;
                color:#3795ed;
                font-size: 0.26rem;
                font-weight: bold;
                font-family:'PingFang-SC-Bold';
                text-decoration: underline;
            }
        }
    }
</style>
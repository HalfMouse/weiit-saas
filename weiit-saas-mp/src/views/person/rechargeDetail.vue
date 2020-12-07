<template>
    <div class="recharge_detail">
        <div class="recharge_info">
            <div class="tips">
                <i class="icon iconfont icon-iconcorrect"></i>
                <span>充值成功</span>
            </div>
            <ul class="recharge_list">
                <li class="fn-clear">
                    <span class="name">充值时间</span>
                    <span class="value">{{timer}}</span>
                </li>
                <li class="fn-clear">
                    <span class="name">充值金额</span>
                    <span class="value">￥{{money}}</span>
                </li>
            </ul>
        </div>
        <a href="javascript:;" @click="ensure()" class="ensure">确定</a>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                money: this.$route.params.money ? this.$route.params.money : localStorage.getItem('recharge_money'),
                timer:''
            }
        },
        methods: {
            // 获取传递过来的数据
            getData() {
                let money = this.$route.params.money;
                if(money){
                    localStorage.setItem('recharge_money',money)
                }
            },
            // 确认返回
            ensure(){
                this.$router.push({
                    path:'/wallet',
                    name:'wallet'
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
        }
    }
</script>

<style scoped lang="scss">
    .recharge_detail{
        .recharge_info{
            background-color: #fff;
            padding-top: 0.2rem;
            .tips{
                display: table;
                margin: 0 auto 0.3rem;
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
                        &.value{
                            float: right;
                            color: #999;
                        }
                    }
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
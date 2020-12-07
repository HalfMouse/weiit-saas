<template>
    <div class="details">
        <div class="card_box">
            <card :cardnum="cardnum"></card>
        </div>
        <div class="rights">
            <div class="member_matter legal_right">
                <h3>享受权益</h3>
                <ul>
                    <li>
                        <i class="icon iconfont icon-youhuijuan"></i>
                        <span>包邮</span>
                    </li>
                    <li>
                        <i class="icon iconfont icon-baoyou1"></i>
                        <span>5折</span>
                    </li>
                    <li>
                        <i class="icon iconfont icon-zengsongjifen"></i>
                        <span>赠送积分</span>
                    </li>
                </ul>
            </div>
            <div class="member_matter user_tips">
                <h3>使用须知</h3>
                <p>本会员卡有效期内全场通用</p>
            </div>
        </div>
        <a href="javascript:;" class="toShopping" @click="toHome()">
            <span>前往购物</span>
            <i class="icon iconfont icon-youjiantouda"></i>
        </a>
    </div>
</template>

<script>
    //引入会员卡组件 
    import card from '@/components/card';
    export default {
        data(){
            return {
                cardnum:1
            }
        },
        components:{
            card
        },
        methods:{
           toHome(){
               this.$router.push({
                   paht:'/',
                   name:'home'
               })
           } 
        }
    }
</script>

<style scoped lang="scss">
    .details{
        .card_box{
            padding: 0.2rem 0.4rem;
        }        
        .rights{
            background-color: #fff;
            padding:0 0.4rem;
            .member_matter{
                h3{
                    width: 100%;
                    border-bottom: 2px solid #ddd;
                    line-height:0.64rem;
                    font-weight: bold;
                    font-family: 'PingFang-SC-Bold';
                    color: #333;
                    font-size: 0.34rem;
                }
                &.legal_right{
                    ul{
                        margin-top: 0.2rem;
                        display: flex;
                        li{
                            flex: 1;
                            text-align: center;
                            .icon{
                                width: 1.2rem;
                                font-size: 1.2rem;
                                &.icon-youhuijuan{
                                    color: #FDC040;
                                }
                                &.icon-baoyou1{
                                    color: #F35B37;
                                }
                                &.icon-zengsongjifen{
                                    color: #2787F2;
                                }
                            }
                            span{
                                display: block;
                                margin-top: 0.1rem;
                                font-size: 0.34rem;
                                color: #666;
                                font-family: 'PingFang-SC-Bold';
                                font-weight: bold;
                            }
                        }
                    }
                }
                &.user_tips{
                    margin-top: 0.26rem;
                    p{
                        line-height: 0.67rem;
                        font-weight: bold;
                        font-family:'PingFang-SC-Bold';
                        color:#999;
                        font-size: 0.28rem;
                    }
                }
            }
        }
        .toShopping{
            display: block;
            margin-top: 0.2rem;
            background-color: #fff;
            line-height: 1.13rem;
            height: 1.13rem;
            padding-left: 0.4rem;
            position: relative;
            span{
                font-size: 0.34rem;
                color: #333;
                font-weight: bold;
                font-family: 'PingFang-SC-Bold';
                display: block;
            }
            .icon{
                position: absolute;
                font-size: 0.4rem;
                right: 0.4rem;
                top: 50%;
                transform: translateY(-50%);
                color: #666;
            }
        }
    }
</style>
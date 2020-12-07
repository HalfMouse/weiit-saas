<template>
    <div class="confirm">
        <div class="confirm_infor">
            <h4>余额提现</h4>
            <div class="flow_box">
                <div class="flow_side clearfix">
                    <div class="postal_icon">
                        <div class="left_icon" v-if="confirmRooty == 'postal'">
                            <span class="dot dot_yes"></span>
                            <i class="icon iconfont icon-shijian-tianchong"></i>
                            <span class="dot dot_no"></span>
                        </div>
                        <div class="left_icon" v-else>
                            <span class="dot dot_yes dot1"></span>
                            <span class="dot dot_yes dot1"></span>
                            <i class="icon iconfont icon-zhifuchenggong"></i>      
                        </div>  
                        <div class="line line1"></div>
                        <div class="line line2"></div>         
                    </div>
                    <div class="postal_txt">
                        <div>
                            <p>发起余额提现申请</p>
                            <div class="flow_time">
                                <h3 :class="{'isSuccess' : confirmRooty == 'tailed'}">后台处理</h3>
                                <p>预计2018-3-26 11:10到账</p>
                            </div>
                            <p v-if="confirmRooty == 'postal'">提现成功&提现失败</p>
                            <p v-else class="success">提现成功</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="confirm_con">
                <div class="confirm_c"  v-if="confirmRooty == 'postal'">
                    <span class="txt fl">提现金额</span>
                    <span class="num fr">￥{{money}}</span>
                </div>
                <div class="confirm_c"  v-else>
                    <span class="txt fl">提现金额</span>
                    <span class="num fr">￥{{singleMoney}}</span>
                </div>
                <div class="confirm_c">
                    <span class="txt fl">到账账户</span>
                    <span class="num fr">{{accoNum}}</span>
                </div>
            </div>
        </div>
        <button class="accomplish_btn" @click="toWallet()">完成</button>
    </div>
</template>

<script>
    // 引入axios 
    import axios from 'axios'
    export default {
        data(){
            return {
                // 提现金额
                money:this.$route.params.money ? this.$route.params.money : localStorage.getItem('money'),
                // 从哪个页面跳转过来参数接收
                confirmRooty:localStorage.getItem('confirmRooty'),
                // 到账账户
                accoNum:this.$route.params.accoNum ? this.$route.params.accoNum : localStorage.getItem('accoNum'),
                // 单笔账目流程
                singleMoney:localStorage.getItem('singleMoney')
            }
        },
        methods:{
            // 跳转到我的钱包
            toWallet(){
                axios.post('/api/user/userInfo',null)
                .then((res) => {
                    if(res.data.code == '0'){
                        let user_infor = res.data.data
                        localStorage.setItem('balance',user_infor.balance);
                        this.$router.push({
                            path:'/wallet',
                            name:'wallet',
                        })
                    }
                    
                })
                .catch((err) => {
                    console.log(err);
                })
                
            }
        },
        mounted(){
            let money = this.$route.params.money;
            let accoNum = this.$route.params.accoNum;
            if(money){
                localStorage.setItem('money',money)
            }
            if(accoNum){
                localStorage.setItem('accoNum',accoNum);
            }
        }
    }
</script>

<style scoped lang="scss">
    .confirm{
        .confirm_infor{
            width: 100%;
            background-color: #fff;
            padding-top: 0.3rem;
            h4{
                font-size: 0.34rem;
                color: #333;
                margin-left: 0.3rem;
            }
            .flow_box{
                padding-left: 0.2rem;
                border-bottom: 2px solid #f5f5f5;
                position: relative;
                padding-bottom: 0.4rem;
                .flow_side{
                    position: relative;
                    margin-top: 0.6rem;
                    z-index: 2;
                    .postal_icon{
                        float: left;
                        position: relative;
                        .left_icon{
                            .dot{
                                display: block;
                                width: 0.2rem;
                                height: 0.2rem;
                                border-radius: 50%;
                                margin: 0 auto;
                                &.dot_yes{
                                    background-color: #ec534e;
                                }
                                &.dot_no{
                                    background-color: #ddd;
                                }
                                &.dot1:nth-child(2){
                                    margin:1rem auto 0.8rem;
                                }
                            }
                            .icon{
                                display: block;
                                font-size: 0.8rem;
                                &.icon-shijian-tianchong{
                                    color: #1296DB;
                                    margin:0.8rem 0;
                                }
                                &.icon-zhifuchenggong{
                                    color: #09BB07;
                                }
                                &.icon-shibai{
                                    color: #F4333C;
                                }
                            }
                        }
                        .line{
                            width: 1px;
                            height: 1.2rem;
                            background-size: 100% 100%;
                            position: absolute;
                            left: 50%;
                            z-index: -1;
                            &.line1{
                                background-image: url('../../../static/images/line1.png');
                                top: 0;
                            }
                            &.line2{
                                background-image: url('../../../static/images/line2.png');
                                top: 1.4rem;
                            }
                        }
                    }
                    .postal_txt{
                        float: left;
                        margin-left: 0.8rem;
                        p{
                            color: #999;
                            font-size: 0.34rem;
                            &.success{
                                color: #333;
                            }
                        }
                        .flow_time{
                            margin: 0.6rem 0;
                            h3{
                                margin-bottom: 0.08rem;
                                font-size:0.34rem;
                               &.isSuccess{
                                   color: #999999
                               }
                            }
                             p{
                                    font-size: 0.28rem; 
                                }
                            margin: 0.7rem 0 0.84rem;
                        }
                    }
                }
                
            }
            .confirm_con{
              padding:0.2rem;  
              .confirm_c{
                  margin-bottom: 0.3rem;
                  overflow: hidden;
                  &:last-child{
                      margin-bottom: 0;
                  }
                  .txt{
                      font-size: 0.3rem;
                      color: #666;
                  }
                  .num{
                      font-size: 0.3rem;
                      color: #333;
                  }
              }
            }
        }
        .accomplish_btn{
            position: fixed;
            left: 50%;
            bottom: 0.4rem;
            width: 3.55rem;
            height: 0.66rem;
            background-color: #FFDC4B;
            border-radius: 0.1rem;
            color: #333;
            font-size: 0.34rem;
            transform: translateX(-50%);
            border:none 0;
        }
    }
</style>
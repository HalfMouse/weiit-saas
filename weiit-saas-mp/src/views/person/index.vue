<template>
    <div class="person">
        <loading v-show="isLoading"></loading>
        <div v-show="!isLoading" class="main_box">
            <div class="header_bg"></div>
            <div class="main">
                <!-- 个人账户信息 -->
                <div class="login_person">
                    <div class="login_person_header clearfix">
                        <div class="person_icon" @click="setPerson()">
                            <img :src="userImg" alt="">
                        </div>
                        <div class="login_or_regist">
                            <!-- <span @click="showLogin()" v-if="isLogin">登陆/注册</span> -->
                            <span>{{userName}}</span>
                        </div>
                        <div class="ewm_code">
                            <i class="icon iconfont icon-erweima"></i>
                        </div>
                    </div>
                    <div class="login_person_bottom">
                        <ul class="clearfix">
                            <li>
                                <a href="javascript:;" class="fn-clear" @click="toOrder('all')">
                                <!-- <a href="javascript:;" class="fn-clear" @click="toAllOrder()"> -->
                                    <span class="order_num">{{myOrderCount}}</span>
                                    <span class="my_order">我的订单</span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" class="fn-clear" @click="toWallet()">
                                    <span class="wallet_num">{{balance}}</span>
                                    <span class="my_wallet">我的钱包</span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" class="fn-clear" @click="toIntegral()">
                                    <span class="integral_num">{{integral}}</span>
                                    <span class="my_integral">我的积分</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- 功能导航 -->
                <div class="menu">
                    <ul class="clearfix">
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toOrder('obligation')">
                            <!-- <a href="javascript:;" class="fn-clear" @click="toObligationOrder()"> -->
                                <i class="icon iconfont icon-zhifu"></i>
                                <span class="menu_txt">待付款</span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toOrder('delivery')">
                            <!-- <a href="javascript:;" class="fn-clear" @click="toDeliveryOrder()"> -->
                                <i class="icon iconfont icon-fahuo"></i>
                                <span class="menu_txt">待发货</span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toOrder('received')">
                            <!-- <a href="javascript:;" class="fn-clear" @click="toReceivedOrder()"> -->
                                <i class="icon iconfont icon-shouhuo"></i>
                                <span class="menu_txt">待收货</span>
                            </a>
                        </li>
                        <li>
                            <router-link to="/returnGoods" class="fn-clear">
                                <i class="icon iconfont icon-money-6"></i>
                                <span class="menu_txt">退货/售后</span>
                            </router-link>
                        </li>
                    </ul>
                </div>
                <!-- 各功能入口 -->
                <div class="guild">
                    <ul>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toCoupon()">
                                <i class="icon iconfont icon-youhuiquan01 icon1"></i>
                                <span>优惠券</span>
                                <i class="icon iconfont icon-youjiantouda icon2"></i>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toDetails()">
                                <i class="icon iconfont icon-huiyuanqia icon1"></i>
                                <span>会员卡</span>
                                <i class="icon iconfont icon-youjiantouda icon2"></i>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toMall()">
                                <i class="icon iconfont icon-huiyuanqia icon1"></i>
                                <span>积分商城</span>
                                <i class="icon iconfont icon-youjiantouda icon2"></i>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toAddress()">
                                <i class="icon iconfont icon-dizhi01 icon1"></i>
                                <span>收货地址</span>
                                <i class="icon iconfont icon-youjiantouda icon2"></i>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toCollection()">
                                <i class="my_collect"></i>
                                <span>我的收藏</span>
                                <i class="icon iconfont icon-youjiantouda icon2"></i>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toFeedback()">
                                <i class="icon iconfont icon-fankuifenxi icon1"></i>
                                <span>意见反馈</span>
                                <i class="icon iconfont icon-youjiantouda icon2"></i>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="showTel()">
                                <i class="icon iconfont icon-qunfengkefujingli1 icon1"></i>
                                <span>在线客服（9:00 - 21:00）</span>
                                <i class="icon iconfont icon-youjiantouda icon2"></i>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toFight()" v-if="haveFight">
                                <i class="icon iconfont icon-fankuifenxi icon1"></i>
                                <span>我的拼团</span>
                                <i class="icon iconfont icon-youjiantouda icon2"></i>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="fn-clear" @click="toCut()" v-if="haveCut">
                                <i class="icon iconfont icon-qunfengkefujingli1 icon1"></i>
                                <span>我的砍价</span>
                                <i class="icon iconfont icon-youjiantouda icon2"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!-- <loging></loging> -->
            
        </div>
        <!-- 登陆窗 -->
        <!-- <login ref="login"></login> -->
        
        <nav-footer :parents="'person'"></nav-footer>
        
    </div>
</template>

<script>
    // 从mint-ui引入MessageBox组件
    import { MessageBox,Toast } from 'mint-ui';
    import NavFooter from '@/components/footer'
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 引入加载组件
    import loading from '@/components/loading'
    import loging from '@/components/loging'
    // 引入登陆窗组件
    // import Login from '@/components/login'
    export default {
        data(){
           return {
                loginShow:false,
                userName:'',
                userImg:'',
                isLogin:true,
                balance:'',
                integral:'',
                myOrderCount:'',
                isLoading:true,
                tel:'',
                haveFight:false,    //是否有我的拼团入口
                haveCut: false    //是否有我的砍价入口
           }
        },
        methods:{
            //跳转到积分页
            toIntegral(){
                this.$router.push({
                    path:'/integral',
                    name:'integral'
                })
            },
            //跳转到钱包页
            toWallet(){
                this.$router.push({
                    path:'/wallet',
                    name:'wallet'
                })
            },
            //跳转到收藏页
            toCollection(){
                this.$router.push({
                    path:'/Collection',
                    name:'Collection'
                })
            },
            // 跳转到订单页
            toOrder(type){
                localStorage.setItem('orderStyle',type)
                this.$router.push({
                    path:'/Order',
                    name:'Order'
                })
            },
            // 跳转到拼团列表
            toFight(){
                this.$router.push({
                    path:'/collageList',
                    name:'collageList',
                    query:{
                        currentTab:1
                    }
                })
            },
            // 跳转到砍价列表
            toCut(){
                this.$router.push({
                    path:'/teams',
                    name:'teams',
                    query:{
                        currentTab:1
                    }
                })
            },
            // 所有订单
            // toAllOrder(){
            //     this.$router.push({
            //         path:'/order',
            //         name:'allOrder'
            //     })
            // },
            // // 待支付订单
            // toObligationOrder(){
            //     this.$router.push({
            //         path:'/order/obligationOrder',
            //         name:'obligationOrder'
            //     })
            // },
            // // 待发货订单
            // toDeliveryOrder(){
            //     this.$router.push({
            //         path:'/order/deliveryOrder',
            //         name:'deliveryOrder'
            //     })
            // },
            // // 待收货订单
            // toReceivedOrder(){
            //     this.$router.push({
            //         path:'/order/receivedOrder',
            //         name:'receivedOrder'
            //     })
            // },
            // 跳转到收获地址页
            toAddress(){
                this.$router.push({
                    path:'/address',
                    name:'address'
                })
                localStorage.setItem('addressRootly','person')
            },
            // 弹出客服电话
            showTel(){
                axios.post('/api/user/getShopInfo',null)
                    .then((res) => {
                        // console.log(res);
                        if(res.data.code == '0'){
                            window.location.href="tel:" + res.data.data.shop_tel;
                        }else{
                            Toast(res.data.message)
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })

                // MessageBox.confirm('',{
                //     title:'客服电话',
                //     message:'4001231234',
                //     cancelButtonClass:'cancelButton1',
                //     confirmButtonClass:'confirmButton',
                //     confirmButtonText:'确认',
                //     cancelButtonText:'取消'
                // }).then((action) => {
                //     if (action == 'confirm') {
                //     // 拨打的时候触发
                //         window.location.href="tel:" + this.tel;
                //     }
                // }).catch((err) => {
                //     // 取消的时候触发
                //     if (err == 'cancel') {
                //         console.log('123');
                //     }
                // });
            },
            // 跳转到意见反馈
            toFeedback(){
                this.$router.push({
                    path:'/Opinion',
                    name:'Opinion',
                })
            },
            // 跳转到会员卡页
            toDetails(){
                // this.$router.push({
                //     path:'/member',
                //     name:'member'
                // })
                Toast('该功能暂未开放！敬请期待');
            },
            // 跳转到优惠券
            toCoupon(){
                this.$router.push({
                    path:'/Coupon',
                    name:'Coupon'
                })
            },
            // 跳转到积分商城
            toMall(){
                this.$router.push({
                    path:'/IntegralMall',
                    name:'IntegralMall'
                })
            },
            // 弹出登陆框
            // showLogin(){
            //     this.$refs.login.show();
            // },
            // 判断是否用户登陆
            existence(){
                // if(localStorage.getItem('user_name')){
                //     this.isLogin = false;
                //     // this.userName = localStorage.getItem('user_name');
                //     // this.userImg = localStorage.getItem('user_img');
                //     // this.balance = localStorage.getItem('balance');
                //     // this.integral = localStorage.getItem('integral');
                //     // this.myOrderCount = localStorage.getItem('myOrderCount');
                // }else{
                //     this.balance = 0;
                //     this.integral = 0;
                //     this.myOrderCount = 0;
                // }
            },
            // 获取个人信息
            getPerson(){
                axios.post('/api/user/userInfo',null)
                    .then((res) => {
                        if(res.data.code == '0'){
                            this.balance = res.data.data.balance;
                            this.integral = res.data.data.integral;
                            this.myOrderCount = res.data.data.myOrderCount;
                            this.isLoading = false
                            localStorage.setItem('balance',this.balance);
                            localStorage.setItem('integral',this.integral);
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            },
            getEnterPoint(){
                axios.post('/api/user/enterPointConfig',null)
                    .then(res => {
                        console.log(res);
                        if(res.data.code == '0'){
                            res.data.data.forEach((item) => {
                                if (item.item_desc == '我的拼团') {
                                    this.haveFight = true;
                                }
                                if (item.item_desc == '我的砍价') {
                                    this.haveCut = true;
                                }
                            })
                        }
                    })
                    .catch(err => {
                        console.log(err);
                    })
            },
            // 修改个人信息
            setPerson(){
                this.$router.push({
                    path:'/setPerson',
                    name:'setPerson'
                })
            }
        },
        components:{
            NavFooter,
            loading,
            loging
        },
        mounted(){
            this.getPerson();
            this.getEnterPoint();
            this.userName = localStorage.getItem('user_name');
            this.userImg = localStorage.getItem('user_img');
        }
    }
</script>

<style scoped lang="scss">
    .person{
        padding-bottom: 1.1rem;
    }
    .my_collect{
        float: left;
        width: 0.36rem;
        height: 0.36rem;
        background-image: url('../../../static/images/collection.png');
        background-size: 100% 100%;
    }
    .header_bg{
        position: fixed;
        top: 0;
        left: 0;
        width:100%;
        height:2.34rem;
        background-image: url('../../../static/images/header_bg.png');
        background-size: 100% 100%;
    }
    // 主体部分
    .main{
        // position: absolute;
        // width: 100%;
        // left: 50%;
        // top: 1rem;
        // transform: translateX(-50%);
        padding-top: 1rem;
        .login_person{
            position: relative;
            width:90%;
            border-radius: 0.22rem ; 
            margin: 0 auto;
            background-color: #fff;
            .login_person_header{
                position: relative;
                padding-top: 0.2rem;
                .person_icon{
                    position: absolute;
                    left: 0.2rem;
                    top: -0.6rem;
                    width: 1.45rem;
                    height: 1.45rem;
                    border-radius: 50%;
                    overflow: hidden;
                    img{
                        width: 1.45rem;
                        height: 1.45rem;
                    }
                }
                .login_or_regist{
                    float: left;
                    margin-left: 2rem;
                    font-family:'PingFang-SC-Medium';
                    color: #333;
                    font-size: 0.28rem;
                }
                .ewm_code{
                    float: right;
                    width: 0.6rem;
                    height: 0.6rem;
                    margin-right: 0.4rem;
                    margin-top: -0.1rem;
                    i{
                        display: block;
                        font-size: 0.6rem;
                        color: #333;
                    }
                }
            }
            .login_person_bottom{
                width: 100%;
                margin-top: 0.6rem;
                padding-bottom: 0.3rem;
                ul{
                    li{
                        width: 33%;
                        float: left;
                        box-sizing: border-box;
                        &:nth-child(2){
                            a{
                                border-left: 1px solid #ddd;
                                border-right: 1px solid #ddd;
                            }
                        }
                        a{
                            display: block;
                            text-align: center;
                            
                            span{
                                display: block;
                                font-size:0.28rem;
                                // font-family:'PingFang-SC-Medium';
                                color:#333;
                                text-align: center;
                                &:first-child{
                                    color:#000;
                                }
                            }
                        }
                    }
                }
            }
        }
        .menu{
            position: relative;
            width: 100%;
            background-color: #fff;
            margin-top: 0.2rem;
            padding-top: 0.2rem;
            padding-bottom: 0.2rem;
            z-index: 5;
            ul{
                li{
                    width: 25%;
                    float: left;
                    a{
                        display: block;
                        text-align: center;
                        height: 100%;
                        i{
                            display: block;
                            font-size: 0.4rem;
                            margin:0 auto;
                            color:#333;
                        }
                        .menu_txt{
                            display: block;
                            margin-top: 0.2rem;
                            font-size: 0.28rem;
                            // font-family:PingFang-SC-Medium;
                            color:#333;
                            line-height:0.16rem;
                            text-align: center;
                        }
                    }
                    
                }
            }
        }
        .guild{
            position: relative;
            width: 100%;
            overflow-y: auto;
            margin-top: 0.2rem;
            z-index: 5;
            min-height:6.42rem;
            // padding-bottom: 1.1rem;
            ul{
                li{
                    box-sizing: border-box;
                    border-bottom: 1px solid #ddd;
                    background-color: #fff;
                    &:last-child{
                        border:none 0;
                    }
                    a{
                        display: block;
                        position: relative;
                        padding: 0.2rem 0 0.2rem 0.36rem;
                        .icon1{
                            float: left;
                            font-size: 0.4rem;
                            &.icon-youhuiquan01{
                                color:#f4cf37;
                            }
                            &.icon-dizhi01{
                                color: #d1abe4;
                            }
                            &.icon-bangzhuzhongxin{
                                color: #7fc3f6;
                            }
                            &.icon-fankuifenxi{
                                color: #fed04a;
                            }
                            &.icon-guanyuwomen{
                                color: #fe8198;
                            }
                            &.icon-qunfengkefujingli1{
                                color: #8edcd0;
                            }
                            &.icon-huiyuanqia{
                                color:#72B5EF;
                            }
                        }
                        span{
                            float: left;
                            font-size: 0.28rem;
                            color:#333;
                            margin-left: 0.2rem;
                            margin-top: 0.05rem;
                        }
                        .icon2{
                            position: absolute;
                            top: 0.24rem;
                            right: 0.2rem;
                            font-size: 0.4rem;
                            color: #cbc9cc;
                            font-weight: 700;
                        }
                    }
                }
            }
        }
        .dot{
            height: 0.5rem;
        }
    }
</style>
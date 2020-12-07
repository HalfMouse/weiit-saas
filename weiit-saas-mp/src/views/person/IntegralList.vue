<template>
    <div class="integralList">
        <ul class="clearfix">
            <li v-for="(item, index) in IntegralList">
                <div class="order-num fn-clear">
                    <span class='order'>订单号：{{item.order_num}}</span>
                    <span class='state' v-if="item.state == 0">待支付</span>
                    <span class='state' v-if="item.state == 1">已支付</span>
                    <span class='state' v-if="item.state == -1">已过期</span>
                </div>
                <div class="item-goods fn-clear">
                    <div class="item-pic">
                        <img :src="$url + item.product_img" alt="">
                    </div>
                    <div class="item-mations">
                        <h3>{{item.product_name}}</h3>
                        <p class="goods-pays fn-clear">
                            <span class="price">￥{{item.pay_price}}</span>
                            <span class="integral">{{item.integral}}积分</span>
                            <span class="smarket_price">￥{{item.smarket_price}}</span>
                        </p>
                    </div>
                </div>
                <div class="pay-btn fn-clear" v-if="item.state == 0">
                    <a href="javascript:;" class="go-pay" @click="immediately(item,$event)">继续支付</a>
                </div>
            </li>
        </ul>
        <pay-load v-show="isPay"></pay-load>
        <loading v-show="isLoading"></loading>
        <!-- 选择支付方式 --> 
        <mt-popup v-model="payment" position="bottom">
            <div class="payment">
                <ul>
                    <li>
                        <label class="mint-radiolist-label">
                            <span class="mint-radio">
                                <input type="radio" class="mint-radio-input" value="wx" v-model="payment_type"> 
                                <span class="mint-radio-core"></span>
                            </span> 
                        </label>
                        <div class="cost_pic">
                            <img src="static/images/wx.png" alt="">
                        </div>
                        <div class="cost_way">
                            <h6>微信支付</h6>
                            <p>推荐安装微信的用户使用</p>
                        </div>
                    </li>
                    <li v-if="balancePayAble">
                        <label class="mint-radiolist-label">
                            <span class="mint-radio">
                                <input type="radio" class="mint-radio-input" value="balance" v-model="payment_type"> 
                                <span class="mint-radio-core"></span>
                            </span> 
                        </label>
                        <div class="cost_pic">
                            <img src="static/images/balance.png" alt="">
                        </div>
                        <div class="cost_way">
                            <h6>余额支付</h6>
                            <p>推荐用户余额使用</p>
                        </div>
                    </li>
                    <li>
                        <a href="javascript:;" @click="ensurePayment()" :style="{background:color1,color:'#fff'}">确定</a>
                    </li>
                </ul>
                
            </div>
        </mt-popup>
        <div class="overlayer" v-if="isPay" @touchmove.prevent></div>  
    </div>
</template>

<script>
    // 引入 Swipe, SwipeItem, Popup
    import { Popup, Toast } from 'mint-ui';
    import axios from 'axios';
    import qs from 'qs';
     // 引入加载组件
    import loading from '@/components/loading'
    import payLoad from '@/components/payLoad'
    export default {
        data() {
            return {
                IntegralList: [],
                pageNo:1,
                isLoading:true,
                payment:false,
                payment_type:'wx',
                isPay:false,
                balancePayAble: false,
                wxPayAble: false,
                color1:localStorage.getItem('bg1'),
                isFlag:true,
                singleOrderCost:null
            }
        },
        methods: {
            getIntegralList() {
               axios.post('/api/integral/integralOrderList', qs.stringify({
                    page:this.pageNo,
                    rows:8
               })).then(res => {
                   console.log(res);
                   if(res.data.code == '0'){
                       this.IntegralList = res.data.data;
                       this.isLoading = false
                   }
               })
            },
             // 确定购买
            ensurePayment(){
                if(this.payment_type == 'wx' && this.isFlag){
                    if(this.wxPayAble){
                        let _this = this;
                        this.isFlag = false
                        this.isPay = true;
                        this.payment = false;
                        // 微信支付
                        axios.post('/api/integral/integralPay', qs.stringify({
                            payment_type:'0',
                            order_num:this.singleOrderCost.order_num
                        })).then((res) => {
                            wx.chooseWXPay({
                                timestamp: res.data.data.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                                nonceStr: res.data.data.nonceStr, // 支付签名随机串，不长于 32 位
                                package:  res.data.data.packageValue, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                                signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                                paySign: res.data.data.paySign, // 支付签名
                                success: function (res) {
                                    _this.payment = false;
                                    _this.isFlag = true;
                                    _this.isPay = false;
                                    _this.$router.push({
                                        path:'/buySuccess',
                                        name:'buySuccess',
                                        query:{
                                            goodPrice:goodPrice,
                                            buy_type:'微信'
                                        }
                                    })
                                },
                                cancel: function(res){
                                    _this.payment = false;
                                    _this.isFlag = true;
                                    _this.isPay = false;
                                }
                            });
                        }).catch((err) => {
                            console.log(err);
                            _this.isFlag = true;
                            _this.isPay = false;
                        })
                    }else{
                        Toast('暂不支持微信支付，请选择其他支付方式');
                    }
                }else if(this.payment_type == 'balance' && this.isFlag){
                    if(this.balancePayAble){
                        this.isFlag = false
                        // 余额支付
                        this.payment = false;
                        MessageBox.confirm('',{
                            width:500,
                            height:600,
                            message:'确认余额付款?',
                            cancelButtonClass:'cancelButton',
                            confirmButtonClass:'confirmButton',
                            confirmButtonText:'确认',
                            cancelButtonText:'取消'
                        }).then((action) => {
                            if (action == 'confirm') {
                                this.isPay = true;
                                axios.post('/api/integral/integralPay', qs.stringify({
                                    payment_type:'1',
                                    order_num:this.singleOrderCost.order_num
                                })).then((res) => {
                                    if(res.data.code == '0'){
                                        this.isFlag = true;
                                        this.isPay = false;
                                        this.$router.push({
                                            path:'/buySuccess',
                                            name:'buySuccess',
                                            query:{
                                                goodPrice:goodPrice,
                                                buy_type:'余额'
                                            }
                                        })
                                    }else{
                                        Toast(res.data.message);
                                        this.isFlag = true;
                                        this.isPay = false;
                                    }
                                }).catch((err) => {
                                    this.isFlag = true;
                                    this.isPay = false;
                                })
                                
                            }
                        }).catch((err) => {
                            if (err == 'cancel') {
                                Toast('交易取消');
                                this.isFlag = true;
                                this.isPay = false;
                            }
                        });
                    }else{
                        Toast('暂不支持余额支付，请选择其他支付方式');
                    }
                }
            },
            immediately(item,e){
                this.payment = true;
                this.singleOrderCost = item
                e.stopPropagation();
            },
            // 获取是否允许的支付方式
            getPayAble(){
                axios.post('/api/product/paymentTypeInfo', null)
                    .then(res => {
                        console.log(res);
                        if(res.data.code == '0'){
                            this.balancePayAble = res.data.data.balancePayAble;
                            this.wxPayAble = res.data.data.wxPayAble;
                        }
                    })
                    .catch(err => {
                        console.log(err);
                    })
            }
        },
        mounted() {
            this.getIntegralList()
            this.getPayAble()
        },
        components:{
            loading,
            payLoad
        }
    }
</script>

<style scoped lang="scss">
    .integralList{
        ul{
            li{
                background-color: #fff;
                margin-top: 0.1rem;
                .order-num{
                    font-size: 0.3rem;
                    height: 0.5rem;
                    border-bottom: 1px solid #f5f5f5;
                    padding: 0 0.1rem;
                    line-height: 0.5rem;
                    .order{
                        float: left;
                        
                    }
                    .state{
                        float: right;
                        color: #999;
                    }
                }
                .item-goods{
                    padding: 0.1rem;
                    .item-pic{
                        float: left;
                        width: 1.8rem;
                        height: 1.8rem;
                        img{
                            display: block;
                            width: 100%;
                            height: 100%;
                        }
                    }
                    .item-mations{
                        float: left;
                        margin-left: 0.2rem;
                        width: 5.1rem;
                        h3{
                            font-size: 0.32rem;
                            margin-top: 0.1rem;
                            overflow : hidden;
                            text-overflow: ellipsis;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                             /*! autoprefixer: off */
                            -webkit-box-orient: vertical;
                            /* autoprefixer: on */
                        }
                        .goods-pays{
                            margin-top: 0.2rem;
                            
                            span{
                                font-size: 0.3rem;
                                float: left;
                                &.integral{
                                    margin-left: 0.2rem;
                                    color: #ec534e;
                                }
                                &.smarket_price{
                                    float: right;
                                    color: #bbb;
                                    margin-right: 0.1rem;
                                }
                            }
                        }
                    }
                }
                .pay-btn{
                    padding:0.15rem 0.1rem;
                    border-top:1px solid #f5f5f5;
                    .go-pay{
                        float:right;
                        font-size:0.28rem;
                        color:#ec534e;
                        border:1px solid #ec534e;
                        padding:0.05rem 0.15rem;
                        border-radius:0.1rem;
                        margin-right:0.1rem;

                    }
                }
            }
        }
        .payment{
            margin-top: 0.2rem;
            background-color: #fff;
            padding-bottom: 0.1rem;
            ul{
                li{
                    padding:0.2rem 0.3rem;
                    border-bottom: 2px solid #f5f5f5;
                    overflow: hidden;
                    &:last-child{
                        border:none 0;
                    }
                    .mint-radiolist-label{
                        float: left;
                        margin-top: 0.2rem;
                        padding:0;
                        .mint-radio-core{
                            display: block;
                            
                        }
                    }
                    .cost_pic{
                        float: left;
                        width: 0.81rem;
                        height: 0.81rem;
                        margin:0 0.2rem;
                        img{
                            width: 100%;
                            height: 100%;
                            display: block;
                        }
                    }
                    .cost_way{
                        float: left;
                        margin-top: 0.06rem;
                        h6{
                            font-size: 0.3rem;
                            color: #333;
                        }
                        p{
                            color: #999;
                            font-size: 0.26rem;
                        }
                    }
                    a{
                        display: block;
                        width: 5.7rem;
                        height: 0.74rem;
                        line-height: 0.74rem;
                        background-color: #fde84d;
                        color: #333; 
                        font-size: 0.32rem;
                        text-align: center;
                        border-radius: 0.1rem;
                        margin: 0 auto;
                    }
                }
            }
        }
        .overlayer{
            position:fixed;
            left:0;
            top:0;
            width:100%;
            height:100%;
            z-index:10;
        }
        .tabNav{
            display: block;
        }
    }
</style>
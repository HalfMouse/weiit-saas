<template>
    <div class="recharge">
        <div class="recharge_box">
            <h6>充值金额</h6>
            <div class="price_box">
                <span>￥</span>
                <input type="number" placeholder="请输入金额" class="price" v-model="price">
            </div>
        </div>
        <a href="javascript:;" class="next" @click="next()">下一步</a>
        <pay-load v-show="isPay"></pay-load>
        <div class="overlayer" v-if="isPay" @touchmove.prevent></div>
    </div>
</template>

<script>
    // 引入UI组件
    import { Field,Toast } from 'mint-ui';
    import axios from 'axios'
    import qs from 'qs'
    import payLoad from '@/components/payLoad'
    export default {
        data() {
            return {
                price: '',
                isFlag:true,
                isPay:false
            }
        },
        methods: {
            next() {
                if(this.price > 0 && this.isFlag){
                    this.isPay = true;
                    this.isFlag = false
                    axios.post('/api/user/balanceRecharge',qs.stringify({
                        money:this.price
                    })).then((res) => {
                        let _this = this;
                        if(res.data.code == '0'){
                            wx.chooseWXPay({
                                timestamp: res.data.data.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                                nonceStr: res.data.data.nonceStr, // 支付签名随机串，不长于 32 位
                                package:  res.data.data.packageValue, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                                signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                                paySign: res.data.data.paySign, // 支付签名
                                success: function (res) {
                                    _this.isPay = false;
                                    _this.isFlag = true;
                                    _this.$router.push({
                                        path:'/rechargeDetail',
                                        name:'rechargeDetail',
                                        params:{
                                            money:_this.price
                                        }
                                    })
                                },
                                cancel:function(res){
                                    Toast('取消付款');
                                    _this.isPay = false;
                                    _this.isFlag = true;
                                }
                            });
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }else{
                    Toast('请输入正确金额');
                }
            }
        },
        components:{
            payLoad
        },
        beforeRouteEnter:(to,from,next)=>{
            var u = navigator.userAgent;
            //ios终端
            var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
            // XXX: 修复iOS版微信HTML5 History兼容性问题
            if (isiOS && to.path !== location.pathname) {
                // 此处不可使用location.replace
                location.assign(to.fullPath)
            } else {
                next()
            }
            axios.post('/weixin/JSSDKWxConfig',qs.stringify({
                currentUrl:location.href.split('#')[0],
                appid:localStorage.getItem('appid')
            })).then((res) => {
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: res.data.data.appId, // 必填，公众号的唯一标识
                    timestamp: res.data.data.timeStamp, // 必填，生成签名的时间戳
                    nonceStr: res.data.data.nonceStr, // 必填，生成签名的随机串
                    signature: res.data.data.signature,// 必填，签名
                    jsApiList: [ 
                                "onMenuShareTimeline",//分享朋友圈接口
                                "onMenuShareAppMessage",//分享给朋友接口    
                                "chooseWXPay"
                    ] // 必填，需要使用的JS接口列表
                });
            }).catch((err) => {
                console.log(err);
            })
            next();
        }
    }
</script>

<style scoped lang="scss">
    .recharge_box{
        background-color: #fff;
        padding: 0.2rem 0.2rem 0.3rem 0;
        h6{
            font-size: 0.28rem;
            color: #666;
            padding-left: 0.2rem;
            margin-bottom: 0.1rem;
        }
        .price_box{
            position: relative;
            .price{
                display: block;
                width: 6.7rem;
                margin:0 auto;
                border-bottom: 1px solid #ddd;
                font-size: 0.32rem;
                box-sizing: border-box;
                padding:0.2rem 0 0.2rem 0.2rem;
            }
            span{
                position: absolute;
                left: 0.2rem;
                top: 50%;
                transform: translateY(-50%);
                font-size: 0.3rem;
                color: #333;
            }
        }
    }
    .next{
        display: block;
        width: 6.9rem;
        color: #333;
        font-size: 0.32rem;
        margin: 0.25rem auto;
        background-color: #ffdc4b;
        line-height: 0.89rem;
        text-align: center;
        border-radius: 0.2rem;
    }
</style>
<template>
    <div class="free_get">
        <loading v-show="isLoading"></loading>
        <div v-show="!isLoading" class="showMain">
            <div class="bargain_money" v-show="isNum" @click="isNum = false" v-if="isHelp">
                <p>你已砍了<span>{{singleBargain}}</span>元啦,赶快分享给小伙伴一起愉快得砍价吧</p>
                <!-- <p>(分享成功后可以多砍一刀哦)</p> -->
                <span class="guide"></span>
            </div>
            <div class="main">
                <div class="main_top">
                    <div class="bargain_good">
                        <p class="rule" @click="lookRules">活动规则<i class="icon iconfont icon-weizhiyonghu"></i></p>
                        <div class="user">
                            <div class="user_icon">
                                <img :src="bargainProduct.user_img" alt="">
                            </div>
                            <span class="userName">{{bargainProduct.user_name}}</span>
                        </div>
                        <p class="find">我发现了一件好货,来一起低价拿吧</p>
                        <div class="goods_box fn-clear">
                            <div class="goods_pic">
                                <img :src="$url + bargainProduct.product_img" alt="">
                            </div>
                            <div class="goods_txt">
                                <h6>{{bargainProduct.product_name}}</h6>
                                <div class="total fn-clear">
                                    <p class="price">￥<span>{{bargainProduct.max_price}}</span></p>
                                    <p class="num" v-if="bargainProduct.total > 0">{{bargainProduct.total}}人已{{min_price}}元拿到</p>
                                    <p class="expressPrice">邮费{{this.expressPrice}}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p class="bargain_price">已砍<span>{{alreadyBargain}}</span>元,还能砍<span>{{surplusPrice}}</span>元</p>
                    <a href="javascript:;" class="share" @click="isNum = true" v-if="is_bargain_owner && surplusPrice > 0">分享给好友,帮你低价拿商品</a>
                    <a href="javascript:;" class="share" @click="helpBargain()" v-if="!is_bargain_owner && surplusPrice > 0">帮好友砍一刀</a>
                    <a href="javascript:;" class="share empty" v-if="surplusPrice == 0">已砍完</a>
                    <p class="times">还剩{{time}}结束,快来砍价吧~</p>
                </div>
                <div class="main_bottom">
                    <div class="help">
                        <h6>
                            <img src="static/images/bargain_line.png" alt="">
                            <span>砍价帮</span> 
                        </h6>
                        <div class="braginList">
                            <div class="bargain_help fn-clear" v-for="item in userBargainlog">
                                <div class="userInfo fn-clear">
                                    <div class="user_icon">
                                        <img :src="item.user_img" alt="">
                                    </div>
                                    <div class="personal">
                                        <span class="user_name">{{item.user_name}}</span>
                                        <span class="together">来一起砍价{{min_price}}元拿</span>
                                    </div>
                                </div>
                                <span class="cut_price">砍掉{{item.bargain_price}}元</span>
                            </div>
                        </div>
                    </div>
                    <!-- <ul class="bargain_list fn-clear">
                        <li>
                            <div class="goods_pic">
                                <img src="static/images/collection_img.png" alt="">
                            </div>
                            <div class="goods_txt">
                                <h6>邦购美特斯邦威2018a春装新款防风夹克男户外运动短外套</h6>
                                <div class="total fn-clear">
                                    <p class="price">￥<span>409</span></p>
                                    <p class="num">已砍666</p>
                                </div>
                            </div>
                        </li>
                    </ul> -->
                    <a href="javascript:;" class="check_out" v-if="is_bargain_owner" @click="bargainBuy">立即购买</a>
                </div>
                <text-nav></text-nav>
            </div>
            
            <rules ref="rules"></rules>
            <!-- 选择支付方式 -->
            <mt-popup v-model="payment" position="bottom">
                <div class="payment">
                    <ul>
                        <li @click="payment_type = 'wx'" v-if="wxPayAble">
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
                        <li @click="payment_type = 'balance'" v-if="balancePayAble">
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
                            <a href="javascript:;" @click="ensurePayment()">确定</a>
                        </li>
                    </ul>
                </div>
            </mt-popup>
            <pay-load  v-show="isPay"></pay-load>
            
        </div>
        <div class="overlayer" v-if="isPay" @touchmove.prevent></div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 引入倒计时
    import {downTime} from '../../../static/js/downTime'
    // 引入活动规则弹窗
    import rules from '../../components/rules'
    // 从mint-ui中调用Popup,MessageBox
    import {MessageBox,Toast} from 'mint-ui';
    // 引入获取参数函数
    import {getQueryString} from '../../../static/js/getQueryString';
    // 引入加载组件
    import loading from '@/components/loading'
    import payLoad from '@/components/payLoad'
    import cooike from '../../../static/js/cookies'
    import textNav from '@/components/textNav'
    export default {
        data(){
            return {
                isNum:true,
                order_id:this.$route.query.order_id,
                alreadyBargain:'',
                bargainProduct:{},
                hasBargain:true,
                owe:'',
                userBargainlog:[],
                bargain_id: this.$route.query.bargain_id,
                // 判断是否是发起者
                is_bargain_owner:true,
                time:'',
                payment_type:'wx',        //支付方式
                payment:false,
                isLoading:true,
                b_order_id:'',
                share_user_id:'',
                singleBargain:'',
                isHelp:true,
                isFlag:true,               //重复点击判断
                isPay:false,
                expressPrice:0,
                surplusPrice:0,
                balancePayAble: false,
                wxPayAble: false
            }
        },
        methods: {
            // 获取砍价信息
            getBargain(order_id) {
                // let b_order_id = localStorage.getItem('order_id');
                axios.post('/api/bargain/bargainPage',qs.stringify({
                    b_order_id:this.order_id,
                    bargain_id:this.bargain_id
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.isLoading = false;
                        // 已砍价格
                        this.alreadyBargain = res.data.data.alreadyBargain;
                        // 砍价信息
                        this.bargainProduct = res.data.data.bargainProduct;
                        
                        this.hasBargain = res.data.data.hasBargain;
                        this.owe = res.data.data.owe;
                        this.userBargainlog = res.data.data.userBargainlog;
                        this.singleBargain = this.userBargainlog[this.userBargainlog.length-1].bargain_price;
                        this.is_bargain_owner = res.data.data.is_bargain_owner;
                        if(this.is_bargain_owner){
                            this.share_user_id = localStorage.getItem('user_id')
                        }
                        // 邮费
                        this.expressPrice = res.data.data.expressPrice;
                        // 最低价格
                        this.min_price = this.bargainProduct.min_price;
                        // 剩余能砍价格
                        let surplus = this.bargainProduct.max_price - this.bargainProduct.min_price - parseFloat(this.alreadyBargain);
                        this.surplusPrice = parseFloat(surplus) > 0 ? parseFloat(surplus).toFixed(2) : 0;
                        // localStorage.setItem('shareBargainGoodImage', this.bargainProduct.product_img);
                        // localStorage.setItem('shareBargainGoodName', this.bargainProduct.product_name);
                        this.share(this.order_id, this.bargain_id, this.share_user_id, this.$url + this.bargainProduct.product_img, this.bargainProduct.product_name);
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 倒计时
            countdDown(){
                // let times = null;
                setInterval(() => {
                    let nowTime = new Date().getTime();
                    let targetTime = this.bargainProduct.end_time - nowTime;
                    this.time = downTime(targetTime);
                },1000)
            },
            // 查看规则
            lookRules(){
                this.$refs.rules.show();
            },
            // 砍价购买
            bargainBuy(){
                this.payment = true;
                
            },
            // 确定购买
            ensurePayment(){
                let pay_price = parseFloat(this.owe) + parseFloat(this.expressPrice);
                this.payment = false;
                if(this.owe >= 0 && this.isFlag){
                    this.isFlag = false;
                   
                    let _this = this;
                    if(this.payment_type == 'wx'){
                        if(this.wxPayAble){
                            // 微信支付
                            this.isPay = true;
                            axios.post('/api/bargain/bargainPay', qs.stringify({
                                payment_type:'0',
                                b_order_id:this.order_id,
                                pay_price: pay_price
                            })).then((res) => {
                                wx.chooseWXPay({
                                    timestamp: res.data.data.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                                    nonceStr: res.data.data.nonceStr, // 支付签名随机串，不长于 32 位
                                    package:  res.data.data.packageValue, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                                    signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                                    paySign: res.data.data.paySign, // 支付签名
                                    success: function (res) {
                                        _this.$router.push({
                                            path:'/buySuccess',
                                            name:'buySuccess',
                                            query:{
                                                goodPrice: pay_price,
                                                buy_type:'微信'
                                            }
                                        })
                                        _this.isFlag = true;
                                        _this.isPay = true;
                                    },
                                    cancel: function(res){
                                        _this.$router.push({
                                            path:'/teams',
                                            name:'teams',
                                            params:{
                                                type:'bargain'
                                            }
                                        })
                                    }
                                });
                            }).catch((err) => {
                                console.log(err);
                            })
                        }else{
                            Toast('暂不支持微信支付，请选择其他支付方式');
                        }
                        
                    }else if(this.payment_type == 'balance'){
                        if(this.balancePayAble){
                            this.isPay = true;
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
                                    axios.post('/api/bargain/bargainPay', qs.stringify({
                                        payment_type:'1',
                                        b_order_id:this.order_id,
                                        pay_price:pay_price
                                    })).then((res) => {
                                        if(res.data.code == '0'){
                                            this.isPay = false;
                                            this.$router.push({
                                                path:'/buySuccess',
                                                name:'buySuccess',
                                                query:{
                                                    goodPrice:pay_price,
                                                    buy_type:'余额'
                                                }
                                            })
                                        }else{
                                            Toast(res.data.message);
                                        }
                                        this.isFlag = true
                                    }).catch((err) => {

                                    })
                                }
                            }).catch((err) => {
                                if (err == 'cancel') {
                                    Toast('取消付款');
                                    this.isFlag = true;
                                    this.isPay = false;
                                }
                            });
                        }else{
                            Toast('暂不支持余额支付，请选择其他支付方式');
                        }
                        
                    }
                }else{
                    Toast('正在付款中，请耐心等待');
                }
            },
            // 分享
            share(order_id, bargain_id, share_user_id, imgUrl, title){
               let host = document.location.hostname;
                let protocol = document.location.protocol;  
                let user_id = localStorage.getItem('user_id');
                let currentUrl = `${protocol}//${host}`; 
                // let title = localStorage.getItem('shareBargainGoodName');
                // let imgUrl = this.$url + localStorage.getItem('shareBargainGoodImage');
                let url = currentUrl + "/freeGet?order_id=" + order_id + "&bargain_id=" + bargain_id + "&share_user_id=" + share_user_id + "&forward=freeGet";
                wx.ready(function(res) {
                    wx.onMenuShareAppMessage({
                        title: title,
                        desc: '',
                        link: url,
                        imgUrl: imgUrl,
                        trigger: function(res) {},
                        cancel: function(res) {},
                        fail: function(res) {}
                    });
                    wx.onMenuShareTimeline({
                        title: title,
                        desc:"",
                        link: url,
                        imgUrl: imgUrl,
                        trigger: function(res) {},
                        success: function(res) {},
                        cancel: function(res) {},
                        fail: function(res) {}
                    });
                });
            },
            // 帮砍
            helpBargain(){
                if(this.hasBargain){
                    Toast('您已经帮助了你好友')
                }else{
                    axios.post('/api/bargain/helpBargain', qs.stringify({
                        b_order_id:this.b_order_id,
                        share_user_id:this.share_user_id
                    })).then((res) => {
                        if(res.data.code == '0'){
                            let msg = res.data.data;
                            this.isHelp = true;
                            this.getBargain(this.b_order_id);
                        }
                    }).catch((err) => {
                        console.log(err);
                    }) 
                    
                }
                
            },
            // 获取是否允许的支付方式
            getPayAble(){
                axios.post('/api/product/paymentTypeInfo', null)
                    .then(res => {
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
        created(){
            
        },
        mounted(){
            this.countdDown();
            if(getQueryString('order_id') != undefined){
                this.isHelp = false;
                this.b_order_id = getQueryString('order_id');
                this.bargain_id = getQueryString('bargain_id');
                this.share_user_id = getQueryString('share_user_id');
                
                this.order_id = this.b_order_id;
                this.getBargain(this.b_order_id);
            }else if(localStorage.getItem('forward') == 'freeGet'){
                this.isHelp = false;
                const urlObj = (JSON.parse(localStorage.getItem('urlObject')));
                this.b_order_id = urlObj.order_id;
                this.share_user_id = urlObj.share_user_id;
                this.bargain_id = urlObj.bargain_id;
                this.order_id = this.b_order_id;
                this.getBargain(this.b_order_id);
            }else{
                this.getBargain(this.order_id);
            }
            
        },
        components:{
            rules,
            loading,
            payLoad,
            textNav  
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
        },
    }
</script>

<style scoped lang="scss">
    .free_get{
        min-height: 100%;
        background-color: #FFF7D3;
        .bargain_money{
            position: fixed;
            width: 100%;
            height: calc(100% - 2rem);
            left: 0;
            top: 0;
            text-align: center;
            background-color: rgba(0, 0, 0, .7);
            padding-top: 2.4rem;
            z-index: 100;
            color: #fff;
            font-size: 0.36rem;
            p{
                padding: 0 0.3rem;
                width: 5rem;
                margin: 0 auto 0.1rem;
                span{
                    font-size: 1rem;
                    color: #ff0700;
                    font-weight: bold;
                }
            }
            .guide{
                position:absolute;
                right: 0.65rem;
                top: 0.5rem;
                width: 2rem;
                height: 1.87rem;
                background-image: url('../../../static/images/guide.png');
                background-size: 100% 100%;
            }  
        }
        .main{
            height: 100%;
            .main_top{
                width: 7.5rem;
                height: 5.87rem;
                background-image: url('../../../static/images/bargain.jpg');
                background-size: 100% 100%;
                padding-top: 0.95rem;
                .bargain_good{
                    position: relative;
                    width: 6.7rem;
                    height: 2.48rem;
                    background-color: #fff;
                    border-radius: 0.1rem;
                    margin: 0 auto;
                    padding-top: 1.2rem;
                    .rule{
                        position: absolute;
                        right: 0.1rem;
                        top: 0.1rem;
                        border: 1px solid #ddd;
                        font-size: 0.26rem;
                        line-height: 0.34rem;
                        padding: 0 0.05rem 0 0.1rem;
                        border-radius: 0.1rem;
                        i{
                            display: inline-block;
                            font-size: 0.26rem;
                            margin-left: 0.05rem;
                        }
                    }
                    .user{
                        width: 1.38rem;
                        position: absolute;
                        left: 50%;
                        top:-0.69rem;
                        margin-left: -0.69rem;
                        .user_icon{
                            width: 1.38rem;
                            height: 1.38rem;
                            border-radius: 50%;
                            overflow: hidden;
                            img{
                                width: 100%;
                                height: 100%;
                            }
                        }
                        .userName{
                            display: block;
                            font-size: 0.28rem;
                            color: #666;
                            text-align: center;
                        }
                    }
                    .find{
                        font-size: 0.28rem;
                        color:#333;
                        text-align: center;
                    }
                    .goods_box{
                        width: 6.16rem;
                        background-color: #f5f5f5;
                        margin: 0.3rem auto 0;
                        padding: 0.1rem;
                        position: relative;
                        .goods_pic{
                            float: left;
                            width: 1.43rem;
                            height: 1.43rem;
                            img{
                                width: 100%;
                                height: 100%;
                            }
                        }
                        .goods_txt{
                            float: left;
                            width: 4.5rem;
                            margin-left: 0.15rem;
                            h6{
                                font-size: 0.28rem;
                                color: #333;
                                width: 4.4rem;
                                display: -webkit-box;
                                /*! autoprefixer: off */
                                -webkit-box-orient: vertical;
                                /* autoprefixer: on */
                                -webkit-line-clamp: 2;
                                overflow: hidden;
                            }
                            .total{
                                position: absolute;
                                bottom: 0.1rem;
                                left: 1.65rem;
                                .price{
                                    float: left;
                                    font-size: 0.28rem;
                                    color: #ec534e;
                                    display:table-cell;   
                                    vertical-align:bottom;
                                    span{
                                        font-size: 0.34rem;
                                    }
                                }
                                .num{
                                    font-size: 0.24rem;
                                    color: #aaa;
                                    float: left; 
                                    vertical-align:bottom;
                                    margin-left: 0.1rem;
                                    margin-top: 0.03rem;
                                }
                                .expressPrice{
                                    font-size: 0.24rem;
                                    color: #aaa;
                                    float: left;  
                                    vertical-align:bottom;
                                    margin-left: 0.7rem;
                                }
                            }
                        }
                    }
                }
                .bargain_price{
                    font-size: 0.28rem;
                    color: #eb423d;
                    text-align: center;
                    margin: 0.1rem 0;
                    span{
                        font-weight: bold;
                        font-size: 0.44rem;
                    }
                }
                .share{
                    display: block;
                    width: 5.7rem;
                    height: 0.73rem;
                    background-color: #fde84d;
                    text-align: center;
                    line-height: 0.73rem;
                    border-radius: 0.1rem;
                    color: #eb423d;
                    font-size: 0.32rem;
                    margin: 0 auto;
                    &.empty{
                        background-color: #ddd;
                        color: #333;
                    }
                }
                .times{
                    font-size: 0.28rem;
                    color: #eb423d;
                    text-align: center;
                    margin-top: 0.1rem;
                }
            }
            .main_bottom{
                background-color: #FFF7D3;
                padding-bottom: 0.2rem;
                .help{
                    width: 6.6rem;
                    padding: 0.2rem 0.05rem 0.1rem;
                    background-color: #F7EBC7;
                    margin: 0 auto;
                    h6{
                        position: relative;
                        margin-bottom: 0.4rem;
                        img{
                            position: absolute;
                            width: 96%;
                            left: 50%;
                            transform: translateX(-50%);
                            top: 0.15rem;
                        }
                        span{
                            position: absolute;
                            font-size: 0.28rem;
                            color: #333;
                            left: 50%;
                            transform: translateX(-50%);
                        }
                    }
                    .bargain_help{
                        padding: 0 0.2rem;
                        margin-bottom: 0.2rem;
                        .userInfo{
                            float: left;
                            .user_icon{
                                float: left;
                                width: 1.16rem;
                                height: 1.16rem;
                                border-radius: 50%;
                                overflow: hidden;
                                img{
                                    width: 100%;
                                    height: 100%;
                                }
                            }
                            .personal{
                                float: left;
                                margin-top: 0.25rem;
                                margin-left: 0.1rem;
                                span{
                                    display: block;
                                    font-size: 0.28rem;
                                    margin-bottom: 0.05rem;
                                }
                            }
                        }
                        .cut_price{
                            float: right;
                            font-size: 0.28rem;
                            color: #eb423d;
                            margin-top: 0.35rem;
                        }
                    }
                }
                // .bargain_list{
                //     padding: 0.2rem;
                //     li{
                //         float: left;
                //         width:3.3rem;
                //         background-color: #fff;
                //         margin-right: 0.1rem;
                //         margin-bottom: 0.1rem;
                //         padding: 0.1rem;
                //         &:nth-child(even){
                //             margin-right: 0;
                //         }
                //         .goods_pic{
                //             width: 2.6rem;
                //             height: 2.6rem;
                //             margin: 0 auto 0.15rem;
                //             img{
                //                 width: 100%;
                //                 height: 100%;
                //             }
                //         }
                //         .goods_txt{
                //             float: left;
                //             width: 4.5rem;
                //             margin-left: 0.15rem;
                //             h6{
                //                 font-size: 0.24rem;
                //                 color: #333;
                //                 width: 3rem;
                //                 overflow : hidden;
                //                 text-overflow: ellipsis;
                //                 display: -webkit-box;
                //                 -webkit-line-clamp: 2;
                //                 -webkit-box-orient: vertical;
                //             }
                //             .total{
                //                 width: 3rem;
                //                 margin-top: 0.15rem;
                //                 line-height: 21px;
                //                 .price{
                //                     float: left;
                //                     font-size: 0.28rem;
                //                     color: #ec534e;
                //                     span{
                //                         font-size: 0.34rem;
                //                     }
                //                 }
                //                 .num{
                //                     float: right;
                //                     font-size: 0.24rem;
                //                     color: #aaa;
                //                 }
                //             }
                //         }
                //     }
                // }
            }
        }
        .check_out{
            display: block;
            width: 5.7rem;
            height: 0.74rem;
            background-color: #fde84d;
            color: #eb423d;
            font-size: 0.32rem;
            text-align: center;
            line-height: 0.74rem;
            border-radius: 0.1rem;
            margin: 0.2rem auto 0;
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
    }
</style>
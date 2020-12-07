<template>
    <div class="shopCart">
        <loading v-show="isLoading"></loading>
        <div v-show="!isLoading">
            <!-- 收件人信息 -->
            <div class="user_information remarks">
                <ul>
                    <li @click="consignee">
                        <h5 v-if="!recipients">请选择收件人信息</h5>
                        <div v-else class="recipients">
                            <p class="recipients_person">
                                <span>{{recipients.consignee}}</span>
                                <span>{{recipients.phone}}</span>
                            </p>
                            <p class="recipients_address">{{recipients.province}}{{recipients.city}}{{recipients.district}}{{recipients.address_detail}}</p>
                        </div>
                        <i class="icon iconfont icon-youjiantouda"></i>
                    </li>
                </ul>
                <i class="icon iconfont icon-dizhi"></i>
            </div>
            <div class="shop_goods">
                <!-- 购物车物品列表信息 -->
                <ul>
                    <li>
                        <div class="goods_information clearfix">
                            <div class="goods_pic">
                                <img :src="$url + productInfo.product_img" alt="">
                            </div>
                            <div class="goods_main">
                                <h6>{{productInfo.product_name}}</h6>
                                <p>{{spec_content}}</p>
                                <!-- <p>{{productInfo}}</p> -->
                                <span>￥{{groupon_price}}</span>
                                <i class="express_money">邮费：{{express_money}}</i>
                            </div>
                            <div class="goods_number">
                                <div href="javascript:;" class="reduce" @click="reduce($event)">
                                    <i class="icon iconfont icon-jian1"></i>
                                </div>
                                <input class="num" v-model="goodsNumber" type="num" maxlength="3">
                                <div href="javascript:;" class="add" @click="add($event)">
                                    <i class="icon iconfont icon-jia1"></i>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 选择支付方式 -->
            <div class="payment">
                <ul>
                    <li @click="setBuyType('wx')">
                        <label class="mint-radiolist-label">
                            <span class="mint-radio">
                                <input type="radio" class="mint-radio-input" value="wx" v-model="setCost"> 
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
                    <li @click="setBuyType('balance')" v-if="balancePayAble">
                        <label class="mint-radiolist-label">
                            <span class="mint-radio">
                                <input type="radio" class="mint-radio-input" value="balance" v-model="setCost"> 
                                <span class="mint-radio-core"></span>
                            </span> 
                        </label>
                        <div class="cost_pic">
                            <img src="static/images/balance.png" alt="">
                        </div>
                        <div class="cost_way">
                            <h6>余额支付</h6>
                            <p>请确保账户余额充足</p>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 底部信息 -->
            <footer>
                <div class="price">
                    <h4>实付款：<span>￥{{(groupon_price * goodsNumber) + express_money}}</span></h4>
                    <p>总额：￥{{(groupon_price * goodsNumber) + express_money}}</p>
                </div>
                <!-- <a href="javascript:;" @click="share = true">找人代付</a> -->
                <a href="javascript:;" @click="submit('launch')" v-if="costMent == 'launch'" :style="{background:color1,color:'#fff'}">发起拼团</a>
                <a href="javascript:;" @click="submit('partake')" v-if="costMent == 'partake'" :style="{background:color1,color:'#fff'}">立即支付</a>
            </footer>
            <pay-load v-show="isPay"></pay-load>
            <!-- 找人代付弹出框 -->
            <!-- <mt-popup v-model="share" position="bottom">
                <div class="share">
                    <h5>发送给朋友</h5>
                    <i class="icon iconfont icon-cha close" @click="share = false"></i>
                    <ul>
                        <li>
                            <div class="share_icon">
                                <img src="static/images/qq.png" alt="">
                            </div>
                            <p>QQ好友</p>
                        </li>
                        <li>
                            <div class="share_icon">
                                <img src="static/images/wx1.png" alt="">
                            </div>
                            <p>微信好友</p>
                        </li>
                        <li>
                            <div class="share_icon">
                                <img src="static/images/dx.png" alt="">
                            </div>
                            <p>发送短信</p>
                        </li>
                    </ul>
                </div>
            </mt-popup> -->
        </div>
        <div class="overlayer" v-if="isPay" @touchmove.prevent></div>
    </div>
</template>

<script>
    // 引入底部导航组件
    import NavFooter from '@/components/footer'
    // 引入数量计算组件
    import calculations from '@/components/calculations'
    // 从mint-ui中调用Popup,MessageBox
    import { Popup,MessageBox,Toast } from 'mint-ui';
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    // 引入加载组件
    import loading from '@/components/loading'
    import payLoad from '@/components/payLoad'
    export default {
        data(){
            return {
                setCost:'wx',
                share:false,
                mode:false,
                recipients:null,
                value:[],
                choices:[],
                saleMessage:'',
                productInfo:null,
                costMent:'',
                defaultAddress:null,
                goodsNumber:1,
                address_id:'',
                share_user_id:'',
                g_order_id: 0,
                pay_price:0,
                express_money:0,
                isLoading:true,
                isFlag:true,
                stock:0,
                groupon_price:0,
                max_limit:null,
                isPay:false,
                spec_content:'',
                color1:'',
                balancePayAble:false,
                wxPayAble:false
            }
        },
        methods:{
            // 获取传递过来的信息
            getData(){
                this.productInfo = JSON.parse(localStorage.getItem('productInfo'));
                this.costMent = localStorage.getItem('costMent');
                this.goodsNumber = localStorage.getItem('goodsNumber');
                this.share_user_id = localStorage.getItem('share_user_id');
                this.groupon_price = localStorage.getItem('groupon_price');
                this.max_limit = localStorage.getItem('maxLimit');
                this.stock = localStorage.getItem('product_stock');
                this.spec_content = localStorage.getItem('spec_content');
                this.color1 = localStorage.getItem('bg1');
                this.g_order_id = localStorage.getItem('g_order_id');
            },
            // 选择收件人信息
            consignee(){
                let length;
                axios.post('/api/user/myAddressList',null)
                    .then((res) => {
                        if(res.data.code == '0'){
                           length = res.data.data.list.length;
                            if(length > 0){
                                this.$router.push({
                                    path:'/address',
                                    name:'address'
                                })
                            }else{
                                this.$router.push({
                                    path:'/addSite',
                                    name:'addSite'
                                })  
                            }
                            localStorage.setItem('addressRootly','fightShop')
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
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
            },
            // 发起拼团
            submit(type){
                let groupon_id = localStorage.getItem('groupon_id');
                let product_id = this.productInfo.product_id;
                // 用户下单的收货地址ID
                let address_id = this.address_id;
                // 支付方式
                let payment_type = this.paymentType();
                // 拼团数量
                let count = this.goodsNumber;
                // 计算总价   
                let pay_price = this.groupon_price * this.goodsNumber;
                // 参与拼团的ids
                let item_id = localStorage.getItem('item_id');
                let _this = this;
                if(address_id){
                    if(type == 'launch'){
                        // 微信支付
                        if(payment_type == '0'){
                            if(this.isFlag && this.wxPayAble){
                                this.isFlag = false;
                                this.isPay = true;
                                axios.post('/api/groupon/startGroupon',qs.stringify({
                                    groupon_id:groupon_id,
                                    product_id:product_id,
                                    pay_price:pay_price,
                                    item_id:item_id,
                                    address_id:this.address_id,
                                    count:count,
                                    payment_type:payment_type
                                })).then((res) => {
                                    if(res.data.code == '0'){
                                        localStorage.setItem('shareInvalutionName', this.productInfo.product_name);
                                        localStorage.setItem('shareInvalutionImage', this.productInfo.product_img);
                                        let g_order_id = res.data.data.g_order_id;
                                        wx.chooseWXPay({
                                            timestamp: res.data.data.payInfo.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                                            nonceStr: res.data.data.payInfo.nonceStr, // 支付签名随机串，不长于 32 位
                                            package:  res.data.data.payInfo.packageValue, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                                            signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                                            paySign: res.data.data.payInfo.paySign, // 支付签名
                                            success: function (res) {
                                                _this.isFlag = true;
                                                _this.isPay = false;
                                                _this.$router.push({
                                                    path:'/invitation',
                                                    name:'invitation',
                                                    query:{
                                                        partakeType:'launch',
                                                        g_order_id:g_order_id
                                                    }
                                                })
                                            },
                                            cancel: function(res){
                                                _this.isFlag = true;
                                                _this.isPay = false;
                                                Toast('未支付完成，请重新支付');
                                            }
                                        });
                                        
                                    }else{
                                        Toast(res.data.message);
                                        _this.isFlag = true;
                                        _this.isPay = false;
                                    }
                                }).catch((err) => {
                                    console.log(err)
                                })
                            }else{
                                Toast('不支持微信支付，请选择其他支付方式')
                            }
                        }else if(payment_type == '1'){
                            if(this.isFlag && this.balancePayAble){
                                // 余额支付
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
                                        this.isFlag = false;
                                        this.isPay = true;
                                        axios.post('/api/groupon/startGroupon',qs.stringify({
                                            groupon_id:groupon_id,
                                            product_id:product_id,
                                            pay_price:pay_price,
                                            item_id:item_id,
                                            address_id:this.address_id,
                                            count:count,
                                            payment_type:payment_type
                                        })).then((res) => {
                                            if(res.data.code == '0'){
                                                localStorage.setItem('shareInvalutionName', this.productInfo.product_name);
                                                localStorage.setItem('shareInvalutionImage', this.productInfo.product_img);
                                                let g_order_id = res.data.data.g_order_id
                                                this.$router.push({
                                                    path:'/invitation',
                                                    name:'invitation',
                                                    query:{
                                                        partakeType:'launch',
                                                        g_order_id:g_order_id
                                                    }
                                                })
                                                this.isPay = false;
                                                this.isFlag = true;
                                            }else{
                                                Toast(res.data.message);
                                                this.isPay = false;
                                                this.isFlag = true;
                                            }
                                            
                                        }).catch((err) => {
                                            console.log(err);
                                            this.isPay = false;
                                        })
                                    }
                                }).catch((err) => {
                                    if (err == 'cancel') {
                                        Toast('未支付完成，请重新支付');
                                        this.isFlag = true;
                                        
                                    }
                                });
                            }else{
                                Toast('不支持余额支付，请选择其他支付方式');
                            }
                        }
                    }else{  
                        // 微信支付
                        if(payment_type == '0' && this.wxPayAble){
                            if(this.isFlag){
                                this.isFlag = false;
                                this.isPay = true;
                                axios.post('/api/groupon/joinGroupon',qs.stringify({
                                    groupon_id:groupon_id,
                                    product_id:product_id,
                                    pay_price:pay_price,
                                    item_id:item_id,
                                    address_id:address_id,
                                    count:count,
                                    payment_type:payment_type,
                                    share_user_id:this.share_user_id,
                                    g_order_id:this.g_order_id
                                })).then((res) => {
                                    let g_order_id = res.data.data.g_order_id;
                                    wx.chooseWXPay({
                                        timestamp: res.data.data.payInfo.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                                        nonceStr: res.data.data.payInfo.nonceStr, // 支付签名随机串，不长于 32 位
                                        package:  res.data.data.payInfo.packageValue, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                                        signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                                        paySign: res.data.data.payInfo.paySign, // 支付签名
                                        success: function (res) {
                                            _this.isFlag = true;
                                            _this.isPay = false;
                                            _this.$router.push({
                                                path:'/invitation',
                                                name:'invitation',
                                                query:{
                                                    partakeType:'partake',
                                                    g_order_id:g_order_id
                                                }
                                            })
                                        },
                                        cancel: function(res){
                                            _this.isFlag = true;
                                            _this.isPay = false;
                                            Toast('未支付完成，请重新支付');
                                        }
                                    });
                                }).catch((err) => {
                                    console.log(err)
                                })
                            }
                        }else if(payment_type == '1' && this.isFlag){
                            if(this.isFlag && this.balancePayAble){
                                // 余额支付
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
                                        this.isFlag = false;
                                        this.isPay = true;
                                        axios.post('/api/groupon/joinGroupon',qs.stringify({
                                            groupon_id:groupon_id,
                                            product_id:product_id,
                                            pay_price:pay_price,
                                            item_id:item_id,
                                            address_id:address_id,
                                            count:count,
                                            payment_type:payment_type,
                                            share_user_id:this.share_user_id,
                                            g_order_id:this.g_order_id
                                        })).then((res) => {
                                            if(res.data.code == '0'){
                                                let g_order_id = res.data.data.g_order_id;
                                                this.isFlag = true;
                                                this.isPay = false;
                                                this.$router.push({
                                                    path:'/invitation',
                                                    name:'invitation',
                                                    query:{
                                                        partakeType:'partake',
                                                        g_order_id:g_order_id
                                                    }
                                                })
                                            }else{
                                                Toast(res.data.message);
                                                this.isFlag = true;
                                                this.isPay = false;
                                            }
                                            
                                        }).catch((err) => {

                                        })
                                    }
                                }).catch((err) => {
                                    if (err == 'cancel') {
                                        Toast('未支付完成，请重新支付');
                                        
                                    }
                                });
                            }
                        }
                    }
                }else{
                    Toast('请选择收货地址！');
                }
                
            },
            stopLook(e){
                e.stopPropagation();
            },
            // 支付方式
            paymentType(){
                let payment_type;
                switch(this.setCost){
                    case 'wx': 
                        payment_type = '0';
                        break;
                    case 'zfb': 
                        payment_type = '2';
                        break;
                    case 'balance':
                        payment_type = '1';
                        break;
                }
                return payment_type;
            },
            // 获取地址信息
            getAddress(){
                axios.post('/api/user/myAddressList',null)
                    .then((res) => {
                        if(res.data.code == '0'){
                            
                            let address = res.data.data.list;
                            this.isLoading = false
                            address.forEach((item) => {
                                if(item.is_default == 0){
                                    this.recipients = item;
                                    this.address_id = item.id;
                                }
                            })
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            },
            // 增加商品数量
            add(e){
                let totalCount;
                if(this.stock > this.max_limit && this.max_limit > 0){
                    totalCount = this.max_limit;
                }else{
                    totalCount = this.stock;
                }
                if(this.goodsNumber < totalCount){
                    if(this.goodsNumber > 99){
                        this.goodsNumber = 99;
                    }else{
                        this.goodsNumber++;
                    }
                }else{
                    this.goodsNumber = totalCount;
                    Toast('你已经添加到商品数量上限，请不要再添加商品')
                }
                this.postaging();
            },
            // 减少商品数量
            reduce(e){
                
                if(this.goodsNumber <= 1){
                    this.goodsNumber = 1;
                }else{
                    this.goodsNumber--;
                }
                this.postaging();
            },
            // 选择支付方式
            setBuyType(type){
                this.setCost = type;
            },
            // 邮费计算
            postaging(){
                axios.post('/api/product/calcExpressPriceForActivity',qs.stringify({
                    product_id:this.productInfo.product_id,
                    count:this.goodsNumber,
                    address_id:this.address_id
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.express_money = res.data.data.expressPrice;
                    }
                }).catch((err) => {
                    console.log(err);
                })
            }
        },
        components:{
            NavFooter,
            calculations,
            loading,
            payLoad
        },
        created(){
            this.getAddress();
            this.getData();
            this.getPayAble();
        },
        beforeRouteEnter:(to,from,next)=>{
            if(from.name === 'address' || from.name === 'addSite'){

            }else{
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
                                    "startRecord",
                                    "stopRecord",
                                    "onVoiceRecordEnd",
                                    "playVoice",
                                    "chooseWXPay"
                        ] // 必填，需要使用的JS接口列表
                    });
                }).catch((err) => {
                    console.log(err);
                })
            next();
        },
        activated:function(){
            this.isPay = false;
            if(this.$route.params.toFightshop == 'address' || this.$route.params.toFightshop == 'addSide'){
                this.recipients = JSON.parse(localStorage.getItem('fightRecipients')); 
                this.address_id = localStorage.getItem('address_id');
            }else{
                this.getAddress();
            }
            this.postaging();
            window.onresize = () => {
                return (() => {
                    window.screenHeight = document.body.clientHeight;
                    this.showHeight = window.screenHeight;
                    this.changeHeight = this.showHeight
                })()
            }
        }

    }
</script>

<style scoped lang="scss">
.goods_number{
        position: absolute;
        right: 0.1rem;
        bottom: 0.18rem;
        text-align: center;
        line-height: 0.42rem;
        div{
            float: left;
            width: 0.49rem;
            height: 0.42rem;
            box-sizing: border-box;
            border: 1px solid #C8C8C8;
            font-size: 0.34rem;
            color: #666;
            .icon{
                display: block;
                font-size: 0.34rem;
                color: #666;
            }
        }
        input{
            float: left;
            width: 0.7rem;
            height: 0.42rem;
            box-sizing:border-box;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            font-size: 0.28rem;
            color: #444;
            text-align: center;
            line-height: 0.42rem;
            background-color: #fff;
            &.numInp{
                background-color: #FAFAFA;
            }
        }
    }
    .shopCart{
        .shop_goods{
            margin-bottom: 2px;
            ul{
                li{ 
                    header{
                        line-height: 0.56rem;
                        background-color: #fff;
                        color:#333;
                        font-size: 0.24rem;
                        padding-left: 0.2rem;
                        i{
                            font-size: 0.24rem;
                            color: #666;
                            display: inline-block;
                            margin-left: 0.2rem;
                        }
                    }
                    .goods_information{
                        position: relative;
                        background-color: #f5f5f5;
                        padding:0.2rem 0;
                        .mint-radiolist-label{
                            position: absolute;
                            top: 50%;
                            transform: translateY(-60%);
                            .mint-radio-core{
                                position: relative;
                                .icon-dui{
                                    position: absolute;
                                    font-size: 0.14rem;
                                    color: #fff;
                                    left: 50%;
                                    top: 50%;
                                    transform: translate(-50%,-50%);
                                    z-index: 999;
                                }
                            }
                            .mint-radio-input:checked + .mint-radio-core{
                                background-color: #fafafa;
                                border:1px solid #EC534E;
                                
                                &::after{
                                    background-color: #EC534E;
                                    width: 100%;
                                    height:100%;
                                    left: 0;
                                    top: 0
                                }
                            }
                        }
                        .goods_pic{
                            float: left;
                            width: 2rem;
                            height: 2rem;
                            margin-left: 0.3rem;
                            img{
                                width: 100%;
                                height: 100%;
                            }
                        }
                        .goods_main{
                            float: left;
                            width: 4.5rem;
                            margin-left: 0.3rem;
                            h6{
                                color: #333;
                                font-size: 0.32rem;
                                display: -webkit-box;
                                /*! autoprefixer: off */
                                -webkit-box-orient: vertical;
                                /* autoprefixer: on */
                                -webkit-line-clamp: 2;
                                overflow: hidden;
                            }
                            p{
                                font-size: 0.26rem;
                                color: #666;
                                height: 0.3rem;
                                margin-top: 0.05rem;
                            }
                            span{
                                position: absolute;
                                bottom: 0.21rem;
                                left: 2.6rem;
                                color: #ff3461;
                                font-size: 0.32rem;
                            }
                            .express_money{
                                font-style: normal;
                                position: absolute;
                                bottom: 0.21rem;
                                left: 4rem;
                                color: #666;
                                font-size: 0.32rem;
                            }
                        }
                        .del_shop_goods{
                            position: absolute;
                            right: 0;
                            top: 0.2rem;
                            width: 0.48rem;
                            height: 0.31rem;
                            background-color: #d7d7d7;
                            border-radius: 0.16rem 0 0 0.16rem;
                            padding-left: 0.15rem;
                            line-height: 0.31rem;
                            i{
                                font-size: 0.2rem;
                                color: #fff;
                                display: block;
                            }
                        }
                        .count{
                            top: 1.75rem;
                            right: 0.3rem;
                        }
                    }
                }
            }
            .goods_cost{
                background-color: #fff;
                padding:0.2rem 0.3rem;
                h5{
                    float: left;
                    font-size: 0.32rem;
                    color: #333;
                }
                div{
                    float: right;
                    font-size: 0.32rem;
                    color: #999;
                    span{
                        color: #ec534e;
                    }
                    &.money{
                        color:#EC534E;
                    }
                }
            }
        }
        .remarks{
            background-color: #fff;
            ul{
                li{
                    padding:0.2rem 0.3rem;
                    border-bottom: 2px solid #f5f5f5;
                    overflow: hidden;
                    &:last-child{
                        border:none 0;
                    }
                    h5{
                        float: left;
                        color: #ccc;
                        font-size: 0.36rem;
                        padding: 0.2rem 0
                    }
                    p{
                        float: right;
                        font-size: 0.32rem;
                        color: #999;
                        i{
                           font-size: 0.3rem;
                           color: #666;
                           display: inline-block;
                           margin-left: 0.2rem; 
                        }
                    }
                    .sale_message{
                        float: left;
                        width: 70%;
                        font-size: 0.3rem;
                        line-height: 0.4rem;
                    }
                }
            }
        }
        .user_information{
            position: relative;
            padding-left: 0.6rem;
            .icon-dizhi{
                position: absolute;
                left: 0.3rem;
                top: 50%;
                font-size: 0.4rem;
                color: #999;
                transform: translateY(-50%);
            }
            ul{
                li{
                    position: relative;
                    .icon{
                        position: absolute;
                        top: 50%;
                        right: 0.22rem;
                        transform: translateY(-50%);
                        color: #666;
                        font-size: 0.3rem;
                       
                    }
                    .recipients{
                        float: left;
                        text-align: left;
                        color: #333;
                        width: 5.5rem;
                        p{
                            float: left;
                            color: #333;
                            font-size: 0.3rem;
                            width: 100%;
                        }
                    }
                }
            }
        }
        .payment{
            margin-top: 0.2rem;
            background-color: #fff;
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
                            font-size: 0.32rem;
                            color: #333;
                        }
                        p{
                            color: #999;
                            font-size: 0.26rem;
                        }
                    }
                }
            }
        }
        footer{
            position: fixed;
            bottom: 0;
            left: 0;
            height: 1rem;
            box-sizing: border-box;
            border-top: 1px solid #e7e7e7;
            .price{
                float: left;
                width: 5.6rem;
                padding-left: 0.2rem;
                background-color: #fff;
                height: 100%;
                h4{
                    font-size: 0.36rem;
                    color: #333;
                    margin-top: 0.05rem;
                    span{
                        display: inline-block;
                        font-weight: bold;
                        color: #ec534e;
                    }
                }
                p{
                    color: #999;
                    font-size: 0.32rem;
                }
            }
            a{
                float: left;
                width: 1.7rem;
                height: 1rem;
                text-align: center;
                line-height: 1rem;
                font-size: 0.36rem;
                background-color: #FFDC4B;
                color: #333;
                &:last-child{
                    color: #fff;
                    background-color: #EC534E;
                }
            }
        }
        .share{
            padding: 0.2rem 0;
            h5{
                font-size: 0.34rem;
                color: #333;
                text-align: center;
                margin-bottom: 0.25rem;
            }
            .close{
                position: absolute;
                top: 0.2rem;
                right: 0.2rem;
                border: 1px solid #999;
                border-radius: 50%;
                text-align: center;
                box-sizing: border-box;
                font-size: 0.2rem;
                color: #999;
                padding:0.05rem;
            }
            ul{
                overflow: hidden;
                li{
                    float: left;
                    width: calc(100% / 3);
                    .share_icon{
                        width: 0.98rem;
                        height: 0.98rem;
                        margin:0 auto;
                        img{
                            width: 100%;
                            height: 100%;
                        }
                    }
                    p{
                        text-align: center;
                        color: #333;
                        font-size: 0.28rem;
                        margin-top: 0.25rem;
                    }
                }
            }
        }
        .shipping{
            background-color: #fff;
            margin-bottom: 0.2rem;
            padding:0 0.2rem;
            line-height: 0.88rem;
            h5{
                float: left;
                font-size: 0.3rem;
                color: #333
            }
            p{
                float: right;
                color: #999;
                font-size: 0.32rem;
                i{
                   font-size: 0.3rem;
                   color: #666; 
                   display: inline-block;
                   margin-left: 0.2rem;
                }
            }
        }
        .shipping_txt{
            position: relative;
            .mint-radiolist-label{
                position: absolute;
                top: 50%;
                transform: translateY(-65%);
                .mint-radio-core{
                    position: relative;
                    .icon-dui{
                        position: absolute;
                        font-size: 0.14rem;
                        color: #fff;
                        left: 50%;
                        top: 50%;
                        transform: translate(-50%,-50%);
                        z-index: 999;
                    }
                }
                .mint-radio-input:checked + .mint-radio-core{
                    background-color: #fafafa;
                    border:1px solid #EC534E;
                    
                    &::after{
                        background-color: #EC534E;
                        width: 100%;
                        height:100%;
                        left: 0;
                        top: 0
                    }
                }
            }
            p{
                float: left;
                padding-left: 0.7rem;
                font-size: 0.3rem;
                line-height: 0.88rem;
                color: #333;
            }
           
        }
        .state_win{
            min-height: 5rem;
            &.coupon_win{
                background-color: #fafafa;
                header{
                    padding-bottom: 0.2rem;
                    border-bottom: 2px solid #ddd;
                }
                ul{
                    li{
                        border:none 0;
                        height: auto;
                        margin-top: 0.2rem;
                        .mint-radiolist-label{
                            position: absolute;
                            right: 0.2rem;
                            top: 50%;
                            transform: translateY(-50%);
                        }
                    }
                }
                .coupon_ensure{
                    display: block;
                    width: 7.1rem;
                    height: 0.79rem;
                    background-color: #ffdc4b;
                    border-radius: 0.1rem;
                    color: #333;
                    font-size: 0.34rem;
                    margin:0 auto 0.2rem;
                }
                .coupon_list{
                    height: 6.2rem;
                    overflow-y: scroll;
                    margin-bottom: 0.5rem;
                    .mint-radio{
                        display: block;
                    }
                }
            }
            header{
                padding-top: 0.2rem;
                text-align: center;
                color: #333;
                font-weight: bold;
                font-size: 0.34rem;
                font-family: 'PingFang-SC-Bold';
            }
            ul{
                padding:0 0.2rem;
                li{
                    position: relative;
                    border-bottom: 2px solid #ddd;
                    height: 1rem;
                    &:last-child{
                        border: none 0;
                    }
                    .mint-radiolist-label{
                        position: relative;
                        overflow: hidden;
                        height: 1rem;
                        .mint-radio{
                            float: right;
                            text-align: right;
                            margin-right: 0.05rem;
                            margin-top: 0.3rem;
                            .mint-radio-core{
                                display: block;
                            }
                        }
                        .mint-radio-label{
                            float: left;
                            text-align: left;
                            position: relative;
                            top: 50%;
                            transform: translateY(-50%);
                            h6{
                                font-size: 0.34rem;
                                color: #666;
                            }
                            p{
                                font-size: 0.24rem;
                                color: #999;
                            }
                        }
                    }
                    
                }
            }
        }
        .shipping_txt{
            line-height: 0.88rem;
            background-color: #fff;
            height: 0.88rem;
            margin-top: -0.18rem;
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
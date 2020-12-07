<template>
    <div class="shopCart_box" @touchstart='touchStart'>
        <div class="empty_shopCar" v-if="cart_info.length == 0 && !isLoading">
            <i class="icon iconfont icon-gouwuche-kong"></i>
            <p>您的购物车还是空的哦~</p>
            <a href="javascript:;" class="look" @click="goLook" :style="{background:color1,color:'#fff'}">去逛逛</a>
        </div>
        <div class="shopCart" v-else>
            <div class="shop_goods">
                <!-- 购物车物品列表信息 -->
                <ul>   
                    <li :key="index" v-for="(item, index) in cart_info" @click="lookDetail(item)">
                        <div class="goods_information clearfix">
                            <label data-v-0f273760="" class="mint-radiolist-label" @click="stopLook($event)">
                                <span data-v-0f273760="" class="mint-radio">
                                    <input data-v-0f273760="" type="checkbox" class="mint-radio-input" :value="item" v-model="choices"> 
                                    <span data-v-0f273760="" class="mint-radio-core">
                                        <i class="icon iconfont icon-dui"></i>
                                    </span>
                                </span>
                            </label>
                            <div class="goods_pic">
                                <img :src="$url + item.product_img" alt="">
                            </div>
                            <div class="goods_main">
                                <h6>{{item.product_name}}</h6>
                                <p>{{item.spec_content}}</p>
                                <span>￥{{item.sale_price}}</span>
                            </div>
                            <div class="goods_number">
                                <div href="javascript:;" class="reduce" @click="reduce($event,item)">
                                    <i class="icon iconfont icon-jian1"></i>
                                </div>
                                <input class="num numInp" v-model="item.count" type="num" maxlength="3">
                                <div href="javascript:;" class="add" @click="add($event,item)">
                                    <i class="icon iconfont icon-jia1"></i>
                                </div>
                            </div>
                            <!-- <calculations ref="sumitate" class="count" :count="item.count" :componentFather="'shop'" :cartId="item.cart_id"></calculations> -->
                            <div class="del_shop_goods" @click="confirmDeletion($event,item.cart_id,index)">
                                <i class="icon iconfont icon-cha"></i>
                            </div>
                        </div>
                    </li>
                </ul>
                <loading v-show="isLoading"></loading>
            </div>
            <!-- 邮费 -->
            <div v-if="cart_info.length > 0 && !isLoading">
                <div class="goods_cost clearfix">
                    <h5>运费</h5>
                    <div class="money">￥{{express_money}}</div>
                </div>
                <!-- 配送方式 -->
                <div class="shipping clearfix" @click="mode = true">
                    <h5>配送方式</h5>
                    <p>{{shippingMode}}<i class="icon iconfont icon-youjiantouda"></i></p>
                </div>
                <!-- 优惠券 -->
                <div class="shipping clearfix" @click="couponChoice">
                    <h5>优惠券</h5>
                    <p>请选择<i class="icon iconfont icon-youjiantouda"></i></p>
                </div>
                <!-- 选择优惠券内容信息 -->
                <div class="shipping_txt" v-if="chooseCoupon() != ''">
                    <label data-v-0f273760="" class="mint-radiolist-label">
                        <span data-v-0f273760="" class="mint-radio">
                            <input data-v-0f273760="" type="checkbox" class="mint-radio-input" checked disabled> 
                            <span data-v-0f273760="" class="mint-radio-core">
                                <i data-v-0f273760="" class="icon iconfont icon-dui"></i>
                            </span>
                        </span>
                    </label>
                    <p>
                        {{chooseCoupon()}}
                    </p>
                </div>
                <!-- 收件人信息 -->
                <div class="user_information remarks">
                    <ul>
                        <li>
                            <h5>收件人信息</h5>
                        </li>
                        <li @click="consignees()">
                            <h5 v-if="!recipients">请选择收件人信息</h5>
                            <div v-if="recipients" class="recipients">
                                <p class="recipients_person">
                                    <span>{{newRecipients.consignee}}</span>
                                    <span>{{newRecipients.phone}}</span>
                                </p>
                                <p class="recipients_address">{{newRecipients.province}}{{newRecipients.city}}{{newRecipients.district}}{{newRecipients.address_detail}}</p>
                            </div>
                            <i class="icon iconfont icon-youjiantouda"></i>
                        </li>
                        <!-- <li class="leave-message">
                            <h5>买家留言：</h5>
                            <input type="text" v-model="saleMessage" placeholder="选填：填写内容已和卖家协商确认" class="sale_message">
                        </li> -->
                    </ul>
                </div>
                <!-- 优惠券 -->
                <div class="shipping leave-message clearfix" @click="couponChoice">
                    <h5>买家留言：</h5>
                    <input type="text" v-model="saleMessage" placeholder="选填：填写内容已和卖家协商确认" class="sale_message">
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
                        <!-- <li @click="setBuyType('ye')" v-if="balancePayAble"> -->
                        <li @click="setBuyType('ye')">
                            <label class="mint-radiolist-label">
                                <span class="mint-radio">
                                    <input type="radio" class="mint-radio-input" value="ye" v-model="setCost"> 
                                    <span class="mint-radio-core"></span>
                                </span> 
                            </label>
                            <div class="cost_pic">
                                <img src="static/images/balance.png" alt="">
                            </div>
                            <div class="cost_way">
                                <h6>余额支付</h6>
                                <p>确保余额是否充足</p>
                            </div>
                        </li>
                    </ul>
                </div>
                <!-- 消费情况 -->
                <div class="shipping_data">
                    <ul>
                        <li>
                            <span class="name">
                                商品金额
                            </span>
                            <span>
                                ￥{{totalPrice}}
                            </span>
                        </li>
                        <li>
                            <span class="name">
                                运费
                            </span>
                            <span>￥{{express_money}}</span>
                        </li>
                        <li>
                            <span class="name">
                                优惠
                            </span>
                            <span v-if="couponPrice > 0">
                                ￥{{couponPrice}}
                            </span>
                            <span v-else>
                                ￥0
                            </span>
                        </li>
                    </ul>
                </div>
                <!-- 底部信息 -->
                <footer :class="{  'nav-hide': hideClass }">
                    <div class="price">
                        <h4>总价：<span>￥{{payPrice}}</span></h4>
                    </div>
                    <!-- <a href="javascript:;" @click="share = true">找人代付</a> -->
                    <a href="javascript:;" @click="submit()" :style="{background:color1}">提交订单</a>
                </footer>
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
                <!-- 配送方式选择弹出框 -->
                <mt-popup v-model="mode" position="bottom" class="state_win">
                    <header>配送方式</header>
                    <ul>
                        <li @click="mode = false">
                            <label class="mint-radiolist-label">
                                <span class="mint-radio">
                                    <input type="radio" class="mint-radio-input" value="送货上门" v-model="shippingMode"> 
                                    <span class="mint-radio-core"></span>
                                </span> 
                                <div class="mint-radio-label">
                                    <h6>送货上门</h6>
                                </div>
                            </label>
                        </li>
                        <li @click="mode = false">
                            <label class="mint-radiolist-label">
                                <span class="mint-radio">
                                    <input type="radio" class="mint-radio-input" value="货到付款" v-model="shippingMode"> 
                                    <span class="mint-radio-core"></span>
                                </span> 
                                <div class="mint-radio-label">
                                    <h6>货到付款</h6>
                                </div>
                            </label>
                        </li>
                        <li @click="mode = false">
                            <label class="mint-radiolist-label">
                                <span class="mint-radio">
                                    <input type="radio" class="mint-radio-input" value="上门自提" v-model="shippingMode"> 
                                    <span class="mint-radio-core"></span>
                                </span> 
                                <div class="mint-radio-label">
                                    <h6>上门自提</h6>
                                </div>
                            </label>
                        </li>
                    </ul>
                </mt-popup>
                <!-- 优惠券选择弹出框 -->
                <mt-popup v-model="couponBox" position="bottom" class="state_win coupon_win" @click="closeBox()">
                    <div v-if="couponLists.length > 0">
                        <header>选择优惠券</header>
                        <div class="coupon_list">
                            <ul>
                                <li class="clearfix" v-for="(item,index) in ableCoupon" @click="couponCount = index">
                                    <usage :coupon="item" :couponRootly="couponRootly"></usage>
                                    <label class="mint-radiolist-label">
                                        <span class="mint-radio">
                                            <input type="radio" class="mint-radio-input" :value="index" v-model="couponCount"> 
                                            <span class="mint-radio-core"></span>
                                        </span> 
                                    </label>
                                </li>
                            </ul>
                            <p class="disableCoupon" v-if="disableCoupon.length > 0">不可用优惠卷</p>
                            <ul>
                                <li class="clearfix" v-for="item in disableCoupon">
                                    <usage :coupon="item" :couponRootly="couponRootly"></usage>
                                </li>
                            </ul>
                        </div>
                        <button class="coupon_ensure" @click="couponEnsure">确定</button>
                    </div>
                    <div class="coupon_tips" v-else @click="closeBox()">
                        暂无可用优惠券
                    </div>
                </mt-popup> 
                <pay-load  v-show="isPay"></pay-load>
            </div>
        </div> 
        <div class="overlayer" v-if="isPay" @touchmove.prevent></div>
        
        <!-- <div v-show="isPay" class="isPay">
            <img src="static/images/weiit.gif" alt="">
        </div> -->
        
        <!-- <nav-footer :parents="'shopCar'"></nav-footer> -->
    </div>
</template>

<script>
    // 引入底部导航组件
    import NavFooter from '@/components/footer'
    // 引入数量计算组件
    import calculations from '@/components/calculations'
    // 从mint-ui中调用Popup,MessageBox
    import { Popup,MessageBox,Toast } from 'mint-ui';
    // 引入每一条优惠券组件
    import usage from '@/components/usage';
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    // 引入加载组件
    import loading from '@/components/loading'
    import payLoad from '@/components/payLoad'
    import {getQueryString} from '../../../static/js/getQueryString'
    export default {
        data(){
            return {
                setCost:'wx',    //支付方式
                share:false,
                mode:false,
                shippingMode:'送货上门',
                couponBox:false,     //优惠券弹窗口标识
                couponRootly:'shopCart',   //来源
                couponCount:'',      //选中优惠券
                shopCart:{},
                couponLists:[],
                allcoupons:[],       //所有优惠卷
                ableCoupon:[],       //可用优惠卷数据
                disableCoupon:[],    //不可用优惠卷数据
                recipients:null,
                value:[],
                choices:[],
                saleMessage:'',
                isLoading:true,
                cart_info:[],         //购物车商品列表
                hideClass: false,
                docmHeight: document.documentElement.clientHeight,  //一开始的屏幕高度
                showHeight: document.documentElement.clientHeight,   //一开始的屏幕高度
                changeHeight: document.documentElement.clientHeight,
                timer:false,
                discounts:0,           //优惠力度
                approach:'',            //优惠方式
                allPrice:'',
                couponsShow:[],
                isFlag:true,
                express_money:0,       //邮费,
                couponId:null,             //优惠券id
                isPay:false,
                isPop:false,
                rangeType:'',           //是否指定商品标识
                payPrice:0,             //实际花费
                couponPrice:0,          //优惠费用
                totalPrice:0,              //总花费
                couponNum:localStorage.getItem('couponNum') ? localStorage.getItem('couponNum') : -1,
                color1:localStorage.getItem('bg1'),
                color2:localStorage.getItem('bg2'),
                address_id:'',
                balancePayAble: false,
                wxPayAble: false,
            }
        },
        methods:{
            // 获取购物车信息
            getCart(){
                this.setCost = localStorage.getItem('setCost') ? localStorage.getItem('setCost') : 'wx';
                axios.post('/api/product/userCart',null)
                .then((res) => {
                    if(res.data.code == "0"){
                        // 获取到的数据
                        this.shopCart = res.data.data;
                        
                        this.allcoupons = this.shopCart.coupons;
                        // 优惠券总数据
                        this.allcoupons.forEach(item => {
                            if(item.is_useable){
                                // 可用优惠卷列表
                                this.ableCoupon.push(item);
                                
                            }else{
                                // 不可用优惠卷列表
                                this.disableCoupon.push(item)
                            }
                        })
                        // 给每条优惠券添加一个新字段value
                        this.ableCoupon.forEach((item,index) => {
                            item.value = index;
                        })
                        // 地址数据
                        this.recipients = this.shopCart.user_address_info;
                        // 购物车商品列表
                        this.cart_info = this.shopCart.cart_info;
                        // 选中商品标识
                        this.choices = this.shopCart.cart_info;
                        // 邮费
                        this.express_money = this.shopCart.express_money;
                        this.benefit();
                        // 页面加载动画标识
                        this.isLoading = false;
                        this.address_id = this.recipients.id;
                    }
                })
                .catch((err) => {
                    console.log(err);
                })
            },
            // 确认按钮
            couponEnsure(){
                this.couponBox = false;
                this.couponNum = this.couponCount;
                // localStorage.setItem('couponNum',this.couponNum);
                this.couponId = this.ableCoupon[this.couponNum].id;
                this.rangeType = this.ableCoupon[this.couponNum].product_range_type;

                this.chooseCoupon();
                // 优惠金额计算
                this.benefit();
            },
            // 选择收件人信息
            consignees(){
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
                            localStorage.setItem('addressRootly','shop')
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            },
            couponChoice(){
                this.couponCount = this.couponNum;
                if(this.totalPrice > 0){
                    this.couponBox = true;
                }else{
                    Toast('亲，你还没有选择商品~');
                }
            },
            // 删除购物车数据
            delGoods(id,index){
                let cart_id = id;
                axios.post('/api/product/delUserCartProduct',qs.stringify({
                    cart_id:cart_id
                })).then((res) => {
                   if(res.data.code == '0'){
                       this.cart_info.splice(index,1);
                       this.choices.forEach((item,iNum) => {
                            if(item.cart_id == cart_id){
                                this.choices.splice(iNum,1);
                            }
                        })
                        this.postaging();
                        this.couponList();
                   }
                }).catch((err) => {
                    console.log(err);
                });
            },
            // 确定是否删除弹出框
            confirmDeletion(e,id,index){
                e.stopPropagation();
                MessageBox.confirm('',{
                    width:500,
                    height:600,
                    message:'确认删除此商品?',
                    cancelButtonClass:'cancelButton',
                    confirmButtonClass:'confirmButton',
                    confirmButtonText:'确认',
                    cancelButtonText:'取消',
                    closeOnClickModal:false
                }).then((action) => {
                    if (action == 'confirm') {
                        this.delGoods(id,index);
                    }
                }).catch((err) => {
                    if (err == 'cancel') {

                    }
                });
            },
            // 优惠卷展示
            couponList(){
               // 购物车ID
                let cart_ids = this.cartIds();
                axios.post('/api/activity/getUserCouponListForCart',qs.stringify({
                    cart_ids:cart_ids
                })).then((res) => {
                    console.log(res);
                    if(res.data.code == '0'){
                        // this.couponLists = res.data.data.coupons;
                        this.couponLists = [];
                        this.ableCoupon = [];
                        this.disableCoupon = [];
                        let couponsArr = res.data.data.coupons;
                        let _this = this;
                        couponsArr.forEach(item => {
                            if(item.is_useable){
                                // 可用优惠卷列表
                                this.ableCoupon.push(item);
                                
                            }else{
                                // 不可用优惠卷列表
                                this.disableCoupon.push(item)
                            }
                            if(_this.couponId != -1){
                                if(item.id == _this.couponId){
                                    if(!item.is_useable){
                                        _this.couponNum = -1;
                                        this.couponPrice = 0;
                                        this.chooseCoupon();
                                        // this.goodsPrice();
                                        this.benefit();
                                    }
                                }
                            }
                            
                        })
                        this.ableCoupon.forEach((item,index) => {
                            item.value = index;
                        })
                        
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 提交订单
            submit(){
                // 购物车ID
                let cart_ids = this.cartIds();
                // 用户下单的收货地址ID
                let address_id;
                if(this.address_id){
                    address_id = this.address_id;
                }else{
                    address_id = ''
                }
                

                // 支付方式
                let payment_type = this.paymentType();

                // 订单备注说明
                let remark = this.saleMessage;

                // 配送方式
                let express_type = this.expressType();
                

                // 快递费用
                let express_money = this.express_money;

                // 优惠券Id
                let coupon_id = this.couponId;

                // 订单实际支付总额
                let pay_price = this.payPrice;
                if(pay_price > 0){
                    if(address_id != ''){
                        if(payment_type == '0' && this.isFlag){
                            // 微信支付
                            if(this.wxPayAble){
                                this.isFlag = false;
                                this.isPay = true;
                                let _this = this;
                                axios.post('/api/order/addOrder',qs.stringify({
                                    cart_ids:cart_ids,
                                    address_id:address_id,
                                    payment_type:payment_type,
                                    remark:remark,
                                    express_type:express_type,
                                    express_money:express_money,
                                    coupon_id:coupon_id,
                                    pay_price:pay_price
                                })).then((res) => {
                                    wx.chooseWXPay({
                                        timestamp: res.data.data.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                                        nonceStr: res.data.data.nonceStr, // 支付签名随机串，不长于 32 位
                                        package:  res.data.data.packageValue, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                                        signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                                        paySign: res.data.data.paySign, // 支付签名
                                        success: function (res) {
                                            _this.isFlag = true;
                                            _this.isPay = false;
                                            _this.$router.push({
                                                path:'/buySuccess',
                                                name:'buySuccess',
                                                query:{
                                                    goodPrice:_this.payPrice,
                                                    buy_type:'微信'
                                                }
                                            })
                                        },  
                                        cancel: function (res) {
                                            _this.isFlag = true;
                                            _this.isPay = false; 
                                            _this.$router.push({
                                                path:'/Order',
                                                name:'Order',
                                                params:{
                                                    selected:'obligation'
                                                }
                                            })
                                        }  
                                    });  
                                    
                                }).catch((err) => {
                                    _this.isFlag = true;
                                    _this.isPay = false;
                                })
                            }else{
                                Toast('暂不支持微信支付，请选择其他支付方式');
                            }
                        }else if(payment_type == '1' && this.isFlag){
                            // 余额支付
                            if(this.balancePayAble){
                                MessageBox.confirm('',{
                                    width:500,
                                    height:600,
                                    message:'确认余额付款?',
                                    cancelButtonClass:'cancelButton',
                                    confirmButtonClass:'confirmButton',
                                    confirmButtonText:'确认',
                                    cancelButtonText:'取消'
                                }).then((action,e) => {
                                    if (action == 'confirm') {
                                        // this.delGoods(id,index);
                                        this.isPay = true
                                        this.isFlag = false
                                        // events(this.isPay);
                                        // event.preventdefault()
                                        axios.post('/api/order/addOrder',qs.stringify({
                                            cart_ids:cart_ids,
                                            address_id:address_id,
                                            payment_type:payment_type,
                                            remark:remark,
                                            express_type:express_type,
                                            express_money:express_money,
                                            coupon_id:coupon_id,
                                            pay_price:pay_price
                                        })).then((res) => {
                                            if(res.data.code == '0'){
                                                localStorage.setItem('setCost','wx');
                                                this.$router.push({
                                                    path:'/buySuccess',
                                                    name:'buySuccess',
                                                    query:{
                                                        goodPrice:this.payPrice,
                                                        buy_type:'余额'
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

                                        })
                                        
                                    }
                                }).catch((err) => {
                                    if (err == 'cancel') {
                                        this.isFlag = true;
                                        this.isPay = false;
                                    }
                                });
                            }else{
                                Toast('暂不支持余额支付，请选择其他支付方式');
                            } 
                        }
                    }else{
                        Toast('亲，请选择你的收货地址~');
                    }
                }else{
                    Toast('亲，您还没有选择任何商品~');
                }
            },
            // 查看商品详情
            lookDetail(item){
                this.$router.push({
                    path:'/detail',
                    name:'detail',
                    query:{
                        product_id:item.product_id
                    }
                })
            },
           
            stopLook(e){
                e.stopPropagation();
            },
            // 配送方式
            expressType(){
                let express_type;
                switch(this.shippingMode){
                    case '送货上门':
                        express_type = '0';
                        break;
                    case '货到付款':
                        express_type = '1';
                        break;
                    case '上门自提':
                        express_type = '2';
                        break;    
                }
                return express_type;
            },
            // 支付方式
            paymentType(){
                let payment_type;
                switch(this.setCost){
                    case 'wx': 
                        payment_type = '0';
                        break;
                    case 'ye': 
                        payment_type = '1';
                        break;
                }
                return payment_type;
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
            },
            // 购物车ID;
            cartIds(){
                let ids = [];
                this.choices.forEach((item) => {
                   ids.push(item.cart_id);
                })
                let cart_ids = ids.join(',');
                
                return cart_ids;
            },
            // 总花费
            goodsPrice(){
                let pay_price = 0;
                this.choices.forEach((item) => {
                   pay_price += item.count * item.sale_price;
                })
                this.totalPrice = pay_price.toFixed(2);
                this.payPrice = (pay_price + this.express_money).toFixed(2);
            },
            // 优惠券金额
            benefit(){
                if(this.couponNum != -1){
                    let pay_price = 0;
                    this.choices.forEach((item) => {
                        pay_price += item.count * item.sale_price;
                    })
                    this.totalPrice = pay_price.toFixed(2);
                    
                    if(this.rangeType == '1'){
                        if(this.totalPrice > 0 && this.discounts > 0){
                            if(this.approach == '1'){
                                this.couponPrice = this.discounts;
                                this.payPrice = this.totalPrice - this.discounts + this.express_money;
                            }else if(this.approach == '2'){
                                this.couponPrice = (this.totalPrice - this.totalPrice * (this.discounts/10)).toFixed(2);
                                this.payPrice = (this.totalPrice - this.couponPrice + this.express_money).toFixed(2);
                            }
                        }else{
                            return 0
                        }
                    }else if(this.rangeType == '2'){
                        let product_ids = this.ableCoupon[this.couponNum].product_ids.split(',');
                        // 指定优惠券商品
                        let counponArray = [];
                        this.choices.forEach((item) => {
                            product_ids.forEach((ele) => {
                                if(ele == item.product_id){
                                    counponArray.push(item);
                                }
                            })
                        })
                        if(this.approach == '1'){
                            this.couponPrice = this.discounts;
                            this.payPrice = this.totalPrice - this.discounts + this.express_money;
                        }else if(this.approach == '2'){
                            let designGoodsPrice = 0;
                            counponArray.forEach((item) => {
                                designGoodsPrice += item.count * item.sale_price;
                            })
                            this.couponPrice = (designGoodsPrice - designGoodsPrice * (this.discounts/10)).toFixed(2);
                            this.payPrice = (this.totalPrice - this.couponPrice + this.express_money).toFixed(2);
                        }
                    }
                }else{
                    this.goodsPrice();
                }
                
            },
            // 购物车为空时，去逛逛
            goLook(){
                this.$router.push({
                    path:"/search",
                    name:'search'
                })
            },
            // 增加商品数量
            add(e,item){
                let totalCount;
                if(item.max_limit > 0 && item.stock > item.max_limit){
                    totalCount = item.max_limit;
                }else{
                    totalCount = item.stock;
                }
                if(item.count < totalCount){
                    if(item.count > 99){
                        item.count = 99;
                        return;
                    }else{
                        item.count++;
                        let cart_id = item.cart_id;
                        let count = item.count;
                        axios.post('/api/product/addUserCartCount',qs.stringify({
                            cart_id:cart_id,
                            count:count
                        })).then((res) => {
                            if(res.data.code == '0'){
                                this.postaging();
                                this.couponList();
                            }
                        }).catch((err) => {

                        })
                    }
                }else{
                    item.count = totalCount;
                    Toast('你添加的数量已超过上限,请不要再添加了');
                }
                e.stopPropagation();
            },
            // 减少商品数量
            reduce(e,item){
                e.stopPropagation();
                if(item.count <= 1){
                    return;
                }else{
                    item.count--;
                    let cart_id = item.cart_id;
                    let count = item.count; 
                    axios.post('/api/product/addUserCartCount',qs.stringify({
                        cart_id:cart_id,
                        count:count
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.postaging();
                            this.couponList();
                        }
                    }).catch((err) => {
                        console.log(err)
                    })
                }
            },
            // 监控弹出框
            inputType() {
                if (!this.timer) {
                    this.timer = true;
                    let that = this;
                    if (that.docmHeight > that.showHeight) {
                    //显示class
                        this.hideClass = true;
                    } else if (that.docmHeight <= that.showHeight) {
                    //显示隐藏
                        this.hideClass = false;
                    }
                    that.timer = false;
                }
            },
            // 选择支付方式
            setBuyType(type){
                this.setCost = type;
                localStorage.setItem('setCost',type)
            },
            // 优惠内容显示
            chooseCoupon(){
                if(this.couponNum == -1){
                    return ''
                }else{
                    let discount;
                    if(this.ableCoupon[this.couponNum].type == '1' || this.ableCoupon[this.couponNum].type == '3'){
                        this.approach = '1'
                        this.discounts = this.ableCoupon[this.couponNum].coupon_content
                        discount = this.ableCoupon[this.couponNum].coupon_content + '元优惠券';
                    }else if(this.ableCoupon[this.couponNum].type == '2'){
                        this.approach = '2'
                        this.discounts = this.ableCoupon[this.couponNum].coupon_content
                        discount = this.ableCoupon[this.couponNum].coupon_content + '折优惠券';
                    }
                    return `${this.ableCoupon[this.couponNum].product}(除优惠活动外)${discount}`;
                }
            },
            // 邮费计算
            postaging(){
                // 购物车ID
                let cart_ids = this.cartIds();
                // 用户下单的收货地址ID
                let address_id;
                if(this.address_id){
                    address_id = this.address_id;
                }else{
                    address_id = ''
                }
                axios.post('/api/order/calcPostage',qs.stringify({
                    cart_ids: cart_ids,
                    address_id: address_id
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.express_money = res.data.data.expressPrice;
                        this.benefit();
                        // this.goodsPrice();
                    }
                }).catch((err) => {
                    console.log(err)
                })
            },
            // 键盘隐藏
            touchStart(){
                if(this.isPop){
                    document.activeElement.blur();
                    this.isPop = false
                }
            },
            // 默认事件的判断
            events(isFlag){
                if(isFlag){
                    event.preventdefault()
                }
            },
            // 关闭窗口
            closeBox(){
                if(this.couponLists.length == 0){
                    this.couponBox = false
                }
            }
        },
        components:{
            NavFooter,
            calculations,
            usage,
            loading,
            payLoad
        },
        beforeRouteEnter:(to,from,next)=>{
            if(from.name == 'address' || from.name == 'addSite'){

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
                                "chooseWXPay"
                    ] // 必填，需要使用的JS接口列表
                });
            }).catch((err) => {
                console.log(err);
            })
            next();
        },
        computed:{
            // 收件人内容
            newRecipients(){
                if(this.$route.params.toshop == 'address' || this.$route.params.toshop == 'addSite'){
                    return this.recipients = JSON.parse(localStorage.getItem('recipients')) ? JSON.parse(localStorage.getItem('recipients')) : this.recipients;
                }else{
                    return this.recipients
                }
            },
        },
        watch:{
            showHeight: 'inputType',
            changeHeight:function(curVal,oldVal){
                if(curVal != oldVal){
                    this.isPop = true
                }
            },
            choices:function(curVal,oldVal){
                this.cartIds();
                if(curVal.length != 0){
                    this.couponList();
                    this.postaging();
                }else{
                    this.express_money = 0;
                    this.payPrice = 0;
                    this.totalPrice = 0;
                    this.couponNum = -1;
                    this.couponPrice = 0;
                }  
            }
        },
        activated:function(){
            // this.recipients = this.chooseCoupon();
            this.isPay = false;
            if(this.$route.params.toshop == 'address' || this.$route.params.toshop == 'addSite'){
                this.address_id = localStorage.getItem('address_id');
            }else{
                let inTo = this.$route.params.inTo;
                this.getCart();
                this.getPayAble();
                if(inTo){
                    localStorage.setItem('setCost','wx');
                }
            }
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
    .shopCart_box{
        height: 100%;
        .isPay{
            width: 2.15rem;
            height: 1.93rem;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%,-50%);
            img{
                width: 100%;
                height: 100%;
            }
        }
    }
    .empty_shopCar{
        width: 100%;
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        text-align: center;
        i{
            font-size: 2rem;
            color:#ddd; 
        }
        p{
            text-align: center;
            font-size: 0.3rem;
            color: #333;
            margin-top: 0.1rem;
            margin-bottom: 0.6rem;
        }
        .look{
            display: block;
            width: 6.9rem;
            height: 0.89rem;
            line-height: 0.89rem;
            border-radius: 0.2rem;
            text-align: center;
            color: #333;
            font-size: 0.32rem;
            margin: 0 auto;
            background: #ffdc4b;
        }
    }
    .shopCart{
        padding-bottom: 1rem;
        .shop_goods{
            margin-bottom: 2px;
            // max-height:7.25rem;
            // overflow-y: scroll;
            ul{
                li{ 
                    border-bottom: 1px solid #f1f1f1;
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
                            margin-left: 0.36rem;
                        }
                    }
                    .goods_information{
                        position: relative;
                        background-color: #f5f5f5;
                        padding:0.2rem 0;
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
                        .goods_pic{
                            float: left;
                            width: 2rem;
                            height: 2rem;
                            margin-left: 0.8rem;
                            img{
                                width: 100%;
                                height: 100%;
                            }
                        }
                        .goods_main{
                            float: left;
                            width: 3.92rem;
                            margin-left: 0.3rem;
                            position: relative;
                            height: 2rem;
                            h6{
                                width: 3.6rem;
                                color: #333;
                                font-size: 0.3rem;
                                overflow : hidden;
                                text-overflow: ellipsis;
                                display: -webkit-box;
                                -webkit-line-clamp: 2;
                                /*! autoprefixer: off */
                                -webkit-box-orient: vertical;
                                /* autoprefixer: on */
                            }
                            p{
                                position: absolute;
                                font-size: 0.28rem;
                                color: #666;
                                bottom: 0.45rem;
                            }
                            span{
                                position: absolute;
                                display: block;
                                color: #ff3461;
                                font-size: 0.28rem;
                                bottom: 0;
                            }
                        }
                        .del_shop_goods{
                            position: absolute;
                            right: 0;
                            top: 0.18rem;
                            width: 0.48rem;
                            background-color: #d7d7d7;
                            border-radius: 0.16rem 0 0 0.16rem;
                            padding: 0.05rem 0 0.05rem 0.15rem;
                            i{
                                font-size: 0.28rem;
                                color: #fff;
                                display: block;
                            }
                        }
                        .count{
                            top: 1.75rem;
                        }
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
                    }
                }
            }
        }
        .goods_cost{
            background-color: #fff;
            padding: 0.15rem 0.3rem;
            border-bottom: 1px solid #f5f5f5;
            h5{
                float: left;
                font-size: 0.28rem;
                color: #333;
            }
            div{
                float: right;
                font-size: 0.28rem;
                color: #999;
                span{
                    color: #ec534e;
                }
                &.money{
                    color:#EC534E;
                }
            }
        }
        .remarks{
            background-color: #fff;
            margin-bottom: 0.2rem;
            ul{
                li{
                    padding:0.2rem 0.25rem 0.2rem 0.3rem;
                    border-bottom: 2px solid #f5f5f5;
                    overflow: hidden;
                    &:last-child{
                        border:none 0;
                    }
                    h5{
                        float: left;
                        color: #333;
                        font-size: 0.28rem;
                    }
                    p{
                        float: right;
                        font-size: 0.28rem;
                        color: #999;
                        i{
                           font-size: 0.36rem;
                           color: #666;
                           display: inline-block;
                           margin-left: 0.2rem; 
                        }
                    }
                    
                }
            }
        }
        .user_information{
            margin-top: 0.2rem;
            ul{
                li{
                    position: relative;
                    .icon{
                        position: absolute;
                        top: 50%;
                        right: 0.22rem;
                        transform: translateY(-50%);
                        color: #666;
                        font-size: 0.36rem;
                       
                    }
                    .recipients{
                        float: left;
                        text-align: left;
                        color: #333;
                        width: 5.5rem;
                        p{
                            float: left;
                            color: #333;
                            font-size: 0.28rem;
                            width: 100%;
                            &.recipients_address{
                                margin-top: 0.05rem;
                            }
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
                        width: 0.7rem;
                        height: 0.7rem;
                        margin:0 0.2rem;
                        img{
                            width: 100%;
                            height: 100%;
                            display: block;
                        }
                    }
                    .cost_way{
                        float: left;
                        h6{
                            font-size: 0.3rem;
                            color: #333;
                        }
                        p{
                            color: #999;
                            font-size: 0.24rem;
                            margin-top: 0.05rem;
                        }
                    }
                }
            }
        }
        footer{
            position: fixed;
            bottom: 0;
            left: 0;
            box-sizing: border-box;
            border-top: 1px solid #e7e7e7;
            z-index: 5;
            background-color: #fff;
            width: 100%;
            &.nav-hide {
                position: static!important;
            }
            .price{
                float: left;
                // width: 3.9rem;
                line-height: 0.96rem;
                background-color: #fff;
                padding-left: 0.28rem;
                h4{
                    font-size: 0.28rem;
                    color: #333;
                    span{
                        display: inline-block;
                        color: #ec534e;
                    }
                }
            }
            a{
                float: right;
                width: 1.7rem;
                text-align: center;
                font-size: 0.32rem;
                background-color: #FFDC4B;
                color: #333;
                line-height: 0.96rem;
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
            padding:0.15rem 0.25rem 0.15rem 0.3rem;
            h5{
                float: left;
                font-size: 0.28rem;
                color: #333;
            }
            p{
                float: right;
                color: #999;
                font-size: 0.26rem;
                i{
                   font-size: 0.26rem;
                   color: #999;
                   display: inline-block;
                //    margin-left: 0.1rem;
                margin-top: 0.05rem;
                   font-weight: 700;
                }
            }
            .sale_message{
                float: left;
                width: 70%;
                font-size: 0.28rem;
                line-height: 0.4rem;
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
        .shipping_data{
            background-color: #fff;
            margin-top: 0.2rem;
            margin-bottom: 0.2rem;
            ul{
                li{
                    padding: 0.2rem 0.25rem 0.2rem 0.3rem;
                    border-bottom: 2px solid #f5f5f5;
                    overflow: hidden; 
                    &:last-child{
                        border:none;
                    } 
                    span{
                        float:right;
                        font-size: 0.28rem;
                        &.name{
                            float: left;
                        }
                    }
                }
            }
           
        }
        .state_win{
            min-height: 5rem;
            &.coupon_win{
                background-color: #fafafa;
                header{
                    padding-bottom: 0.2rem;
                    border-bottom: 1px solid #ddd;
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
                    .disableCoupon{
                        text-align: center;
                        font-size: 0.32rem;
                        color: #333;
                        margin-top: 0.4rem;
                    }
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
        
    }
    .overlayer{
        position:fixed;
        left:0;
        top:0;
        width:100%;
        height:100%;
        z-index:10;
    }
    .coupon_tips{
        text-align: center;
        font-size: 0.36rem;
        color: #333;
        line-height: 5rem;
    }
</style>
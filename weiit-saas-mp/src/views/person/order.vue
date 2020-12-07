<template>
    <div class="order">
        <div class="nav">  
            <mt-navbar v-model="active">
                <mt-tab-item id="all">
                    <div @click="getAll()" class="tabNav">
                        <a href="javascript:;">全部</a> 
                    </div>
                </mt-tab-item>
                <mt-tab-item id="obligation">
                    <div @click="getObligation()" class="tabNav">
                        <a href="javascript:;">待付款</a> 
                    </div>
                </mt-tab-item>
                <mt-tab-item id="delivery">
                    <div @click="getDelivery()" class="tabNav">
                        <a href="javascript:;">待发货</a> 
                    </div>
                </mt-tab-item>
                <mt-tab-item id="received">
                    <div @click="getReceived()" class="tabNav">
                        <a href="javascript:;">待收货</a> 
                    </div>
                </mt-tab-item>
                <!-- <mt-tab-item id="all" @click="getAll()">全部</mt-tab-item>
                <mt-tab-item id="obligation" @click="getObligation()">待付款</mt-tab-item>
                <mt-tab-item id="delivery" @click="getDelivery()">待发货</mt-tab-item>
                <mt-tab-item id="received" @click="getReceived()">待收货</mt-tab-item> -->
            </mt-navbar>
        </div>  
        <div class="page-tab-container">  
            <mt-tab-container class="page-tabbar-tab-container" v-model="active">  
                <mt-tab-container-item id="all">  
                    <!-- cell组件 -->  
                    <!-- 全部订单 -->
                    <div class="goodList">
                        <div class="goodListMenu">
                            <ul
                            v-infinite-scroll="loadMore1"
                            infinite-scroll-disabled="loading1"
                            infinite-scroll-distance="10" class="clearfix">
                                <li :key="index" v-for="(item, index) in allOrderGoods">
                                    <div class="goods">
                                        <div class="active_region clearfix">
                                            <a href="javascript:;" class="activity">
                                                <span>订单号：{{item.order_num}}</span>
                                            </a>
                                            <span class="seller_tips">{{goodsMation(item.state)}}</span>
                                        </div>
                                        <ul>
                                            <li :key="iNum" v-for="(elm, iNum) in item.item">
                                                <div class="goods_infor clearfix"  @click="seeDetail(item)">
                                                    <good-infor :goodinfor="elm" :goodsRootly="fatherComponent"></good-infor>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="goods_cost clearfix">
                                            <p class="total_money" v-if="item.express_money"> 合计:￥{{item.pay_price}} (含运费￥{{item.express_money}})</p>
                                            <p class="total_money" v-else> 合计:￥{{item.pay_price}} (含运费￥0)</p>
                                            <span class="total_num">共{{computeCount(item.item)}}件商品</span>
                                        </div>
                                        <div class="fun_btn clearfix"  v-if="item.state == 0 || item.state == 2">
                                            <a href="javascript:;" class="ensure" v-if="item.state == '2'" @click="ensure_goods(item,index)">确认收货</a>
                                            <a href="javascript:;" class="check" v-if="item.state == '2' || item.state == '4'" @click="lookLogistics(item)">查看物流</a>
                                            <span class="ensure" v-if="item.state == '0'" v-on:click="immediately(item,$event)" :style="{background:color1,color:'#fff'}">继续支付</span>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <no-more v-if="allLoaded1 && allOrderGoods.length > 0"></no-more>
                            <pay-load v-show="isPay"></pay-load>
                            <loading v-show="isLoading1"></loading>
                        </div>
                    </div> 
                    <empty v-if="!isLoading1 && allOrderGoods.length == 0" :fatherComponent="fatherComponent"></empty>
                </mt-tab-container-item>  
                <mt-tab-container-item id="obligation">  
                    <!-- cell组件 --> 
                    <!-- 待付款 -->
                    <div class="goodList" v-if="obligationOrderGoods.length > 0">
                        <div class="goodListMenu">
                            <ul
                            v-infinite-scroll="loadMore2"
                            infinite-scroll-disabled="loading2"
                            infinite-scroll-distance="10" class="clearfix">
                                <li :key="index" v-for="(item, index) in obligationOrderGoods">
                                    <div class="goods">
                                        <div class="active_region clearfix">
                                            <a href="javascript:;" class="activity">
                                                <span>订单号：{{item.order_num}}</span>
                                                <!-- <i class="icon iconfont icon-youjiantouda"></i> -->
                                            </a>
                                            <span class="seller_tips">{{goodsMation(item.state)}}</span>
                                        </div>
                                        <ul>
                                            <li :key="iNum" v-for="(elm, iNum) in item.item">
                                                <div class="goods_infor clearfix"  @click="seeDetail(item)">
                                                    <good-infor :goodinfor="elm" :goodsRootly="fatherComponent"></good-infor>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="goods_cost clearfix">
                                            <p class="total_money" v-if="item.express_money"> 合计:￥{{item.pay_price}} (含运费￥{{item.express_money}})</p>
                                            <p class="total_money" v-else> 合计:￥{{item.pay_price}} (含运费￥0)</p>
                                            <span class="total_num">共{{computeCount(item.item)}}件商品</span>
                                        </div>
                                        <div class="fun_btn">
                                            <span class="ensure" v-on:click="immediately(item,$event)" :style="{background:color1,color:'#fff'}">继续支付</span>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <loading v-show="isLoading2"></loading>
                            <no-more v-if="allLoaded2 && obligationOrderGoods.length > 0"></no-more>
                            <pay-load v-show="isPay"></pay-load>
                        </div>
                    </div> 
                    <empty v-if="!isLoading2 && obligationOrderGoods.length == 0" :fatherComponent="fatherComponent"></empty>
                </mt-tab-container-item>  
                <mt-tab-container-item id="delivery">  
                    <!-- cell组件 -->  
                    <!-- 待发货 -->
                    <div class="goodList" v-if="deliveryOrderGoods.length > 0">
                        <div class="goodListMenu">
                            <ul
                            v-infinite-scroll="loadMore3"
                            infinite-scroll-disabled="loading3"
                            infinite-scroll-distance="10" class="clearfix">
                                <li :key="index" v-for="(item, index) in deliveryOrderGoods">
                                    <div class="goods">
                                        <div class="active_region clearfix">
                                            <a href="javascript:;" class="activity">
                                                <span>订单号：{{item.order_num}}</span>
                                                <!-- <i class="icon iconfont icon-youjiantouda"></i> -->
                                            </a>
                                            <span class="seller_tips">{{goodsMation(item.state)}}</span>
                                        </div>
                                        <ul>
                                            <li :key="iNum" v-for="(elm, iNum) in item.item">
                                                <div class="goods_infor clearfix"  @click="seeDetail(item)">
                                                    <good-infor :goodinfor="elm" :goodsRootly="fatherComponent"></good-infor>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="goods_cost clearfix">
                                            <p class="total_money" v-if="item.express_money"> 合计:￥{{item.pay_price}} (含运费￥{{item.express_money}})</p>
                                            <p class="total_money" v-else> 合计:￥{{item.pay_price}} (含运费￥0)</p>
                                            <span class="total_num">共{{computeCount(item.item)}}件商品</span>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <loading v-show="isLoading3"></loading>
                            <no-more v-if="allLoaded3 && deliveryOrderGoods.length > 0"></no-more>
                        </div>
                    </div> 
                    <empty v-if="!isLoading3 && deliveryOrderGoods.length == 0" :fatherComponent="fatherComponent"></empty>
                </mt-tab-container-item>  
                <mt-tab-container-item id="received">  
                    <!-- cell组件 -->  
                    <!-- 待收货 -->
                    <div class="goodList" v-if="receivedOrderGoods.length > 0">
                        <div class="goodListMenu">
                            <ul
                            v-infinite-scroll="loadMore4"
                            infinite-scroll-disabled="loading4"
                            infinite-scroll-distance="10" class="clearfix">
                                <li :key="index" v-for="(item, index) in receivedOrderGoods">
                                    <div class="goods">
                                        <div class="active_region clearfix">
                                            <a href="javascript:;" class="activity">
                                                <span>订单号：{{item.order_num}}</span>
                                                <!-- <i class="icon iconfont icon-youjiantouda"></i> -->
                                            </a>
                                            <span class="seller_tips">{{goodsMation(item.state)}}</span>
                                        </div>
                                        <ul>
                                            <li :key="iNum" v-for="(elm, iNum) in item.item">
                                                <div class="goods_infor clearfix"  @click="seeDetail(item)">
                                                    <good-infor :goodinfor="elm" :goodsRootly="fatherComponent"></good-infor>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="goods_cost clearfix">
                                            <p class="total_money" v-if="item.express_money"> 合计:￥{{item.pay_price}} (含运费￥{{item.express_money}})</p>
                                            <p class="total_money" v-else> 合计:￥{{item.pay_price}} (含运费￥0)</p>
                                            <span class="total_num">共{{computeCount(item.item)}}件商品</span>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <loading v-show="isLoading4"></loading>
                            <no-more v-if="allLoaded4 && receivedOrderGoods.length > 0"></no-more>
                        </div>
                    </div> 
                    <empty v-if="!isLoading4 && receivedOrderGoods.length == 0" :fatherComponent="fatherComponent"></empty>
                </mt-tab-container-item>  
            </mt-tab-container>  
        </div>
        
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
    //引入axios 
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 从mint-ui中引入TabContainer, TabContainerItem,Navbar
    import { Navbar, TabItem, MessageBox, Toast, loadmore } from 'mint-ui';
    // 引入商品信息
    import GoodInfor from '@/components/goodInfor'
    // 引入当内容为空时
    import empty from '@/components/empty'
    // 引入加载组件
    import loading from '@/components/loading'
    import payLoad from '@/components/payLoad'
    import noMore from '@/components/noMore'
    export default {
        data(){
            return {
                active:localStorage.getItem('orderStyle') ? localStorage.getItem('orderStyle') : 'all',
                // 全部订单
                allOrderGoods:[],
                // 待付款订单
                obligationOrderGoods:[],
                // 待发货订单
                deliveryOrderGoods:[],
                // 待收货订单
                receivedOrderGoods:[],
                fatherComponent:'order',
                isLoading1: true,
                isLoading2: true,
                isLoading3: true,
                isLoading4: true,
                loading1: true,
                loading2: true,
                loading3: true,
                loading4: true,
                scrollMode:"auto", //移动端弹性滚动效果，touch为弹性滚动，auto是非弹性滚动,
                allLoaded1: false,
                allLoaded2: false,
                allLoaded3: false,
                allLoaded4: false,
                pageNo1:1,
                pageNo2:1,
                pageNo3:1,
                pageNo4:1,
                bottomText: '加载中...',
                scrollMode: "touch",
                payment:false,
                payment_type:'wx',
                singleOrderCost:null,
                isFlag:true,
                isPay:false,
                isPass:true,
                color1:localStorage.getItem('bg1'),
                color2:localStorage.getItem('bg2'),
                balancePayAble: false,
                wxPayAble: false
            }
        },
        components:{
            GoodInfor,
            empty,
            loading,
            payLoad,
            noMore
        },
        methods:{
            // 确认是否删除订单
            delOrder(){
                let htmls = `<div style="color:#333;font-weight:bold;margin-top:2rem;margin-bottom:0.8rem;">确认删除订单?</div>`;
                MessageBox.confirm('',{
                    width:500,
                    height:600,
                    title:'',
                    message:htmls,
                    cancelButtonClass:'cancelButton',
                    confirmButtonClass:'confirmButton',
                    confirmButtonText:'确认',
                    cancelButtonText:'取消'
                }).then((action) => {
                    if (action == 'confirm') {
                        console.log('abc');
                    }
                }).catch((err) => {
                    if (err == 'cancel') {
                        console.log('123');
                    }
                });
            },
            // 获取所有订单
            getAllOrder(){
                axios.post('/api/order/orderList',qs.stringify({
                    page:this.pageNo1,
                })).then((res) => {
                    if(res.data.code == '0'){  
                        let list = res.data.data.list;
                        console.log(list);
                        list.forEach(item => {
                            this.allOrderGoods.push(item);
                        })
                        this.hasNextPage = res.data.data.hasNextPage;
                        if(!this.hasNextPage){
                            this.loading1 = true;
                            this.allLoaded1 = true
                        }else{
                            this.loading1 = false;
                        }
                        this.isLoading1 = false;
                        this.isPass = true
                    }
                }).catch((err) => {
                    console.log(err)
                })
            },
            // 获取待付款订单
            getObligationOrderGoods(){
                axios.post('/api/order/orderList',qs.stringify({
                        state:'0',
                        page:this.pageNo2
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach(item => {
                            this.obligationOrderGoods.push(item);
                        })
                        this.hasNextPage = res.data.data.hasNextPage;
                        if(!this.hasNextPage){
                            this.loading2 = true;
                            this.allLoaded2 = true
                        }else{
                            this.loading2 = false;
                        }
                        this.isLoading2 = false;
                    }
                }).catch((err) => {
                    console.log(err)
                })
            },
            // 获取待发货订单
            getDeliveryOrderGoods(){
                axios.post('/api/order/orderList',qs.stringify({
                        state:'1',
                        page:this.pageNo3
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach(item => {
                            this.deliveryOrderGoods.push(item);
                        })
                        this.hasNextPage = res.data.data.hasNextPage;
                        if(!this.hasNextPage){
                            this.loading3 = true;
                            this.allLoaded3 = true
                        }else{
                            this.loading3 = false;
                        }
                        this.isLoading3 = false;
                    }
                }).catch((err) => {
                    console.log(err)
                })
            },
            // 获取待收货订单
            getReceivedOrderGoods(){
                axios.post('/api/order/orderList',qs.stringify({
                        state:'2',
                        page:this.pageNo4
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach(item => {
                            this.receivedOrderGoods.push(item);
                        })
                        this.hasNextPage = res.data.data.hasNextPage;
                        if(!this.hasNextPage){
                            this.loading4 = true;
                            this.allLoaded4 = true
                        }else{
                            this.loading4 = false;
                        }
                        this.isLoading4 = false;
                    }
                }).catch((err) => {
                    console.log(err)
                })
            },
            // 全部顶单
            getAll(){
                if(this.allOrderGoods.length == 0){
                    this.getAllOrder();
                }
            },
            // 待付款订单
            getObligation(){
                if(this.obligationOrderGoods.length == 0){
                    this.getObligationOrderGoods();
                }
            },
            // 待发货订单
            getDelivery(){
                if(this.deliveryOrderGoods.length == 0){
                    this.getDeliveryOrderGoods();
                }
            },
            // 待收货订单
            getReceived(){
                if(this.receivedOrderGoods.length == 0){
                    this.getReceivedOrderGoods();
                }
            },
            // 计算当前状态值
            goodsMation(state){
                switch(state){
                    case -1:return '交易取消';break;
                    case 0: return '待付款';break;
                    case 1: return '待发货';break;
                    case 2: return '待收货';break;
                    case 3: return '待评价';break;
                    case 4: return '交易完成';break;
                    default:return '待付款'
                }
            },
            // 查看详情
            seeDetail(item){
                if(this.isPass){
                    this.$router.push({
                        path:'/orderDetails',
                        name:'orderDetails',
                        query:{
                            order_num:item.order_num
                        }
                    })
                }
                
            },
            // 计算商品总数
            computeCount(arr){
                let count = 0;
                arr.forEach((item) => {
                    count += item.count;
                })
                return count;
            },
            // 跳转
            detail(id){
                this.$router.push({
                    path:'/detail',
                    name:'detail',
                    query:{
                        product_id:id
                    }
                })
            },
            // 确认订单收货
            ensure_goods(item,index){
                let htmls = `<div style="color:#333;font-weight:bold;">请确认是否已收到货?</div>`;
                MessageBox.confirm('',{
                    width:500,
                    height:600,
                    title:'',
                    message:htmls,
                    cancelButtonClass:'cancelButton',
                    confirmButtonClass:'confirmButton',
                    confirmButtonText:'确认',
                    cancelButtonText:'取消'
                }).then((action) => {
                    if (action == 'confirm') {
                        axios.post('/api/order/updateOrderState', qs.stringify({
                            order_num:item.order_num
                        })).then((res) => {
                            if(res.data.code == '0'){
                                Toast('收货完成');
                                this.receivedOrderGoods.splice(index,1);
                                this.$router.go(0)
                            }
                        }).catch((err) => {
                            console.log(err);
                        })
                    }
                }).catch((err) => {
                    if (err == 'cancel') {
                        console.log('123');
                    }
                });
                
            },
            // 查看物流详情
            lookLogistics(elm){
                this.$router.push({
                    path:'/logistics',
                    name:'logistics',
                    params:{
                        express_code:elm.express_code,
                        express_num:elm.express_num,
                        express_name:elm.express_name,
                        goodPicture:elm.item[0].product_img
                    }
                })
            },
            // 添加数据
            loadMore1(){
                this.isPass = false;
                this.pageNo1++;
                this.getAllOrder();
            },
            loadMore2(){
                this.isPass = false;
                this.pageNo2++;
                this.getAllOrder();
            },
            loadMore3(){
                this.pageNo3++;
                this.getDeliveryOrderGoods();
            },
            loadMore4(){
                this.pageNo4++;
                this.getReceivedOrderGoods();
            },
            // 继续支付
            immediately(item,e){
                this.payment = true;
                this.singleOrderCost = item;
                console.log(item);
                e.stopPropagation();
            },
             // 确定购买
            ensurePayment(){
                let goodPrice = this.singleOrderCost.pay_price + this.singleOrderCost.express_money;
                if(this.payment_type == 'wx' && this.isFlag){
                    if(this.wxPayAble){
                        let _this = this;
                        this.isFlag = false
                        this.isPay = true;
                        this.payment = false;
                        // 微信支付
                        axios.post('/api/order/orderPay', qs.stringify({
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
                                axios.post('/api/order/orderPay', qs.stringify({
                                    payment_type:'1',
                                    order_num:this.singleOrderCost.order_num
                                })).then((res) => {
                                    console.log(res);
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
        mounted(){
            this.getPayAble()
            if(!this.active){
                this.active = 'all';
            }
            switch(this.active){
                case 'all':
                    this.getAllOrder();
                    break;
                case 'obligation':
                    this.getObligationOrderGoods();
                    break;
                case 'delivery':
                    this.getDeliveryOrderGoods();
                    break;
                case 'received':
                    this.getReceivedOrderGoods();
                    break;
            }
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
    
    .mint-cell{
        margin-top: 0.2rem;
    }
    .mint-cell-value{
        width: 100%;
    }
    .order{
        height: 100%;
    }
    .noMore{
        display: block;
        font-size: 0.28rem;
        color: #aaa;
        text-align: center;
    }
    .goodList{
        height: 100%;
        overflow-y: scroll;
        .goodListMenu{
            min-height:8.5rem;
            padding-top: 1.2rem;
        }
        ul{
            li{
                margin-bottom: 0.2rem;
                .goods{
                    width: 100%;
                    .active_region{
                        padding:0.2rem;
                        padding-right: 0;
                        background-color: #fff;
                        .activity{
                            float: left;
                            span{
                                float: left;
                                font-size:0.28rem;
                                font-family:'PingFang-SC-Medium';
                                color:#333;
                            }
                            .icon{
                                font-size: 0.3rem;
                                font-weight: bold;
                                float: left;
                            }
                        }
                        .seller_tips{
                            float: right;
                            font-size: 0.28rem;
                            color: rgba(236,83,78,1);
                            margin-right: 0.2rem;
                        }
                    }
                    .goods_infor{
                        width: 100%;
                    }
                    .goods_cost{
                        width: 100%;
                        height: 0.6rem;
                        background-color: #fff;
                        text-align: right;
                        line-height: 0.6rem;
                        font-size: 0.28rem;
                        .total_num{
                            float: right;
                            color: rgba(51,51,51,1);
                        }
                        .total_money{
                            float: right;
                            display: inline-block;
                            margin-left: 0.2rem;
                            color: rgba(51,51,51,1);
                            margin-right: 0.2rem;
                        }
                    }
                    .fun_btn{
                        position: relative;
                        width: 100%;
                        height: 0.56rem;
                        background-color: #fff;
                        text-align: right;
                        .check{
                            float: right;
                            padding: 0 0.1rem;
                            height: 0.46rem;
                            line-height: 0.46rem;
                            background: #fff;
                            border:1px solid #666;
                            font-size: 0.28rem;
                            color: rgba(51,51,51,1);
                            margin-right: 0.2rem;
                            border-radius: 0.1rem;
                        }
                        .ensure{
                            position: relative;
                            float: right;
                            margin-right: 0.2rem;
                            padding: 0 0.1rem;
                            line-height: 0.48rem;
                            font-size: 0.28rem;
                            color: rgba(51,51,51,1);
                            background-color: rgba(255,220,75,1);
                            z-index: 99;
                            border-radius: 0.1rem;
                        }
                    }
                }
            }
        }
    }
    
    .nav{
        position: fixed;
        left: 0;
        width: 100%;
        background-color: #fff;
        border-bottom: 2px solid #f2f2f2;
        margin-bottom: 0.2rem;
        z-index: 10000;
        button{
            border:none 0;
        }
    }
    .page-tab-container{
        height: 100%;
        position: relative;
        top: -0.1rem;
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
</style>
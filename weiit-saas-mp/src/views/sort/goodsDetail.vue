<template>
    <div class="goods_detail">
        <loading v-show="isLoading"></loading>
        <!-- 商品信息 -->
        <div v-show="!isLoading">
            <div class="goods_show">
                <!-- 头部图片展示 -->
                <div class="goods">
                    <mt-swipe :auto="0">
                        <mt-swipe-item v-for="item in productInfo.product_imgs">
                            <div class="show">
                                <img :src="$url + item.product_img" alt="">
                            </div>
                        </mt-swipe-item>
                    </mt-swipe>
                </div>
                <!-- 商品信息介绍 -->
                <div class="goods_txt">
                    <h4>{{productInfo.product_name}}</h4>
                    <div class="cost clearfix">
                        <div class="money">
                            <span>￥{{productInfo.sale_price}}</span>
                            <span>￥{{productInfo.smarket_price}}</span>
                        </div>
                        <ul class="tags clearfix">
                            <li v-for="item in tag_info">
                                {{item.tag_name}}
                            </li>
                        </ul>
                        <div class="discount">
                            <p>运费：{{productInfo.expressInfo}}</p>
                            <p class="Sales" :class="{'salesily':tag_info.length == 0}">库存 {{productInfo.stock}} | 已售 {{productInfo.sale_count}}</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 选择规格 -->
            <div class="choice_rules" @click="choiceRule">
            	<h3>选择</h3>
            	<span>规格</span>
            	<i class="icon iconfont icon-youjiantouda"></i>
            </div>
            <van-tabs v-model="active" class="tables">
                <van-tab :title="'商品详情'">
                    <!-- 商品图片展示 -->
                    <div class="goods_introduce">
                        <div v-html="product_desc">
                            {{product_desc}}
                        </div>
                    </div>
                </van-tab>
                <van-tab :title="'商品属性'">
                    <!-- 商品注解 -->
                    <div class="goods_attribute" v-if="length > 0">
                        <ul class="clearfix">
                            <li class="attribute_info" v-for="item in productInfo.attribute_info">
                                <span class="attribute_name">{{item.attribute_name}}</span>
                                <span class="attribute_value">{{item.attribute_value}}</span>   
                            </li>
                        </ul>
                    </div>
                </van-tab>
            </van-tabs>
            
            
            <!-- 底部信息 -->
            <div class="buy">
                <div class="buy_ability">
                    <!-- 首页 -->
                    <div class="abilities" @click="toHome()">
                        <i class="icon iconfont icon-home"></i>
                        <span>首页</span>
                    </div>
                    <!-- 购物车 -->
                    <div class="abilities" @click="toShop()">
                        <i class="icon iconfont icon-gouwuche"></i>
                        <span>购物车</span>
                        <!-- <b class="num" v-if="counts > 0">{{counts}}</b> -->
                    </div>
                    <!-- 收藏 -->
                    <div class="abilities" @click="collected()">
                        <i class="icon iconfont" :class="isCollected ? 'icon-shoucang2' : 'icon-shoucang3'"></i>
                        <span v-if="!isCollected">收藏</span>
                        <span v-else>已收藏</span>
                    </div>
                </div>
                <!-- 右侧加入购物和立即购买按钮 -->
                <div class="buy_btn">
                    <a href="javascript:;" class="join_car" :style="{background:color2,color:'#fff'}" @click="chooseSize('join')">加入购物车</a>
                    <a href="javascript:;" class="buy_now" :style="{background:color1,color:'#fff'}" @click="chooseSize('buy')">立即购买</a>
                </div>
            </div>
            <!-- 底部商品规格选择弹出框 -->
            <mt-popup v-model="choose" position="bottom">
                <div class="size_box">
                    <h4>选择规格</h4>
                    <i class="icon iconfont icon-cha" @click="choose = false"></i>
                    <!-- 选择商品信息 -->
                    <div class="goods_content clearfix">
                        <div class="goods_img">
                            <img :src="$url + productInfo.product_img" alt="">
                        </div>
                        <div class="goods_mations">
                            <h5>{{productInfo.product_name}}</h5>
                            <p class="clearfix">
                                <span class="price" v-if="stockProduct.sale_price">￥{{stockProduct.sale_price}}</span>
                                <span class="price" v-if="!stockProduct.sale_price">￥{{productInfo.sale_price}}</span>
                                <span class="num">库存：{{stock}}</span>
                            </p>
                        </div>
                    </div>
                    <div class="size_main">
                        <!-- 商品规格选择 -->
                        <div :key="index1" class="goods_color" v-for="(item,index1) in productInfo.spec_info">
                            <h6>{{item.spec_name}}</h6>
                            <ul class="clearfix">
                                <li :key="index2" v-for="(sort,index2) in item.values" @click="checked(index1,index2)" :style="{'background':sort.isChecked ? color1 : ''}" :class="[sort.isChecked ? 'active' : '']">
                                    {{sort.spec_value}}
                                </li>
                            </ul>
                        </div>
                        <!-- 商品数量选择 -->
                        <div class="buy_num clearfix" :class="{'buy_num1':productInfo.max_limit == 0}">
                            <h6>购买数量</h6>
                            
                            <div class="goods_number">
                                <div href="javascript:;" class="reduce" @click="reduce($event)">
                                    <i class="icon iconfont icon-jian1"></i>
                                </div>
                                <span class="num">{{counts}}</span>
                                <div href="javascript:;" class="add" @click="add($event)">
                                    <i class="icon iconfont icon-jia1"></i>
                                </div>
                            </div>
                        </div>
                        <p class="maxLimit" v-if="max_limit > 0">该商品限购{{max_limit}}件</p>
                    </div>
                    <div v-if="confirmBtn">
                        <a href="javascript:;" class="ensure_btn" @click="ensure('none')" v-if="stock > 0" :style="{background:color1,color:'#fff'}">确定</a>
                        <a href="javascript:;" class="ensure_btn empty" v-else>库存不足</a>
                    </div>
                    <div class="confirm_box" v-if="!confirmBtn">
                        <a href="javascript:;" :style="{background:color2}" @click="ensure('join')" v-if="stock > 0">加入购物车</a>
                        <a href="javascript:;" :style="{background:color1}" @click="ensure('buy')" v-if="stock > 0">立即购买</a>
                        <a href="javascript:;" class="ensure_btn empty"  v-if="stock == 0">库存不足</a>
                    </div>
                </div>
            </mt-popup>
            <text-nav v-show="!isLoading"></text-nav>
        </div>
        
    </div>
</template>

<script>
    // 引入 Swipe, SwipeItem, Popup
    import { Swipe, SwipeItem, Popup, Toast } from 'mint-ui';
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    // 引入加载组件
    import loading from '@/components/loading'
    // 引入获取参数函数
    import {getQueryString} from '../../../static/js/getQueryString';
    import textNav from '@/components/textNav'
    export default {
        data(){
            return {
                isCollected:false,
                choose:false,
                partake:false,
                look:false,
                surplusNum:1,
                product_id:this.$route.query.product_id,
                productInfo:{},       //没有规则选择时的数据
                length:0,
                userId:localStorage.getItem('user_id'),
                stockProduct:{},      //有规则时的数据
                counts:0,
                costMent:'',
                spec_config:0,
                item_id:0,
                isLoading:true,
                product_desc:'',
                tag_info:[],
                isFlag:true,     
                hasCollection:true,
                // 限购数量
                max_limit:0,
                stock:0,
                // 规则是否选择
                isOk:false,
                color1:localStorage.getItem('bg1'),
                color2:localStorage.getItem('bg2'),
                confirmBtn:true,
                active:0
            }
        },
        methods:{
            // 提交订单
            chooseSize(type){
                if(this.userId){
                	this.confirmBtn = true
                    this.choose = true;
                    this.costMent = type;
                }
            },
            //将其他的规则设置为未选中状态
            doChooseSize (row){ 
                // 获取当前行对象
                let obj = this.productInfo.spec_info[row];
                // 遍历设置同行中所有数据字段isChecked为false
                for (let ele of obj.values)
                {
                    ele["isChecked"] = false;
                }
            },
            // 加入购物车
            ensure(tip){
                // 防止重复点击
                if(this.isFlag){
                	if(tip == 'join'){
                		this.costMent = 'join'
                	}else if(tip == 'buy'){
                		this.costMent = 'buy';
                	}
                    // 判断是否选出商品属性
                    // 选择的规格
                    let spec_content;
                    // 规格选择是否规范标识
                    let hasSize = true;
                    // 是否是多规格商品
                    if(this.spec_config == 1){
                        // 判断选择规格情况
                        if(this.checkSize()){
                            let specArr = []
                            this.productInfo.spec_info.forEach((item) => {
                                item.values.forEach((ele) => {
                                    if(ele.isChecked){
                                        specArr.push(ele.spec_value)
                                    }
                                })
                            })
                            spec_content = specArr.join(';');
                        }else{
                            hasSize= false;
                            Toast('请选择商品属性');
                            this.isOk = true;
                        }
                    }else{
                        this.item_id = this.productInfo.item_id;
                        spec_content = ''
                        this.isOk = true;
                    }
                    if(hasSize && this.isOk){
                        this.isFlag = false;
                        axios.post('/api/product/addUserCart',qs.stringify({
                            product_id:this.product_id,
                            item_id:this.item_id,
                            spec_content:spec_content,
                            count:this.counts
                        })).then((res) => {
                            if(res.data.code == '0'){
                                localStorage.setItem('toshop','goodDetail')
                                if(this.costMent == 'join'){
                                    // 加入购物车
                                    this.choose = false;
                                    Toast({
                                        message: '添加成功，在购物车等亲~',
                                        iconClass: 'icon icon-success'
                                    })   
                                }else if(this.costMent == 'buy'){
                                    // 直接立即购买
                                    this.choose = false;
                                    this.$router.push({
                                        path:'/shopCar',
                                        name:'shopCar',
                                        params:{
                                            inTo:'goods'
                                        }
                                    })
                                }   
                            }else{
                                Toast(res.data.message);
                            }
                            this.isFlag = true;
                            this.isOk = false;
                        }).catch((err) => {
                            console.log(err);
                        })
                    }
                }
            },
            // 获取商品信息
            getGoods(product_id){
                 // 判读是否拥有userId
                if(this.userId){
                    axios.post('/api/product/productDetail', qs.stringify({
                        product_id:product_id,
                        user_id:this.userId
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.productInfo = res.data.data.product_info;
                            this.max_limit = this.productInfo.max_limit;
                            this.length = this.productInfo.attribute_info.length;
                            this.spec_config = this.productInfo.spec_config;
                            this.shareImg = this.productInfo.product_imgs[0].product_img;
                            // 替换img标签和p标签内容
                            this.product_desc = this.productInfo.product_desc.replace(/img/g,'img style="width:100%;float:left"');
                            this.product_desc = this.product_desc.replace(/<p/g,'<p style="font-size:0.28rem;overflow:hidden"');
                            this.product_desc = this.product_desc.replace(/<video/g,'<video style="width:100%;object-fit:cover" playsinline="true" webkit-playsinline="true" x-webkit-airplay="true"');
                            this.isLoading = false;
                            this.tag_info = this.productInfo.tag_info;
                            this.stock = this.productInfo.stock;
                            this.shareFriend(this.productInfo.product_name, this.$url + this.shareImg)
                            // localStorage.setItem('shareGoodImage', this.shareImg);
                            // localStorage.setItem('shareGoodName', this.productInfo.product_name);
                            if(this.stock > 0){
                                this.counts = 1;
                            }else{
                                this.counts = this.stock;
                            }
                            
                            if(this.spec_config == 0){
                                this.item_id = this.productInfo.item_id;
                            }
                            if(this.productInfo.is_collection != '0'){
                                this.isCollected = true
                            }else{
                                this.isCollected = false
                            }
                            
                            this.productInfo.spec_info.forEach(item => {
                                item.values.forEach(item => {
                                    item.isChecked=false;
                                })
                            })
                           
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }else{
                    axios.post('/api/product/productDetail', qs.stringify({
                        product_id:product_id
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.productInfo = res.data.data.product_info;
                            this.leng = this.productInfo.attribute_info.length;
                            this.product_desc = this.productInfo.product_desc.replace(/img/g,'img style="width:100%"');
                            this.product_desc = this.product_desc.replace(/<p/g,'<p style="font-size:0.32rem"');
                            this.isLoading = false;
                            this.tag_info = this.productInfo.tag_info;
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }
            },
            // 取消加入收藏
            collected(){
                if(this.hasCollection){
                    this.hasCollection = false;
                    if(this.userId){
                        let id = localStorage.getItem('product_id');
                        if(!this.isCollected){
                            // 加入收藏
                            axios.post('/api/product/addProductCollection',qs.stringify({
                                product_id:id
                            })).then((res) => {
                                if(res.data.code == '0'){
                                    this.isCollected = !this.isCollected;
                                    this.hasCollection = true;
                                    Toast('收藏成功');
                                }
                            }).catch((err) => {
                                console.log(err);
                            })
                        }else{
                            // 取消加入收藏
                            axios.post('/api/user/myCollectionDelete',qs.stringify({
                                product_id:id
                            })).then((res) => {
                                if(res.data.code == '0'){
                                    this.isCollected = !this.isCollected;
                                    this.hasCollection = true;
                                    Toast('取消宝贝收藏');
                                }
                            }).catch((err) => {
                                console.log(err);
                            })
                        }
                    }
                }
                
            },
            // 进入购物车
            toShop(){
                if(this.userId){
                    this.$router.push({
                        path:'/shopCar',
                        name:'shopCar',
                        params:{
                            inTo:'goods'
                        }
                    })
                }
            },
            // 选择规格
            checked(row,col){
                this.doChooseSize(row);
                // 获取当前values值
                var list =  this.productInfo.spec_info[row].values;
                // 改变对应列中isChecked值
                list[col].isChecked = true;
                // 设置数字值 
                this.$set( list, col, list[col] );
                // 首先判断规则选择是否完整
                let flag = this.checkSize();
                //如果规则选择全部了。才查询库存
                if (flag)
                {
                    // 拼接规格id用来查询库存信息
                    let spec_custom = this.doSelSpec();
                    let product_id = this.product_id;

                    // 查询库存
                    axios.post('/api/product/productSpecCheck',qs.stringify({
                        spec_custom:spec_custom,
                        product_id:product_id
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.stockProduct = res.data.data;
                            this.item_id = this.stockProduct.item_id;
                            this.stock = this.stockProduct.stock;
                            this.isOk = true;
                            let totalCount;
                            if(this.max_limit > 0 && this.stock > this.max_limit){
                                totalCount = this.max_limit
                            }else{
                                totalCount = this.stock
                            }
                            if(totalCount < this.counts){
                                this.counts = totalCount;
                            }
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }
            },
            // 检测规则是否全部检测
            checkSize(){ 
                //如果返回true。那么说明都选中
                let flag = true;
                for(let i of this.productInfo.spec_info){
                    let item = i;
                    
                    let arr = item.values;
                    let index = arr.findIndex((ele) => {
                        return ele.isChecked
                    })
                    if(index <= -1){
                        flag = false;
                        break;
                    }
                }
                    
                return flag;
            },
            // 查询库存
            doSelSpec(){
                let tempArr = [];
                this.productInfo.spec_info.forEach((item,index) => {
                    item.values.forEach(ele => {
                        if(ele.isChecked){
                            tempArr.push(ele.spec_value_id);
                        }
                    })
                })
                let spec_custom = tempArr.join(';');
                if (spec_custom.indexOf(",")>-1) spec_custom = spec_custom.replace(/,/g,"");
                return spec_custom;
            },
            // 增加商品数量
            add(e){
                // 判断是否大于库存
                let totalCount;
                if(this.max_limit > 0 && this.stock > this.max_limit){
                    totalCount = this.max_limit
                }else{
                    totalCount = this.stock
                }
                if(this.counts < totalCount){
                    if(this.counts > 99){
                        this.counts = 99;
                    }else{
                        this.counts++;
                    }
                }else{
                    this.counts = totalCount;
                    Toast('你购买的数量超过上限,请不要再添加了');
                }
                e.stopPropagation();
            },
            // 减少商品数量
            reduce(e){
                if(this.counts <= 1){
                    return;
                }else{
                    this.counts--;
                }
                e.stopPropagation();
            },
            // 分享
            shareFriend(shareTitle, imgUrl){
                let host = document.location.hostname;
                let protocol = document.location.protocol;  
                let user_id = localStorage.getItem('user_id');
                let currentUrl = `${protocol}//${host}`; 
                // let imgUrl = this.$url + localStorage.getItem('shareGoodImage');
                // let shareTitle = localStorage.getItem('shareGoodName');

                let url = location.href.split('#')[0] + "&forward=detail&share_user_id=" + user_id;
                
                
                wx.ready(function(res) {
                    wx.onMenuShareAppMessage({
                        title: shareTitle,
                        desc:'',
                        link: url,
                        imgUrl:imgUrl
                    });
                    wx.onMenuShareTimeline({
                        title: shareTitle,
                        desc:"",
                        link: url,
                        imgUrl: imgUrl
                    });
                });
            },
            // 返回首页
            toHome(){
                this.$router.push({
                    path:'/33',
                    name:'home'
                })
            },
            //打开选择规则弹窗
            choiceRule(){
            	this.choose = true;
            	this.confirmBtn = false;
            }
        },
        created(){
          
            if(this.$route.query.target_id){
                this.product_id = this.$route.query.target_id
            }else{
                this.product_id=this.$route.query.product_id;
            }
            if(getQueryString('product_id') != undefined){
                this.product_id = getQueryString('product_id');
                this.getGoods(this.product_id)
            }else if(localStorage.getItem('forward') == 'freeGet'){
                this.isHelp = false;
                const urlObj = (JSON.parse(localStorage.getItem('urlObject')));
                this.product_id = urlObj.product_id;
                this.getGoods(this.product_id)
            }else{
                this.getGoods(this.product_id);
            }
        },
        mounted(){
             
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
        components:{
            loading,
            textNav
        }
    }
</script>

<style scoped lang="scss">
    .goods_detail{
        padding-bottom: 1.1rem;
        .goods_show{
            background-color: #fff;
            padding-bottom: 0.25rem;
            .goods{
                height: 100vw;
                .show{
                    width: 100vw;
                    height: 100vw;
                    img{
                       width: 100%;
                    }
                }
                
            }
            .goods_txt{
                width: 7rem;
                margin: 0 auto;
                h4{
                    margin-top: 0.4rem;
                   font-size: 0.32rem;
                   color: #333;
                   font-weight: bold; 
                }
                .cost{
                    margin-top:0.3rem;
                    .money{
                        float: left;
                        span{
                            display: block;
                            color: #ec534e;
                            font-size: 0.3rem;
                            &:last-child{
                                font-size: 0.28rem;
                                color: #999;
                                text-decoration: line-through;
                            }
                        }
                    }
                    .tags{
                        float: left;
                        margin-left: 0.1rem;
                        margin-top: 0.05rem;
                        li{
                            float: left;
                            margin-left: 0.1rem;
                            border-radius: 0.08rem;
                            box-sizing: border-box;
                            border: 1px solid #ec534e;
                            color: #ec534e;
                            font-size: 0.1rem;
                            padding: 0.05rem;
                        }
                    }
                    .discount{
                        float: right;
                        
                        p{
                            text-align: right;
                            font-size: 0.26rem;
                            color: #999;
                            &.Sales{
                                margin-top: 0.05rem;
                            }
                        }
                    }
                }
            }
            
        }
        .choice_rules{
        	line-height: 0.8rem;
        	height: 0.8rem;
        	background-color: #fff;
        	margin: 0.2rem 0;
        	padding: 0 0.2rem;
        	h3{
        		float: left;
        		font-size: 0.3rem;
        	}
        	span{
        		float: left;
        		font-size: 0.28rem;
        		color: #999;
        		margin-left: 0.6rem;
        	}
        	.icon{
        		float: right;
        		color: #999;
        	}
        }
        .circumstance{
            padding: 0 0.2rem;
            background-color: #fff;
            margin-bottom: 0.2rem;
            h4{
                position: relative;
                line-height: 1rem;
                font-size: 0.36rem;
                color: #333;
                .look_more{
                    position: absolute;
                    right: 0.1rem;
                    top: 50%;
                    transform: translateY(-50%);
                    color: #999;
                    font-size: 0.28rem;
                }
            }
            ul{
                li{
                    border-top: 1px solid #f5f5f5;
                    box-sizing: border-box;
                    height: 1rem;
                    .user{
                        float: left;
                        
                        .user_pic{
                            float: left;
                            width: 0.7rem;
                            height: 0.7rem;
                            border-radius: 50%;
                            overflow: hidden;
                            margin-top: 0.15rem;
                            img{
                                display: block;
                                width: 100%;
                                height: 100%;
                            }
                        }
                        .user_name{
                            float: left;
                            margin-left: 0.15rem;
                            font-size: 0.28rem;
                            color: #333;
                            line-height: 1rem;
                        }
                    }
                    .bargain_situation{
                        float: left;
                        margin-left: 1.9rem;
                        margin-top: 0.16rem;
                        text-align: center;
                        p{
                            &.num{
                                color: #333; 
                                font-size: 0.24rem;
                                font-weight: bold;
                                span{
                                    color: #FC8C35
                                }
                            }
                            &.time{
                                color: #000;
                                font-size: 0.24rem;
                            }
                        }
                    }
                    .goBargain{
                        float: right;
                        width: 1.24rem;
                        height: 0.51rem;
                        background-color: #fc8c35;
                        border-radius: 0.1rem;
                        color: #fff;
                        text-align: center;
                        line-height: 0.51rem;
                        font-size: 0.24rem;
                        margin-top: 0.25rem;
                    }
                }
            }
        }
        .show_order{
            height: 1rem;
            background-color: #fff;
            line-height: 1rem;
            position: relative;
            padding-left: 0.2rem;
            span{
                float: left;
                font-size: 0.36rem;
                color: #333;
                font-weight: bold;
            }
            .icon-wodeshaidan{
                float: left;
                font-size: 0.33rem;
                color: #b9b9b9;
                margin-left: 0.1rem;
            }  
            .icon-youjiantouda{
                position: absolute;
                font-size: 0.3rem;
                color: #666;
                top: 50%;
                right: 0.2rem;
                transform: translateY(-50%);
            }
        }
        .goods_attribute{
            width: calc(100% - 0.3rem);
            padding:0.1rem 0.2rem;
            padding-left: 0.25rem;
            background-color:#fff;
            ul{
                width: 100%;
                li{
                    line-height: 0.4rem;
                    color: #666;
                    font-size: 0.28rem;
                    width: 100%;
                    overflow: hidden;
                    margin-bottom: 0.1rem;
                    span{
                        float: left;
                        &.attribute_name{
                            width: 1.3rem;
                            margin-right: 0.5rem;
                            text-align: left;
                            color: #999;
                            text-overflow:ellipsis;
                            white-space:nowrap;
                            overflow:hidden;
                        }
                        &.attribute_value{
                            width: 5.2rem;
                        }
                    }
                }
            }
        }
        .goods_introduce{
            img{
                width:100%;
            }
        }
        .good_introduction{
            background-color: #fff;
            width: 7.5rem;
            img{
                width: 100%;
            }
        }
        .buy{
            position: fixed;
            background-color: #fff;
            left: 0;
            bottom: 0;
            width: 100%;
            z-index: 100;
            .buy_ability{
                float: left;
                width: calc(100% - 3.68rem);
                padding: 0.1rem 0;
                .abilities{
                    float: left;
                    width: calc(100% / 3);
                    text-align: center;
                    position: relative;
                    i{
                        display: block;
                        font-size: 0.44rem;
                        &.icon-shoucang2{
                            color: #EC534E;
                        }
                    }
                    span{
                        display: block;
                        color: #666;
                        font-size: 0.28rem;
                        margin-top: 0.05rem;
                    }
                    .num{
                        position: absolute;
                        top: 0;
                        right: 0.15rem;
                        padding:0 0.05rem;
                        border-radius: 0.14rem;
                        text-align: center;
                        color: #EC534E;
                        font-size: 0.12rem;
                        border:1px solid #EC534E;
                        box-sizing: border-box;
                        background-color: #fff;
                        height: 0.28rem;
                        line-height: 0.28rem;
                    }
                }
            }
            .buy_btn{
                float: right;
                a{
                    display: block;
                    color: #333;
                    font-size: 0.32rem;
                    text-align: center;
                    line-height: 1.1rem;
                    &.join_car{
                        float: left;
                        width: 1.99rem;
                        background-color: #fc8c35;
                    }
                    &.buy_now{
                        float: left;
                        width: 1.69rem;
                        background-color: #ffdc4b;
                    }
                }
            }
        }
        .size_box{
            background-color: #fff;
            position: relative;
            h4{
                line-height: 1rem;
                text-align: center;
                border-bottom: 1px solid #d9d9d9;
                font-size: 0.34rem;
                color: #333;
            }
            .icon-cha{
                position: absolute;
                font-size: 0.25rem;
                color: #666;
                top:0.3rem;
                right: 0.2rem;
            }
            .goods_content{
                padding:0.2rem 0;
                border-bottom: 1px solid #d9d9d9;
                box-sizing: border-box;
                .goods_img{
                    float: left;
                    margin-left: 0.2rem;
                    width: 1.3rem;
                    height: 1.3rem;
                    img{
                        width:100%;
                        height:100%;
                    }
                }
                .goods_mations{
                    float: left;
                    margin-left: 0.2rem;
                    width: 5.5rem;
                    font-size: 0.28rem;
                    h5{
                        
                        color: #333;
                        font-family: 'PingFang-SC-Regular';
                    }
                    p{
                        margin-top: 0.35rem;
                        .price{
                            float: left;
                            color: #ff3461;
                        }
                        .num{
                            float: right;
                            color: #999;
                        }
                    }
                }
            }
            .size_main{
                max-height: 4.9rem;
                overflow-y: scroll;
                .goods_color{
                    padding:0.3rem 0.2rem;
                    border-bottom: 1px solid #d9d9d9;
                    
                    h6{
                        font-size: 0.28rem;
                        color: #333;
                        font-weight: bold;
                        font-family:'PingFang-SC-Bold';
                        margin-bottom: 0.2rem;
                        margin-left: 0.1rem;
                    }
                    ul{
                        li{
                            float: left;
                            padding:0 0.2rem;
                            height: 0.63rem;
                            border-radius: 0.15rem;
                            border: 1px solid #d9d9d9;
                            text-align: center;
                            box-sizing: border-box;
                            line-height: 0.63rem;
                            margin-right: 0.14rem;
                            margin-bottom: 0.1rem;
                            font-size: 0.24rem;
                            &.active{
                                color: #fff;
                            }
                        }
                    }
                }
                .buy_num{
                    position: relative;
                    padding: 0.2rem 0.3rem 0;
                     &.buy_num1{
                        padding-bottom: 0.2rem;
                    }
                    h6{
                        float: left;
                        font-size: 0.28rem;
                        font-weight: bold;
                        font-family: 'PingFang-SC-Bold';
                        color: #333;
                    }
                    
                    .goods_number{
                        float: right;
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
                        .num{
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
                .maxLimit{
                    float: left;
                    font-size: 0.28rem;
                    color: #EC534E;
                    margin-bottom: 0.2rem;
                    padding-left: 0.3rem;
                }
            }
            
            .ensure_btn{
                display: block;
                width: 100%;
                background-color: #ffdc4b;
                border:none 0;
                font-size: 0.32rem;
                color: #333;
                padding: 0.25rem 0;
                text-align: center;
                &.empty{
                    background-color: #ddd;
                }
            }
        }
        .goLook{
           border-radius: 0.1rem; 
        }
        .looking{
            width: 5.83rem;
            padding-bottom: 0.2rem;
            h5{
                line-height: 1rem;
                text-align: center;
                color: #333;
                font-weight: bold;
                font-size: 0.34rem;
                box-sizing: border-box;
                border-bottom: 1px solid #f5f5f5;
                position: relative;
                i{
                    position: absolute;
                    font-size: 0.15rem;
                    color: #999;
                    right: 0.3rem;
                    top: 0.2rem;
                    line-height: 1;
                }
            }
            .look_list{
                max-height: 4rem;
                overflow-y: scroll;
            }
            ul{
                li{
                    padding: 0 0.2rem;
                    box-sizing: border-box;
                    border-bottom: 1px solid #f5f5f5;
                    height: 1rem;
                    .user_pic{
                        float: left;
                        width: 0.7rem;
                        height: 0.7rem;
                        margin-top: 0.15rem;
                        border-radius: 50%;
                        overflow: hidden;
                        img{
                            width: 100%;
                            height: 100%;
                            display: block;
                        }
                    }
                    .user_mations{
                        float: left;
                        margin-top: 0.15rem;
                        margin-left: 0.2rem;
                        p{
                           font-size: 0.28rem;
                           color: #333;
                           span{
                               display: inline-block;
                               margin-left: 0.1rem;
                               font-size: 0.24rem;
                               color: #bcbcbc;
                           } 
                           &:last-child{
                               font-size: 0.24rem;
                               color: #000;
                           }
                        }
                    }
                    .goBargain{
                        float: right;
                        width: 1.24rem;
                        height: 0.51rem;
                        background-color: #fc8c35;
                        border-radius: 0.1rem;
                        color: #fff;
                        text-align: center;
                        line-height: 0.51rem;
                        font-size: 0.24rem;
                        margin-top: 0.25rem;
                    }
                }
            }
        }
        .partake_box{
            border-radius: 0.1rem;
            .partake{
                background-color: #fff;
                width: 5.47rem;
                padding-top: 0.4rem;
                padding-bottom: 0.3rem;
                border-radius: 0.1rem;
                position: relative;
                .icon-cha{
                    position: absolute;
                    right: 0.2rem;
                    top:0.2rem;
                    font-size: 0.25rem;
                    color: #999;
                }
                h4{
                    text-align: center;
                    color: #333;
                    font-size: 0.34rem;
                    font-weight: bold;
                    font-family: 'PingFang-SC-Bold';
                }
                p{
                    text-align: center;
                    color: #333333;
                    font-weight: bold;
                    font-size: 0.28rem;
                    margin-top: 0.1rem;
                    font-family:'PingFang-SC-Bold';
                    span{
                        color: #f00;
                    }
                }
                ul{
                    display: table;
                    margin: 0.3rem auto 0;
                    padding:0 0.2rem;
                    text-align: center;
                    li{
                        display: inline-block;
                        margin-right: 0.2rem;
                        margin-bottom: 0.2rem;
                        &:last-child{
                            margin-left: 0.05rem;
                        }
                        .part_user{
                            width: 1.05rem;
                            height: 1.05rem;
                            border-radius: 50%;
                            overflow: hidden;
                            img{
                                display: block;
                                width: 100%;
                                height: 100%;
                            }
                            i{
                                display: block;
                                font-size: 1.25rem;
                                color: #C1C1C1;
                                margin-top: -0.1rem;
                                margin-left: -0.05rem;
                            }
                        }
                    }
                }
                .take_part{
                    display: block;
                    width: 3.39rem;
                    height: 0.55rem;
                    text-align: center;
                    line-height: 0.55rem;
                    background-color: #fc8c35;
                    color: #fff;
                    border-radius: 0.1rem;
                    font-size: 0.24rem;
                    margin:0 auto;
                }
            }
        }
    }
    .confirm_box{
        display: flex;
        display: -webkit-flex;
    	a{
    		flex: 1;
    		text-align: center;
    		line-height: 1.1rem;
    		font-size: 0.32rem;
    		color: #fff;
    	}
    }
    .tables{
        min-height:2rem;
        background-color: #fff;
    }
</style>
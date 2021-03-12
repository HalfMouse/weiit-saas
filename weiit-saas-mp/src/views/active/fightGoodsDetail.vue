<template>
    <div class="goods_detail">
        <!-- 商品信息 -->
        <loading v-show="isLoading"></loading>
        <div v-show="!isLoading">
            <div class="goods_show">
                <!-- 头部图片展示 -->
                <div class="goods">
                    <mt-swipe :auto="0">
                        <mt-swipe-item v-for="(item, index) in productInfo.product_imgs" :key="index">
                            <div class="show">
                                <img :src="$url + item.product_img" alt="">
                            </div>
                        </mt-swipe-item>
                    </mt-swipe>
                    <!-- <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <div class="swiper" v-for="item in productInfo.product_imgs">
                                <img :src="$url + item.product_img" alt="">
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div> -->
                    
                </div>
                <!-- 商品信息介绍 -->
                <div class="goods_txt">
                    <h4>{{productInfo.product_name}}</h4>
                    <div class="cost clearfix">
                        <div class="money">
                            <!-- <span>￥{{productInfo.sale_price}}</span> -->
                            <span>￥{{extInfo.groupon_price}}</span>
                            <span>￥{{productInfo.smarket_price}}</span>
                        </div>
                        <div class="discount">
                            <ul class="clearfix">
                                <li v-for="item in productInfo.tag_info">
                                    {{item.tag_name}}
                                </li>
                            </ul>
                            <p class="Sales">已拼{{hasGrouponCount}}件 | {{groupon_number}}人团</p>
                        </div>
                    </div>
                </div>
            </div>
            <p class="express_money">运费：{{productInfo.expressInfo}}</p>
            
            <!-- 拼单 -->
            <div class="circumstance" v-if="inProcessGroupon.length > 0">
                <h4>
                    {{extInfo.allInGroupon}}人在拼单
                    <a href="javascript:;" class="look_more" @click="look = true">查看更多></a>
                </h4>
                <div class="partake_list">
                    <ul>
                        <li v-for="(item,index) in inProcessGroupon">
                            <div class="user clearfix">
                                <div class="user_pic">
                                    <img :src="item.user_img" alt="">
                                </div>
                                <p class="user_name">{{item.user_name}}</p>
                            </div>
                            <a href="javascript:;" class="goBargain" @click="goPartake(item)" :style="{background:color1}">去拼单</a>
                            <div class="bargain_situation">
                                <p class="num">还差<span>{{item.owe_people}}人</span>拼成</p>
                                <p class="time">剩余{{countdDown(item)}}{{item.time}}</p>
                            </div>
                        </li>
                    </ul>
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
                    <div class="goods_introduce" v-html="product_desc">
                        {{product_desc}}
                    </div>
                    
                </van-tab>
                <van-tab :title="'商品属性'">
                    <!-- 商品注解 -->
                    <div class="goods_attribute" v-if="attribute_info.length > 0">
                        <ul class="clearfix">
                            <li :key="index" class="attribute_info" v-for="(item,index) in productInfo.attribute_info">
                                <span class="attribute_name">{{item.attribute_name}}</span>
                                <span class="attribute_value">{{item.attribute_value}}</span>   
                            </li>
                        </ul>
                    </div>
                </van-tab>
            </van-tabs>
            

            <!-- 底部信息 -->
            <div class="buy">
                <!-- <div class="buy_ability"> -->
                    <!-- 首页 -->
                    <!-- <div class="abilities" @click="toHome()">
                        <i class="icon iconfont icon-home"></i>
                        <span>首页</span>
                    </div> -->
                    <!-- 购物车 -->
                    <!-- <div class="abilities" @click="toShop()">
                        <i class="icon iconfont icon-gouwuche"></i>
                        <span>购物车</span>
                    </div> -->
                    <!-- 收藏 -->
                    <!-- <div class="abilities" @click="collected()">
                        <i class="icon iconfont" :class="isCollected ? 'icon-shoucang2' : 'icon-shoucang3'"></i>
                        <span v-if="!isCollected">收藏</span>
                        <span v-else>已收藏</span>
                    </div> -->
                <!-- </div> -->
                <!-- 右侧加入购物和立即购买按钮 -->
                <div class="share_btn" v-if="isShare == 'snatching' && surplusNum && surplusNum > 0" :style="{background:color1,color:'#fff'}" @click="isShare = true">
                    <a href="javascript:;">邀请好友拼单</a>
                </div>
                <div class="buy_btn" v-else>
                    <a href="javascript:;" class="join_car" @click="chooseSize('single')" :style="{background:color2,color:'#fff'}">
                        <!-- <span>￥{{productInfo.sale_price}}</span> -->
                        <h1>单独购买</h1> 
                    </a>
                    <a href="javascript:;" class="buy_now" @click="chooseSize('fightBuy')" :style="{background:color1,color:'#fff'}">
                        <!-- <span>￥{{productInfo.sale_price}}</span> -->
                        <h1>发起拼团</h1> 
                    </a>
                </div>
            </div>
            <text-nav v-show="!isLoading"></text-nav>
            <!-- 拼单查看更多弹出框 -->
            <mt-popup v-model="look" class="goLook">
                <div class="looking">
                    <h5>
                        正在拼单
                        <i class="icon iconfont icon-cha" @click="look = false"></i>
                    </h5>
                    <div class="look_list"> 
                        <ul>
                            <li class="clearfix" v-for="item in inProcessGroupon">
                                <div class="user_pic">
                                    <img :src="item.user_img" alt="">
                                </div>
                                <div class="user_mations">
                                    <p>
                                        {{item.user_name}}<span>还差{{item.owe_people}}人</span>
                                    </p>
                                    <p>
                                        剩余{{countdDown(item)}}{{item.time}}
                                    </p>
                                </div>
                                <a href="javascript:;" class="goBargain" @click="goPartake(item)" :style="{background:color1,color:'#fff'}">去拼单</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </mt-popup>
            <mt-popup v-model="isMore" class="partake_box">
                <div class="partake">
                    <i class="icon iconfont icon-cha" @click="isMore = false"></i>
                    <h4>参与{{partaker.user_name}}的拼单</h4>
                    <p>仅剩<span>{{partaker.owe_people}}</span>个名额，{{countdDown(partaker)}}{{partaker.time}}小时后结束</p>
                    <ul class="clearfix">
                        <li v-for="item in partaker.userImgArray">
                            <div class="part_user">
                                <img :src="item.user_img" alt="">
                            </div>
                        </li>
                        <li v-for="item in surplusShow">
                            <div class="part_user">
                                <img src="static/images/surplus.png" alt="">
                            </div>
                        </li>
                    </ul>
                    <a href="javascript:;" class="take_part"  :style="{background:color1,color:'#fff'}" @click="siglePartake(partaker)">参与拼单</a>
                </div>
            </mt-popup>
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
                            <div class="clearfix">
                                <div class="price">
                                    <!-- <span v-if="groupon_price > 0">￥{{groupon_price}}</span> -->
                                    <span v-if="buyType == 'single'">￥{{singleGrouponPrice}}</span>
                                    <span v-if="buyType == 'fightBuy'">￥{{groupon_price}}</span>
                                </div>
                                <div class="num">
                                    <span>库存：{{stock}}</span>
                                </div>
                            </div>
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
                        <div class="buy_num clearfix" :class="{'buy_num1':max_limit == 0}">
                            <h6>购买数量</h6>
                            
                            <div class="goods_number">
                                <div href="javascript:;" class="reduce" @click="reduce($event)">
                                    <i class="icon iconfont icon-jian1"></i>
                                </div>
                                <span class="num">{{num}}</span>
                                <div href="javascript:;" class="add" @click="add($event)">
                                    <i class="icon iconfont icon-jia1"></i>
                                </div>
                            </div>
                        </div>
                        <p class="maxLimit" v-if="max_limit > 0">该商品没人限购{{max_limit}}件</p>
                    </div>
                    <div v-if="confirmBtn">
                        <a href="javascript:;" class="ensure_btn" @click="ensure('none')" v-if="stock > 0" :style="{background:color1,color:'#fff'}">确定</a>
                        <a href="javascript:;" class="ensure_btn empty" v-else>库存不足</a>
                    </div>
                    <div class="confirm_box" v-if="!confirmBtn">
                        <a href="javascript:;" :style="{background:color2}" @click="ensure('single')" v-if="stock > 0">单独购买</a>
                        <a href="javascript:;" :style="{background:color1}" @click="ensure('fightBuy')" v-if="stock > 0">发起拼团</a>
                        <a href="javascript:;" class="ensure_btn empty" v-if="stock == 0">库存不足</a>
                    </div>
                </div>
            </mt-popup>
            <div class="shareWin" v-show="isShare" @click="isShare = false">
                <div class="share_tips">
                    <p>邀请好友成团获取更优惠价格，更加划算得到商品</p>
                </div>
                <span class="guide"></span>
            </div>
        </div>
    </div>
</template>

<script>
    // 引入 Swipe, SwipeItem, Popup, Toast
    import { Swipe, SwipeItem, Popup, Toast } from 'mint-ui';
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    // 引入倒计时
    import {downTime} from '../../../static/js/downTime'
    // 引入加载组件
    import loading from '@/components/loading'
    // 引入获取参数函数
    import {getQueryString} from '../../../static/js/getQueryString';
    // 引入cookie
    import cookie from '../../../static/js/cookies';
    import textNav from '@/components/textNav'
    export default {
        data(){
            return {
                isCollected:false,
                choose:false,
                look:false,
                // 商品id
                product_id:this.$route.query.product_id,
                // 砍价id
                groupon_id:this.$route.query.groupon_id,
                // 商品信息
                productInfo:{},
                userId:localStorage.getItem('user_id'),
                stockProduct:{},
                inProcessGroupon:[],
                extInfo:{},
                join_id:0,
                num:1,
                timer:null,
                // item_id:'',
                groupon_price:0,
                spec_custom:'',
                isShare:localStorage.getItem('look_detail'),
                attribute_info:[],
                user_id:'',
                g_order_id:'',
                spec_config:0,
                showImg:[],
                surplusShow:[],
                partaker:{},
                isMore:false,
                buyType:'',
                isLoading:true,
                product_desc:'',
                hasGrouponCount:'',
                isFlag:true,     
                hasCollection:true,
                max_limit:0,
                surplusNum:localStorage.getItem('surplusNum'),
                stock:0,
                isOk:false,
                groupon_number:0,    //一个团人数
                singleGrouponPrice:0,   //但规格拼团价格
                buyType:'',
                color1:localStorage.getItem('bg1'),
                color2:localStorage.getItem('bg2'),
                styleObject:{
                    background:localStorage.getItem('bg1'),
                    color:'#fff'
                },
                confirmBtn:true,
                active:0,
                isShare:false
            }
        },
        methods:{
            // 提交订单
            chooseSize(type){
                this.buyType = type;
                if(this.userId){
                	this.confirmBtn = true;
                    this.choose = true;
                    this.join_id = 0;
                    this.buyType = type;
                    // 查询库存
                    if(type == 'single'){
                        // 单独购买时信息
                        this.singleGrouponPrice = this.productInfo.sale_price;
                        axios.post('/api/product/productSpecCheck',qs.stringify({
                            spec_custom:this.spec_custom,
                            product_id:this.product_id
                        })).then((res) => {
                            if(res.data.code == '0'){
                                this.stockProduct = res.data.data;
                                this.item_id = this.stockProduct.item_id;
                                this.singleGrouponPrice = this.stockProduct.sale_price;
                            }
                        }).catch((err) => {
                            console.log(err);
                        })
                    }else if(type == 'fightBuy'){
                        // 拼团购买时信息
                        localStorage.setItem('costMent','launch')
                        axios.post('/api/groupon/productSpecCheck',qs.stringify({
                            spec_custom:this.spec_custom,
                            product_id:this.product_id
                        })).then((res) => {
                            if(res.data.code == '0'){
                                this.stockProduct = res.data.data;
                                this.item_id = this.stockProduct.item_id;
                                this.groupon_price = this.stockProduct.groupon_price;
                            }
                        }).catch((err) => {
                            console.log(err);
                        })
                    }
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
                
                if(this.isFlag){
                	if(tip == 'single'){
                		this.buyType == 'single'
                	}else if(tip == 'fightBuy'){
                		this.costMent = 'fightBuy';
                	}
                    // 选择的规格
                    let spec_content;
                    // 规则选择标识
                    let hasSize = true;
                    let item_id;
                    // 判断是否是多规格选择
                    if(this.productInfo.spec_config == 1){
                        
                        // 是否规则都勾选
                        if(this.checkSize()){
                            
                            let specArr = [];
                            this.productInfo.spec_info.forEach((item) => {
                                item.values.forEach((ele) => {
                                    if(ele.isChecked){
                                        specArr.push(ele.spec_value)
                                    }
                                })
                            })
                            
                            spec_content = specArr.join(';');
                            item_id = this.stockProduct.item_id;
                        }else{
                            Toast('请选择商品属性');
                            hasSize = false;
                            this.isFlag = true;
                            this.isOk = true;
                        }
                    }else{
                        spec_content = '';
                        
                        item_id = this.productInfo.item_id;
                        this.isOk = true;
                    }
                    if(hasSize && this.isOk){
                        this.isFlag = false;
                        if(this.buyType == 'single'){
                            axios.post('/api/product/addUserCart',qs.stringify({
                                product_id:localStorage.getItem('product_id'),
                                item_id:item_id,
                                spec_content:spec_content,
                                count:this.num
                            })).then((res) => {
                                if(res.data.code == '0'){
                                    this.$router.push({
                                        path:'/shopCar',
                                        name:'shopCar'
                                    })   
                                }else{
                                    
                                    Toast('你已经达到限购数量上限，请不要再添加了~')
                                }
                                this.isFlag = true;
                                this.isOk = false
                            }).catch((err) => {
                                console.log(err);
                            })
                        }else{
                            if(this.stock >= parseInt(this.groupon_number)){
                                localStorage.setItem('toFightshop','fightGood');
                                localStorage.setItem('productInfo',JSON.stringify(this.productInfo))
                                localStorage.setItem('goodsNumber',this.num)
                                localStorage.setItem('item_id',item_id);
                                localStorage.setItem('share_user_id',this.user_id);
                                localStorage.setItem('g_order_id',this.g_order_id)
                                localStorage.setItem('product_stock',this.stock)
                                localStorage.setItem('groupon_price',this.groupon_price)
                                localStorage.setItem('maxLimit',this.max_limit)
                                localStorage.setItem('spec_content',spec_content)
                                this.$router.push({
                                    path:'/fightShop',
                                    name:'fightShop'
                                })     
                            }else{
                                Toast('库存不足以成团，请单独购买！')
                            }
                            
                            this.isFlag = true;
                        }
                        
                    }
                }
            },
            // 获取商品信息
            getFightGoods(product_id,groupon_id){
                if(this.userId){
                    axios.post('/api/groupon/grouponProduct',qs.stringify({
                        product_id:product_id,
                        groupon_id:groupon_id
                    })).then((res) => {
                        if(res.data.code == '0'){
                            console.log(res);
                            this.hasGrouponCount = res.data.data.hasGrouponCount;
                            this.productInfo = res.data.data.productDetail.product_info;
                            this.product_desc = this.productInfo.product_desc.replace(/img/g,'img style="width:100%;float:left"');
                            this.product_desc = this.product_desc.replace(/<p/g,'<p style="font-size:0.28rem;overflow:hidden;"');
                            this.inProcessGroupon = res.data.data.inProcessGroupon;
                            this.extInfo = res.data.data.extInfo;
                            this.attribute_info = res.data.data.productDetail.product_info.attribute_info;
                            this.spec_config = this.productInfo.spec_config;
                            this.isLoading = false;
                            this.max_limit = this.productInfo.max_limit;
                            this.stock = this.productInfo.stock;
                            this.groupon_number = res.data.data.extInfo.groupon_number;
                            this.groupon_price = this.extInfo.groupon_price;
                            this.singleGrouponPrice = this.productInfo.sale_price;
                            if(this.stock > 0){
                                this.num = 1;
                            }else{
                                this.num = 0;
                            }
                            if(this.productInfo.spec_config == '0'){
                                this.item_id = this.productInfo.item_id;
                            }
                            this.inProcessGroupon.forEach((item) => {
                                this.$set(item,'partake',false);
                                this.$set(item,'userImgArray',[]);
                                this.$set(item,'time','');
                            })
                            this.share(this.productInfo.product_name, this.$url + this.productInfo.product_img);
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }else{
                    
                }
            },
            // 取消加入收藏
            collected(){
                if(this.hasCollection){
                    if(this.userId){
                        let id = localStorage.getItem('product_id');
                        if(!this.isCollected){
                            // 加入收藏
                            this.hasCollection = false;
                            axios.post('/api/product/addProductCollection',qs.stringify({
                                product_id:id
                            })).then((res) => {
                                if(res.data.code == '0'){
                                    this.hasCollection = true;
                                    this.isCollected = !this.isCollected;
                                    Toast('收藏成功');
                                }
                            }).catch((err) => {
                                console.log(err);
                            })
                            
                        }else{
                            // 取消加入收藏
                            this.hasCollection = false;
                            axios.post('/api/user/myCollectionDelete',qs.stringify({
                                product_id:id
                            })).then((res) => {
                                if(res.data.code == '0'){
                                    this.hasCollection = true;
                                    this.isCollected = !this.isCollected;
                                    Toast('取消宝贝收藏');
                                }
                            }).catch((err) => {
                                console.log(err);
                            })
                        }
                    }
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
                    this.spec_custom = this.doSelSpec();
                    // 查询库存
                    if(this.buyType == 'single'){
                        // 单独购买时信息
                        axios.post('/api/product/productSpecCheck',qs.stringify({
                            spec_custom:this.spec_custom,
                            product_id:this.product_id
                        })).then((res) => {
                            if(res.data.code == '0'){
                                this.stockProduct = res.data.data;
                                this.item_id = this.stockProduct.item_id;
                                this.groupon_price = this.stockProduct.sale_price;
                                this.isOk = true;
                                if(!this.stockProduct.stock || this.stockProduct.stock == 0){
                                    this.num = 0;
                                    this.stock = 0;
                                }else if(this.stockProduct.stock < this.num){
                                    this.stock = this.stockProduct.stock;
                                    this.num = this.stockProduct.stock;
                                }
                            }
                        }).catch((err) => {
                            console.log(err);
                        })
                    }else if(this.buyType == 'fightBuy'){
                        // 拼团购买时信息
                        axios.post('/api/groupon/productSpecCheck',qs.stringify({
                            spec_custom:this.spec_custom,
                            product_id:this.product_id
                        })).then((res) => {
                            if(res.data.code == '0'){
                                this.stockProduct = res.data.data;
                                this.item_id = this.stockProduct.item_id;
                                this.groupon_price = this.stockProduct.groupon_price;
                                this.isOk = true;
                                if(!this.stockProduct.stock || this.stockProduct.stock == 0){
                                    this.num = 0;
                                    this.stock = 0;
                                }else{
                                    this.stock = this.stockProduct.stock;
                                    if(this.stockProduct.stock < this.num){
                                        this.num = this.stockProduct.stock;
                                    }
                                }
                            }
                        }).catch((err) => {
                            console.log(err);
                        })
                    }
                    
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
                let totalCount;
                if(this.max_limit > 0 && this.stock > this.max_limit){
                    totalCount = this.max_limit
                }else{
                    totalCount = this.stock
                }
                if(this.num < totalCount){
                    if(this.num > 99){
                        this.num = 99;
                    }else{
                        this.num++;
                    }
                }else{
                    this.num = totalCount;
                    Toast('你添加的数量超过商品上限,请不要再添加了');
                }
                
                e.stopPropagation();
            },
            // 减少商品数量
            reduce(e){
                e.stopPropagation();
                if(this.num <= 1){
                    this.num = 1
                }else{
                    this.num--;
                }
            },
            // 倒计时
            countdDown(item){
                // let times = null;
                this.timer = setInterval(() => {
                    let nowTime = new Date().getTime();
                    let targetTime = item.end_time - nowTime;
                    item.time = downTime(targetTime);
                },1000)
            },
            // 参与拼团
            siglePartake(item){
                this.isMore = false;
                this.choose = true;
                localStorage.setItem('costMent','partake')
                this.buyType = 'fightBuy'
                this.user_id = item.user_id;
                this.g_order_id = item.g_order_id;
                this.join_id = -1;
            },
            // 获取参与人数信息
            goPartake(item){
                this.look = false;
                this.partaker = item;
                axios.post('/api/groupon/getJoinGrouponInfo', qs.stringify({
                    g_order_id:item.g_order_id,
                    groupon_id:this.groupon_id
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.partaker.isJoin = res.data.data.isJoin;
                        if(res.data.data.isJoin){
                            Toast('你已经参加过这个拼团');
                        }else{
                            this.isMore = true;
                        }
                        
                        this.partaker.userImgArray = res.data.data.user_img;
                        let total = res.data.data.groupon_number;
                        if(total > 8){
                            this.surplusShow.length = 8 - this.partaker.userImgArray.length;
                        }else{
                            this.surplusShow.length = total - this.partaker.userImgArray.length;
                        }
                    }
                })
                .catch((err) => {
                    console.log(err);
                })   
            },
            // 返回首页
            toHome(){
                this.$router.push({
                    path:'/33',
                    name:'home'
                })
            },
            // 分享给好友
            share(title, imgUrl){
                let host = document.location.hostname;
                let protocol = document.location.protocol;  
                let user_id = localStorage.getItem('user_id')
                let currentUrl = `${protocol}//${host}`; 
                // let title = localStorage.getItem('shareFightGoodName');
                // let imgUrl = this.$url + localStorage.getItem('shareFightGoodImage');
                let url = currentUrl + "/fightDetail?groupon_id=" + localStorage.getItem('groupon_id') +  "&product_id=" + localStorage.getItem('product_id') + "&forward=fightDetail&share_user_id=" + user_id;
                wx.ready(function(res) {
                    wx.onMenuShareAppMessage({
                        title: title,
                        desc:'',
                        link: url,
                        imgUrl: imgUrl,
                        trigger: function(res) {},
                        success: function(res) {},
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
            //打开选择规则弹窗
            choiceRule(){
            	this.choose = true;
            	this.confirmBtn = false;
            }
        },
        mounted(){
            if(getQueryString('product_id') != undefined){
                this.isParket = false;
                // this.g_order_id = getQueryString('g_order_id');
                this.product_id = getQueryString('product_id');
                this.groupon_id = getQueryString('groupon_id');
                localStorage.setItem('groupon_id',this.groupon_id);
                this.getFightGoods(this.product_id,this.groupon_id);
            }else if(localStorage.getItem('forward') == 'fightDetail'){
                this.isParket = false;
                const urlObj = (JSON.parse(localStorage.getItem('urlObject')));
                // this.g_order_id = urlObj.g_order_id;
                this.product_id = urlObj.product_id;
                this.groupon_id = urlObj.groupon_id;
                localStorage.setItem('groupon_id',this.groupon_id);
                this.getFightGoods(this.product_id,this.groupon_id);
            }else{
                this.getFightGoods(this.product_id,this.groupon_id);
                // this.getInvitation(this.g_order_id);
            }
            // this.countdDown();
            
        },
        components:{
            loading,
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
        }
    }
</script>

<style scoped lang="scss">
    .goods_detail{
        padding-bottom: 1.1rem;
        .goods_show{
            background-color: #fff;
            margin-bottom: 0.2rem;
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
                   font-size: 0.34rem;
                   color: #333;
                   font-weight: bold; 
                }
                .cost{
                    margin-top:0.3rem;
                    .money{
                        float: left;
                        text-align: center;
                        span{
                            display: block;
                            color: #ec534e;
                            font-size: 0.32rem;
                            &:last-child{
                                font-size: 0.28rem;
                                color: #999;
                                margin-top: 0.1rem;
                                text-decoration: line-through;
                            }
                        }
                    }
                    .discount{
                        float: right;
                        ul{
                            li{
                                float: right;
                                height: 0.48rem;
                                margin-left: 0.1rem;
                                border-radius: 0.08rem;
                                text-align: center;
                                box-sizing: border-box;
                                line-height: 0.48rem;
                                border: 1px solid #ec534e;
                                color: #ec534e;
                                font-size: 0.3rem;
                                padding: 0 0.1rem;
                            }
                        }
                        p{
                            text-align: right;
                            font-size: 0.24rem;
                            color: #999;
                            margin-top: 0.1rem;
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
        .express_money{
            font-size:0.26rem;
            color: #999;
            margin:0.2rem 0;
            padding-left:0.1rem;
            background-color:#fff;
            padding:0.15rem 0.3rem;
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
            .partake_list{
                max-height:2rem;
                overflow-y: scroll;
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
                            float: right;
                            margin-right: 0.2rem;
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
            padding: 0.15rem;
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
            margin-top: 0.2rem;
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
            // .buy_ability{
            //     float: left;
            //     width: calc(100% - 3.68rem);
            //     padding: 0.1rem 0;
            //     .abilities{
            //         float: left;
            //         width: calc(100% / 3);
            //         text-align: center;
            //         padding-top: 0.15rem;
            //         position: relative;
            //         i{
            //             display: block;
            //             font-size: 0.44rem;
            //             &.icon-shoucang2{
            //                 color: #EC534E;
            //             }
            //         }
            //         span{
            //             display: block;
            //             color: #666;
            //             font-size: 0.28rem;
            //             margin-top: 0.05rem;
            //         }
            //         .num{
            //             position: absolute;
            //             top: 0;
            //             right: 0.1rem;
            //             // padding:0 0.05rem;
            //             padding:0 0.05rem;
            //             border-radius: 0.14rem;
            //             text-align: center;
            //             color: #EC534E;
            //             font-size: 0.12rem;
            //             border:1px solid #EC534E;
            //             box-sizing: border-box;
            //             background-color: #fff;
            //             height: 0.28rem;
            //             line-height: 0.28rem;
            //         }
            //     }
            // }
            .buy_btn{
                // float: right;
                display: flex;
                display: -webkit-flex;
                a{
                    flex: 1;
                    display: block;
                    color: #333;
                    font-size: 0.32rem;
                    text-align: center;
                    line-height: 1.1rem;
                    h1{
                        font-size: 0.32rem;
                    }
                    &.join_car{
                        float: left;
                        width: 1.99rem;
                        background-color: #fc8c35;
                    }
                    &.buy_now{
                        float: left;
                        width: 1.69rem;
                        background-color: #ffdc4b;
                        color: #fff;
                    }
                }
            }
            .share_btn{
                line-height: 1.1rem;
                a{
                    display: block;
                    text-align: center;
                    font-size: 0.34rem;
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
                    h5{
                        font-size: 0.28rem;
                        color: #333;
                        font-family: 'PingFang-SC-Regular';
                    }
                    div{
                        font-size: 0.28rem;
                        margin-top: 0.28rem;
                        .price{
                            float: left;
                            color: #ff3461
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
                        font-weight: bold;
                        font-family: 'PingFang-SC-Bold';
                        color: #333;
                        top: 0.2rem;
                        font-size: 0.28rem;
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
                line-height: 0.8rem;
                text-align: center;
                color: #333;
                font-weight: bold;
                font-size: 0.34rem;
                box-sizing: border-box;
                border-bottom: 1px solid #f5f5f5;
                position: relative;
                i{
                    position: absolute;
                    color: #999;
                    right: 0.15rem;
                    top: -0.08rem;
                    font-size:0.28rem;
                }
            }
            .look_list{
                max-height: 4rem;
                overflow-y: scroll;
            }
            ul{
                li{
                    padding: 0.15rem 0.2rem;
                    box-sizing: border-box;
                    border-bottom: 1px solid #f5f5f5;
                    position: relative;
                    .user_pic{
                        float: left;
                        width: 0.8rem;
                        height: 0.8rem;
                        border-radius: 50%;
                        overflow: hidden;
                        img{
                            width: 100%;
                            height: 100%;
                            display: block;
                        }
                    }
                    .user_mations{
                        position: absolute;
                        top:50%;
                        transform: translateY(-50%);
                        left: 1.4rem;
                        p{
                           font-size: 0.3rem;
                           color: #333;
                           span{
                               display: inline-block;
                               margin-left: 0.1rem;
                               font-size: 0.26rem;
                               color: #bcbcbc;
                           } 
                           &:last-child{
                               font-size: 0.28rem;
                               color: #000;
                               margin-top: 0.05rem;
                           }
                        }
                    }
                    .goBargain{
                        position: absolute;
                        top:50%;
                        transform: translateY(-50%);
                        right:0.2rem;
                        background-color: #fc8c35;
                        border-radius: 0.1rem;
                        color: #fff;
                        text-align: center;
                        font-size: 0.28rem;
                        padding: 0.1rem 0.1rem;
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
                    font-size: 0.3rem;
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
                        border: none 0;
                        &:last-child{
                            margin-left: 0.05rem;
                        }
                        .part_user{
                            width: 1.05rem;
                            height: 1.05rem;
                            border-radius: 50%;
                            overflow: hidden;
                            img{
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
                    text-align: center;
                    background-color: #fc8c35;
                    color: #fff;
                    border-radius: 0.1rem;
                    font-size: 0.28rem;
                    margin:0 auto;
                    padding: 0.15rem 0;
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
    .shareWin{
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,.7);
            .share_tips{
                width: 5rem;
                position: absolute;
                left: 50%;
                transform: translateX(-50%);
                top:3rem;
                background-color: #fff;
                border-radius: 0.2rem;
                padding: 0.45rem 0.3rem;
                
                h5{
                    font-size: 0.32rem;
                    text-align: center;
                    margin-bottom: 0.2rem;
                    font-weight: 700;
                    span{
                        color: #ec534e;
                    }
                }
                p{
                    font-size: 0.28rem;
                    text-align: center;
                    margin: 0 auto;
                    font-weight: 500;
                }
            }
            .guide{
                position:absolute;
                right: 0.75rem;
                top: 0.5rem;
                width: 2rem;
                height: 1.87rem;
                background-image: url('../../../static/images/guide.png');
                background-size: 100% 100%;
            }
        }
</style>
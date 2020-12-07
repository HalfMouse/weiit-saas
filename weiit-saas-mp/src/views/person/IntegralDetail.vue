<template>
    <div class="goods_detail">
        <loading v-show="isLoading"></loading>
        <!-- 商品信息 -->
        <div v-show="!isLoading">
            <div class="goods_show">
                <!-- 头部图片展示 -->
                <div class="goods">
                    <mt-swipe :auto="0">
                        <mt-swipe-item v-for="(item, index) in product_imgs" :key="index">
                            <div class="show">
                                <img :src="$url + item.product_img" alt="">
                            </div>
                        </mt-swipe-item>
                    </mt-swipe>
                </div>
                <!-- 商品信息介绍 -->
                <div class="goods_txt">
                    <h4>{{product_name}}</h4>
                    <div class="cost clearfix">
                        <div class="money">
                            <span>￥{{integral_price}} + {{integral}}积分</span>
                            <span>￥{{sale_price}}</span>
                        </div>
                        <div class="discount">
                            <p>运费：{{expressInfo}}</p>
                            <p class="Sales">库存{{stock}} | 已售{{sale_count}}</p>
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
                    <div class="goods_attribute" v-if="attribute_info.length > 0">
                        <ul class="clearfix">
                            <li class="attribute_info" v-for="item in attribute_info">
                                <span class="attribute_name">{{item.attribute_name}}</span>
                                <span class="attribute_value">{{item.attribute_value}}</span>   
                            </li>
                        </ul>
                    </div>
                </van-tab>
            </van-tabs>
            
            
            <!-- 底部信息 -->
            <div class="buy">
                <a href="javascript:;" class="buy_now" :style="{background:color1,color:'#fff'}" @click="choose = true">立即兑换</a>
            </div>
            <!-- 底部商品规格选择弹出框 -->
            <mt-popup v-model="choose" position="bottom">
                <div class="size_box">
                    <h4>选择规格</h4>
                    <i class="icon iconfont icon-cha" @click="choose = false"></i>
                    <!-- 选择商品信息 -->
                    <div class="goods_content clearfix">
                        <div class="goods_img">
                            <img :src="$url + product_img" alt="">
                        </div>
                        <div class="goods_mations">
                            <h5>{{product_name}}</h5>
                            <p class="clearfix">
                                <span class="price">￥{{sale_price}}</span>
                                <span class="num">库存：{{stock}}</span>
                            </p>
                        </div>
                    </div>
                    <div class="size_main">
                        <!-- 商品数量选择 -->
                        <div class="buy_num clearfix" :class="{'buy_num1':max_limit == 0}">
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
                    <div>
                        <a href="javascript:;" class="ensure_btn" @click="ensure()" v-if="stock > 0" :style="{background:color1,color:'#fff'}">确定</a>
                        <a href="javascript:;" class="ensure_btn empty" v-else>库存不足</a>
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
                choose:false,
                counts:0,
                isLoading:true,
                product_desc:'',
                isFlag:true,     
                // 限购数量
                max_limit:0,
                stock:0,
                // 规则是否选择
                isOk:false,
                color1:localStorage.getItem('bg1'),
                color2:localStorage.getItem('bg2'),
                active:0,
                price:0,
                integralInfo:null,
                information:null,
                product_imgs:[],
                product_name:'',
                integral_price:0,
                integral:0,
                sale_price:0,
                stock:0,
                sale_count:0,
                expressInfo:'',
                attribute_info:[],
                product_img:'',
                // validate_id:this.$route.query.validate_id,
                // validate_id_token:this.$route.query.validate_id_token
            }
        },
        methods:{
            // 提交订单
            chooseSize(type){
                this.choose = true;
            },
            
            // 获取商品信息
            getGoods(){
                axios.post('/api/integral/integralProductDetail', qs.stringify({
                    validate_id: this.$route.query.validate_id,
                    validate_id_token: this.$route.query.validate_id_token
                })).then((res) => {
                    console.log(res);
                    if(res.data.code == '0'){
                        this.load = true,
                        this.stock = res.data.data.productDetail.product_info.stock, //商品库存
                        this.price = res.data.data.productDetail.product_info.sale_price, //商品价格
                        this.maxLimit = res.data.data.integralInfo.max_limit, //限购数量
                        this.information = res.data.data.productDetail.product_info,
                        this.integralInfo = res.data.data.integralInfo;
                        this.product_imgs = this.information.product_imgs;
                        this.product_name = this.information.product_name;
                        this.integral_price = this.integralInfo.integral_price;
                        this.integral = this.integralInfo.integral;
                        this.sale_price = this.information.sale_price;
                        this.stock = this.information.stock;
                        this.sale_count = this.information.sale_count;
                        this.expressInfo = this.information.expressInfo;
                        this.attribute_info = this.information.attribute_info;
                        this.product_img = this.information.product_img;
                        // 替换img标签和p标签内容
                        this.product_desc = this.information.product_desc.replace(/img/g,'img style="width:100%;float:left"');
                        this.product_desc = this.product_desc.replace(/<p/g,'<p style="font-size:0.28rem;overflow:hidden"');
                        this.product_desc = this.product_desc.replace(/<video/g,'<video style="width:100%;object-fit:cover" playsinline="true" webkit-playsinline="true" x-webkit-airplay="true"');
                        this.isLoading = false;
                        localStorage.setItem('shareGoodImage', this.product_img);
                        localStorage.setItem('shareGoodName', this.product_name);
                        if(this.stock > 0){
                            this.counts = 1;
                        }else{
                            this.counts = this.stock;
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
            },
            // 进入购物车
            toShop(){
                this.$router.push({
                    path:'/shopCar',
                    name:'shopCar',
                    params:{
                        inTo:'goods'
                    }
                })
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
            ensure(){
                var IntegralGoods = {
                    validate_id: this.$route.query.validate_id,
                    validate_id_token: this.$route.query.validate_id_token,
                    count: this.counts,
                    information: this.information, //商品详情内容
                    integralInfo: this.integralInfo //积分信息
                }
                localStorage.setItem('IntegralGoods',JSON.stringify(IntegralGoods))
                this.$router.push({
                    url: '/IntegralCar',
                    name: 'IntegralCar'
                })
            },
            //打开选择规则弹窗
            choiceRule(){
            	this.choose = true;
            }
            // 分享
        //     shareFriend(){
        //         let host = document.location.hostname;
        //         let protocol = document.location.protocol;  
        //         let user_id = localStorage.getItem('userId');
                // let currentUrl = `${protocol}//${host}?share_user_id=${user_id}`; 
        //         let imgUrl = this.$url + localStorage.getItem('shareGoodImage');
        //         let shareTitle = localStorage.getItem('shareGoodName');
        //         let url = location.href.split('#')[0] + "?product_id=" + localStorage.getItem('product_id') + "&forward=detail";
                
                
        //         wx.ready(function(res) {
        //             wx.onMenuShareAppMessage({
        //                 title: shareTitle,
        //                 desc:'',
        //                 link: url,
        //                 imgUrl:imgUrl
        //             });
        //             wx.onMenuShareTimeline({
        //                 title: shareTitle,
        //                 desc:"",
        //                 link: url,
        //                 imgUrl: imgUrl
        //             });
        //         });
        //     },
            
        },
        created(){
            // validate_id: validate_id,
            //         validate_id_token: validate_id_token
            // if(this.$route.params.validate_id){
            //     this.validate_id = this.$route.params.validate_id;
            //     this.validate_id_token = this.$route.params.validate_id_token
            // }else if(this.$route.params.target_id){
            //     this.product_id = this.$route.params.target_id;
            // }else{
            //     this.product_id = localStorage.getItem('product_id');
            // }
            // if(this.product_id){
            //     localStorage.setItem('product_id',this.product_id);
            // }
            // if(getQueryString('product_id') != undefined){
            //     this.product_id = getQueryString('product_id');
            //     this.getGoods(this.product_id)
            // }else if(localStorage.getItem('forward') == 'freeGet'){
            //     this.isHelp = false;
            //     const urlObj = (JSON.parse(localStorage.getItem('urlObject')));
            //     this.product_id = urlObj.product_id;
            //     this.getGoods(this.product_id)
            // }else{
            //     this.getGoods(this.product_id);
            // }
            // this.validate_id = this.$route.query.validate_id;
            // this.validate_id_token = this.$route.query.validate_id_token;
        },
        mounted(){
            //  this.shareFriend();
             this.getGoods()
        },
        // beforeRouteEnter:(to,from,next)=>{
        //     var u = navigator.userAgent;
        //     //ios终端
        //     var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
        //     // XXX: 修复iOS版微信HTML5 History兼容性问题
        //     if (isiOS && to.path !== location.pathname) {
        //         // 此处不可使用location.replace
        //         location.assign(to.fullPath)
        //     } else {
        //         next()
        //     }
        //      axios.post('/weixin/JSSDKWxConfig',qs.stringify({
        //             currentUrl:location.href.split('#')[0],
        //             appid:localStorage.getItem('appid')
        //         })).then((res) => {
        //             wx.config({
        //                 debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        //                 appId: res.data.data.appId, // 必填，公众号的唯一标识
        //                 timestamp: res.data.data.timeStamp, // 必填，生成签名的时间戳
        //                 nonceStr: res.data.data.nonceStr, // 必填，生成签名的随机串
        //                 signature: res.data.data.signature,// 必填，签名
        //                 jsApiList: [
        //                             "onMenuShareTimeline",//分享朋友圈接口
        //                             "onMenuShareAppMessage",//分享给朋友接口  
        //                             "startRecord",
        //                             "stopRecord",
        //                             "onVoiceRecordEnd",
        //                             "playVoice",
        //                             "chooseWXPay"
        //                 ] // 必填，需要使用的JS接口列表
        //             });
        //         }).catch((err) => {
        //             console.log(err);
        //         })
        //     next();
        // },
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
            a{
                display: block;
                color: #333;
                font-size: 0.32rem;
                text-align: center;
                line-height: 1.1rem;
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
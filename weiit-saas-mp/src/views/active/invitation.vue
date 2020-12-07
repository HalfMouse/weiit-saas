<template>
    <div class="invitation">
        <loading v-show="isLoading"></loading>
        <div v-show="!isLoading">
            <div class="main">
                <div class="goods_pic">
                    <img :src="$url + productInfo.product_img" alt="">
                </div>
                <div class="partake_person">
                    <ul>
                        <li v-for="(item,index) in showImg">
                            <div class="part_user part_user1">
                                <img :src="item.user_img" alt="">
                            </div>
                            <i class="isOriginator" v-if="index == 0">团长</i>
                        </li>
                        <li v-for="(item, index) in surplusShow">
                            <div class="part_user">
                                <img src="static/images/surplus.png" alt=""/>
                            </div>
                        </li>
                        <li v-if="total > 10">
                            <div class="part_user part_user2">
                                <i class="icon iconfont icon-more"></i>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="fight_detail" v-if="surplus.length > 0">
                    <!-- <div class="fight_state"></div> -->
                    <p class="invite_txt">还差<span>{{surplus.length}}</span>人，赶快邀请好友拼单吧</p>
                    
                    <a href="javascript:;" class="invite_btn" v-if="isOriginator" @click="isShare = true">邀请好友拼单 <span>{{countdDown()}}{{time}}</span>后到期</a>
                    <a href="javascript:;" class="invite_btn" v-else @click="partakeActive">参与活动</a>
                </div>
                <div class="fight_detail" v-if="surplus.length <= 0">
                    <p class="invite_txt">这个单已经被拼完了，可以发动其他的拼单</p>
                    <a href="javascript:;" class="invite_btn" @click="toMore()">查看更多拼单</a>
                </div>
                <ul class="fight_list">
                    <li class="fn-clear" @click="snatching">
                        <span>商品名称</span>
                        <p>{{productInfo.product_name}}</p>
                        <i class="icon iconfont icon-youjiantouda"></i>
                    </li>
                    <li class="fn-clear" @click="isTips = true">
                        <span>拼单须知</span>
                        <p>·好友拼单·人满发货·人不满退款</p>
                        <i class="icon iconfont icon-youjiantouda"></i>
                    </li>
                </ul>
            </div>
            <div class="tips" v-show="isTips">
                <div class="tips_box">
                    <h6>如何参加拼团</h6>
                    <ul>
                        <li><span>·</span> 发起拼单或参加别人的拼单</li>
                        <li><span>·</span> 在规定的时间内，邀请好友参加拼单</li>
                        <li><span>·</span> 未达拼单人数，款项将自动原路返还</li>
                    </ul>
                    <i class="icon" @click="isTips = false">x</i>
                </div>
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
                        <img :src="$url + product_info.product_img" alt="">
                    </div>
                    <div class="goods_mations">
                        <h5>{{product_info.product_name}}</h5>
                        <div class="clearfix">
                            <div class="price">
                                <span v-if="stockProduct.groupon_price >= 0">￥{{stockProduct.groupon_price}}</span>
                                <span v-else>￥{{groupon_price}}</span>
                            </div>
                            <div class="num">
                                <span>库存：{{stock}}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="size_main">
                    <!-- 商品规格选择 -->
                    <div :key="index1" class="goods_color" v-for="(item,index1) in product_info.spec_info">
                        <h6>{{item.spec_name}}</h6>
                        <ul class="clearfix">
                            <li :key="index2" v-for="(sort,index2) in item.values" @click="checked(index1,index2)" :class="[sort.isChecked ? 'active' : '']">
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
                <div>
                    <a href="javascript:;" class="ensure_btn" @click="ensure()" v-if="stock > 0">确定</a>
                    <a href="javascript:;" class="ensure_btn empty" v-else>库存不足</a>
                </div>
            </div>
        </mt-popup>
        <div class="shareWin" v-show="isShare && surplus.length > 0" @click="isShare = false">
            <div class="share_tips">
                <h5>还差<span>{{surplus.length}}</span>人，点击右上角发送给朋友</h5>
                <p>邀请好友成团获取更优惠价格，更加划算得到商品</p>
            </div>
            <span class="guide"></span>
        </div>
        <text-nav v-show="!isLoading"></text-nav>
        <!-- <div class="groom_list">
            <ul class="fn-clear">
                <li>
                    <div class="goods_pic">
                        <img src="static/images/collection_img.png" alt="">
                    </div>
                    <p>长城（GreatWall）红酒 特选7年橡木桶解百纳干红葡...</p>
                    <div class="dataInfo fn-clear">
                        <div class="price">￥<span>299</span></div>
                        <span class="fightNum">已拼666</span>
                    </div>
                </li>
                <li>
                    <div class="goods_pic">
                        <img src="static/images/collection_img.png" alt="">
                    </div>
                    <p>长城（GreatWall）红酒 特选7年橡木桶解百纳干红葡...</p>
                    <div class="dataInfo fn-clear">
                        <div class="price">￥<span>299</span></div>
                        <span class="fightNum">已拼666</span>
                    </div>
                </li>
                <li>
                    <div class="goods_pic">
                        <img src="static/images/collection_img.png" alt="">
                    </div>
                    <p>长城（GreatWall）红酒 特选7年橡木桶解百纳干红葡...</p>
                    <div class="dataInfo fn-clear">
                        <div class="price">￥<span>299</span></div>
                        <span class="fightNum">已拼666</span>
                    </div>
                </li>
                <li>
                    <div class="goods_pic">
                        <img src="static/images/collection_img.png" alt="">
                    </div>
                    <p>长城（GreatWall）红酒 特选7年橡木桶解百纳干红葡...</p>
                    <div class="dataInfo fn-clear">
                        <div class="price">￥<span>299</span></div>
                        <span class="fightNum">已拼666</span>
                    </div>
                </li>
            </ul>
        </div> -->
        <!-- 分享给朋友 -->
        <!-- <mt-popup v-model="share" position="bottom">
            <div class="share">
                <h5>发送给朋友</h5>
                <div class="close" @click="share = false">
                    <i class="icon iconfont icon-cha"></i>
                </div>
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
</template>

<script>
    // 引入交互数据工具
    import axios from 'axios'
    import qs from 'qs'
    // 引入倒计时
    import {downTime} from '../../../static/js/downTime';
    // 引入获取参数函数
    import {getQueryString} from '../../../static/js/getQueryString';
    // 引入加载组件
    import loading from '@/components/loading'
    import payLoad from '@/components/payLoad'
    import textNav from '@/components/textNav'
    // 引入 Toast
    import { Toast } from 'mint-ui';
    export default {
        data() {
            return {
                share: true,
                isTips:false,
                g_order_id:this.$route.query.g_order_id,
                headImgList:[],
                productInfo:{},
                surplus:[],
                time:'24:00:00',
                showImg:[],
                surplusShow:[],
                total:0,
                isLoading:true,
                isParket:true,
                choose:false,
                num:1,
                product_id:'',
                groupon_id:'',
                product_info:{},
                item_id:'',
                stockProduct:{},
                isJoin:false,
                user_id:'',
                isOriginator:'',
                isShare:true,
                end_time:'',
                time:'',
                cdTimer:null,
                stock:0,
                max_limit:0,
                groupon_price:0,
                spec_content:'',       //规格名称
                share_user_id:''
            }
        },
        methods: {
            // 跳转拼单详情
            snatching() {
                localStorage.setItem('look_detail','snatching');
                localStorage.setItem('surplusNum',this.surplus.length);
                this.$router.push({
                    path:'/fightDetail',
                    name:'fightDetail',
                    query:{
                        product_id:this.product_id,
                        groupon_id:this.groupon_id,
                        data:new Date()
                    }
                })
            },
            // 获取拼团信息
            getInvitation(g_order_id){
                axios.post('/api/groupon/grouponSuccessPage',qs.stringify({
                    g_order_id:g_order_id
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.isOriginator = res.data.data.isOriginator;
                        this.headImgList = res.data.data.headImgList;
                        this.productInfo = res.data.data.productInfo;
                        this.end_time = this.productInfo.end_time;
                        let entries = this.headImgList.length;
                        this.total = res.data.data.productInfo.groupon_number;
                        this.isLoading = false
                        if(this.headImgList.length > 10){
                            this.showImg = this.headImgList.slice(0,10);
                            this.surplusShow = []
                        }else{
                            this.showImg = this.headImgList;
                            if(this.total > 10){
                                this.surplusShow.length = 9 - this.headImgList.length;
                            }else{
                                this.surplusShow.length = this.total - this.headImgList.length;
                            }
                        }
                        if(this.isOriginator){
                            this.share_user_id = localStorage.getItem('user_id');
                        }
                        localStorage.setItem('shareInvalutionName', this.productInfo.product_name);
                        localStorage.setItem('shareInvalutionImage', this.productInfo.product_img);
                        this.surplus.length = this.total - entries;
                        this.shareFriend(g_order_id, this.share_user_id);
                    }
                }).catch((err) => {
                    console.log(err)
                })
            },
            // 分享
            shareFriend(g_order_id, share_user_id){
                let host = document.location.hostname;
                let protocol = document.location.protocol;
                let user_id = localStorage.getItem('user_id');
                let currentUrl = `${protocol}//${host}`; 
                let url = currentUrl + "/invitation?g_order_id=" + g_order_id + "&share_user_id=" + share_user_id + "&groupon_id=" + localStorage.getItem('groupon_id') +  "&product_id=" + localStorage.getItem('product_id') + "&forward=invitation&share_user_id=" + user_id;
                let title = localStorage.getItem('shareInvalutionName');
                let imgUrl = this.$url + localStorage.getItem('shareInvalutionImage');
                wx.ready(function(res) {
                    wx.onMenuShareAppMessage({
                        title: title,
                        desc:"",
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
            // 倒计时
            countdDown(){
                this.cdTimer = setInterval(() => {
                    this.getTime();
                },1000)
            },
            getTime(){
                let nowTime = new Date().getTime();
                let targetTime = parseInt(this.end_time) - nowTime;
                this.time = downTime(targetTime);
            },
            // 跳转到拼团列表
            toMore(){
                this.$router.push({
                    path:'/collageList',
                    name:'collageList'
                })
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
                if(this.num < 1){
                    return;
                }else{
                    this.num--;
                }
                e.stopPropagation();
            },
            // 确认选择
            ensure(){
                localStorage.setItem('costMent','partake');

                localStorage.setItem('toFightshop','invitation');
                localStorage.setItem('productInfo',JSON.stringify(this.productInfo))
                localStorage.setItem('goodsNumber',this.num)
                localStorage.setItem('item_id',this.item_id);
                localStorage.setItem('share_user_id',this.user_id);
                localStorage.setItem('g_order_id',this.g_order_id)
                localStorage.setItem('product_stock',this.stock)
                localStorage.setItem('groupon_price',this.groupon_price)
                localStorage.setItem('maxLimit',this.product_info.max_limit)
                localStorage.setItem('spec_content',this.spec_content)
                this.$router.push({
                    path:'/fightShop',
                    name:'fightShop'
                }) 
            },
            // 获取商品信息
            getGoodSize(){
                axios.post('/api/groupon/grouponProduct',qs.stringify({
                    product_id:this.product_id,
                    groupon_id:this.groupon_id
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.product_info = res.data.data.productDetail.product_info;
                        this.stock = this.product_info.stock;
                        this.max_limit = this.product_info.max_limit;
                        this.groupon_price = res.data.data.extInfo.groupon_price;
                        if(this.product_info.spec_config == '0'){
                            this.item_id = this.product_info.item_id;
                        }
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            //将其他的规则设置为未选中状态
            doChooseSize (row){ 
                // 获取当前行对象
                let obj = this.product_info.spec_info[row];
                // 遍历设置同行中所有数据字段isChecked为false
                for (let ele of obj.values)
                {
                    ele["isChecked"] = false;
                }
            },
            // 选择规格
            checked(row,col){
                this.doChooseSize(row);
                // 获取当前values值
                var list =  this.product_info.spec_info[row].values;
                // 改变对应列中isChecked值
                list[col].isChecked = true;
                // 设置数字值 
                this.$set( list, col, list[col] );
                // 首先判断规则选择是否完整
                let flag = this.checkSize();
                //如果规则选择全部了。才查询库存
                if (flag){
                    // 拼接规格id用来查询库存信息
                    this.spec_custom = this.doSelSpec();
                    // 拼团购买时信息
                    axios.post('/api/groupon/productSpecCheck',qs.stringify({
                        spec_custom:this.spec_custom,
                        product_id:this.product_id
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.stockProduct = res.data.data;
                            this.item_id = this.stockProduct.item_id;
                            this.groupon_price = this.stockProduct.groupon_price;
                            this.stock = this.stockProduct.stock;
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
                for(let i of this.product_info.spec_info){
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
                let str = ''
                this.product_info.spec_info.forEach((item,index) => {
                    item.values.forEach(ele => {
                        if(ele.isChecked){
                            tempArr.push(ele.spec_value_id);
                            str += ele.spec_value + ';';
                        }
                    })
                })
                this.spec_content = str;
                let spec_custom = tempArr.join(';');
                if (spec_custom.indexOf(",")>-1) spec_custom = spec_custom.replace(/,/g,"");
                return spec_custom;
            },
            // 查看是否参加过
            join(){
                axios.post('/api/groupon/getJoinGrouponInfo', qs.stringify({
                    g_order_id:this.g_order_id,
                    groupon_id:this.groupon_id
                })).then((res) => {
                    if(res.data.code == '0'){
                        // this.look = false;
                        this.isJoin = res.data.data.isJoin;
                        this.user_id = res.data.data.user_img[0].user_id;
                    }
                })
                .catch((err) => {
                    console.log(err);
                })
            },
            // 参加活动
            partakeActive(){
                if(this.isJoin){
                    Toast('你已经参加过活动，请不要再参加了');
                }else{
                    this.choose = true;
                }
            }
        },
        mounted(){
            if(getQueryString('g_order_id') != undefined){
                this.isParket = false;
                this.g_order_id = getQueryString('g_order_id');
                this.product_id = getQueryString('product_id');
                this.groupon_id = getQueryString('groupon_id');
                localStorage.setItem('groupon_id',this.groupon_id);
                this.join();
                this.getGoodSize();
                this.getInvitation(this.g_order_id);
            }else if(localStorage.getItem('forward') == 'invitation'){
                this.isParket = false;
                const urlObj = (JSON.parse(localStorage.getItem('urlObject')));
                this.g_order_id = urlObj.g_order_id;
                this.product_id = urlObj.product_id;
                this.groupon_id = urlObj.groupon_id;
                localStorage.setItem('groupon_id',this.groupon_id);
                this.join();
                this.getGoodSize();
                this.getInvitation(this.g_order_id);
            }else{
                this.getInvitation(this.g_order_id);
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
            let appid = localStorage.getItem('appid');
             axios.post('/weixin/JSSDKWxConfig',qs.stringify({
                    currentUrl:location.href.split('#')[0],
                    appid: appid
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
        components:{
            loading,
            textNav
        },
        destroyed () {
            // （很重要）当跳转到其他页面的时候，要在生命周期的destroyed里清空this.cdTimer，不然会出错
            clearInterval(this.cdTimer)
        }
    }
</script>

<style scoped lang="scss">
    .invitation{
        .goods_pic{
            width: 100%;
            img{
                width: 100%;
            }
        }
        .fight_detail{
            background-color: #fff;
            padding: 0.1rem 0;
            margin-bottom: 0.2rem;
            .fight_time{
                line-height: 0.34rem;
                padding: 0 0.15rem;
                background-color: #f2f2f2;
                color: #333;
                font-size: 0.26rem;
                display: table;
                margin: 0 auto;
            }
            .invite_txt{
                text-align: center;
                color: #333;
                font-size: 0.3rem;
                font-weight: bold;
                margin:0.2rem 0;
                span{
                    color: #f00;
                }
            }
            .invite_btn{
                display: block;
                width: 6.6rem;
                height: 0.8rem;
                text-align: center;
                line-height: 0.8rem;
                color: #333;
                border-radius: 0.1rem;
                background-color: #ffdc4b;
                font-size: 0.32rem;
                margin: 0 auto;
                span{
                    color: #f00;
                    font-size: 0.36rem;
                }
            }
        }
        .partake_person{
            background-color: #fff;
            margin: 0.2rem 0;
            padding-top: 0.2rem;
            ul{
                display: table;
                margin: 0 auto;
                padding:0 0.2rem;
                text-align: center;
                // overflow: hidden;
                li{
                    display: inline-block;
                    margin-right: 0.2rem;
                    position: relative;
                    // margin-bottom: 0.2rem;
                    &:last-child{
                        margin-left: 0.05rem;
                    }
                    .part_user{
                        width: 1.05rem;
                        height: 1.05rem;
                        border-radius: 50%;
                        &.part_user1{
                            overflow: hidden;
                        }
                        &.part_user2{
                        }
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
                            &.icon-more{
                                font-size: 0.8rem;
                            }
                        }
                    }
                    .isOriginator{
                        position: absolute;
                        line-height: 0.4rem;
                        padding: 0 0.1rem;
                        color: #fff;
                        background-color: #EB9F29;
                        left: -0.15rem;
                        top:-0.15rem;
                        font-size: 0.24rem;
                        border-radius: 0.15rem;
                        font-style: normal;
                    }
                }
            }
        }
        .fight_list{
            li{
                position: relative;
                background-color: #fff;
                margin-bottom: 0.05rem;
                height: 0.74rem;
                padding: 0 0.6rem 0 0.2rem;
                line-height: 0.74rem;
                span{
                    float: left;
                    font-size: 0.3rem;
                    color: #333;
                    
                }
                p{
                    float: right;
                    font-size: 0.23rem;
                    color: #333;
                    width: 3.9rem;
                    text-overflow:ellipsis;
                    white-space:nowrap;
                    overflow:hidden;
                    text-align: right;
                }
                i{
                    position: absolute;
                    right: 0.2rem;
                    top: 50%;
                    transform: translateY(-50%);
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
                width: 0.38rem;
                height: 0.38rem;
                position: absolute;
                top: 0.1rem;
                right: 0.1rem;
                border: 1px solid #999;
                border-radius: 50%;
                color: #999;
                text-align: center;
                line-height: 0.38rem;
                i{
                    display: block;
                    font-size: 0.28rem;
                }
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
        .groom_list{
            padding: 0.1rem;
            ul{
                li{
                    width: 3.3rem;
                    padding: 0.15rem;
                    background-color:#fff;
                    margin-right: 0.1rem;
                    margin-bottom: 0.1rem;
                    &:nth-child(even){
                        margin-right: 0;
                    }
                    float: left; 
                    .goods_pic{
                        width: 2.4rem;
                        height: 2.4rem;
                        margin: 0 auto;
                    }
                    p{
                        font-size: 0.24rem;
                        color: #333;
                        display: -webkit-box;
                        /*! autoprefixer: off */
                        -webkit-box-orient: vertical;
                        /* autoprefixer: on */
                        -webkit-line-clamp: 2;
                        overflow: hidden;
                        margin: 0.1rem 0;
                    }
                    .dataInfo{
                        .price{
                            float: left;
                            font-size: 0.24rem;
                            color: #ec534e;
                            span{
                                font-size: 0.28rem;
                            }
                        }
                        .fightNum{
                            float: right;
                            font-size: 0.28rem;
                            color: #d3d3d3;
                        }
                    }
                }
            }
        }
        .tips{
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,.5);
            .tips_box{
                position: absolute;
                left: 50%;
                top: 50%;
                background-color: #F4564A;
                transform: translate(-50%,-50%);
                width: 5rem;
                border-radius: 0.2rem;
                color: #fff;
                padding:0.3rem 0.5rem;
                h6{
                    width: 2.78rem;
                    height: 0.78rem;
                    text-align: center;
                    line-height: 0.9rem;
                    font-size: 0.3rem;
                    background-image: url('../../../static/images/rules.png');
                    background-size: 100% 100%;
                    color: #C6000A;
                    margin: 0 auto 0.3rem;
                }
                ul{
                    li{
                        font-size: 0.28rem;
                        margin-bottom: 0.2rem;
                        span{
                            color: #fff;
                            font-size: 0.4rem;
                        }
                    }
                }
                .icon{
                    position: absolute;
                    right: 0.1rem;
                    top: 0.1rem;
                    font-size: 0.4rem;
                    color: #fff;
                    font-style: normal;
                    border: 1px solid #fff;
                    padding: 0.1rem;
                    border-radius: 50%;
                    width: 0.2rem;
                    height: 0.2rem;
                    text-align: center;
                    line-height: 0.13rem;
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
                        font-size: 0.24rem;
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
                            padding:0 0.1rem;
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
                                background-color: #FFDC4B;
                            }
                        }
                    }
                }
                .buy_num{
                    position: relative;
                    padding: 0.2rem 0.3rem;
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
    }
</style>
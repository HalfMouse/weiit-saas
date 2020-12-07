<template>
    <div class="bargain">
        <!-- 头部信息 -->
        <header v-if="fightGood == 'my'" :style="{background:color1}">
            <div class="head">
                <!-- 判断是否为砍价 -->
                <div class="clearfix">
                    <span class="how">如何砍价</span>
                    <span class="rule" @click="lookRules">查看砍价规则></span>
                </div>
            </div>
            <div class="line"></div>
            <ul>
                <li>
                    <i class="icon iconfont icon-gouwuche"></i>
                    <span>选择心仪商品</span>
                </li>
                <li>
                    <i class="icon iconfont icon-yaoqinghaoyou"></i>
                    <span>邀请好友砍价</span> 
                </li>
                <li>
                    <i class="icon iconfont icon-songhuo"></i>
                    <span>砍价必减</span>
                </li>
            </ul>
        </header>
        <div class="tips" v-if="fightGood == 'my' && bargainMessage.length > 0">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div v-for="item in bargainMessage" class="fn-clear swiper-slide">
                        <img :src="item.user_img" alt="">
                        <p>{{item.user_name}}{{item.pay_price}}拿了{{item.product_name}}</p>
                    </div>
                </div>
            </div>
            
        </div>
        <!-- 商品列表展示 -->
        <div class="bargain_list" v-if="fightGood == 'my'">
            <!-- 砍价商品列表 -->
            <div class="bargain_goods">
                <ul
                    v-infinite-scroll="loadMore"
                    infinite-scroll-disabled="loading"
                    infinite-scroll-distance="10" class="clearfix">
                    <li :key="index" class="clearfix" v-for="(item, index) in bargainList">
                        <div class="bargain_pic">
                            <img :src="$url + item.product_img" alt="" v-if="item.product_img">
                            <img src="static/images/goods.png" alt="" v-else>
                        </div>
                        <div class="bargain_txt">
                            <h4>{{item.product_name}}</h4>
                            <p class="bargain_num" v-if="item.count > 0">
                                <span>{{item.count}}人已{{item.min_price}}元拿到</span>
                            </p>
                            <p class="bargain_price">
                                <span>原价{{item.max_price}}元</span>
                            </p>
                        </div>
                        <div class="bargain_btn">
                            <!-- 砍价按钮 -->
                            <a href="javascript:;" @click="bargainPrice(item)" :style="{background:color1,color:'#fff'}">砍价{{item.min_price}}元得</a>
                        </div>
                    </li>
                </ul>
                <no-more v-if="allLoaded && bargainList.length > 0"></no-more>
            </div>
            <loading v-show="isLoading"></loading>
        </div>
        <!-- 我的砍价拼团商品列表 -->
        <div class="my_fight" v-if="fightGood == 'all'">
            <!-- 我的砍价商品列表 -->
            <div class="myBargain_goods">
                <ul
                    v-infinite-scroll="loadMore3"
                    infinite-scroll-disabled="loading3"
                    infinite-scroll-distance="10" class="clearfix">
                    <li :key="index" v-for="(item, index) in myBargainList">
                        <div class="fightGoods fn-clear">
                            <div class="fight_pic">
                                <img :src="$url + item.product_img" alt=""  v-if="item.product_img">
                                <img src="static/images/goods.png" alt="" v-if="!item.product_img">
                                <div class="choice" v-if="item.state != 0">
                                    <img src="static/images/success.png" alt="" v-if="item.state == 1">
                                    <img src="static/images/fail.png" alt="" v-if="item.state == -1">
                                    <!-- <i class="icon iconfont" :class="[{'icon-gougou':item.state == 1},{'icon-cha':item.state == -1}]" ></i> -->
                                </div>
                            </div>
                            <div class="fight_txt">
                                <h6>{{item.product_name}}</h6>
                                <span>{{fightBargainState(item.state)}}</span>
                            </div>
                        </div>
                        <div class="again_btn">
                            <a href="javascript:;" v-if="item.state == 1 || item.state == -1" @click="fightGood = 'my'" :style="{background:color1,color:'#fff'}">再砍一次</a>
                            <a href="javascript:;" v-else @click="keepBargain(item)" :style="{background:color1,color:'#fff'}">继续砍价</a>
                            <div class="remaining_time" v-if="item.state == 0">
                                <span>{{item.hours}}</span>
                                <i>:</i>
                                <span>{{item.minutes}}</span>
                                <i>:</i>
                                <span>{{item.seconds}}</span>
                                后结束
                            </div>
                        </div>
                    </li>
                </ul>
                <no-more v-if="allLoaded3 && myBargainList.length > 0"></no-more>
            </div>
        </div>
        <!-- 砍价按钮弹出框 -->
        <mt-popup v-model="isOk" position="bottom">
            <div class="pop_cont">
                <div class="pop_head">选择收获地址</div>
                <div class="pop_address">
                    <ul>
                        <li v-for="item in addressList" @click="ensureAddress(item)">
                            <p>
                                <span>{{item.consignee}}</span>
                                <span>{{item.phone}}</span>
                            </p>
                            <p>{{item.province}} {{item.city}} {{item.district}} {{item.address_detail}}</p>
                            <i class="icon iconfont icon-youjiantouda"></i>
                        </li>
                        <li @click="addAddress()">
                            添加新收获地址
                            <i class="icon iconfont icon-youjiantouda"></i>
                        </li>
                    </ul>
                </div>
                <i class="icon iconfont icon-cha" @click="isOk = false"></i>
            </div>
        </mt-popup>
        <mt-popup v-model="isJoin">
            <div class="bargain_tips">
                <h6>当前商品有正在开的团快去砍价吧~</h6>
                <a href="javascript:;" class="keepPrice" @click="keepPrice">继续砍价</a>
                <i class="icon iconfont icon-cha" @click="isJoin = false"></i>
            </div>
        </mt-popup>
        <div class="foot_btn">
            <a href="javascript:;" @click="choiceFight('my')" :class="{'active':fightGood == 'all'}">砍价商品</a>
            <a href="javascript:;" class="launch"  @click="choiceFight('all')" :class="{'active':fightGood == 'my'}">我的砍价</a>
        </div>
        <rules ref="rules"></rules>
        <!-- <div class="overlayer" v-if="isPay" @touchmove.prevent></div> -->
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 从mint-ui中引入popup,MessageBox
    import { Popup,MessageBox,Loadmore,Toast, InfiniteScroll } from 'mint-ui';
    // 引入活动规则弹窗
    import rules from '@/components/rules';
    // 引入加载组件
    import loading from '@/components/loading';
    import payLoad from '@/components/payLoad';
    import Swiper from 'swiper';
    import 'swiper/dist/css/swiper.min.css';
    import noMore from '@/components/noMore';
    export default {
        data(){
            return {
                // 弹出框状态
                isOk:false,
                isJoin:false,
                // 砍价数据
                bargainList:[],
                // 底部按钮颜色状态值
                fightGood:'my',
                // 我的砍价列表
                myBargainList:[],
                // 地址列表
                addressList:[],
                bargain_id:'',
                order_id:'',
                bargainMessage:[],
                allLoaded: false,   //砍价列表标识
                allLoaded3: false,  //我的砍价标识
                pageNo:1,           //砍价列表页数
                pageNo3:1,          //我的砍价页数
                pages:1,
                // isPay:false,
                color1:localStorage.getItem('bg1'),
                color2:localStorage.getItem('bg2'),
                isLoading:true,
                isLoading3:true, 
                loading:true,
                loading3:true
            }
        },
        methods:{
            
            // 确认砍价收货地址
            ensureAddress(item){
                let hmls = `<p style="text-align:center;width:3rem;margin:0 auto;line-height:0.28rem;color:#666;font-size:0.28rem;margin-top:0.1rem">${item.province + item.city + item.district + item.address_detail}</p>`;
                MessageBox.confirm('',{
                    title:'确认您得收货地址',
                    message:hmls,
                    cancelButtonClass:'cancelButton',
                    confirmButtonClass:'confirmButton',
                    confirmButtonText:'确认',
                    cancelButtonText:'取消'
                }).then((action) => {
                    if (action == 'confirm') {
                        this.isOk = false
                        axios.post('/api/bargain/bargainOrder',qs.stringify({
                            bargain_id:this.bargain_id,
                            address_id:item.id
                        })).then((res) => {
                            if(res.data.code == '0'){
                                this.$router.push({
                                    path:'/freeGet',
                                    name:'freeGet',
                                    query:{
                                        order_id:res.data.data.b_order_id,
                                        bargain_id:this.bargain_id
                                    }
                                })
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
            // 新增砍价收货地址
            addAddress(){
                localStorage.setItem('addressRootly','fight')
                this.$router.push({
                    path:'/addSite',
                    name:'addSite'
                })
            },
            // 切换拼团状态
            choiceFight(type){
                this.fightGood = type;
            },
            // 获取砍价商品数据
            getBargainGood(){
                axios.post('/api/bargain/selectBargainList',qs.stringify({
                    page:this.pageNo
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;;
                        list.forEach(item => {
                            this.bargainList.push(item);
                        })
                        this.hasNextPage = res.data.data.hasNextPage;
                        if(!this.hasNextPage){
                            this.loading = true;
                            this.allLoaded = true
                        }else{
                            this.loading = false;
                        }
                        this.isLoading = false;
                        this.isPass = true
                    }
                })
                .catch((err) => {
                    console.log(err);
                })
            },
            loadMore(){
                this.pageNo++;
                this.isPass = false;
                this.getBargainGood();
            },
            // 计算当前拼团状态
            fightBargainState(state){
                switch(state){
                    case -1:
                        return '砍价失败';
                        break;
                    case 0:
                        return '砍价进行时';
                        break;
                    case 1:
                        return '砍价成功';
                        break;
                }
            },
            // 获取地址
            getAddress(){
                axios.post('/api/user/myAddressList',qs.stringify({
                    page:this.pages
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.addressList = res.data.data.list;
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 获取我的砍价商品数据
            getMyBargainList(){
                axios.post('/api/bargain/userBargain',qs.stringify({
                    page:this.pageNo3
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach(item => {
                            this.myBargainList.push(item);
                        })
                        this.myBargainList.forEach((item) => {
                            this.$set(item,'hours','');
                            this.$set(item,'minutes','');
                            this.$set(item,'seconds','');
                            if(item.state == 0){
                                this.times(item);
                            }
                        })
                        this.hasNextPage = res.data.data.hasNextPage;
                        if(!this.hasNextPage){
                            this.loading3 = true;
                            this.allLoaded3 = true
                        }else{
                            this.loading3 = false;
                        }
                        this.isLoading3 = false;
                        this.isPass = true
                    }
                })
                .catch((err) => {
                    console.log(err);
                })
            },
            loadMore3(){
                this.pageNo3++;
                this.isPass = false;
                this.getMyBargainList();
            },
            // 去砍价
            bargainPrice(item){
                this.bargain_id = item.bargain_id;
                localStorage.setItem('shareBargainGoodImage', item.product_img);
                localStorage.setItem('shareBargainGoodName', item.product_name);
                if(item.stock > 0){
                    if(item.b_order_id === null){
                        this.isOk = true;
                    }else{
                        this.isJoin = true;
                    }
                }else{
                    Toast('库存不足，请选择其他商品')
                }
                
            },
            // 商品列表继续砍价
            keepPrice(){
                axios.post('/api/bargain/isBargain',qs.stringify({
                    bargain_id:this.bargain_id
                })).then((res) => {
                    if(res.data.code == 0){
                        this.$router.push({
                            path:'/freeGet',
                            name:'freeGet',
                            query:{
                                order_id:res.data.data.b_order_id,
                                bargain_id:this.bargain_id
                            }
                        })
                    }
                }).catch((err) => {
                    console.log(err);
                })
                
            },
            // 我的砍价列表继续砍价
            keepBargain(item){
                this.$router.push({
                    path:'/freeGet',
                    name:'freeGet',
                    params:{
                        order_id:item.b_order_id,
                        bargain_id:item.bargain_id
                    }
                })
            },
            
            
            
            // 查看规则
            lookRules(){
                this.$refs.rules.show();
            },
            // 计算时间
            times(item){
                setInterval(function(){
                    let nowTime = new Date().getTime();
                    let targetTime = item.end_time - nowTime;
                    item.hours = parseInt(targetTime / 1000 / 60 / 60 , 10) < 10 ? '0' + parseInt(targetTime / 1000 / 60 / 60 , 10) : parseInt(targetTime / 1000 / 60 / 60 , 10);
                    item.minutes = parseInt(targetTime / 1000 / 60 % 60 , 10) < 10 ? '0' + parseInt(targetTime / 1000 / 60 % 60 , 10) : parseInt(targetTime / 1000 / 60 % 60 , 10);
                    item.seconds = parseInt(targetTime / 1000 % 60 , 10) < 10 ? '0' + parseInt(targetTime / 1000 % 60 , 10) : parseInt(targetTime / 1000 % 60 , 10);
                },1000);

            },
            getBargainMessage(){
                axios.post('/api/bargain/bargainMessage',null)
                    .then((res) => {
                        if(res.data.code == '0'){
                            console.log(res);
                            this.bargainMessage = res.data.data;
                            let mySwiper = new Swiper('.swiper-container', {
                                autoplay:3000,//可选选项，自动滑动
                                direction : 'vertical',//竖向滑动
                                loop : true,//循环滑动
                                speed: 500,
                                autoplayDisableOnInteraction : false,
                                simulateTouch : false,
                                noSwiping : true,
                                noSwipingClass : 'swiper-slide',
                                observer:true,//修改swiper自己或子元素时，自动初始化swiper 
                                observeParents:false,//修改swiper的父元素时，自动初始化swiper 
                                onSlideChangeEnd: function(swiper){ 
                                　　　swiper.update();  
                                　　　mySwiper.startAutoplay();
                                　　  mySwiper.reLoop();  
                                }
                            })
                        }
                    })
                    .catch((err) => {
                        console.log(err)
                    })
            },
            // 判断进入途径
            getInto(){
                if(this.$route.query.currentTab){
                    this.fightGood = 'all'
                }else{
                    this.fightGood = 'my'
                }
            }
        },
        mounted(){
            this.getInto();
            this.getAddress();
            this.getBargainMessage()
            this.getBargainGood();
            this.getMyBargainList();
            
        },
        components:{
            rules,
            loading,
            payLoad,
            noMore
        }
    }
</script>

<style scoped lang="scss">
    .bargain{
        height: 100%;
        header{
            position: relative;
            width: 100%;
            height: 2.48rem;
            background-color: #FFD929;
            padding-top: 0.2rem;
            margin-bottom: 0.2rem;
            .head{
                font-size: 0.26rem;
                color: #a27507;
                .how{
                    float: left;
                    margin-left: 0.2rem;
                }
                .rule{
                    float: right;
                    margin-right: 0.2rem;
                }
            }
            .line{
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-52%,-50%);
                width: 6.73rem;
                height: 0.2rem;
                background-image: url('../../../static/images/pass.png');
                background-size: 100% 100%;
            }
            ul{
                display: table;
                margin: 0.4rem auto 0;
                li{
                    float: left;
                    width: 1.6rem;
                    margin-right: 0.7rem;
                    text-align: center;
                    &:last-child{
                        margin-top: -0.25rem;
                        span{
                            margin-top: -0.06rem;
                        }
                    }
                    .icon{
                        font-size: 0.84rem;
                        color: #fff;
                        display: block;
                        &.icon-songhuo{
                            font-size: 1.21rem;
                        }
                    } 
                    span{
                        display: block;
                        color: #333;
                        font-size: 0.26rem;
                        margin-top: 0.1rem;
                    }
                }
            }
        }
        .bargain_list{
            padding-bottom: 1.1rem;
            ul{
                li{
                    position: relative;
                    background-color: #fff;
                    padding:0.2rem;
                    margin-bottom: 0.2rem;
                    .bargain_pic{
                        width: 2rem;
                        height: 2rem;
                        float: left;
                        img{
                            width: 100%;
                            height: 100%;
                        }
                    }
                    .bargain_txt{
                        float: left;
                        margin-left: 0.1rem;
                        width: 5rem;
                        h4{
                            font-size: 0.28rem;
                            color: #333;
                            height: 0.78rem;
                            overflow : hidden;
                            text-overflow: ellipsis;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            /*! autoprefixer: off */
                            -webkit-box-orient: vertical;
                            /* autoprefixer: on */
                        }
                        .bargain_num{
                            font-size: 0.24rem;
                            color: #aaa;
                            margin-top: 0.5rem;
                        }
                        .bargain_price{
                            position: absolute;
                            left: 2.3rem;
                            bottom: 0.2rem;
                            font-size: 0.28rem;
                            color: #ec534e;
                        }
                    }
                    .bargain_btn{
                        position: absolute;
                        right: 0.2rem;
                        bottom: 0.2rem;
                        a{
                            display: block;
                            text-align: center;
                            line-height: 0.53rem;
                            background-color: #ffdc4b;
                            border-radius: 0.1rem;
                            font-size: 0.28rem;
                            color: #333;
                            font-family: 'PingFang-SC-Bold';
                            padding:0 0.1rem;
                        }
                    }
                }
            }
        }
        .pop_cont{
            background-color: #fff;
            padding: 0 0.15rem;
            position: relative;
            width: calc(100% - 0.3rem);
            .pop_head{
                line-height: 1rem;
                text-align: center;
                border-bottom: 1px solid #ddd;
                box-sizing: border-box;
                font-size: 0.34rem;
                color: #333;
                font-weight: bold;
                font-family:'PingFang-SC-Bold';
            }
            .icon-cha{
                position: absolute;
                font-size: 0.29rem;
                color: #999;
                top: 0.35rem;
                right: 0.3rem;
            }
            .pop_address{
                padding-bottom: 0.3rem;
                height: 5.5rem;
                overflow-y: scroll;
                ul{
                    li{
                        position: relative;
                        border-bottom: 1px solid #ddd;
                        box-sizing: border-box;
                        font-size: 0.28rem;
                        color: #333;
                        font-family:'PingFang-SC-Bold';
                        padding:0.3rem 0.8rem 0.3rem 0;
                        &:last-child{
                            padding: 0.4rem 0;
                        }
                        .icon-youjiantouda{
                            position: absolute;
                            top: 50%;
                            right: 0.15rem;
                            transform: translateY(-50%);
                        }
                    }
                }
            }
        }
        .foot_btn{
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
            height: 1.05rem;
            border-top: 0.02rem solid #d5d5d5;
            display: flex;
            display: -webkit-flex;
            background-color: #fff;
            z-index:100;
            a{
                flex: 1;
                line-height: 1.05rem;
                font-size: 0.32rem;
                color: #333;
                text-align: center;
                box-sizing: border-box;
                &.launch{
                    border-left: 1px solid #d5d5d5;
                }
                &.active{
                    color: #aaa;
                }
            }
        }
        .my_fight{
            padding-bottom: 1.1rem;
            ul{
                li{
                    padding: 0.2rem;
                    background-color: #fff;
                    margin-bottom: 0.24rem;
                    position: relative;
                    .fightGoods{
                        .fight_pic{
                            position: relative;
                            float: left;
                            width: 1.86rem;
                            height: 1.86rem;
                            img{
                                width: 100%;
                                height: 100%;
                            }
                            .choice{
                                position: absolute;
                                width: 1.49rem;
                                height: 1.49rem;
                                left: 50%;
                                top: 50%;
                                transform: translate(-50%,-50%);
                                border-radius: 50%;
                                background-color: rgba(0,0,0,0.5);
                                text-align: center;
                                // line-height: 1.49rem;
                                .icon{
                                    position: absolute;
                                    left: 50%;
                                    top: 50%;
                                    transform: translate(-50%,-50%);
                                    font-size: 0.6rem;
                                    font-weight: bold;
                                }
                                .icon-gougou{
                                    color: #09BB07;
                                }
                                .icon-cha{
                                    font-size: 0.8rem;
                                    color: #f4333c;
                                }
                            }
                        }
                        .fight_txt{
                            float: left;
                            width: 4.96rem;
                            height: 1.66rem;
                            margin-left: 0.28rem;
                            border-bottom: 1px solid #ddd;
                            padding-bottom: 0.2rem;
                            h6{
                                font-size: 0.28rem;
                                color: #666;
                                display: -webkit-box;
                                /*! autoprefixer: off */
                                -webkit-box-orient: vertical;
                                /* autoprefixer: on */
                                -webkit-line-clamp: 2;
                                overflow: hidden;
                            }
                            span{
                                display: block;
                                color: #ec534e;
                                font-size: 0.28rem;
                                margin-top: 0.3rem;
                            }
                        }
                    }
                    .again_btn{
                        overflow: hidden;
                        margin-top: 0.2rem;
                        a{
                            float: right;
                            height: 0.48rem;
                            line-height: 0.48rem;
                            color: #333;
                            background-color: #ffdc4b;
                            padding: 0 0.15rem;
                            font-size: 0.3rem;
                            border-radius: 0.1rem;
                        }
                        .remaining_time{
                            float: right;
                            font-size: 0.3rem;
                            margin-right: 0.25rem;
                            line-height: 0.48rem;
                            i{
                                display: inline-block;
                                font-style: normal;
                            }
                            span{
                                display: inline-block;
                                background-color: #333;
                                color: #fff;
                                padding: 0 0.05rem;
                                border-radius: 0.06rem;
                            }
                        }
                    }
                }
            }
            .no_more{
                display: table;
                margin:0 auto;
                span{
                    float: left;
                    height: 1px;
                    width: 2.11rem;
                    background-color: #ddd;
                    margin-top: 0.15rem;
                }
                p{
                    float: left;
                    font-size: 0.26rem;
                    color: #ddd;
                    margin:0 0.7rem;
                }
            }
        }
        .bargain_tips{
            width: 5rem;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%,-50%);
            background-color: #fff;
            border-radius: 0.1rem;
            padding: 0.5rem 0.4rem 0.4rem;
            h6{
                width: 3.6rem;
                font-size: 0.34rem;
                color: #333;
                margin: 0 auto;
                text-align: center;
            }
            .keepPrice{
                display: block;
                margin: 0 auto;
                background-color: #ffdc4b;
                color: #333;
                line-height: 0.7rem;
                font-size: 0.3rem;
                text-align: center;
                border: 0.1rem;
                border-radius: 0.1rem;
                margin-top: 0.36rem;
            }
            .icon-cha{
                position: absolute;
                font-size: 0.29rem;
                color: #999;
                top: 0.15rem;
                right: 0.15rem;
            }
        }
        .tips{
            font-size: 0.3rem;
            overflow: hidden;
            width: 100%;
            height: 0.68rem;
            background-color: #fff;
            margin-bottom: 0.2rem;
            .swiper-container{
                height: 0.68rem;
                .swiper-wrapper{
                    .swiper-slide{
                        overflow: hidden;
                        padding: 0 0.2rem;
                        img{
                            float: left;
                            width: 0.4rem;
                            height: 0.4rem;
                            border-radius: 50%;
                            margin-top: 0.14rem;
                        }
                        p{
                            width: 6.5rem;
                            float: left;
                            font-size: 0.3rem;
                            letter-spacing:0.02rem;
                            text-overflow:ellipsis;
                            white-space:nowrap;
                            overflow:hidden;
                            line-height: 0.68rem;
                            margin-left: 0.15rem;
                        }
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
    }
    .noMore{
        display: block;
        font-size: 0.28rem;
        color: #aaa;
        text-align: center;
    }
    .overlayer{
        position:fixed;
        left:0;
        top:0;
        width:100%;
        height:100%;
        z-index:10;
    }
    .myBargain_goods{
        min-height:8.4rem;
    }
</style>
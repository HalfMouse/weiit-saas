<template>
    <div class="showBox">
        <div class="good_list blankShow">
            <!-- 大图显示 -->
            <div class="list_box" v-if="listStyle == 'big'">
                <ul class="big_list fn-clear">
                    <li v-for="item in showGoods" @click="lookDetail(item)">
                         <div class="good_pic">
                            <img class="goodsPic" :src="$url + item.product_img" alt="">
                            <!-- <img class="goodsPic" src="static/images/goods.png" alt=""> -->
                            <!-- <div class="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="">
                            </div> -->
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                        <!-- <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div> -->
                    </li>
                </ul>
            </div>
            <!-- 小图显示 -->
            <div class="list_box" v-if="listStyle == 'small'">
                <ul class="small_list fn-clear">
                    <li v-for="item in showGoods" @click="lookDetail(item)">
                        <div class="good_pic">
                            <img class="goodsPic" :src="$url + item.product_img" alt="">
                            <!-- <img class="goodsPic" src="static/images/goods.png" alt=""> -->
                            <!-- <div class="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="">
                            </div> -->
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 一大两小图显示 -->
            <div class="list_box" v-if="listStyle == 'zigzag'">
                <ul class="zigzag_list fn-clear">
                    <li class="big" v-for="item in showbigGoods" @click="lookDetail(item)">
                        <div class="good_pic">
                            <img class="goodsPic" :src="$url + item.product_img" alt="">
                            <!-- <div class="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="">
                            </div> -->
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                        <!-- <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div> -->
                    </li>
                    <li class="small last_small" v-for="item in showSmallGoods" @click="lookDetail(item)">
                        <div class="good_pic">
                            <img class="goodsPic" :src="$url + item.product_img" alt="">
                            <!-- <div class="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="">
                            </div> -->
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 详细列表图显示 -->
            <div class="list_box" v-if="listStyle == 'detailed'">
                <ul class="detailed_list">
                    <li v-for="item in showGoods" class="fn-clear" @click="lookDetail(item)">
                        <div class="good_pic">
                            <img class="goodsPic" :src="$url + item.product_img" alt="">
                            <!-- <img class="goodsPic" src="static/images/goods.png" alt=""> -->
                            <!-- <div class="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="">
                            </div> -->
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <p class="des">{{item.firstCateName}}{{item.secondCateName}}{{item.thirdCateName}}</p>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                        <!-- <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div> -->
                    </li>
                </ul>
            </div>
            <!-- 一行三个图显示 -->
            <div class="list_box" v-if="listStyle == 'more'">
                <ul class="small_list more_list fn-clear">
                    <li v-for="item in showGoods" @click="lookDetail(item)">
                        <div class="good_pic">
                            <img class="goodsPic" :src="$url + item.product_img" alt="">
                            <!-- <img class="goodsPic" src="static/images/goods.png" alt=""> -->
                            <!-- <div class="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="">
                            </div> -->
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 横向滚动图显示 -->
            <div class="list_box" v-if="listStyle == 'scroll'">
                <div class="scroll_box">
                    <ul class="small_list more_list fn-clear scroll_lsit" ref="scrollBox">
                        <li v-for="item in showGoods" @click="lookDetail(item)">
                            <div class="good_pic">
                                <img class="goodsPic" :src="$url + item.product_img" alt="">
                            <!-- <img class="goodsPic" src="static/images/goods.png" alt=""> -->
                                <!-- <div class="cornerMark">
                                    <img :src="'static/images/' + corner + '.png'" alt="">
                                </div> -->
                            </div>
                            <div class="good_txt">
                                <h5 v-if="goodName">{{item.product_name}}</h5>
                                <span v-if="goodPrice">￥{{item.sale_price}}</span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            
        </div> 
    </div>
</template>

<script>
    // 引入axios,qs
    import axios from 'axios';
    import qs from 'qs';
    export default {
        props:{
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        addFun: 'manual',
                        showNum:6,
                        listStyle:'big',
                        goodName:true,
                        goodDes:'des',
                        goodPrice:true,
                        buyBtn:true,
                        btnStyle:'btn1',
                        cornerMark:true,
                        corner:'new',
                        btnTxt3:'马上抢',
                        btnTxt4:'购买',
                        showGoods:[],
                        showbigGoods:[],
                        showSmallGoods:[],
                    }
                },
            }
        },
        data() {
            return {
                addFun: 'manual',
                showNum:6,
                listStyle:'big',
                goodName:true,
                goodDes:'des',
                goodPrice:true,
                buyBtn:true,
                btnStyle:'btn1',
                cornerMark:true,
                corner:'new',
                btnTxt3:'马上抢',
                btnTxt4:'购买',
                showGoods:[],
                showbigGoods:[],
                showSmallGoods:[],
                count:2,
                productIds:[]
            }
        },
        methods:{
            original(){
                this.addFun = this.pageParam.addFun;
               	this.showNum = this.pageParam.showNum;
                this.btnStyle = this.pageParam.btnStyle;
                this.btnTxt3 = this.pageParam.btnTxt3;
                this.buyBtn = this.pageParam.buyBtn;
                this.corner = this.pageParam.corner;
                this.cornerMark = this.pageParam.cornerMark;
                this.goodDes = this.pageParam.goodDes;
                this.goodName = this.pageParam.goodName;
                this.goodPrice = this.pageParam.goodPrice;
                this.listStyle = this.pageParam.listStyle;
                let productIds = this.pageParam.productIds.join(',');
                if(this.pageParam.addFun == 'manual'){
                    axios.post('/api/product/getProductListByIds',qs.stringify({
                        productGetType:0,
                        productIds:productIds
                    })).then((res) => {
                        this.showGoods = res.data.data.productInfo;
                        this.showbigGoods = this.showGoods.slice(0,1);
                        this.showSmallGoods = this.showGoods.slice(1,3);
                    }).catch((err) => {
                        console.log(err);
                    })
                }else if(this.pageParam.addFun == 'automatic'){
                    axios.post('/api/product/getProductListByIds',qs.stringify({
                        productGetType:1,
                        showNum:this.showNum
                    })).then((res) => {
                        this.showGoods = res.data.data.productInfo;
                        this.showbigGoods = this.showGoods.slice(0,1);
                        this.showSmallGoods = this.showGoods.slice(1,3);
                    }).catch((err) => {
                        console.log(err);
                    })
                }
                
            },
            lookDetail(item){
                localStorage.setItem('shareGoodImage', item.product_img);
                localStorage.setItem('shareGoodName', item.product_name);

                this.$router.push({
                    path:'/detail',
                    name:'detail',
                    query:{
                        product_id:item.product_id
                    }
                })
            }
        },
        mounted(){
            this.original(); 
        },
        updated(){
            if(this.listStyle == 'scroll'){
                let length = this.showGoods.length;
                let picWidth = 2.25;
                let margin = 0.25;
                let width = (picWidth + margin) * length - margin;
                this.$refs.scrollBox.style.width = width + 'rem';  
            }
            
        }
    }
</script>

<style scoped>
    .list_box{
        padding: 0 0.2rem;
    }
    .list_box ul li{
        position: relative;
        margin-bottom: 0.15rem;
    }
    .buy_icon{
        position: absolute;
        width: 0.48rem;
        height: 0.48rem;
        border-radius: 50%;
        border: 1px solid #f44;
        text-align: center;
        line-height: 0.48rem;
        right: 0.04rem;
        bottom: 0.04rem;
    }
    .buy_icon .icon{
        font-size: 0.4rem;
        color: #f44;
    }
    .good_pic{
        position: relative;
    }
    .good_pic .cornerMark{
        position: absolute;
        left: 0;
        top: 0;
    }
    .good_pic .cornerMark img{
        display: block;
    }
    .good_pic img.goodsPic{
        width: 100%;
        height: 100%;
    }
    .scroll_box{
        width: 100%;
        overflow-x:scroll;
    }
    .scroll_box ul li:last-child{
        margin-right:0;
    }
    /* 大图排列 */
    .zigzag_list .good_pic,
    .big_list .good_pic{
        width: 100%;
    }
    .detailed_list .good_txt h5,
    .zigzag_list .good_txt h5,
    .small_list .good_txt h5,
    .big_list .good_txt h5{
        font-size: 0.32rem;
        color: #333;
        /* margin-bottom: 0.12rem; */
         text-overflow:ellipsis;
       white-space:nowrap;
       overflow:hidden;
    }   
    .detailed_list .good_txt span,
    .zigzag_list .good_txt span,
    .small_list .good_txt span,
    .big_list .good_txt span{
        display: block;
        font-size: 0.32rem;
        color: #f44;
    }
    /* 小图排列 */
    .small_list{
        margin-right: -0.2rem;
    }
    /* .list_box .small_list li .good_txt{
        width: 3.3rem;
    } */
    .zigzag_list li.small .good_pic,
    .small_list .good_pic{
        width: 3.4rem;
        height: 3.4rem;
    }
    .zigzag_list li,
    .small_list li{
        float: left;
        /* margin-right: 0.2rem; */
    }
    .small_list li{
        width: 50%;
    }
    .small_list li:nth-child(even){
        margin-right: 0;
    }
    .zigzag_list li.small .good_txt h5,
    .small_list li .good_txt h5{
         text-overflow:ellipsis;
       white-space:nowrap;
       overflow:hidden;

    }
    .small_list li:nth-child(event){
        margin-right: 0;
    }
    .zigzag_list li.small .good_txt h5,
    .zigzag_list li.small .good_txt span,
    .small_list .good_txt h5,
    .small_list .good_txt span{
        font-size: 0.28rem;
        
    }
    /* 一行三个 */
    .more_list{
        margin-right: -0.25rem;
    }
    .more_list li{
        position: relative;
        width: 2.25rem;
        margin-right: 0.14rem;
        height: 3.3rem;
    }
    .more_list li:nth-child(even){
        margin-right: 0.25rem;
    }
    .more_list li .good_pic{
        width: 2.25rem;
        height: 2.25rem;
    }
    .more_list .good_txt{
        width: 1.7rem;
    }
    .more_list .good_txt h5,
    .small_list .good_txt span{
        font-size: 0.24rem;
    }
    /* .more_list .good_txt span, 
    .small_list .good_txt span,
    .small .good_txt span{
        position: absolute;
        bottom: 0.05rem;
    }
    .small_list .good_txt,
    .small .good_txt{
        height: 1.2rem;
    } */
    .scroll_lsit{
        width: 16rem;
    }
    /* 一大两小 */
    .zigzag_list li.big{
        margin-right: 0;
        width: 100%;
    }
    .zigzag_list li.small{
        width: 50%;
        /* width: 3.4rem; */
    }
    .zigzag_list li.small.last_small:last-child{
        margin-right: 0;
    }
    /* 详细列表 */
    .detailed_list .good_pic{
        width: 2rem;
        height: 2rem;
        float: left;
        margin-right: 0.2rem;
    }
    .detailed_list li{
        padding: 0.2rem 0;
    }
    .detailed_list .good_txt{
        float: left;
        padding-top: 0.12rem;
        width: 4.8rem;
    }
    .detailed_list .good_txt h5{
        font-size: 0.32rem;
        color: #333;
        margin-bottom: 0.2rem;
        overflow : hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        /*! autoprefixer: off */
        -webkit-box-orient: vertical;
        /* autoprefixer: on */
    }
    .detailed_list .good_txt span{
        margin-top: 0.2rem;
    }
    .detailed_list .buy_icon{
        right: 0.22rem;
        bottom: 0.26rem;
    }
    .shop{
        position: absolute;
        border: 1px solid #f44;
        width: 0.48rem;
        height: 0.48rem;
        border-radius: 50%;
        text-align: center;
        line-height: 0.52rem;
        right: 0.24rem;
        bottom: 0.14rem;
    }
    .shop .icon{
        display: block;
        font-size: 0.32rem;
        color: #f44;
    }
    .shop1,.shop2{
        position:absolute;
        right: 0.12rem;
        bottom: 0.12rem;
        font-size: 0.24rem;
        line-height: 0.4rem;
        padding: 0 0.1rem;
        cursor: pointer;
        background-color: #f44;
        color: #fff;
        border-radius: 0.2rem;;
    }
    .shop2{
        background-color: #fff;
        line-height: 0.4rem;
        border-radius: 0;
        border: 1px solid #f44;
        color: #f44;
    }
    .small_list .shop1,
    .small_list .shop2{
        bottom: 0;
        right: 0.08rem;
    }
    .detailed_list .shop1,
    .detailed_list .shop2{
        bottom: 0.24rem;
    }
</style>
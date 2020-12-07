<template>
    <div class="showBox">
        <div class="advertisement blankShow" :class="{'adver':navList.length != 0}">
            <div class="swiper-area" v-if=" temp == 'temp1'">
                
                <van-swipe :autoplay="4000" @change="onChange">
                    <van-swipe-item v-for="(item, index) in navList" :key="index">
                        <a href="javascript:;" @touchend="toPage(item)" @touchmove="stopTouch()">
                            <img :src="item.img" width="100%"/>
                        </a>
                    </van-swipe-item>
                </van-swipe>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp2'">
                <div class="sort sort2" v-for="item in navList">
                    <a href="javascript:;" @click="toPage(item)" class="">
                        <img :src="item.img" alt="">
                    </a>
                </div> 
            </div>
            <div class="advertisement_box fn-clear" v-if=" temp == 'temp3'">
                <div class="sort_box sorts">
                    <van-swipe>
                        <van-swipe-item v-for="(item, index) in navList" :key="index">
                            <a href="javascript:;" @click="toPage(item)">
                                <img :src="item.img" alt="">
                            </a>
                        </van-swipe-item>
                    </van-swipe>
                </div>
            </div>
            <div class="advertisement_box fn-clear" v-if=" temp == 'temp4'">
                <div class="temp4_box fn-clear">
                    <div class="sort sort4" v-for="item in navBigList">
                        <a href="javascript:;" @click="toPage(item)">
                            <img :src="item.img" alt="">
                        </a>
                    </div>
                    <div class="sort_box1">
                        <div class="sort sort5" v-for="item in navSmallList">
                            <a href="javascript:;" @click="toPage(item)">
                                <img :src="item.img" alt="">
                            </a>
                        </div>
                    </div>
                </div>
                
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp5'">
                <div class="sort_box fn-clear" ref="sortBox">
                    <div class="sort sort3" v-for="item in navList">
                        <a href="javascript:;" @click="toPage(item)">
                            <img :src="item.img" alt="">
                        </a>
                    </div>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp6'">
                <div class="sort_box2 fn-clear" ref="sortBox">
                    <div class="sort sort7" v-for="item in navList">
                        <a href="javascript:;" @click="toPage(item)">
                            <img :src="item.img" alt="">
                        </a>
                    </div>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp7'">
                <div class="sort_box2 fn-clear" ref="sortBox">
                    <div class="sort sort8" v-for="item in navList">
                        <a href="javascript:;" @click="toPage(item)">
                            <img :src="item.img" alt="">
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import { Swipe, SwipeItem } from 'mint-ui';
    
    export default {
        props:['pageParam'],
        data(){
            return {    
                temp:'temp1',
                navList:[],
                navBigList:[],
                navSmallList:[],
                obj:{
                    temp:'temp1',
                    navList:[],
                    navBigList:[],
                    navSmallList:[],
                },
                isClick:true
            }
        },
        mounted(){
            this.temp = this.pageParam.temp;
            this.navList = this.pageParam.navList;
            this.navBigList = this.pageParam.navBigList;
            this.navSmallList = this.pageParam.navSmallList;
        },
        methods:{
            toPage(item){
                if(this.isClick && item.url !== ''){
                    if(item.url == 'index'){
                        this.$router.push({
                            path:'/' + item.validate_id,
                            name:'home1',
                            params:{
                                page_id:item.validate_id
                            }
                        })
                    }else if(item.navShow == '外链'){
                        window.location.href = item.url
                    }else{
                        this.$router.push({
                            path:'/' + item.url,
                            name:item.url,
                            query:{
                                target_id:item.validate_id
                            }
                        }); 
                    }
                }
                
            },
            stopTouch(){
                this.isClick = false;
            },
            onChange(){
                this.isClick = true;
            }
        },
        updated(){
            if(this.temp === 'temp5'){
                let length = this.navList.length;
                let picWidth = 2.3;
                let margin = 0.2;
                let width = (picWidth + margin) * length - margin - 0.3;
                this.$refs.sortBox.style.width = width + 'rem';  
            }
        }
    }
</script>

<style scoped>
    .advertisement_b{
        width: 100%;
        margin: 0 auto;
        overflow: hidden;
    }
    .advertisement_box{
        width:100%;
        overflow-x:scroll;
    }
    .advertisement_box1{
        /* height: 3.3rem; */
        /* height: 2.9rem; */
    }
    .sort{
        background:#E7F8FF;
        color: #fff;
        text-align: center;
        font-size: 0.6rem;
        font-weight: bold;
    }
    .sort img{
        display: block;
        width: 100%;
        height: 100%;
    }
    .sort1{
        width: 100%;
        height: 2.5rem;
        line-height: 2.5rem;
    }
    .adver .sort1{
        height: auto;
    }
    .sort2{
        width: 100%;
        height: 1.28rem;
        margin-bottom: 0.2rem;
        line-height: 1.28rem;
    }
    .adver .sort2{
        height: auto;
    }
    .sort2:last-child{
        margin-bottom: 0;
    }
    .sort_box{
        padding: 0.1rem;
    }
    .sort_box .sort:last-child{
        margin-right:0
    }
    .sort3{
        float: left;
        width: 2.3rem;
        height: 2.3rem;
        margin-right: 0.1rem;
    }
    .sort4{
        float: left;
        width: 3.7rem;
        height:  5.5rem;
    }
    .sort_box1{
        float: right;
        width: 3.6rem;
    }
    .sort5{
       height: 2.65rem;
       margin-bottom: 0.2rem;
    }
    .sort5:last-child{
        margin-bottom: 0;
    }
    .sort6{
        width: 100%;
    }
    .dots{
        position: absolute;
        left: 50%;
        bottom: 0.4rem;
        transform: translateX(-50%);
    }
    .dots span{
        display: inline-block;
        width: 0.16rem;
        height: 0.16rem;
        border-radius: 50%;
        margin: 0 0.1rem;
        background-color: rgba(0,0,0,.2);
    }
    .dots span.current{
        opacity: 1;
        background: #007aff;
    }
    .temp4_box{
        padding: 0 0.15rem;
        height: 5.5rem;
    }
    .swiper-area{
        width:100%;
        clear:both;
    }
    .swiper-area img{
        display: block;
    }
    .sorts{
        padding: 0;
    }
    .sorts a{
        display: block;
    }
    .sorts a img{
        width: 100%;
    }
    .sort_box2{
        width: 100%;
    }
    .sort7{
        width: 50%;
        float: left;
    }
    .sort8{
        width: 33.3%;
        float: left;
    }
    .sort8 a,
    .sort7 a{
        display: block;
    }
    .sort8 a img,
    .sort7 a img{
        display: block;
        width: 100%;
    }
</style>
<template>
    <div class="showBox">
        <div class="advertisement blankShow" v-if="navList.length == 0">
            <div class="advertisement_box" v-if=" temp == 'temp1'">
                <div class="sort sort1">图片</div>
                <div class="dots">
                    <span class="current"></span>
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
            
            <div class="advertisement_box" v-if=" temp == 'temp2'">
                <div class="sort sort2">图片</div> 
                <div class="sort sort2">图片</div> 
            </div>
            <div class="advertisement_box fn-clear advertisement_box1" v-if=" temp == 'temp3'">
                <div class="sort_box sorts">
                    <div class="sort sort6">图片</div>
                    <div class="sort sort6">图片</div>
                    <div class="sort sort6">图片</div>
                </div>
            </div>
            <div class="advertisement_box fn-clear" v-if=" temp == 'temp4'">
                <div class="sort sort4">图片</div>
                <div class="sort_box1">
                    <div class="sort sort5">图片</div>
                    <div class="sort sort5">图片</div>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp5'">
                <div class="sort_box">
                    <div class="sort sort3">图片</div>
                    <div class="sort sort3">图片</div>
                    <div class="sort sort3">图片</div>
                    <div class="sort sort3">图片</div>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp6'">
                <div class="sort-box">
                    <div class="sort sort7">图片</div>
                    <div class="sort sort7">图片</div>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp7'">
                <div class="sort-box">
                    <div class="sort sort8">图片</div>
                    <div class="sort sort8">图片</div>
                    <div class="sort sort8">图片</div>
                </div>
            </div>
        </div>
        <div class="advertisement blankShow" v-else :class="{'adver':navList.length != 0}">
            <div class="advertisement_box" v-if=" temp == 'temp1'">
                <div class="sort sort1" v-for="item in navBigList">
                    <div class="sort sort1" v-if="item.img == ''">图片</div>
                    <img :src="item.img" alt="" v-else draggable="false">
                </div>
                <div class="dots">
                    <span v-for="(item,index) in navList" :class="{'current':index==0}"></span>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp2'">
                <div class="sort sort2" v-for="item in navList">
                    <div class="sort sort2" v-if="item.img == ''">图片</div>
                    <img :src="item.img" alt="" v-else draggable="false">
                </div> 
            </div>
            <div class="advertisement_box fn-clear" v-if=" temp == 'temp3'">
                <div class="sort_box sorts">
                    <div class="sort sort6" v-for="item in navList">
                        <div class="sort sort6" v-if="item.img == ''">图片</div>
                        <img :src="item.img" alt="" v-else draggable="false">
                    </div>
                </div>
            </div>
            <div class="advertisement_box fn-clear" v-if=" temp == 'temp4'">
                <div class="sort sort4" v-for="item in navBigList">
                    <div class="sort sort4" v-if="item.img == ''">图片</div>
                    <img :src="item.img" alt="" v-else draggable="false">
                </div>
                <div class="sort_box1">
                    <div class="sort sort5" v-for="item in navSmallList">
                        <div class="sort sort5" v-if="item.img == ''">图片</div>
                        <img :src="item.img" alt="" v-else draggable="false">
                    </div>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp5'">
                <div class="sort_box">
                    <div class="sort sort3" v-for="item in navList">
                        <div class="sort sort3" v-if="item.img == ''">图片</div>
                        <img :src="item.img" alt="" v-else draggable="false">
                    </div>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp5'">
                <div class="sort_box">
                    <div class="sort sort3" v-for="item in navList">
                        <div class="sort sort3" v-if="item.img == ''">图片</div>
                        <img :src="item.img" alt="" v-else draggable="false">
                    </div>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp6'">
                <div class="sort_box2 fn-clear">
                    <div class="sort sort7" v-for="item in navList">
                        <div class="sort sort7" v-if="item.img == ''">图片</div>
                        <img :src="item.img" alt="" v-else draggable="false">
                    </div>
                </div>
            </div>
            <div class="advertisement_box" v-if=" temp == 'temp7'">
                <div class="sort_box2 fn-clear">
                    <div class="sort sort8" v-for="item in navList">
                        <div class="sort sort8" v-if="item.img == ''">图片</div>
                        <img :src="item.img" alt="" v-else draggable="false">
                    </div>
                </div>
            </div>
        </div>
        <!-- 设置广告 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-advertisement @event="getData" @getAdver="getAdver" :pageParam="pageParam"></set-advertisement>
        </div>
    </div>
</template>

<script>
    // 设置广告  
    import setAdvertisement from '@/components/set/setAdvertisement'
    // 设置头部
    import headModify from '@/components/common/headModify'
    import List from '../../../static/js/List'
    import {mapActions} from 'vuex'
    export default {
        props:{
            keyText:String,
            tempId:Number,
            keyWords:String,
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        temp:'temp1',
                        navList:[],
                        navBigList:[],
                        navSmallList:[],
                        imgHeight:0,
                        haveBlock:'no'
                    }
                },
            },
            
        },
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
                imgHeight:0,
                imgWidth:0,
                haveBlock:'no'
            }
        },
        components:{
            setAdvertisement,
            headModify
        },
        methods: {
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(type) {
                this.temp = type;
                this.obj.temp = type;
                this.changeData({id:this.tempId,op:this.obj});
            },
            getAdver(data){
                
                this.navList = data.navList;
                this.navBigList = data.navList.slice(0,1);
                this.navSmallList = data.navList.slice(1,3);
                this.obj.navList = data.navList;
                this.obj.navBigList = data.navList.slice(0,1);
                this.obj.navSmallList = data.navList.slice(1,3);
                this.obj.temp = data.temp;
                this.obj.haveBlock = data.haveBlock
                this.computedHeight();
                this.obj.imgHeight = this.imgHeight;
                this.obj.imgWidth = this.imgWidth;
                
                this.changeData({id:this.tempId,op:this.obj});
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.temp = this.temp;
                list.pageParam.navList = this.navList;
                list.pageParam.navBigList = this.navBigList;
                list.pageParam.navSmallList = this.navSmallList;
                list.pageParam.imgHeight = this.imgHeight;
                list.pageParam.imgWidth = this.imgWidth;
                list.pageParam.haveBlock = this.haveBlock;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.temp = this.pageParam.temp;
                this.navList = this.pageParam.navList;
                this.navBigList = this.pageParam.navBigList;
                this.navSmallList = this.pageParam.navSmallList;
                this.imgHeight = this.pageParam.imgHeight;
                this.imgWidth = this.pageParam.imgWidth;
                this.haveBlock = this.pageParam.haveBlock;
            },
            // 计算图片高度
            computedHeight(){
                if(this.navList.length > 0 && this.navList[0].img != ''){
                    let img_url = this.navList[0].img;
                    // 创建对象
                    var img = new Image();
                    // 改变图片的src
                    img.src = img_url;
                    this.imgHeight = img.height;
                    this.imgWidth = img.width;
                }
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .advertisement_box{
        width: 100%;
        margin: 0 auto;
        overflow-x: hidden;
        position: relative;
    }
    .sort{
        background:#E7F8FF;
        color: #fff;
        text-align: center;
        font-size: 30px;
        font-weight: bold;
    }
    .sort img{
        display: block;
        width: 100%;
        height: 100%;
    }
    .sort1{
        width: 100%;
        height: 125px;
        line-height: 125px;
    }
    .adver .sort1{
        height: auto;
    }
    .sort2{
        width: 100%;
        height: 64px;
        margin-bottom: 10px;
        line-height: 64px;
    }
    .adver .sort2{
        height: auto;
    }
    .sort2:last-child{
        margin-bottom: 0;
    }
    .sort_box{
        width: 912px;
        overflow: hidden;
    }
    .sort3{
        float: left;
        width: 104px;
        height: 104px;
        margin-right: 10px;
        line-height: 104px;
    }
    .sort4{
        float: left;
        width: 155px;
        height: 187px;
        line-height: 187px;
    }
    .sort_box1{
        float: right;
        width: 155px;
    }
    .sort5{
       height: 90px;
       margin-bottom: 7px;
       line-height: 90px;
    }
    .sort5:last-child{
        margin-bottom: 0;
    }
    .sort6{
    	width: 100%;
    	line-height: 85px;
    	height: 170px;
    }
    .dots{
        position: absolute;
        left: 50%;
        bottom: 20px;
        transform: translateX(-50%);
    }
    .dots span{
        display: inline-block;
        width: 8px;
        height: 8px;
        border-radius: 50%;
        margin: 0 5px;
        background-color: rgba(0,0,0,.2);
    }
    .dots span.current{
        opacity: 1;
        background: #007aff;
    }
    .advertisement_box1{
    	height: 170px;
    	overflow: hidden;
    }
    .sorts{
    	width: 100%;
    	height: 170px;
    }
    .sort_box2{
    	width: 100%;
    }
    .sort7{
    	float: left;
        width: 50%;
    }
    .sort8{
        float: left;
        width: 33.3%;
    }
    .sort8 img,
    .sort7 img{
    	width: 100%;
    }
    .sort-box{
        width: 100%;
    }
</style>
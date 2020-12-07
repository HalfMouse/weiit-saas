<template>
    <div class="showBox">
        <div class="bargain blankShow">
            <!--<div class="head fn-clear">
                <span class="title">显示砍价</span>
                <a href="javascript:;" class="more" v-if="moreBtn">更多砍价></a>
            </div>-->
            <div class="main">
                <bargain-head :titleTxt="titleTxt" v-if="haveTitle == 'yes'"></bargain-head>
                <div class="main_goods">
                    <bargain-good :bargainGoods="bargainGoods" :goods="goods"></bargain-good>
                </div>
            </div>
        </div>
        <!-- 设置砍价 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-bargain @event="getData" :pageParam="pageParam"></set-bargain>
        </div> 
    </div>
</template>

<script>
    // 设置店招  
    import setBargain from '@/components/set/setBargain'
    // 设置头部
    import headModify from '@/components/common/headModify'
    // 砍价头部
    import bargainHead from '@/components/common/bargainHead'
    // 砍价商品
    import bargainGood from '@/components/common/bargainGood'
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
                        moreBtn:true,
                        titleTxt:'',
                        stock:true,
                        btnStyle:'style1',
                        countDown:true,
                        bargainBtn:true,
                        goodStyle:'big',
                        bargainGoods:[],
                        bargain_ids:[],
                        addFun:'manual',
                        haveTitle:'yes'
                    }
                }
            },
            
        },
        data(){
            return {
            	addFun:'manual',
                moreBtn:true,
                titleTxt:'',
                stock:true,
                btnStyle:'style1',
                countDown:true,
                bargainBtn:true,
                goodStyle:'big',
                bargainGoods:[],
                count:2,
                bargain_ids:[],
                single:'',
                isState:'increase',
                haveTitle:'yes'
            }
        },
        components:{
            setBargain,
            headModify,
            bargainHead,
            bargainGood
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(bargain){
            	this.addFun = bargain.addFun;
                this.moreBtn = bargain.moreBtn;
                this.titleTxt = bargain.titleTxt;
                this.countDown = bargain.countDown;
                this.stock = bargain.stock;
                this.btnStyle = bargain.btnStyle;
                this.bargainBtn = bargain.bargainBtn;
                this.goodStyle = bargain.goodStyle;
                this.bargain_ids = bargain.bargain_ids;
                this.haveTitle = bargain.haveTitle;
                if(this.addFun == 'manual'){
                    if(this.bargain_ids.length == 0){
                        this.bargainGoods = [];
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/ump/bargain/getProductByBargainIds',
                            params:{
                                bargain_ids:JSON.stringify(this.bargain_ids),
                                bargainGetType:0
                            }
                        }).then(res => {
                        	console.log(res);
                        	this.bargainGoods = res.data.data;
                        }).catch(err => {
                            (err);
                        })
                    }
                }else if(this.addFun == 'automatic'){
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/bargain/getProductByBargainIds',
                        params:{
                            bargainGetType:1
                        }
                    }).then(res => {
                        this.bargainGoods = res.data.data;
                    }).catch(err => {
                        (err);
                    })
                }
                // 修改数据
                this.changeData({id:this.tempId,op:bargain})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.addFun = this.addFun;
                list.pageParam.moreBtn = this.moreBtn;
                list.pageParam.titleTxt = this.titleTxt;
                list.pageParam.countDown = this.countDown; 
                list.pageParam.stock = this.stock;
                list.pageParam.btnStyle = this.btnStyle;
                list.pageParam.bargainBtn = this.bargainBtn;
                list.pageParam.goodStyle = this.goodStyle;
                list.pageParam.bargain_ids = this.bargain_ids;
                list.pageParam.haveTitle = this.haveTitle;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.addFun = this.pageParam.addFun;
                this.moreBtn = this.pageParam.moreBtn;
                this.titleTxt = this.pageParam.titleTxt;
                this.countDown = this.pageParam.countDown;
                this.stock = this.pageParam.stock;
                this.btnStyle = this.pageParam.btnStyle;
                this.bargainBtn = this.pageParam.bargainBtn;
                this.goodStyle = this.pageParam.goodStyle;
                this.bargain_ids = this.pageParam.bargain_ids;
                this.haveTitle = this.pageParam.haveTitle;
                if(this.pageParam.addFun == 'manual'){
                    if(this.bargain_ids.length == 0){
                        this.bargainGoods = [];
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/ump/bargain/getProductByBargainIds',
                            params:{
                                bargain_ids:JSON.stringify(this.bargain_ids),
                                bargainGetType:0
                            }
                        }).then(res => {
                            this.bargainGoods = res.data.data;
                        }).catch(err => {
                            (err);
                        })
                    }
                }else if(this.pageParam.addFun == 'automatic'){
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/bargain/getProductByBargainIds',
                        params:{
                            bargainGetType:1
                        }
                    }).then(res => {
                        this.bargainGoods = res.data.data;
                    }).catch(err => {
                        (err);
                    })
                }
            }
        },
        computed:{
            goods(){
                var goods = {
                    countDown:this.countDown,
                    stock:this.stock,
                    btnStyle:this.btnStyle,
                    bargainBtn:this.bargainBtn,
                    goodStyle:this.goodStyle
                }
                return goods;
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }

    }
</script>

<style scoped>
    .bargain .head{
        padding: 5px 15px;
        line-height: 30px;
    }
    .bargain .head .title{
        float: left;
        font-size: 16px;
        color: #333;
        font-weight: 700;
    }
    .bargain .head .more{
        float: right;
        font-weight: 14px;
        color: #ec534e;
    }
    .main_goods{
        padding: 8px 0;
        background-color: #fff;
    }
</style>
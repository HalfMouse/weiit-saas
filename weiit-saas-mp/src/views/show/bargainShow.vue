<template>
    <div class="showBox">
        <div class="bargain blankShow" v-if="bargainGoods.length > 0">
            <!-- <div class="head fn-clear">
                <span class="title">显示砍价</span>
                <a href="javascript:;" class="more" v-if="moreBtn" @click="bargainList">更多 ></a>
            </div> -->
            <div class="main">
                <bargain-head :titleTxt="titleTxt" v-if="haveTitle == 'yes'"></bargain-head>
                <div class="main_goods">
                    <bargain-good :goods="goods" :bargainGoods="bargainGoods"></bargain-good>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 砍价头部
    import bargainHead from '@/views/common/bargainHead'
    // 砍价商品
    import bargainGood from '@/views/common/bargainGood'
    export default {
        props:['pageParam'],
        data(){
            return {
                moreBtn:true,
                titleTxt:'',
                stock:true,
                btnStyle:'style1',
                countDown:true,
                bargainBtn:true,
                goodStyle:'detail',
                bargainGoods:[],
                count:2,
                bargain_ids:[],
                haveTitle:'yes'
            }
        },
        components:{
            bargainHead,
            bargainGood
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
        methods: {
            original(){
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
                let bargain_ids = this.pageParam.bargain_ids.join(',');
                if(this.bargain_ids && this.pageParam.addFun == 'manual'){
                    axios.post('/api/bargain/getProductByBargainIds',qs.stringify({
                        bargainGetType:0,
                        bargain_ids:bargain_ids
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.bargainGoods = res.data.data;
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }else if(this.pageParam.addFun == 'automatic'){
                    axios.post('/api/bargain/getProductByBargainIds',qs.stringify({
                        bargainGetType:1
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.bargainGoods = res.data.data;
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }
            }
        },
        mounted(){
            this.original();
        }

    }
</script>

<style scoped>
    .bargain .head{
        padding: 0.1rem 0.3rem;
        line-height: 0.6rem;
    }
    .bargain .head .title{
        float: left;
        font-size: 0.28rem;
        color: #333;
        font-weight: 700;
    }
    .bargain .head .more{
        float: right;
        font-size: 0.28rem;
        color: #ec534e;
    }
    .main_goods{
        background-color: #fff;
    }
</style>
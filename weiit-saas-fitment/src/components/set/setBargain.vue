<template>
    <div class="set_fight">
    	<div class="contol_group fn-clear">
            <span>添加方式：</span>
            <div class="setChoice">
                <el-radio v-model="addFun" label="manual">手动获取商品</el-radio>
                <el-radio v-model="addFun" label="automatic">自动获取商品</el-radio>
            </div>
        </div>
        <div class="contol_group fn-clear" v-if="haveTitle == 'yes'">
            <p class="demonstration">
                <span>标题名：</span> 
            </p>
            <div class="setChoice">
                <el-input v-model="titleTxt" placeholder="请输入内容" maxlength="8"></el-input>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span>是否有标题：</span>
            <div class="setChoice">
                <el-radio v-model="haveTitle" label="yes">是</el-radio>
                <el-radio v-model="haveTitle" label="no">否</el-radio>
            </div>
        </div>
        <div class="contol_group contol_group1 fn-clear" v-if="addFun == 'manual'">
            <span class="add_title" :class="{'hasNo':isMust}">商品：</span>
            <div class="add_main fn-clear setChoice">
                <ul class="seckill_list">
                    <li :key="index" v-for="(item,index) in bargainGoods">
                        <i class="icon iconfont icon-guanbi" @click="del(item, index)"></i>
                        <div class="seckill_pic" v-if="item.product_pic != ''">
                            <img :src="imageDomaia + item.product_img" alt="" width="78" height="78" draggable="false">
                        </div>
                    </li>
                    <li>
                        <div class="setChoice add_voice" @click="fightShow()">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                    </li>
                </ul>
                <fight-win :parentComponent="parentComponent" ref="fights" @choice="getSeckill"></fight-win>
            </div>
        </div>
        <p v-if="isMust && addFun == 'manual'" class="reminder">请选择商品</p>
        <div class="contol_group fn-clear">
            <span>列表样式：</span>
            <div class="setChoice">
                <!--<el-radio v-model="goodStyle" label="detail">详情列表</el-radio>-->
                <el-radio v-model="goodStyle" label="big">大图</el-radio>
            </div>
        </div>
        <div class="add">
            <div class="contol_group contol_group1 fn-clear">
                <span>显示内容：</span>
                <div class="setChoice">
                    <!--<el-checkbox v-model="moreBtn">更多按钮</el-checkbox>-->
                    <!--<el-checkbox v-model="countDown">倒计时</el-checkbox>-->
                    <el-checkbox v-model="stock">剩余库存</el-checkbox>
                    <el-checkbox v-model="bargainBtn">砍价按键</el-checkbox>
                </div>
            </div>
            <div class="btnStyle" v-if="bargainBtn">
                <el-radio v-model="btnStyle" label="style1">样式1</el-radio>
                <el-radio v-model="btnStyle" label="style2">样式2</el-radio>
            </div>
        </div>
        <!--<div class="contol_group fn-clear">
            <span>更多设置：</span>
            <div class="setChoice">
                <el-checkbox v-model="saleAll">隐藏已售罄拼团商品</el-checkbox>
            </div>
        </div>-->
        
    </div>
</template>

<script>
    // 引入砍价商品弹窗
    import fightWin from '@/components/common/fightWin'
    import {mapState,mapMutations} from 'vuex';
    export default {
        props:['pageParam'],
        data() {
            return {
                titleTxt:'',
                addFun:'manual',
                goodStyle:'big',
                moreBtn:true,
                countDown:true,
                stock:true,
                bargainBtn:true,
                btnStyle:'style1',
                saleAll:true,
                parentComponent:'bargain',
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                bargain_ids:[],
                bargainGoods:[],
                haveTitle:'yes'
            }
        },
        updated(){
            var bargain = {
                goodStyle:this.goodStyle,
                btnStyle:this.btnStyle,
                stock:this.stock,
                countDown:this.countDown,
                moreBtn:this.moreBtn,
                titleTxt:this.titleTxt,
                bargainBtn:this.bargainBtn,
                bargain_ids:this.bargain_ids,
                addFun:this.addFun,
                bargainGoods:this.bargainGoods,
                haveTitle:this.haveTitle
            }
            this.$emit('event', bargain);
        },
        components:{
            fightWin
        },
        methods:{
             ...mapMutations(['noState','changeState','stopSort']),
            // 弹出拼团物品选择框
            fightShow(){
                if(this.bargainGoods.length >= 30){
                    this.bargainGoods.length = 30
                }
                this.$refs.fights.show();
                this.stopSort();
            },
            // 获取选中的数据
            getSeckill(goods){
                this.bargain_ids = this.bargain_ids.concat(goods);
                if(this.addFun == 'manual'){
                    if(this.bargain_ids.length > 0){
                        this.noState()
                    }else{
                        this.changeState();
                    }
                }
				if(this.bargain_ids.length > 0){
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/bargain/getProductByBargainIds',
                        params:{
                            bargain_ids:JSON.stringify(this.bargain_ids),
                            bargainGetType:0
                        }
                    }).then(res => {
                    	console.log(res);
                        this.bargainGoods = res.data.data
                    }).catch(err => {
                        (err);
                    })
                }else{
                    this.bargainGoods = []
                }
            },
            // 删除当前项
            del(item, index){
                this.bargainGoods.splice(index,1);
                this.bargain_ids = this.bargain_ids.filter(ele => {
                   return ele !== item.bargain_id;
                })
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
                        this.bargain_ids = [];
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
                    
                }  
            }
        },
        computed:{
            ...mapState(['isMust'])
        },
        mounted(){
           this.initData() 
        },
        watch:{
            addFun:function(curVal, oldVal){
                if(curVal != oldVal){
                    this.bargain_ids = [];
                    this.bargainGoods = [];
                }
            }
        }
    }
</script>

<style scoped>
    .contol_group {
        margin-top: 17px;
    }
    .contol_group span {
        float: left;
        width: 85px;
        text-align: right;
        margin-right: 10px;
    }
    .contol_group .reBack{
        font-size: 12px;
        color: #3388ff;
        width: auto;
        margin-left: 10px;
        margin-top: 3px;
    }
    .demonstration{
        float: left;
        margin-top: 2px;
    }
    .setChoice{
        float: left;
    }
    .add{
        width: 388px;
        background-color: #fff;
        padding: 10px;
        box-sizing: border-box;
        border:1px solid #ddd;
        border-radius: 4px;
        margin:17px auto 0;
    }
    .add .setChoice{
        width: 126px;
    }
    .add .setChoice .last{
        margin-left: 0;
        margin-top: 5px;
    } 
    .add .contol_group1{
        margin-top: 0;
    }
    .add .contol_group span{
        float: left;
        width:69px; 
    }
    .demonstration1{
        margin-top: 4px;
    }
    .tips{
        text-align: center;
        margin-top: 10px;
        padding-left: 8px;
    }
    .el-checkbox+.el-checkbox{
        margin: 0;
    }
    .btnStyle{
        margin-left: 102px;
    }
    /* .add .add_voice{
        width: 53px;
        height: 53px;
        box-sizing: border-box;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 53px;
        cursor: pointer;
        
    } */
    
    .setChoice1{
        margin-left: 79px;
    }
    .add_voice {
        width: 53px;
        height: 53px;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 53px;
        cursor: pointer;
    }
    .add_voice .icon{
        font-size: 20px;
        color: #3388ff;
    }
    /* 右侧展示选中图片 */
    .seckill_list{
        width: 260px;
        float: left;
    }
    .seckill_list li{
        position: relative;
        width: 78px;
        height: 78px;
        float: left;
        margin-right: 5px;
        margin-bottom: 5px;
        box-sizing: border-box;
        z-index: 20;
        cursor: pointer;
    }
    .seckill_list li:hover .icon-guanbi{
        display: block;
    }
    .seckill_list li img{
        width: 78px;
        height: 78px;
        box-sizing: border-box;
        border: 1px solid #ddd;
    }
    .add_voice{
        width: 78px;
        height: 78px;
        box-sizing: border-box;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 78px;
        float: left;
        cursor: pointer;
        
    }
    .icon-guanbi{
        position: absolute;
        display: block;
        font-size: 16px;
        color: #a3a3a3;
        cursor: pointer;
        right: 0;
        top: -5px;
        cursor: pointer;
        display: none;
    }
    .hasNo{
        color:#f44; 
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        padding-left: 95px;
        font-size: 12px;
    }
</style>
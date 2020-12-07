<template>
    <div class="set_fight">
        <div class="contol_group fn-clear">
            <span>添加方式：</span>
            <div class="setChoice">
                <el-radio v-model="addFun" label="manual">手动获取</el-radio>
                <el-radio v-model="addFun" label="automatic">自动获取</el-radio>
            </div>
        </div>
        <div class="contol_group fn-clear" v-if="haveTitle == 'yes'">
            <p class="demonstration">
                <span>标题名：</span> 
            </p>
            <div class="setChoice">
                <el-input v-model="fightTitle" placeholder="请输入内容" maxlength="8"></el-input>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span>是否去掉标题：</span>
            <div class="setChoice">
                <el-radio v-model="haveTitle" label="yes">是</el-radio>
                <el-radio v-model="haveTitle" label="no">否</el-radio>
            </div>
        </div>
        <div class="add" v-if="addFun == 'manual'">
            <div class="contol_group contol_group1 fn-clear">
                <span :class="{'hasNo':isMust}">选择商品：</span>
                <div class="setChoice skillpic" >
                    <ul class="seckill_list">
                        <li v-for="(item,index) in seckillGoods">
                            <i class="icon iconfont icon-guanbi" @click="del(item, index)"></i>
                            <div class="seckill_pic" v-if="item.product_pic != ''">
                                <img :src="imageDomaia + item.product_img" alt="" width="78" height="78" draggable="false">
                            </div>
                        </li>
                        <li>
                            <div class="add_voice" @click="fightShow()">
                                <i class="icon iconfont icon-jia"></i>
                            </div>
                        </li>
                    </ul>
                    <fight-win :parentComponent="parentComponent" ref="fights" @choice="getSeckill"></fight-win>
                    
                </div>
            </div>
            <p class="addTips">最多添加30个商品</p>
            <p v-if="isMust && addFun == 'manual'" class="reminder">请选择商品</p>
        </div>
        <div class="add" v-if="addFun == 'automatic'">
            <div class="contol_group fn-clear contol_group1">
                <span class="demonstration demonstration1">显示个数：</span>
                <div class="setChoice">
                    <el-input v-model="showNum" placeholder="最多显示30个" type="number"></el-input>
                </div>
            </div>
            <!--<div class="contol_group fn-clear">
                <div class="setChoice setChoice1">
                    <el-checkbox v-model="lookAllBtn">查看全部按钮</el-checkbox>
                </div>
            </div>-->
            <!--<div class="contol_group fn-clear">
                <span class="demonstration demonstration1">排序规则：</span>
                <div class="setChoice">
                    <el-select v-model="value" placeholder="请选择">
                        <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
                    </el-select>
                </div>
            </div>-->
        </div>
        <div class="contol_group fn-clear">
            <span>显示样式：</span>
            <div class="setChoice">
                <el-radio v-model="goodStyle" label="big">大图</el-radio>
                <el-radio v-model="goodStyle" label="matrix">矩阵</el-radio>
                <el-radio v-model="goodStyle" label="list">列表</el-radio>
            </div>
        </div>
        <div class="add">
            <!-- <div class="contol_group fn-clear">
                <span>填充方式：</span>
                <div class="setChoice">
                    <el-radio v-model="isFill" label="yes">填充</el-radio>
                    <el-radio v-model="isFill" label="no">留白</el-radio>
                </div>
            </div> -->
            <div class="contol_group contol_group1 fn-clear">
                <span>显示内容：</span>
                <div class="setChoice">
                    <el-checkbox v-model="goodName">商品标题</el-checkbox>
                    <el-checkbox v-model="fightNum">已团件数</el-checkbox>
                </div>
            </div>
        </div>
        <!--<div class="contol_group fn-clear">
            <span>显示样式：</span>
            <div class="setChoice">
                <el-checkbox v-model="saleAll">隐藏已售罄拼团商品</el-checkbox>
            </div>
        </div>-->
        <p class="tips">只展示活动进行中的拼团商品</p>
    </div>
</template>

<script>
    // 引入拼团商品弹窗
    import fightWin from '@/components/common/fightWin'
    import {mapState,mapMutations} from 'vuex';
    export default {
        props:['pageParam'],
        data() {
            return {
                parentComponent:'fight',
                addFun:'manual',
                showNum: '',
                lookAllBtn: true,
                selectedRule:'销量越高越靠前',
                options: [{
                    value: '选项1',
                    label: '销量越高越靠前'
                }, {
                    value: '选项2',
                    label: '浏览次数越多越靠前'
                }, {
                    value: '选项3',
                    label: '开始时间越晚越靠前'
                }, {
                    value: '选项4',
                    label: '结束时间越早越靠前'
                }],
                value: '选项1',
                goodName:true,
                fightNum:true,
                saleAll:true,
                goodStyle:'big',
                // isFill:'yes',
                // 传递展示选择内容
                seckillGoods:[],
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                groupon_ids:[],
                fightTitle:'',
                haveTitle:"yes"
            }
        },
        updated(){
            var fight = {
                addFun: this.addFun,
                showNum: this.showNum,
                lookAllBtn: this.lookAllBtn,
                selectedRule: this.selectedRule,
                options: this.options,
                value: this.value,
                goodName: this.goodName,
                fightNum: this.fightNum,
                saleAll: this.saleAll,
                goodStyle: this.goodStyle,
                groupon_ids:this.groupon_ids,
                fightTitle:this.fightTitle,
                haveTitle:this.haveTitle
            }
            
            this.$emit('event', fight);
        },
        methods: {
            ...mapMutations(['noState','changeState','stopSort']),
            // 弹出拼团物品选择框
            fightShow(){
                if(this.seckillGoods.length >= 30){
                    this.seckillGoods.length = 30
                }
                this.$refs.fights.show();
                this.stopSort();
            },
            // 获取选中的数据
            getSeckill(goods){
                this.groupon_ids = this.groupon_ids.concat(goods);
                console.log(this.groupon_ids);
                if(this.addFun == 'manual'){
                	if(this.groupon_ids.length > 0){
                        this.noState()
                    }else{
                        this.changeState();
                    }
                }
                
               if(this.groupon_ids.length > 0){
               		this.$ajax({
                        methods:'get',
                        url:'/center/ump/groupon/grouponListByIds',
                        params:{
                            groupon_ids: JSON.stringify(this.groupon_ids),
                            grouponGetType: 0
                        }
                    }).then(res => {
                    	console.log(this.seckillGoods);
                    	this.seckillGoods = res.data.data;
                    }).catch(err => {
                        (err);
                    })
               	}else{
               		this.seckillGoods = []
               	}
            },
            // 删除当前项
            del(item, index){
                this.seckillGoods.splice(index,1);
                this.groupon_ids = this.groupon_ids.filter(ele => {
                   return ele !== item.groupon_id;
                })
            },
            // 初始化数据
            initData(){
                this.addFun = this.pageParam.addFun;
                this.showNum = this.pageParam.showNum;
                this.lookAllBtn = this.pageParam.lookAllBtn;
                this.selectedRule = this.pageParam.selectedRule;
                this.options = this.pageParam.options;
                this.value = this.pageParam.value;
                this.goodName = this.pageParam.goodName;
                this.fightNum = this.pageParam.fightNum;
                this.saleAll = this.pageParam.saleAll;
                this.goodStyle = this.pageParam.goodStyle;
                this.fightTitle = this.pageParam.fightTitle;
                this.haveTitle = this.pageParam.haveTitle;
                if(this.pageParam.addFun == 'manual'){
                    if(this.pageParam.groupon_ids.length == 0){
                        this.seckillGoods = []
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/ump/groupon/grouponListByIds',
                            params:{
                               groupon_ids: JSON.stringify(this.groupon_ids),
                               grouponGetType: 0
                            }
                        }).then(res => {
                            this.seckillGoods = res.data.data;
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
        components:{
            fightWin
        },
        mounted(){
            this.initData();
        },
        watch:{
            addFun:function(curVal, oldVal){
                if(curVal != oldVal){
                    this.groupon_ids = [];
                    this.seckillGoods = [];
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
        width: 100px;
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
        width: 285px;
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
    /* .add .add_voice{
        width: 53px;
        height: 53px;
        box-sizing: border-box;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 53px;
        cursor: pointer;
        
    } */
    .add .add_voice .icon{
        font-size: 20px;
        color: #3388ff;
    }
    .addTips{
        margin-top: 8px;
        margin-left: 79px;
        color: #666;
    }
    .setChoice1{
        margin-left: 79px;
    }
   /* 拼团商品弹出框 */
    .goodChoiceBox{
        position: fixed;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
        z-index: 9999;
        background-color: rgba(0,0,0,.3);
    }
    .goodChoice{
        position: absolute;
        width: 600px;
        height: 454px;
        background-color: #fff;
        border-radius: 8px;
        left: 50%;
        top: 50%;
        margin-left: -300px;
        margin-top: -277px;
    }
    .goodChoice .icon-cha{
        position: absolute;
        right: 8px;
        top: 8px;
        font-size: 16px;
        color: #ccc;
        cursor: pointer;
    }
    .goodChoice .icon-cha:hover{
        color: #333;
    }
    .goodChoice .head .title,
    .goodChoice .head .selectSort,
    .goodChoice .head .searchBox{
        float: left;
    }
    .goodChoice .head .title{
        margin-left: 15px;
        line-height: 30px;
        font-size: 14px;
        color: #333;
    }
    .goodChoice .head{
        padding:10px 0;
    }
    .goodChoice .head .selectSort{
        margin-left:20px;
        margin-right: 10px;
    }
    .search_box{
        width: 150px;
    }
    .selectbox{
        width: 150px;
    }
    .search_btn{
        padding:8px 20px;
    }
    .ensure{
        margin-top: 10px;
    }
    .ensure_btn{
        background-color: #4b0;
        color: #fff;
        border-radius: 6px;
        font-size: 12px;
        line-height: 30px;
        padding: 0 10px;
        border:none 0;
    }
    .ensure_btn:focus{
        border:none 0;
    }
    .goodChoice .tabPic img{
        width: 60px;
        height: 60px;
    }
    /* 右侧展示选中图片 */
    .seckill_list{
        
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
        padding-left: 79px;
        font-size: 12px;
    }
</style>
<template>
    <div class="set_sort">
        <div class="contol_group fn-clear">
            <span>选择模板：</span>
            <div class="setChoice">
                <el-radio v-model="navPos" label="left">左侧菜单</el-radio>
                <el-radio v-model="navPos" label="top">顶部菜单</el-radio>
            </div>
        </div>
        <!-- 当选择导航在顶部的时候 -->
        <div v-if="navPos == 'top'">
            <div class="contol_group fn-clear">
                <span class="demonstration demonstration1">选择分组：</span>
                <div class="setChoice">
                    <el-select v-model="sortValue" multiple placeholder="请选择" :reserve-keyword="true" @change="changeValue">
                        <el-option
                        v-for="item in options"
                        :key="item.group_id"
                        :label="item.group_name"
                        :value="item.group_id">
                        </el-option>
                    </el-select>
                </div>
            </div>
             <div class="contol_group fn-clear">
                <span class="demonstration demonstration1">显示数量：</span>
                <div class="setChoice">
                    <el-input v-model="showNum" placeholder="最多显示20个"></el-input>
                </div>
            </div> 
            <div class="add">
                <div class="contol_group contol_group1 fn-clear">
                    <span>排序：</span>
                    <div class="setChoice">
                        <el-radio v-model="sortOrder" label="time">按时间</el-radio>
                        <el-radio v-model="sortOrder" label="sale">按销量</el-radio>
                        <el-radio v-model="sortOrder" label="price">按价格</el-radio>
                    </div>
                </div>
                <div class="contol_group fn-clear">
                    <span>显示样式：</span>
                    <div class="setChoice">
                        <el-radio v-model="goodStyle" label="big">大图</el-radio>
                        <el-radio v-model="goodStyle" label="matrix">矩阵</el-radio>
                        <el-radio v-model="goodStyle" label="list">列表</el-radio>
                    </div>
                </div>
                <div class="contol_group fn-clear">
                    <span>显示内容：</span>
                    <div class="setChoice">
                        <el-checkbox v-model="checkedGoodName">商品名称</el-checkbox>
                        <!--<el-checkbox v-model="checkedBuyBtn">购买按钮</el-checkbox>-->
                        <el-checkbox v-model="checkedPrice">价格</el-checkbox>
                        <!--<el-checkbox v-model="checkedSummary" class="last">商品简介</el-checkbox>-->
                    </div>
                </div>
                <div class="contol_group fn-clear">
                    <span>显示导航：</span>
                    <div class="setChoice">
                        <el-radio v-model="navShow" label="yes">是</el-radio>
                        <el-radio v-model="navShow" label="no">否</el-radio>
                    </div>
                </div>
                <!--<div class="contol_group fn-clear" v-if="checkedBuyBtn">
                    <span>按钮样式：</span>
                    <div class="setChoice">
                        <el-radio v-model="btnStyle" label="button1">样式1</el-radio>
                        <el-radio v-model="btnStyle" label="button2">样式2</el-radio>
                        <el-radio v-model="btnStyle" label="button3">样式3</el-radio>
                        <el-radio v-model="btnStyle" label="button4" class="last">样式4</el-radio>
                    </div>
                    <el-input v-model="btnTxt3" placeholder="马上抢" v-if="btnStyle == 'button3'" class="btn_txt" maxlength="4"></el-input>
                    <el-input v-model="btnTxt4" placeholder="购买" v-if="btnStyle == 'button4'" class="btn_txt" maxlength="4"></el-input>
                    <div class="tips" v-if="btnStyle == 'button3' || btnStyle == 'button4'">
                        <el-tooltip class="item" effect="light" content="自定义购买按钮文案，最多输入四个字" placement="top" >
                            <i class="icon iconfont icon-iconfontwenhao1"></i>
                        </el-tooltip>
                    </div>
                </div>-->
            </div>
        </div>
        <!-- 当选择导航在左侧的时候 -->
        <div v-if="navPos == 'left'">
            <!-- <div class="contol_group contol_group1 fn-clear">
                <span>图片填充方式：</span>
                <div class="setChoice">
                    <el-radio v-model="isFill" label="yes">填充</el-radio>
                    <el-radio v-model="isFill" label="no">留白</el-radio>
                </div>
            </div> -->
            <div class="contol_group fn-clear">
                <span class="demonstration demonstration1">选择分组：</span>
                <div class="setChoice">
                    <el-select v-model="sortValue" multiple placeholder="请选择" :reserve-keyword="true" @change="changeValue">
                        <el-option
                        v-for="item in options"
                        :key="item.group_id"
                        :label="item.group_name"
                        :value="item.group_id">
                        </el-option>
                    </el-select>
                </div>
            </div>
            <div class="contol_group fn-clear">
                <span class="demonstration demonstration1">显示数量：</span>
                <div class="setChoice">
                    <el-input v-model="showNum" placeholder="最多显示20个"></el-input>
                </div>
            </div> 
        </div>
    </div>
</template>

<script>
    export default {
        props:['pageParam'],
        data(){
            return{
                // 选择模板
                navPos:'top',
                sortChose:'',
                // 显示最多个数
                showNum:6,
                sortOrder:'sale',
                // 显示样式
                goodStyle:'big',
                // 购买按钮状态判断
                checkedBuyBtn:true,
                // 价格按钮状态判断
                checkedPrice:true,
                // 商品简介状态判断
                checkedSummary:true,
                // 商品名称状态判断
                checkedGoodName:true,
                // 按钮样式选择
                btnStyle: 'button1',
                // 填充状态判断
                // isFill:'yes',
                // 按钮样式3文字选择
                btnTxt3:'马上抢',
                // 按钮样式4文字选择                
                btnTxt4:'购买',
                // 选择分组数据
                options: [],
                sortValue: [],
                orderListName:[],
                group_ids:[],
                navShow:'yes'
            }
        },
        updated(){
            var goods = {
                navPos:this.navPos,
                sortChose:this.sortChose,
                showNum:this.showNum,
                sortOrder:this.sortOrder,
                goodStyle:this.goodStyle,
                checkedBuyBtn:this.checkedBuyBtn,
                checkedPrice:this.checkedPrice,
                checkedSummary:this.checkedSummary,
                checkedGoodName:this.checkedGoodName,
                btnStyle: this.btnStyle,
                // isFill:this.isFill,
                btnTxt3:this.btnTxt3,
                btnTxt4:this.btnTxt4,
                orderListName:this.orderListName,
                group_ids:this.group_ids,
                navShow:this.navShow
            }
            this.$emit('event', goods);
        },
        mounted(){
            this.getLinks();
            this.initData();
        },
        methods:{
            // 选中的值
            changeValue(val){
                this.group_ids = val;
                // if(this.showNum){
                //    this.group_ids = this.group_ids.slice(0, this.showNum);
                // }else{
                //     this.group_ids = this.group_ids.slice(0, 20);
                // }
            },           
            // 获取链接数据
            getLinks(){
                this.$ajax({
                    methods:'get',
                    url:'/center/productGroup/productGroupList'
                }).then(res => {
                    this.options = res.data.productGroupList.list;
                    if(this.options){
                    	if(this.showNum == ''){
	                        if(this.options.length >= 20){
	                            this.options.length = 20
	                        }
	                    }else{
	                       if(this.options.length >= this.showNum){
	                            this.options.length = this.showNum
	                        } 
	                    }
                    }
                    
                }).catch(err => {
                    (err);
                })
            },
            // 初始化数据
            initData(){
                this.navPos = this.pageParam.navPos;
                this.sortChose = this.pageParam.sortChose;
                this.showNum = this.pageParam.showNum;
                this.sortOrder = this.pageParam.sortOrder;
                this.goodStyle = this.pageParam.goodStyle;
                this.checkedBuyBtn = this.pageParam.checkedBuyBtn;
                this.checkedPrice = this.pageParam.checkedPrice;
                this.checkedSummary = this.pageParam.checkedSummary;
                this.checkedGoodName = this.pageParam.checkedGoodName;
                this.btnStyle = this.pageParam.btnStyle;
                // this.isFill = this.pageParam.isFill;
                this.btnTxt3 = this.pageParam.btnTxt3;
                this.btnTxt4 = this.pageParam.btnTxt4;
                this.navShow = this.pageParam.navShow;
                if(this.pageParam.group_ids){
                    this.group_ids = this.group_ids.concat(this.pageParam.group_ids);
                }
                if(this.pageParam.group_ids){
                    if(this.group_ids.length == 0){
                        this.sortValue = [];
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/productGroup/getProductByGroupIds',
                            params:{
                                group_ids: this.group_ids.join(',')
                            }
                        }).then(res => {
                            if(res.data.code == '0'){
                                res.data.data.forEach((item) => {
                                    this.sortValue.push(Number(item.group_id))
                                })
                            }
                        }).catch(err => {
                            (err);
                        })
                    }
                }
            }
        }
    }
</script>

<style scoped>
.contol_group {
  margin-top: 17px;
  position: relative;
}
.contol_group span {
  float: left;
  width: 95px;
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
    width: 200px;
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
.btn_txt{
    width: 90px;
    margin-left: 80px;
    margin-top: 8px;
}
.icon-iconfontwenhao1{
    font-size: 16px;
    color: #999;
}
.tips{
    position: absolute;
    bottom: 3px;
    right: 172px;
}
.el-icon-close:before{
    color: "\e60f"
}
</style>
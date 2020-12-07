<template>
    <div class="set_seckill">
        <div class="contol_group contol_group1 fn-clear">
            <span>选择商品：</span>
            <div class="setChoice add_voice">
                <i class="icon iconfont icon-jia"></i>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span>显示样式：</span>
            <div class="setChoice">
                <el-radio v-model="seckill.goodStyle" label="big">大图</el-radio>
                <el-radio v-model="seckill.goodStyle" label="matrix">矩阵</el-radio>
                <el-radio v-model="seckill.goodStyle" label="list">列表</el-radio>
            </div>
        </div>
        <div class="add">
            <div class="contol_group contol_group1 fn-clear">
                <span>填充方式：</span>
                <div class="setChoice">
                    <el-radio v-model="seckill.isFill" label="yes">填充</el-radio>
                    <el-radio v-model="seckill.isFill" label="no">留白</el-radio>
                </div>
            </div>
            <div class="contol_group fn-clear">
                <div class=" fn-clear">
                    <span>显示内容：</span>
                    <div class="setChoice">
                        <el-checkbox v-model="seckill.goodName" class="check" v-if="seckill.goodStyle == 'big'">商品标题</el-checkbox>
                        <el-checkbox v-model="seckill.fightTime" class="check" v-if="seckill.goodStyle == 'matrix' || seckill.goodStyle == 'list'">抢购倒计时</el-checkbox>
                        <el-checkbox v-model="seckill.fightNum" class="check">已团件数</el-checkbox>
                        <el-checkbox v-model="seckill.buyBtn" class="check">购买按钮</el-checkbox>
                    </div>
                </div>
                <div class="setChoice3" v-if="seckill.buyBtn">
                    <el-radio v-model="seckill.btnStyle" label="btn1">样式1</el-radio>
                    <el-radio v-model="seckill.btnStyle" label="btn2">样式2</el-radio>
                    <el-radio v-model="seckill.btnStyle" label="btn3">样式3</el-radio>
                    <el-radio v-model="seckill.btnStyle" label="btn4">样式4</el-radio>
                </div>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <div class=" fn-clear">
                <span>更多设置：</span>
                <div class="setChoice">
                    <el-checkbox v-model="seckill.hideSaleAll" class="check">隐藏已售罄商品</el-checkbox>
                    <el-checkbox v-model="seckill.hideActive" class="check">隐藏活动结束商品</el-checkbox>
                </div>
            </div>
            <div class="setChoice2" v-if="seckill.hideActive">
                <el-radio v-model="seckill.hideTime" label="hours">24小时后隐藏</el-radio>
                <el-radio v-model="seckill.hideTime" label="now">立即隐藏</el-radio>
            </div>
        </div>
        <p class="tips">小程序仅支持显示实物（含分销）、虚拟、电子卡券商品</p>
    </div>
</template>

<script>
    import {mapState} from 'vuex'
    export default {
        computed:{
            ...mapState(['seckill'])
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
    margin-top: 10px;
}
.tips{
    color: #999;
    margin-top: 10px;
}
.add_voice{
    width: 53px;
    height: 53px;
    box-sizing: border-box;
    border: 1px dotted #ddd;
    text-align: center;
    line-height: 53px;
    
}
.add_voice .icon{
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
.check{
    display: block;
    margin-left: 0;
    margin-bottom: 5px;
}
.setChoice2{
    padding-left: 115px;
}
.setChoice3{
    padding-left: 78px;
}
.setChoice3 .el-radio+.el-radio {
    margin-left: 8px;
}
</style>
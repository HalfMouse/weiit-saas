<template>
    <div class="set_lines">
        <div class="contol_group fn-clear">
            <span class="demonstration">颜色：</span>
            <div class="setChoice">
                <el-color-picker v-model="lineColor" class="line_color"></el-color-picker>
            </div>
            <span class="reBack" @click="lineColor = '#DDDDDD'">重置</span>
        </div>
        <div class="contol_group fn-clear">
            <span>边距：</span>
            <div class="setChoice">
                <el-radio v-model="haveMargin" label="no_margin">无边距</el-radio>
                <el-radio v-model="haveMargin" label="have_margin">左右留边</el-radio>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span>样式：</span>
            <div class="setChoice">
                <el-radio v-model="manner" label="dashed">虚线</el-radio>
                <el-radio v-model="manner" label="solid">实线</el-radio>
                <el-radio v-model="manner" label="dotted">点线</el-radio>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props:['pageParam'],
    data() {
        return {
            haveMargin: "no_margin",
            manner: "solid",
            lineColor: "#DDDDDD"
        }
    },
    methods:{
        initData(){
            this.haveMargin = this.pageParam.haveMargin;
            this.manner = this.pageParam.manner;
            this.lineColor = this.pageParam.lineColor;
        }
    },
    updated(){
        var obj = {
            haveMargin: this.haveMargin,
            manner: this.manner,
            lineColor: this.lineColor
        }
        this.$emit('event', obj);
    },
    mounted(){
        this.initData();
    }
};
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
    cursor: pointer;
}
.demonstration{
    margin-top: 2px;
}
.setChoice{
    float: left;
}
.line_color{
    height: 25px;
}
</style>
<template>
    <div class="set_search">
        <div class="contol_group fn-clear">
            <span>选择风格：</span>
            <div class="setChoice">
                <el-radio v-model="searchStyle" label="ordinary">普通搜索</el-radio>
                <el-radio v-model="searchStyle" label="top">顶部搜索</el-radio>
            </div>
        </div>
        <div class="fn-clear" v-if="searchStyle == 'top'">
            <div class="contol_group contol_group1 fn-clear">
                <span>外底色：</span>
                <div class="setChoice">
                    <el-color-picker v-model="searchColor_outside"></el-color-picker>
                </div>
            </div>
            <div class="contol_group contol_group2 fn-clear">
                <span>内底色：</span>
                <div class="setChoice">
                    <el-color-picker v-model="searchColor_inside"></el-color-picker>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props:['pageParam'],
        data(){
            return {
                searchStyle:'ordinary',
                searchColor_outside:'#FF6633',
                searchColor_inside:'#E64514'
            }
        },
        updated(){
            var searchData = {
                searchStyle:this.searchStyle,
                searchColor_outside:this.searchColor_outside,
                searchColor_inside:this.searchColor_inside,
            }
            this.$emit('event', searchData);
        },
        methods:{
            initData(){
                this.searchStyle = this.pageParam.searchStyle;
                this.searchColor_outside = this.pageParam.searchColor_outside;
                this.searchColor_inside = this.pageParam.searchColor_inside;
            }
        },
        mounted(){
            this.initData();
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
.setChoice{
    float: left;
}
.demonstration{
    position: relative;
    margin-top: 5px;
}
.contol_group1{
    float: left;
}
.contol_group2{
    float: right;
    margin-right: 108px;
}
</style>
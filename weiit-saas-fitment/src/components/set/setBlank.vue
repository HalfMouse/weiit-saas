<template>
    <div class="set_blank">
        <div class="contol_group fn-clear">
            <span class="demonstration">空白高度：</span>
            <div class="block">
                <el-slider v-model="value" :min="10" :max="100"></el-slider>
            </div>
            <span class="values">{{value}}像素</span>
        </div>
    </div>
</template>

<script>
    export default {
        props:['pageParam'],
        data(){
            return {
                value:30
            }
        },
        updated(){
            var obj = {
                value: this.value
            }
            this.$emit('event', obj);
        },
        methods:{
            // 初始化数据
            initData(){
                this.value = this.pageParam.value;
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
        margin-top: 9px;
    }
    .block{
        width: 225px;
        float: left;
    }
    .contol_group span.values{
        float: left;
        width: auto;
        margin-left: 15px;
    }
</style>
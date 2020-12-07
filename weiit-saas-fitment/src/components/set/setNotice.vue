<template>
    <div class="set_notice">
        <div class="contol_group fn-clear">
            <p class="demonstration1" :class="{'hasNo':isMust}">
                <span class="icon">*</span>公告：
            </p>
            <div class="setChoice">
                <el-input v-model="noticeTxt" placeholder="请输入内容"></el-input>
            </div>
        </div>
        <p v-if="isMust" class="reminder">请填写公告内容</p>
        <div class="contol_group fn-clear">
            <span class="demonstration2">背景颜色：</span>
            <div class="setChoice">
                <el-color-picker v-model="bgColor"></el-color-picker>
            </div>
            <span class="reBack" @click="bgColor='#FFF5E7'">重置</span>
        </div>
         <div class="contol_group contol_group1 fn-clear">
            <span class="demonstration2">文字颜色：</span>
            <div class="setChoice">
                <el-color-picker v-model="textColor"></el-color-picker>
            </div>
            <span class="reBack" @click="textColor='#999999'">重置</span>
        </div>
    </div>
</template>

<script>
    import {mapState,mapMutations} from 'vuex';
    export default {
    	props:['pageParam'],
        data() {
            return {
                bgColor:'#FFF5E7',
                textColor:'#999999',
                noticeTxt:''
            }
        },
        methods:{
            ...mapMutations(['noState','changeState']),
             // 初始化数据
            initData(){
                this.bgColor = this.pageParam.bgColor;
                this.textColor = this.pageParam.textColor;
                this.noticeTxt = this.pageParam.noticeTxt;
            }
        },
        computed:{
            ...mapState(['isMust'])
            
        },
        updated(){
            var notices = {
                bgColor: this.bgColor,
                textColor: this.textColor,
                noticeTxt: this.noticeTxt,
            }
            this.$emit('event', notices);
        },
        watch:{
            noticeTxt:function(curVal,oldVal){
                if(curVal.length == 0){
                    this.changeState();
                }else{
                    this.noState();
                }
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
    .demonstration1{
        float: left;
        margin-top: 7px;
        width: 85px;
        text-align: right;
        position: relative;
    }
    .demonstration1 .icon{
        position: absolute;
        width: auto;
        color: #f44;
        left: 38px;
    }
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
    .contol_group1{
        margin-top: 2px;
    }
    .demonstration2{
        margin-top: 2px;
    }
    .setChoice{
        float: left;
    }
    .hasNo{
        color:#f44; 
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        padding-left: 86px;
        font-size: 12px;
    }
</style>
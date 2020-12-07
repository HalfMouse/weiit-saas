<template>
    <div class="set_service">
        <div class="contol_group fn-clear">
            <span class="demonstration">文本：</span>
            <!-- <el-input class="tel_num" type="text" placeholder="客服电话" v-model="custom_txt"></el-input> -->
            <input type="text" v-model="custom_txt" placeholder="请输入标题"/>

        </div>
        <div class="contol_group fn-clear" :class="{'hasNo':isMust}">
            <span class="demonstration">电话：</span>
            <input type="tel" maxlength="11" v-model="custom_tel" placeholder="请输入电话号码"/>
            <!-- <el-input type="tel" class="tel_num" v-model="custom_tel" maxlength="11"></el-input> -->
        </div>
        <p v-if="isMust && !custom_tel" class="reminder">请填写客服电话</p>
        <p v-if="isMust && custom_tel" class="reminder">请填写正确电话</p>
    </div>
</template>

<script>
    import {mapState,mapMutations} from 'vuex';
    export default {
        props:['pageParam'],
        data() {
            return {
                custom_txt:'客服电话',
                custom_tel:null
            }
        },
        methods:{
            ...mapMutations(['noState','changeState']),
            initData(){
                this.custom_txt = this.pageParam.custom_txt;
                this.custom_tel = this.pageParam.custom_tel;
            }
        },
        computed:{
            ...mapState(['isMust'])
        },
        updated(){
            var service = {
                custom_txt: this.custom_txt,
                custom_tel: this.custom_tel
            }
            this.$emit('event', service);
        },
        watch:{
            custom_tel:function(curVal,oldVal){
                
                if(curVal){
                    this.noState();
                }else{
                    this.changeState();
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
    .contol_group span {
        float: left;
        width: 85px;
        text-align: right;
        margin-right: 10px;
        margin-top: 5px;
    }
    .contol_group input{
        padding-left: 5px;
    }
    .setChoice{
        float: left;
    }
    .tips{
        float: left;
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        padding-left: 93px;
        font-size: 12px;
    }
    .hasNo{
        color: #f44;
    }
    .tel_num{
        width: 200px;
    }
</style>
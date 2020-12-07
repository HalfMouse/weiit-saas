<template>
    <div class="showBox">
        <a class="service fn-clear blankShow" @click="showTel()">
            <i class="icon iconfont icon-dianhua"></i>
            <span>{{custom_txt}}：{{custom_tel}}</span>
            <i class="icon iconfont icon-you"></i>
        </a>
    </div>
</template>

<script>
    export default {
        props:{
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        custom_txt:'客服电话',
                        custom_tel:''
                    }
                },
            }
        },
        data(){
            return {
                custom_txt:'客服电话',
                custom_tel:''
            }
        },
        mounted(){
            this.custom_txt = this.pageParam.custom_txt;
            this.custom_tel = this.pageParam.custom_tel;
        },
        methods:{
            // 弹出客服电话
            showTel(){
                window.location.href="tel:" + this.custom_tel;
            }
        }
    }
</script>

<style scoped>
    .service{
        display: block;
      padding: 15px 10px;  
      background-color: #fff;
      cursor: pointer;
    }
    .service .icon-dianhua{
        float: left;
        font-size: 18px;
        color: #999;
        margin-right: 8px;
    }
    .service span{
        float: left;
        font-size: 12px;
        font-size: 16px;
        color: #777
    }
    .service .icon-you{
        float: right;
        font-size: 16px;
        color: #999;
        font-weight: bold
    }
</style>
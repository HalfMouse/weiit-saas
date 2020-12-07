<template>
    <div class="showBox">
        <div class="notice fn-clear blankShow" :style="{backgroundColor:bgColor}">
            <div class="right_txt" v-if="noticeTxt == ''" :style="{color:textColor}">请填写内容，如果过长，将会在手机上滚动显示</div>
            <van-notice-bar v-else
                :color="textColor"
                :text="noticeTxt"
                :background="bgColor"
                left-icon="../../../static/images/notice1.png"
            />
            
        </div>
    </div>
</template>

<script>
    export default {
        props:{
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        bgColor:'#FFF5E7',
                        textColor:'#999999',
                        noticeTxt:''
                    }
                },
            }
        },
        data() {
            return {
                bgColor:'#FFF5E7',
                textColor:'#999999',
                noticeTxt:'',
                count:2
            }
        },
        mounted(){
            this.bgColor = this.pageParam.bgColor;
            this.textColor = this.pageParam.textColor;
            this.noticeTxt = this.pageParam.noticeTxt;
        }
    }
</script>

<style scoped>
    .notice{
        color: rgb(102, 102, 102);
        background: rgb(255, 248, 233);
        position: relative;
    }
    .left_icon{
        float: left;
        width: 0.36rem;
        height: 0.36rem;
        margin-right: 0.1rem;
    }
    .left_icon img{
        width: 100%;
        display: block;
    }
    .right_txt{
        float: left;
        font-size: 0.28rem;
    }
</style>
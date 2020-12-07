<template>
    <div class="showBox">
        <div class="notice fn-clear blankShow" :style="{backgroundColor:bgColor}">
            <div class="left_icon">
                <img src="static/images/notice1.png" alt="" draggable="false">
            </div>
            <div class="right_txt" v-if="noticeTxt == ''" :style="{color:textColor}">请填写内容，如果过长，将会在手机上滚动显示</div>
            <div class="right_txt" v-else :style="{color:textColor}">{{noticeTxt}}</div>
        </div>
        <!-- 设置公告 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-notice @event="getData" :pageParam="pageParam"></set-notice>
        </div>  
    </div>
</template>

<script>
    // 设置公告
    import setNotice from '@/components/set/setNotice'
    // 设置头部
    import headModify from '@/components/common/headModify'
    import List from '../../../static/js/List'
    import {mapActions} from 'vuex'
    export default {
        props:{
            keyText:String,
            tempId:Number,
            keyWords:String,
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        bgColor:'#FFF5E7',
                        textColor:'#999999',
                        noticeTxt:''
                    }
                }
            }
        },
        data() {
            return {
                bgColor:'#FFF5E7',
                textColor:'#999999',
                noticeTxt:''
            }
        },
        components:{
            setNotice,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(notice){
                this.bgColor = notice.bgColor;
                this.textColor = notice.textColor;
                this.noticeTxt = notice.noticeTxt;
                // 修改数据
                this.changeData({id:this.tempId,op:notice})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.bgColor = this.bgColor;
                list.pageParam.textColor = this.textColor;
                list.pageParam.noticeTxt = this.noticeTxt;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.bgColor = this.pageParam.bgColor;
                this.textColor = this.pageParam.textColor;
                this.noticeTxt = this.pageParam.noticeTxt;
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .notice{
        color: rgb(102, 102, 102);
        background: rgb(255, 248, 233);
        padding:9px 10px;
        position: relative;
    }
    .left_icon{
        float: left;
        width: 16px;
        height: 16px;
        margin-right: 8px;
    }
    .left_icon img{
        width: 100%;
    }
    .right_txt{
        float: left;
        width: 260px;
        font-size: 12px;
        margin-top: -2px;
        white-space: nowrap;
        overflow: hidden;
    }
    /* 右侧设置 */
    .modify_box {
        position: absolute;
        right: -450px;
        top:0;
        padding: 12px 10px;
        min-height: 28px;
        background: #f8f8f8;
        border-radius: 5px;
        border: 1px solid #e5e5e5;
        width: 420px;
        margin-left: 20px;
        font-size: 12px;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        z-index: 5;
    }
    .modify_box:after, 
    .modify_box:before {
        right: 100%;
        top: 20px;
        border: solid transparent;
        content: " ";
        height: 0;
        width: 0;
        position: absolute;
        pointer-events: none;
    }
    .modify_box:before {
        border-color: transparent;
        border-right-color: #e5e5e5;
        border-width: 7px;
        margin-top: -7px;
    }
</style>
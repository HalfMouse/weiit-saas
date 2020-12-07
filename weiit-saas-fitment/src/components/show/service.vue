<template>
    <div class="showBox">
        <div class="service fn-clear blankShow">
            <i class="icon iconfont icon-dianhua"></i>
            <span>{{custom_txt}}：{{custom_tel}}</span>
            <i class="icon iconfont icon-you"></i>
        </div>
        <!-- 设置客服电话 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-service @event="getData" :pageParam="pageParam"></set-service>
        </div> 
    </div>
</template>

<script>
    // 设置头部 
    import headModify from '@/components/common/headModify'
    // 设置客服
    import setService from '@/components/set/setService'
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
                        custom_txt:'客服电话',
                        custom_tel:''
                    }
                }
            }
        },
        data(){
            return {
                custom_txt:'客服电话',
                custom_tel:''
            }
        },
        components:{
            headModify,
            setService
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(service){
                this.custom_txt = service.custom_txt;
                this.custom_tel = service.custom_tel;
                // 修改数据
                this.changeData({id:this.tempId,op:service})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.custom_txt = this.custom_txt;
                list.pageParam.custom_tel = this.custom_tel;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.custom_txt = this.pageParam.custom_txt;
                this.custom_tel = this.pageParam.custom_tel; 
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .service{
      padding: 5px 10px;  
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
<template>
    <div class="showBox">
        <div class="version blankShow" :style="{backgroundColor:bgColor}">
            <p :style="{color:fontColor,fontSize:fontS,textAlign:sition}">
                {{textarea}}
            </p>
            
        </div>
        <!-- 设置文本 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-version @event="getData" :pageParam="pageParam"></set-version>
        </div> 
    </div>
</template>

<script>
    // 设置文本
    import setVersion from '@/components/set/setVersion'
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
                        font: 'big',
                        fontPos: 'left',
                        fontColor:'#000',
                        bgColor:'#fff',
                        textarea:''
                    }
                },
            }
        },
        data() {
            return {
                font: 'big',
                fontPos: 'left',
                fontColor:'#000',
                bgColor:'#fff',
                textarea:''
            }
        },
        computed:{
            fontS(){
                switch(this.font){
                    case 'big':
                        return '18px';
                        break;
                    case 'middle':
                        return '14px';
                        break;
                    case 'small':
                        return '12px';
                        break;
                }
            },
            sition(){
                switch(this.fontPos){
                    case 'left':
                        return 'left';
                        break;
                    case 'center':
                        return 'center';
                        break;
                    case 'right':
                        return 'right';
                        break;
                }
            }
        },
        components:{
            setVersion,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(versions){
                this.font = versions.font;
                this.fontPos = versions.fontPos;
                this.fontColor = versions.fontColor;
                this.bgColor = versions.bgColor;
                this.textarea = versions.textarea;
                // 修改数据
                this.changeData({id:this.tempId,op:versions})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.font = this.font;
                list.pageParam.fontPos = this.fontPos;
                list.pageParam.fontColor = this.fontColor;
                list.pageParam.bgColor = this.bgColor;
                list.pageParam.textarea = this.textarea;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.font = this.pageParam.font;
                this.fontPos = this.pageParam.fontPos;
                this.fontColor = this.pageParam.fontColor;
                this.bgColor = this.pageParam.bgColor;
                this.textarea = this.pageParam.textarea; 
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .version{
        padding: 10px 5px;
        background-color: #fff;
    }
    .version p{
        text-align: left;
        columns: #000;
        font-size: 14px;
        word-break:break-all;
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
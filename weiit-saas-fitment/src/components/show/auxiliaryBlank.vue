<template>
    <div class="showBox">
        <div class="auxiliary_blank blankShow" :style="{height:value + 'px'}">
        
        </div>
        <!-- 设置白块 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-blank @event="getData" :pageParam="pageParam"></set-blank>
        </div> 
    </div>
    
</template>

<script>
    // 设置空白块
    import setBlank from '@/components/set/setBlank'
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
                    return {showStyle:'type3',bgPic:''}
                }
            }
        },
        data(){
            return {
                value:30
            }
        },
        components:{
            setBlank,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(obj){
                this.value = obj.value
                // 修改数据
                this.changeData({id:this.tempId,op:obj})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.value = this.value;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.value = this.pageParam.value;
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .auxiliary_blank{
        background-color: #fff;
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
<template>
    <div class="showBox">
        <div class="auxiliary_lines blankShow">
            <span :style="{borderColor:lineColor,width:width,borderStyle:border }"></span>
        </div>
        <!-- 设置辅助线 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-lines  @event="getData" :pageParam="pageParam"></set-lines>
        </div> 
    </div>
</template>

<script>
    // 设置辅助线 
    import setLines from '@/components/set/setLines'
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
                    return {haveMargin: "no_margin",manner: "solid",lineColor: "#DDDDDD"}
                }
            }
        },
        data() {
            return {
                haveMargin: "no_margin",
                manner: "solid",
                lineColor: "#DDDDDD"
            }
        },
        computed:{
            width(){
                if(this.haveMargin == 'no_margin'){
                    return '100%';
                }else{
                    return '80%';
                }
            },
            border(){
                switch(this.manner){
                    case 'dashed':
                        return 'dashed';
                        break;
                    case 'solid':
                        return 'solid';
                        break;
                    case 'dotted':
                        return 'dotted';
                        break;
                }
            }
        },
        components:{
            setLines,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(obj){
                this.haveMargin = obj.haveMargin;
                this.manner = obj.manner;
                this.lineColor = obj.lineColor;
                // 修改数据
                this.changeData({id:this.tempId,op:obj})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.haveMargin = this.haveMargin;
                list.pageParam.manner = this.manner;
                list.pageParam.lineColor = this.lineColor;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.haveMargin = this.pageParam.haveMargin;
                this.manner = this.pageParam.manner;
                this.lineColor = this.pageParam.lineColor;
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .auxiliary_lines{
        width: 100%;
        height: 15px;
        padding-top: 15px;
        margin: 0 auto;
    }
    .auxiliary_lines span{
        display: block;
        border:none 0;
        border-bottom:2px solid #ddd;
        margin: 0 auto;
        padding: 0;
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
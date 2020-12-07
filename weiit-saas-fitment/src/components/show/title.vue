<template>
    <div class="showBox">
        <div class="title fn-clear blankShow">
            <h6 v-if="inputTitle == ''" :style="{textAlign:style}" :class="{'active':titleStyle == 'style2'}">
                <span class="line" v-if="titleStyle == 'style2'"></span>
                <span class="txt">点击编辑『标题』</span>
                <span class="line" v-if="titleStyle == 'style2'"></span>                
            </h6>
            <h6 v-else :style="{textAlign:style}" :class="{'active':titleStyle == 'style2'}">
                <span class="line" v-if="titleStyle == 'style2'"></span>
                <span class="txt">{{inputTitle}}</span>
                <span class="line" v-if="titleStyle == 'style2'"></span> 
            </h6>
            <span class="more" v-if="more == 'isHave'">更多></span>
        </div>
        <!-- 设置标题 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-title @event="getData" :pageParam="pageParam"></set-title>
        </div>
    </div>
</template>

<script>
    // 设置标题
    import setTitle from '@/components/set/setTitle'
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
                        titleStyle:'style1',
                        more:'isHave',
                        inputTitle:'',
                        titleNav:null
                    }
                }
            }
        },
        data() {
            return {
                titleStyle:'style1',
                more:'isHave',
                inputTitle:'',
                titleNav:null
            }
        },
        computed:{
            style(){
                switch(this.titleStyle){
                    case 'style1':
                        return 'left';
                        break;
                    case 'style2':
                        return 'center';
                        break;
                }
            }
        },
        components:{
            setTitle,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(title){
                this.titleStyle = title.titleStyle;
                this.more = title.more;
                this.inputTitle = title.inputTitle;
                this.titleNav = title.titleNav;
                // 修改数据
                this.changeData({id:this.tempId,op:title})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.titleStyle = this.titleStyle;
                list.pageParam.more = this.more;
                list.pageParam.inputTitle = this.inputTitle;
                list.pageParam.titleNav = title.titleNav;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.titleStyle = this.pageParam.titleStyle;
                this.more = this.pageParam.more;
                this.inputTitle = this.pageParam.inputTitle;
                this.titleNav = this.pageParam.titleNav;
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .title{
        position: relative;
        line-height: 44px;
        padding: 0 10px;
        background-color: #fff;
    }
    .title h6{
        position: relative;
        color: #333;
        font-size: 17px;
    }
    .title .more{
        position: absolute;
        top: 0;
        right: 10px;
        font-size: 14px;
        color: #666;
        height: 100%;
        line-height: 44px;
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
    .title h6.active{
        display: table;
        margin: 0 auto;
    }
    .title h6 span.txt{
       margin: 0 8px 0 10px;
    }
    .title h6 span.line{
        width: 18px;
        height: 2px;
        background-color: #000;
        margin-top: 21px;
    }
</style>
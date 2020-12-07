<template>
    <div class="showBox">
        <div class="rich_text blankShow fn-clear" :style="{'backgroundColor':richColor}">
            <div v-if="content != ''" v-html="content"></div>
            <div class="cap-richtext" v-else>
                <p>点此编辑『富文本』内容 ——></p>
                <p>你可以对文字进行<strong>加粗</strong>、<em>斜体</em>、<span style="text-decoration: underline;">下划线</span>、<span style="text-decoration: line-through;">删除线</span>、文字<span style="color: rgb(0, 176, 240);">颜色</span>、<span style="background-color: rgb(255, 192, 0); color: rgb(255, 255, 255);">背景色</span>、以及字号<span style="font-size: 20px;">大</span><span style="font-size: 14px;">小</span>等简单排版操作。</p>
                <p>还可以在这里加入表格了</p>
                <table><tbody><tr><td width="93" valign="top" style="word-break: break-all;">中奖客户</td><td width="93" valign="top" style="word-break: break-all;">发放奖品</td><td width="93" valign="top" style="word-break: break-all;">备注</td></tr><tr><td width="93" valign="top" style="word-break: break-all;">猪猪</td><td width="93" valign="top" style="word-break: break-all;">内测码</td><td width="93" valign="top" style="word-break: break-all;"><em><span style="color: rgb(255, 0, 0);">已经发放</span></em></td></tr><tr><td width="93" valign="top" style="word-break: break-all;">大麦</td><td width="93" valign="top" style="word-break: break-all;">积分</td><td width="93" valign="top" style="word-break: break-all;"><a href="javascript: void(0);" target="_blank">领取地址</a></td></tr></tbody></table>
                <p style="text-align: left;margin-bottom:0;padding-bottom:5px;"><span style="text-align: left;">也可在这里插入图片、并对图片加上超级链接，方便用户点击。</span></p>
            </div>
        </div>
        <!-- 设置富文本 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-rich @event="getData" :pageParam="pageParam"></set-rich>
        </div>
    </div>
</template>

<script>
    // 设置富文本
    import setRich from '@/components/set/setRich'
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
                        content:'',
                        richColor:'#f9f9f9'
                    }
                }
            }
        },
        data(){
            return {
               content:'',
               richColor:'#f9f9f9'
            }
        },
        components:{
            setRich,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(rich){
                this.content = rich.content.replace(/img/g,'img style="width:100%;float:left"');
                this.richColor = rich.richColor;
                // 修改数据
                this.changeData({id:this.tempId,op:rich})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.content = this.content;
                list.pageParam.richColor = this.richColor;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            initData(){
                this.content = this.pageParam.content;
                this.richColor = this.pageParam.richColor;
            }
            
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .rich_text{
        padding: 5px 10px;
    }
    .cap-richtext p{
        margin-bottom: 16px;
    }
    .cap-richtext td, .cap-richtext th {
        padding: 5px 10px;
        border: 1px solid #ddd;
    }
    .cap-richtext table{
        margin-bottom: 16px;
    }
    .cap-richtext em, .cap-richtext i {
        font-style: italic;
    }
    
</style>
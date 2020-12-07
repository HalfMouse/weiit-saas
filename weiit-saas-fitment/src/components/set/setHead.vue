<template>
    <div class="set_head">
        <div class="contol_group fn-clear">
            <span class="demonstration">页面名称：</span>
            <div class="setChoice">
                <el-input v-model="pageName" placeholder="请输入标题"></el-input>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span class="demonstration">页面描述：</span>
            <div class="setChoice">
                <el-input v-model="pageDesc" placeholder="用户通过微信分享给朋友时，会自动显示页面描述"></el-input>
            </div>
        </div>
        <!--<div class="contol_group fn-clear">
            <span class="demonstration">分类：</span>
            <div class="setChoice">
                <el-input v-model="sort" placeholder="请选择"></el-input>
            </div>
        </div>-->
        <!--<div class="contol_group fn-clear">
            <span>背景颜色：</span>
            <div class="setChoice">
                <el-radio v-model="bgColor" label="custom">默认背景颜色</el-radio>
                <el-radio v-model="bgColor" label="auto">自定义背景颜色</el-radio>
            </div>
        </div>-->
    </div>
</template>

<script>
    import {getQueryString} from '../../../static/js/getQueryString';
    export default {
        data(){
            return {
                pageName:'',
                pageDesc:'',
                pageStyle:'',
                templateId:null
            }
        },
        updated(){
            var obj = {
                pageName: this.pageName,
                pageDesc: this.pageDesc
            }
            this.$emit('event', obj);
        },
        methods:{
            // 获取编辑信息
            getEditNews(){
                this.$ajax({
                    methods:'get',
                    url:'/center/design/weiPage',
                    params:{
                        templateId:this.templateId
                    }
                }).then(res => {
                    this.pageDesc = res.data.pageInfo.page_desc;
                    this.pageName = res.data.pageInfo.page_name;
                }).catch(err => {
                    (err)
                })
            },
            // 获取模板信息
            getResource(){
                this.$ajax({
                    methods:'get',
                    url:'/center/design/page/getTemplatePageJson',
                    params:{
                        templateId:this.templateId
                    }
                }).then(res => {
                    this.pageDesc = res.data.pageInfo.page_desc;
                    this.pageName = res.data.pageInfo.page_name;
                }).catch(err => {
                    (err)
                })
            }
        },
        mounted(){
            if(this.pageStyle == 'create'){
                this.getResource();
            }else if(this.pageStyle == 'edit'){
                this.getEditNews()
            }
        },
        created(){
            this.templateId = getQueryString('templateId');
            this.pageStyle = getQueryString('pageStyle');
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
    }
    .demonstration{
        margin-top: 7px;
    }
    .setChoice{
        float: left;
        width: 270px;
    }
</style>
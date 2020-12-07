<template>
    <div>
        <div class="close" v-show="showFlag">
            <i class="icon iconfont icon-guanbi" @click="isShow=true"></i>
        </div>
        <!-- 删除弹出框 -->
        <div class="del_box" v-show="isShow">
            <h5>确定删除？</h5>
            <div>
                <el-button class="del_btn" type="primary" @click="del($event)">确认</el-button>
                <el-button @click="isShow=false">取消</el-button>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data(){
            return {
                showFlag:false,
                isShow:false
            }
        },
        methods:{
            del(e){
                
            }
        }
    }
</script>

<style scoped>
    .icon-guanbi{
        position: absolute;
        display: block;
        font-size: 20px;
        color: #a3a3a3;
        cursor: pointer;
        height: 20px;
        left: -2px;
        top: -6px;
    }
    .close{
        position: absolute;
        top: -6px;
        right: -7px;
        background-color: #fff;
        width:16px;
        height: 16px;
        border-radius: 50%;
        z-index: 999;
    }  
    .del_box{
        position: absolute;
        right: 38px;
        top: -19px;
        background-color: #fff;
        padding: 10px 20px;
        border-radius: 6px;
        z-index: 990;
        border:1px solid #ccc;
    }
    .del_box h5{
        text-align: center;
        color: #333;
        margin-bottom: 10px;

    }
    .el-button{
        padding:6px 12px;
    }
</style>
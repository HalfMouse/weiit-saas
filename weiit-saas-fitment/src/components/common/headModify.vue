<template>
    <h5>
        <span>{{keyText}}</span>
        <!--<a href="javascript:;">查看教程</a>-->
    </h5> 
</template>

<script>
    export default {
        props:['keyText'],
    }
</script>

<style scoped>
    /* 右侧设置栏头部 */
    h5{
        padding-bottom: 5px;
        border-bottom: 1px solid #e5e5e5;
        overflow: hidden;
    }
    h5 span{
        float: left;
    }
    h5 a{
        float: right;
        color: #38f;
        cursor: pointer;
    }
</style>
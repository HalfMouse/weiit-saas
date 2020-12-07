<template>
    <div class="bargain_head fn-clear">
        <div class="head_show fn-clear">
            <span class="line"></span>
            <span class="txt" v-if="titleTxt == ''">限时砍价</span>
            <span class="txt" v-if="titleTxt != ''">{{titleTxt}}</span>
            <span class="line"></span>
            <a href="javascript:;" class="more">更多 ></a>
        </div>
    </div>
</template>

<script>
    export default {
        props:['titleTxt']
    }
</script>

<style scoped>
    .bargain_head{
        width: 100%;
        height: 44px;
        background-color: #fff;
        text-align: center;
        line-height: 44px;
    }
    .head_show{
        display: table;
        margin: 0 auto;
    }
    .head_show span{
        float: left;
    }
    .bargain_head span.line{
        width: 25px;
        height: 2px;
        background-color: #000;
        margin-top: 21px;
    }
    .bargain_head span.txt{
        font-size: 16px;
        font-weight: bold;
        color: #333;
        margin: 0 15px;
    }
    .head_show .more{
    	position: absolute;
    	right: 5px;
    	top: 0;
    	color: #EC534E;
    }
</style>
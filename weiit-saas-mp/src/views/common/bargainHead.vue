<template>
    <div class="bargain_head fn-clear">
        <div class="head_show fn-clear">
            <span class="line"></span>
            <span class="txt" v-if="titleTxt == ''">限时砍价</span>
            <span class="txt" v-if="titleTxt != ''">{{titleTxt}}</span>
            <span class="line"></span>
            
        </div>
        <a href="javascript:;" class="more"  @click="bargainList">更多 ></a>
    </div>
</template>

<script>
    export default {
        props:['titleTxt'],
        methods:{
            bargainList() {
                this.$router.push({
                    path:'/teams',
                    name:'teams',
                    params:{
                        type:'bargain'
                    }
                })
            },
        }
    }
</script>

<style scoped>
    .bargain_head{
        position: relative;
        width: 100%;
        height: 0.88rem;
        background-color: #fff;
        text-align: center;
        line-height: 0.88rem;
    }
    .head_show{
        display: table;
        margin: 0 auto;
    }
    .head_show span{
        float: left;
    }
    .bargain_head span.line{
        width: 0.5rem;
        height: 0.04rem;
        background-color: #000;
        margin-top: 0.42rem;
    }
    .bargain_head span.txt{
        font-size: 0.4rem;
        font-weight: bold;
        color: #333;
        margin: 0 0.3rem;
    }
    .more{
        position: absolute;
        right: 0.2rem;
        top: 50%;
        transform: translateY(-50%);
        font-size: 0.28rem;
        color: #ec534e;
    }
</style>
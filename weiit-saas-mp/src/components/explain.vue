<template>
    <div class="explain_box" v-show="isOk">
        <div class="explain_pic">
            <img src="static/images/rabbit.png" alt="">
        </div>
        <div v-if="item == 'wallet'">
            <h4>什么是余额</h4>
            <p>余额是指您在{{page_name}}的一个账户，如账户内有款项，可用于{{page_name}}商城的商品</p>
        </div>
        <div v-if="item == 'integral'">
            <h4>什么是积分</h4>
            <p>余额是指您在{{page_name}}的一个账户，如账户内有积分，可用于兑换{{page_name}}商城的商品</p>
        </div>
        <span @click="hide()">朕知道了</span>
    </div>
</template>

<script>
    export default {
        props:['item'],
        data(){
            return{
                isOk:true,
                page_name:localStorage.getItem('page_name')
            }
        },
        methods:{
            hide(){
                this.isOk = false;
            }
        }
    }
</script>

<style scoped lang="scss">
    .explain_box{
        position: fixed;
        left: 50%;
        bottom: 0.6rem;
        width: 6.09rem;
        height: 1.96rem;
        background-color: #fff;
        border-radius: 0.2rem;
        padding: 0.2rem 0.4rem 0;
        box-shadow: 0px 0px 1rem 0px rgba(153,153,153,.2);
        transform: translateX(-50%);
        .explain_pic{
            position: absolute;
            left: 0.2rem;
            top: -0.8rem;
            width: 1.4rem;
            height: 1.4rem;
            img{
                width: 100%;
                height: 100%;
            }
        }
        h4{
            color: #999;
            line-height: 0.3rem;
            font-size: 0.3rem;
            font-weight: normal;
            margin-bottom: 0.26rem;
            margin-left: 1.4rem;
        }
        p{
            font-size: 0.3rem;
            color: #999;
            line-height: 0.36rem;
        }
        span{
            position: absolute;
            right: 0.4rem;
            bottom: 0.15rem;
            font-size: 0.3rem;
            font-weight: bold;
            color: #3795ED;
        }
    }
</style>
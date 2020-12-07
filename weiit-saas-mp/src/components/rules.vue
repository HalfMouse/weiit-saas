<template>
    <div class="rule_box" v-show="isTips">
        <div class="txt_box">
            <h6>活动规则</h6>
            <p>1.砍到商家规定的底价，即可按照底价购买商品;</p>
            <p>2.对于同一个砍价，您只能帮助砍价一次;</p>
            <p>3.每次砍价金额随机，参与好友越多越容易成功</p>
            <p>4.砍价完成以后需要7天内在砍价页完善收货信息，逾期失效;</p>
            <p>5.帮好友砍价,可以随机获得【宝刀】哦;</p>
            <i class="icon" @click="isTips = false">x</i>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                isTips: false
            }
        },
        methods: {
            show() {
                this.isTips = true
            }
        },
    }
</script>

<style scoped lang="scss">
    .rule_box{
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,.5);
        z-index: 100;
        .txt_box{
            position: absolute;
            left: 50%;
            top: 50%;
            background-color: #F4564A;
            transform: translate(-50%,-50%);
            width: 5rem;
            border-radius: 0.2rem;
            color: #fff;
            padding:0.3rem 0.5rem;
            h6{
                width: 2.78rem;
                height: 0.78rem;
                text-align: center;
                line-height: 0.9rem;
                font-size: 0.3rem;
                background-image: url('../../static/images/rules.png');
                background-size: 100% 100%;
                color: #C6000A;
                margin: 0 auto 0.3rem;
            }
            p{
                font-size: 0.28rem;
                margin-bottom: 0.2rem;
            }
            .icon{
                position: absolute;
                right: 0.1rem;
                top: 0.1rem;
                font-size: 0.4rem;
                color: #fff;
                font-style: normal;
                border: 1px solid #fff;
                padding: 0.1rem;
                border-radius: 50%;
                width: 0.2rem;
                height: 0.2rem;
                text-align: center;
                line-height: 0.13rem;
            }
        }
    }
</style>
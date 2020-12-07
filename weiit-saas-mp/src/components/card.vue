<template>
    <div class="card" :class="cardnum > 0 ? 'noExpire' : 'expire'" @click="toDetails()">
        <div class="card_name clearfix">
            <div class="userPic" :class="cardnum > 0 ? 'noExpirePic' : 'expirePic'"></div>
            <span class="userName">京东商城</span>
            <i class="icon iconfont" :class="cardnum > 0 ? 'icon-erweima' : 'icon-yiguoqi'"></i>
        </div>
        <span class="userId">用户ID</span>
        <p class="expiry_date">
            <span class="date_txt">有效期：</span> 
            <span class="date_time">2012.12.12-2021.1.1</span> 
        </p>
    </div>
</template>

<script>
    export default {
        props:['cardnum'],
        data(){
            return {
            }
        },
        methods:{
            // 跳转到会员卡详情页
            toDetails(){
                if(this.cardnum){
                    this.$router.push({
                        path:'/memberDetails',
                        name:'memberDetails'
                    })
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .card{
        height: 2.6rem;
        border-radius: 0.2rem;
        color: #fff;
        padding:0.2rem 0.4rem;
        &.noExpire{
            background-color: #8F82BC;
        }
        &.expire{
            background-color: #999;
        }
        .card_name{
            margin-bottom: 0.32rem;
            .userPic{
                float: left;
                width: 0.74rem;
                height: 0.74rem;
                background-size: 100% 100%;
                &.noExpirePic{
                    background-image: url('../../static/images/noexpire.png');
                }
                &.expirePic{
                    background-image: url('../../static/images/expire.png');
                }
            }
            .userName{
                float: left;
                line-height: 0.56rem;
                font-size: 0.3rem;
                font-weight: bold;
                margin-left: 0.16rem;
            }
            .icon{
                float: right;
                &.icon-erweima{
                    font-size: 0.7rem;
                }
                &.icon-yiguoqi{
                    font-size: 1.4rem;
                    margin-top: -0.2rem;
                    margin-right: -0.3rem;
                }
            }
        }
        .userId{
            display: block;
            font-weight: bold;
            font-size: 0.5rem;
            line-height: 0.48rem;
            margin-bottom: 0.6rem;
        }
        .expiry_date{
            overflow: hidden;
            span{
                float: left;
                &.date_txt{
                    font-size: 0.32rem;
                }
                &.date_time{
                    font-size: 0.28rem;
                    margin-top: 0.03rem;
                }
            }
        }
    }
</style>
<template>
    <div class="text_nav">
        <div class="logo">
            <img src="static/images/logo.png" alt="">
        </div>
        <p>蜗店提供技术支持</p>
    </div>
</template>

<script>
    export default {
        
    }
</script>

<style scoped lang="scss">
    .text_nav{
        position: absolute;
        width: 100%;
        bottom: 0.5rem;
        ul{
            display: table;
            margin: 0 auto;
            overflow: hidden;
            li{
                float: left;
                font-size: 0.28rem;
                color: #333;
                border-right: 1px solid #ccc;
                padding: 0 0.1rem;
                &:first-child{
                    margin-left: 0;
                }
                &:last-child{
                   border:none 0;
                }
            }
        }
        .logo{
            width: 1.2rem;
            margin: 0.4rem auto 0.2rem;
            img{
                display: block;
                width: 100%;
            }
        }
        p{
            text-align: center;
            font-size: 0.28rem;
            color: #333;
        }
    }
</style>
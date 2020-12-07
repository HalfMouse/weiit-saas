<template>
    <header>
        <div class="back">
            <i class="icon iconfont icon-arrow-left"></i>
            <span>返回</span>
        </div>
        <span>我的订单</span>
    </header>
</template>

<script>
    export default {
        
    }
</script>

<style scoped lang="scss">
    header{
        position: fixed;
        width: 100%;
        height: 3rem;
        background-color: #1b1a1f;
        padding-top: 3rem;
        color:#fefeff;
        text-align: center;
        .back{
            position: absolute;
            left: 1rem;
        }
    }
</style>
<template>
    <header>
        <i class="line"></i>
        <span>{{title}}</span>
        <a href="javascript:;" class="more" v-if="title == '商 品 列 表'">更多></a>
    </header>
</template>

<script>
    export default {
        props:['title']
        
    }
</script>

<style scoped lang="scss">
    header{
        line-height: 1rem;
        text-align: center;
        position: relative;
        background-color: #fff;
        i{
            position: absolute;
            width: 3.2rem;
            height: 2px;
            background-color: #000;
            left: 50%;
            top: 50%;
            transform: translate(-50%,-50%);
        }
        span{
            position: relative;
            width: 2.2rem;
            color: #333;
            font-size: 0.32rem;
            z-index: 10;
            background: #fff;
            display: block;
            height: 100%;
            margin: 0 auto;
            font-weight: bold;
        }
        .more{
            position: absolute;
            right: 0.2rem;
            top: 50%;
            transform: translateY(-50%);
            color: #EC534E;
            font-size: 0.28rem;
        }
    }
</style>
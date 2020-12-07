<template>
    <div class="all">
        <span class="line line_left"></span>
        <p class="no_more">我是有底线的</p>
        <span class="line line_right"></span>
    </div>
</template>

<script>
    export default {
    }
</script>

<style scoped lang="scss">
.all{
    position: relative;
    margin: 0.2rem 0;
    .no_more{
        text-align: center;
        color: #999;
        font-size: 0.28rem;
        margin-top:0.1rem;
    }
    .line{
        width: 1.8rem;
        height: 1px;
        background-color: #999;
        position: absolute;
        top: 50%;
        transform:translateY(-50%);
        &.line_left{
            left: 0.5rem;
        }
        &.line_right{
            right: 0.5rem;
        }
    }
}
    
</style>
<template>
    <div class="error">
        {{msg}}
    </div>
</template>

<script>
    export default {
        data() {
            return {
                msg: '该页面不存在'
            }
        },
    }
</script>

<style scoped lang="scss">
    .error{
        position: absolute;
        width: 100%;
        font-size: 0.3rem;
        color: #333;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        text-align: center;
    }
</style>
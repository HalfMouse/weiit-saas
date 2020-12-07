<template>
    <div class="showBox">
        <div class="combination blankShow">
        
        </div>
        <!-- 设置组合 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-combination></set-combination>
        </div>
    </div>
    
</template>

<script>
    // 设置拼团
    import setCombination from '@/components/set/setCombination'
    // 设置头部
    import headModify from '@/components/common/headModify' 
    export default {
        props:['keyText'],
        components:{
            setCombination,
            headModify
        }
    }
</script>

<style scoped>
    .combination{
        min-height:50px;
    }
</style>
<template>
    <div class="shop_goods">
        <div class="active_num">
            <span>活动专区1</span>
        </div>
        <div class="goods_mations">
            <label class="mint-checklist-label">
                <span class="mint-checkbox">
                    <input type="checkbox" class="mint-checkbox-input" :checked="item.is_default == 0" @click="checked(index)"> 
                    <span class="mint-checkbox-core"></span>
                </span>
            </label>
            <good :facomponent="facomponent"></good>
        </div>
    </div>
</template>

<script>
    // 引入good组件
    import good from 'good' 
    export default {
        data(){
            return {
                facomponent:'shopCart'
            }
        },
        components:{
            good,
            
        }
    }
</script>

<style scoped>

</style>
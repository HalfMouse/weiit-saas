<template>
    <div class="sekill">
        <ul class="fn-clear" :class="[{'goodBig':seckill.goodStyle == 'big'},{'matrix':seckill.goodStyle == 'matrix'},{'list':seckill.goodStyle == 'list'}]">
            <li>
                <seckill-good :goodStyle="seckill.goodStyle"></seckill-good>
            </li>
            <li>
                <seckill-good :goodStyle="seckill.goodStyle"></seckill-good>
            </li>
            <li>
                <seckill-good :goodStyle="seckill.goodStyle"></seckill-good>
            </li>
            <li>
                <seckill-good :goodStyle="seckill.goodStyle"></seckill-good>
            </li>
        </ul>
    </div>
</template>

<script>
    // 引入秒杀商品
    import seckillGood from '@/components/common/seckillGood'
    export default {
        data(){
            return {
                goodStyle:'list'
            }
        },
        components:{
            seckillGood
        }
    }
</script>

<style scoped>
    /* 矩阵 */
    .matrix li{
        float: left;
        margin-right: 4px;
    }
    .matrix li:nth-child(even){
        margin-right: 0;
    }
</style>
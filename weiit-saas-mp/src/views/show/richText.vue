<template>
    <div class="showBox">
        <div class="rich_text blankShow" :style="{'backgroundColor':bgColor}">
            <div v-html="message"></div>
        </div>
    </div>
</template>

<script>
    export default {
        props:['pageParam'],
        data(){
            return {
               message:'你好呀',
               bgColor:'#f9f9f9'
            }
        },
        // mounted(){
        //     this.message = this.pageParam.message;
        //     this.bgColor = this.pageParam.bgColor;
        // }
    }
</script>

<style scoped>
    .cap-richtext{
        padding: 0.2rem;
        padding-bottom: 0;
    }
    .cap-richtext p{
        margin-bottom: 0.32rem;
    }
    .cap-richtext td, .cap-richtext th {
        padding: 0.1rem 0.2rem;
        border: 1px solid #ddd;
    }
    .cap-richtext table{
        margin-bottom: 0.32rem;
    }
    .cap-richtext em, .cap-richtext i {
        font-style: italic;
    }
</style>
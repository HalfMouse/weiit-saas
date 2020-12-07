<template>
    <div class="showBox">
        <div class="auxiliary_blank blankShow" :style="{height:value + 'px'}">
        
        </div>
    </div>
</template>

<script>
    export default {
        props:{
            pageParam:{
                type:Object,
                default:() => {
                    return {showStyle:'type3',bgPic:''}
                },
            }
        },
        data(){
            return {
                value:30,
                count:2
            }
        },
        mounted(){
            this.value = this.pageParam.value;
        }
    }
</script>

<style scoped>
    .auxiliary_blank{
        background-color: #fff;
    }
</style>
<template>
    <div class="showBox vidoe-box">
        <iframe width="100%" height="100%"  frameborder=0 :src="videos" allowfullscreen="true" 
    webkitallowfullscreen="true"
    mozallowfullscreen="true"></iframe>
    </div>
    
</template>

<script>
    export default {
        props:['pageParam'],
        data(){
            return {
                videos:''
            }
        },
        mounted(){
            this.videos = this.pageParam.videos
        }
    }
</script>

<style scoped>
    .showBox{
        position: relative;
        width:100%;
        /* width:1px; */
        height: 4rem;
    }
    .PlayPic{
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 4.25rem
    }
</style>
<template>
    <div class="showBox">
        <div class="video blankShow">
            <iframe width="100%" height="100%" frameborder=0 :src=videoUrl allowfullscreen="true" v-if="videoUrl != ''"></iframe>
            
            <img src="static/images/video_show.png" alt="" width="100%" height="200" v-else>
        </div>
    <!-- 设置店招 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-video @event="getData" :pageParam="pageParam"></set-video>
        </div> 
    </div>
    
</template>

<script>
    // 设置视频
    import setVideo from '@/components/set/setVideo'
    // 设置头部
    import headModify from '@/components/common/headModify'
    import List from '../../../static/js/List'
    import {mapActions} from 'vuex' 
    export default {
        props:{
            keyText:String,
            tempId:Number,
            keyWords:String,
            pageParam:{
                type:Object,
                default:() => {
                    return {
		               videoUrl:''
                    }
                }
            }
        },
        data(){
            return {
                videoUrl:''
            }
        },
        components:{
            setVideo,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            getData(obj){
                this.videoUrl = obj.videoUrl
                console.log(this.videoUrl);
                // 修改数据
                this.changeData({id:this.tempId,op:obj})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.videoUrl = this.videoUrl;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            initData(){
            	this.videoUrl = this.pageParam.videoUrl;
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
.showBox .video{
    position: relative;
    height: 200px;
    z-index: -1;
}
</style>
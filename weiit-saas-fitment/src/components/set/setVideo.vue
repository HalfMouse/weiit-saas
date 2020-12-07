<template>
    <div class="set_video">
        <div class="contol_group contol_group1 fn-clear">
            <span class="">视频地址：</span>
            <div class="setChoice">
                <input type="text" v-model="videos"/>
            </div>
        </div>
        <p v-if="isMust && videos == ''" class="reminder" :class="{'hasNo':isMust && videos == ''}">视频地址不能为空</p>
    </div>
</template>

<script>
	// 引入语音上传组件
    import {mapState,mapMutations} from 'vuex';
    export default {
    	props:['pageParam'],
        data(){
            return {
                // 视频路径
                videoUrl:'',
                videos:''
            }
        },
        updated(){
        	if(this.videos != '' && this.videos){
        		//https://v.qq.com/txp/iframe/player.html?vid=c06108gfanu
        		let urlArray = this.videos.split('?');
	        	let vid = urlArray[urlArray.length-1].split('=')[1];
	            this.videoUrl = 'http://v.qq.com/iframe/player.html?vid=' + vid + '&tiny=0&auto=0';
        	}
        	
            var video = {
            	videos:this.videos,
               	videoUrl:this.videoUrl
            }
            this.$emit('event', video);
        },
        methods:{
            ...mapMutations(['noState','changeState','stopSort']),
            initData(){
            	this.videoUrl = this.pageParam.videoUrl;
            	this.videos = this.pageParam.videos;
            }
        },
        computed:{
            ...mapState(['isMust'])
        },
        mounted(){
            this.initData();
            
        },
        watch:{
            videos:function(curVal,oldVal){
                if(curVal.length == 0){
                    this.changeState();
                }else{
                    this.noState();
                }
            }
        }
    }
</script>

<style scoped>
    .contol_group {
        margin-top: 17px;
    }
    .contol_group span {
        float: left;
        text-align: right;
        margin-right: 10px;
    }
    .add_voice{
        cursor: pointer;
        float: left;
        width: 50px;
        height: 50px;
        border: 1px solid #ddd;
        background: #fff;
        text-align: center;
        line-height: 50px;
    }
    .add_voice .icon{
        color: #38f;
    }
    .desc{
        color: #999;
        margin-top: 10px;
        padding-left: 74px;
    }
    .hasNo{
        color:#f44; 
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        padding-left: 74px;
        font-size: 12px;
    }
    .setChoice2{
    	float: left;
    	width: 250px;
    }
    .video-txt{
    	float: left;
    }
    .video-name{
    	float: left;
    }
    .video-check{
    	float: left;
    	color: #409EFF;
    	cursor: pointer;
    }
</style>
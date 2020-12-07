<template>
    <div class="showBox">
        <div class="voice blankShow">
            <div class="simulation fn-clear" v-if="voiceStyle == 'simulation'">
                <div class="simulation_left fn-clear" v-if="pos == 'left'">
                    <div class="user_pic">
                        <img src="static/images/user.jpg" alt="" v-if="portrait == ''" draggable="false">
                        <img :src="portrait" alt="" v-else draggable="false">
                    </div>
                    <div class="voice_pic">
                        <img src="static/images/simulation_left.png" alt="" draggable="false">
                    </div>
                </div>
                <div class="simulation_right fn-clear" v-if="pos == 'right'">
                    <div class="voice_pic">
                        <img src="static/images/simulation_right.png" alt="" draggable="false">
                    </div>
                    <div class="user_pic">
                        <img src="static/images/user.jpg" alt="" v-if="portrait == ''" draggable="false">
                        <img :src="portrait" alt="" v-else draggable="false">
                    </div>
                </div>
            </div>
            <div class="simple" v-if="voiceStyle == 'simple'">
                <div class="music_player">
                    <div class="play">
                        <i class="icon iconfont icon-bofang"></i>
                    </div>
                    <div class="rate fn-clear">
                        <p>
                            {{voiceTitle}}
                        </p>
                        <div class="speed">
                            <div class="speed_icon">
                                <span></span>
                            </div>
                            <span class="speed_line"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 设置语音 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-voice @event="getData" :pageParam="pageParam"></set-voice>
        </div> 
    </div>
</template>

<script>
    // 设置店招  
    import setVoice from '@/components/set/setVoice'
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
                        voiceStyle:'simulation',
                        pos: 'left',
                        voiceTitle:'',
                        checked:false,
                        portrait:'',
                        AfterStop:'again'
                    }
                },
            }
        },
        data() {
            return {
                voiceStyle:'simulation',
                pos: 'left',
                voiceTitle:'',
                checked:false,
                portrait:'',
                voiceData:null,
                AfterStop:'again'
            }
        },
        components:{
            setVoice,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(voice){
                this.voiceStyle = voice.voiceStyle;
                this.pos = voice.pos;
                this.voiceTitle = voice.voiceTitle;
                this.isLoop = voice.isLoop;
                this.portrait = voice.portrait;
                this.AfterStop = voice.AfterStop;
                this.voiceData = voice.voiceData
                // 修改数据
                this.changeData({id:this.tempId,op:voice});
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.voiceStyle = this.voiceStyle;
                list.pageParam.pos = this.pos;
                list.pageParam.voiceTitle = this.voiceTitle;
                list.pageParam.isLoop = this.isLoop;
                list.pageParam.portrait = this.portrait;
                list.pageParam.AfterStop = this.AfterStop;
                list.pageParam.voiceData = this.voiceData
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.voiceStyle = this.pageParam.voiceStyle;
                this.pos = this.pageParam.pos;
                this.voiceTitle = this.pageParam.voiceTitle;
                this.isLoop = this.pageParam.isLoop;
                this.portrait = this.pageParam.portrait;
                this.AfterStop = this.pageParam.AfterStop;
                this.voiceData = this.pageParam.voiceData;
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
.voice{
    background-color: #fff;
    padding: 10px 0;
}
    .simulation{
        display: block;
        padding: 0 20px;
    }
    .simulation_left .user_pic,
    .simulation_right .voice_pic{
        margin-right: 5px;
    }
    .simulation_right{
        float: right;
    }
    .user_pic{
        float: left;
        width: 38px;
        height: 38px;
    }
    .user_pic img{
        width: 100%;
        height: 100%;
    }
    .voice_pic{
        float: left;
        width: 185px;
        height: 38px;
    }
    .voice_pic img{
        width: 100%;
        height: 100%;
    }
    .simple{
        width: 100%;
        
    }
    .music_player{
        position: relative;
        width: 290px;
        height: 60px;
        margin:0 auto;
    }
    .play{
        float: left;
        width: 40px;
    }
    .play .icon-bofang{
        display: block;
        color: #44BB00;
        font-size: 40px;
    }
    .rate{
        position: absolute;
        float: left;
        width: 210px;
        left: 46px;
        top: 21px;
    }
    .rate p{
        position: absolute;
        left: 0;top: -18px;
    }
    .speed{
        position: absolute;
        height: 16px;
        width: 100%;
        left: 0;
        top: 2px;
    }
    .speed_icon{
        width: 16px;
        height: 16px;
        border-radius: 50%;
        position: absolute;
        text-align: center;
        line-height: 16px;
        left: 0;
        top: 50%;
        margin-top: -8px;
        border:1px solid #e5e5e5;
        background-color: #fff;
    }
    .speed_icon span{
        position: absolute;
        left: 50%;
        top: 50%;
        margin-top: -2px;
        margin-left: -2px;
        width: 4px;
        height: 4px;
        background-color: #6ebb00;
    }
    .speed_line{
        display: block;
        width: 100%;
        height: 2px;
        background-color: #f2f2f2;
        margin-top: 7px;
    }
    /* 右侧设置 */
    .modify_box {
        position: absolute;
        right: -450px;
        top:0;
        padding: 12px 10px;
        min-height: 28px;
        background: #f8f8f8;
        border-radius: 5px;
        border: 1px solid #e5e5e5;
        width: 420px;
        margin-left: 20px;
        font-size: 12px;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        z-index: 5;
    }
    .modify_box:after, 
    .modify_box:before {
        right: 100%;
        top: 20px;
        border: solid transparent;
        content: " ";
        height: 0;
        width: 0;
        position: absolute;
        pointer-events: none;
    }
    .modify_box:before {
        border-color: transparent;
        border-right-color: #e5e5e5;
        border-width: 7px;
        margin-top: -7px;
    }
</style>
<template>
    <div class="set_voice">
        <div class="contol_group fn-clear">
            <span>选择风格：</span>
            <div class="setChoice">
                <el-radio v-model="voiceStyle" label="simulation">模拟微信对话样式</el-radio>
                <el-radio v-model="voiceStyle" label="simple">简易音乐播放器</el-radio>
            </div>
        </div>
        <div class="add add1">
            <div class="contol_group contol_group1 fn-clear">
                <span>添加音频：</span>
                <!-- <div class="setChoice add_voice">
                    <i class="icon iconfont icon-jia"></i>
                </div> -->
                <div class="changeVoice" v-if="voiceData">
                    <span class="playBubble" @click="playing">{{playTxt}}</span>
                    <audio :src="imageDomaia + voiceData.file_url" ref="audios" @ended="endPlay"  loop="loop" v-if="isLoop"></audio>
                    <audio :src="imageDomaia + voiceData.file_url" ref="audios" @ended="endPlay" v-else></audio>
                    <span class="addVoice" @click="addVoice">重新选择</span>
                </div>
                <span class="addVoice" @click="addVoice" v-if="!voiceData">选择音频</span>
                
            </div>
            <p v-if="isMust" class="reminder">必须选择一个音频文件</p>
            <div class="contol_group fn-clear">
                <span>播放：</span>
                <div class="setChoice">
                    <el-radio v-model="AfterStop" label="again">暂停后再恢复播放时，从头开始</el-radio>
                    <el-radio v-model="AfterStop" label="continue">暂停后再回复播放时，从暂停位置开始</el-radio>
                </div>
            </div>
        </div>
        <div class="contol_group fn-clear" v-if="voiceStyle == 'simulation'">
            <span>气泡：</span>
            <div class="setChoice">
                <el-radio v-model="pos" label="left">居左</el-radio>
                <el-radio v-model="pos" label="right">居右</el-radio>
            </div>
        </div>
        <div class="add" v-if="voiceStyle == 'simulation'">
            <div class="contol_group contol_group1 fn-clear">
                <span>添加头像：</span>
                <div class="setChoice add_voice add_voice1"  @click="choicePic" v-if="portrait == ''">
                    <i class="icon iconfont icon-jia"></i>
                </div>
                <div class="setChoice add_voice add_voice1" v-else>
                    <i class="icon iconfont icon-guanbi" @click="portrait = ''"></i>
                    <img :src="portrait" alt="" draggable="false">
                </div>
            </div>
            <p class="advise">建议尺寸：80 x 80 像素（如果不设置，默认将使用店铺logo）</p>
        </div>
        <div class="add" v-if="voiceStyle == 'simple'">
            <div class="contol_group contol_group1 fn-clear">
                <span class="voice_tips" :class="{'hasNo':isMust}">标题：</span>
                <div class="setChoice">
                    <input type="text" v-model="voiceTitle" class="voice_title">
                </div>
            </div>
            <p v-if="isMust && voiceStyle == 'simple'" class="reminder">标题不能为空</p>
            <div class="contol_group fn-clear">
                <span>循环：</span>
                <div class="setChoice">
                    <el-checkbox v-model="isLoop">开启循环播放</el-checkbox>
                </div>
            </div>
        </div>
        <pic-win :parentComponent="parentComponent" ref="picWin" @choose="getChoose"></pic-win>
        <voice-win ref="voiceWin" @transmit="getVoice"></voice-win>
    </div>
</template>

<script>
    import {mapState,mapMutations} from 'vuex';
    // 引入图片选择组件
    import picWin from '@/components/common/picWin'
    // 引入语音上传组件
    import voiceWin from '@/components/common/voiceWin'
    export default {
        props:['pageParam'],
        data() {
            return {
                voiceStyle:'simulation',
                pos: 'left',
                voiceTitle:'',
                isLoop:true,
                parentComponent:'voice',
                // 头像
                portrait:'',
                // 图片前缀
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                AfterStop:'again',
                voiceData:null,
                playTxt:'点击播放',
                isPlay:false
            }
        },
        updated(){
            var voice = {
                voiceStyle: this.voiceStyle,
                pos: this.pos,
                voiceTitle: this.voiceTitle,
                checked: this.checked,
                portrait:this.portrait,
                AfterStop:this.AfterStop,
                voiceData:this.voiceData,
                isLoop:this.isLoop
            }
            this.$emit('event', voice);
        },
        components:{
            picWin,
            voiceWin
        },
        methods: {
            ...mapMutations(['noState','changeState','startSort','stopSort']),
            // 打开添加图片弹窗
            choicePic() {
                this.$refs.picWin.show();
                this.stopSort();
            },
            // 获取传递过来的数据
            getChoose(pic){
                this.portrait = this.imageDomaia + pic.file_url;
            },
            // 打开语音选择弹窗
            addVoice(){
                this.$refs.voiceWin.show();
                this.stopSort();
            },
            // 接收传递过来的音频数据
            getVoice(obj){
                this.voiceData = obj;
                if(this.voiceData){
                    this.noState()
                }else{
                    this.changeState()
                }
            },
            // 播放结束
            endPlay(){
                if(!this.isLoop){
                    this.isPlay = false;
                    this.playTxt = '暂停';
                }
                
            },
            // 试播音频
            playing(){
                if(this.isPlay){
                    this.playTxt = '点击播放';
                    this.isPlay = false;
                    this.$refs.audios.pause();
                    if(this.AfterStop == 'again'){
                        this.$refs.audios.currentTime = 0;
                    }
                }else{
                    this.playTxt = '暂停';
                    this.isPlay = true;
                    this.$refs.audios.play();
                }
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
        computed:{
            ...mapState(['isMust'])
        },
        mounted(){
            this.initData();
        }
    }
</script>

<style scoped>
    .contol_group {
        margin-top: 17px;
    }
    .contol_group span {
        float: left;
        width: 85px;
        text-align: right;
        margin-right: 10px;
    }
    .setChoice{
        float: left;
    }
    .add{
        width: 388px;
        background-color: #fff;
        padding: 10px;
        box-sizing: border-box;
        border:1px solid #ddd;
        border-radius: 4px;
        margin:17px auto 0;
    }
    .add .contol_group1{
        margin-top: 0;
    }
    .add p.advise{
        display: block;
        margin-top: 17px;
        color: #999;
        font-size: 12px;
        margin-left: 5px;
    }
    .add .contol_group span{
        float: left;
        width:69px; 
    }
    .add .contol_group1 span.voice_tips{
        margin-top: 6px;
    }
    .add .contol_group1 .voice_title{
        width: 205px;
        height: 32px;
        border:1px dotted #ddd;
        font-size: 12px;
        color: #333;
        padding:0 10px;
    }
    .add .setChoice{
        width: 230px;
    }
    .add1 .el-radio+.el-radio{
        margin-left: 0;
    }
    .add .add_voice{
        width: 78px;
        height: 78px;
        box-sizing: border-box;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 78px;
        cursor: pointer;
    }
    .add .add_voice .icon-jia{
        font-size: 20px;
        color: #3388ff;
    }
    .add .add_voice1{
        position: relative;
    }
    .add .add_voice1 img{
        width: 100%;
        height: 100%;
    }
    .add .add_voice1 .icon-guanbi{
        position: absolute;
        right: -7px;
        top: -37px;
        color: #a3a3a3;
        font-size: 14px;
        cursor: pointer;
    }
    .add .contol_group span.addVoice{
        float: left;
        width: auto;
        cursor: pointer;
        color: #38f;
    }
    .changeVoice{
        float: left;
    }
    .contol_group span.playBubble{
        text-align: left;
    }
    .playBubble{
        float: left;
        border-radius: 3px;
        color: #70a13f;
        position: relative;
        border: 1px solid #84d55a;
        display: inline-block;
        width: 110px;
        height: 30px;
        padding: 0 6px 0 7px;
        font-size: 12px;
        line-height: 30px;
        cursor: pointer;
        background: #a0e75a;
        vertical-align: middle;
        margin-left: 7px;
        margin-right: 10px;
        margin-top: -5px;
    }
    .playBubble:before{
        position: absolute;
        content: "";
        left: -13px;
        top: 8px;
        width: 0;
        height: 0;
        border: 6px solid transparent;
        border-right: 6px solid #84d55a;
    }
    .playBubble:after{
        position: absolute;
        content: "";
        left: -12px;
        top: 8px;
        width: 0;
        height: 0;
        border: 6px solid transparent;
        border-right: 6px solid #a0e75a;
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        padding-left: 80px;
        font-size: 12px;
    }
    .hasNo{
        color: #f44;
    }
</style>
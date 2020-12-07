<template>
    <div class="showBox">
        <div class="voice blankShow">
            <div class="simulation fn-clear" v-if="voiceStyle == 'simulation'">
                <div class="simulation_left fn-clear" v-if="pos == 'left'">
                    <div class="user_pic">
                        <img src="static/images/user.jpg" alt="" v-if="portrait == ''">
                        <img :src="portrait" alt="" v-else>
                    </div>
                    <div class="voice_pic">
                        <img src="static/images/play_left.png" alt="" class="play_state" v-if="!isPlay" @click="play">
                        <img src="static/images/player.gif" alt="" v-if="isPlay" class="play_state" @click="play">
                        <audio :src="$url + voiceData.file_url" ref="audios" @ended="endPlay"></audio>
                        <img src="static/images/left_play.png" @click="play" class="play_box">
                    </div>
                </div>
                <div class="simulation_right fn-clear" v-if="pos == 'right'">
                    <div class="voice_pic">
                        <img src="static/images/play_right.png" alt="" class="play_state1" v-if="!isPlay" @click="play">
                        <img src="static/images/green_player.gif" alt="" v-if="isPlay" class="play_state1" @click="play">
                        <audio :src="$url + voiceData.file_url" ref="audios" @ended="endPlay"></audio>
                        <img src="static/images/right_play.png" @click="play" class="play_box">
                    </div>
                    <div class="user_pic">
                        <img src="static/images/user.jpg" alt="" v-if="portrait == ''">
                        <img :src="portrait" alt="" v-else>
                    </div>
                </div>
            </div>
            <div class="simple" v-if="voiceStyle == 'simple'">
                <div class="music_player">
                    <div class="play" @click="play()">
                        <i class="icon iconfont" :class="isPlay ? 'icon-stop' : 'icon-bofang'"></i>
                    </div>
                    <div id="progressBarBg0" class="rate fn-clear">
                        <p>
                            {{voiceTitle}}
                        </p>
                        <div class="cap_slider" id="progressBarBg0">
                            <div class="cap_slide_line" @mousedown="jumpProgress($event)" ref="capBg">
                                <span class="complete_line" ref="capLine"></span>
                                <span class="cap_slot" ref="capSlot" @mousedown="moveProgress($event)"></span>
                            </div>
                        </div>
                        <div class="times">
                            <span class="current_time">{{timeNow}}</span>
                            <span class="total_time">{{timeDuration}}</span>
                        </div>
                    </div>
                    <audio :src="$url + voiceData.file_url" ref="audios" @ended="endPlay" loop="loop" v-if="isLoop" @timeupdate="progress"></audio>
                    <audio :src="$url + voiceData.file_url" ref="audios" @ended="endPlay" v-else @timeupdate="progress"></audio>
                </div>
            </div>
        </div> 
    </div>
</template>

<script>
    export default {
        props:['pageParam'],
        data() {
            return {
                voiceStyle:'simulation',
                pos: 'left',
                AfterStop:'again',
                voiceTitle:'时间都去那儿了',
                isLoop:false,
                portrait:'',
                count:2,
                isPlay:false,
                voiceValue:0,
                maxVoice:0,
                voiceData:{},
                timeNow:'',
                timeDuration:''
            }
        },
        mounted(){
            this.voiceStyle = this.pageParam.voiceStyle;
            this.pos = this.pageParam.pos;
            this.AfterStop = this.pageParam.AfterStop;
            this.voiceTitle = this.pageParam.voiceTitle;
            this.isLoop = this.pageParam.isLoop;
            this.portrait = this.pageParam.portrait;
            this.voiceData = this.pageParam.voiceData;
        },
        methods: {
            // 播放音频
            play(){
                if(this.isPlay){
                    this.isPlay = false;
                    this.$refs.audios.pause();
                    if(this.AfterStop == 'again'){
                        this.$refs.audios.currentTime = 0;
                    }
                }else{
                    this.isPlay = true;
                    this.$refs.audios.play();
                    
                }
            },
            // 播放结束
            endPlay(){
                this.$refs.audios.pause();
                this.$refs.audios.currentTime = 0;
                
                this.$refs.capSlot.style.left = 0 + '%';
                this.$refs.capLine.style.width = 0 + '%';
                if(!this.isLoop){
                    this.isPlay = false;
                }
                
                
            },
            // 播放进度
            progress(){
                var value = this.$refs.audios.currentTime / this.$refs.audios.duration;
                this.$refs.capSlot.style.left = value*100 + '%';
                this.$refs.capLine.style.width = value*100 + '%';
            },
            // 点击跳跃进度
            jumpProgress(e){
                // 只有音乐开始播放后才可以调节，已经播放过但暂停了的也可以
                if (!this.$refs.audios.paused || this.$refs.audios.currentTime != 0) {
                    var pgsWidth = this.$refs.capBg.offsetWidth;
                    var rate = e.offsetX / pgsWidth;
                    this.$refs.audios.currentTime = this.$refs.audios.duration * rate;
                }
            },
            // 拖动进度条
            moveProgress(e){
                if (!this.$refs.audios.paused || this.$refs.audios.currentTime != 0){
                    let oriLeft = this.$refs.capSlot.offsetLeft;
                    let mouseX = e.clientX;
                    let maxLeft = oriLeft; // 向左最大可拖动距离
                    let maxRight = document.getElementById('progressBarBg0').offsetWidth - oriLeft; // 向右最大可拖动距离

                    // 禁止默认的选中事件（避免鼠标拖拽进度点的时候选中文字）
                    if (e.preventDefault) {
                        e.preventDefault();
                    } else {
                        e.returnValue = false;
                    }
                    // 禁止事件冒泡
                    if (e && e.stopPropagation) {
                        e.stopPropagation();
                    } else {
                        window.event.cancelBubble = true;
                    }
                    // 开始拖动
                    document.onmousemove = function (e) {
                        var length = e.clientX - mouseX;
                        if (length > maxRight) {
                            length = maxRight;
                        } else if (length < -maxLeft) {
                            length = -maxLeft;
                        }
                        var pgsWidth = this.$refs.capBg.offsetWidth;
                        var rate = (oriLeft + length) / pgsWidth;
                        audio.currentTime = audio.duration * rate;
                    };

                    // 拖动结束
                    document.onmouseup = function () {
                        document.onmousemove = null;
                        document.onmouseup = null;
                    };
                }
            },
            addEventListeners: function () {  
                const self = this;  
                self.$refs.audios.addEventListener('timeupdate', self._currentTime);
                self.$refs.audios.addEventListener('canplay', self._durationTime)  
            },  
            removeEventListeners: function () {  
                const self = this;  
                self.$refs.audios.removeEventListener('timeupdate', self._currentTime)  
                self.$refs.audios.removeEventListener('canplay', self._durationTime)  
            },   
            _currentTime: function () {  
                const self = this;  
                self.timeNow = parseInt(self.$refs.audios.currentTime)  
            },  
            _durationTime: function () {  
                const self = this;  
                self.timeDuration = parseInt(self.$refs.audios.duration)  
            }  
        },  
        beforeDestroyed() {  
            this.removeEventListeners()  
        }  
    }
</script>

<style scoped>
    .voice{
        background-color: #fff;
        padding: 0.2rem 0;
    }
    .simulation{
        display: block;
        padding: 0 0.4rem
    }
    .simulation_left .user_pic,
    .simulation_right .voice_pic{
        margin-right: 0.1rem;
    }
    .simulation_right{
        float: right;
    }
    .user_pic{
        float: left;
        width: 0.76rem;
        height: 0.76rem;
    }
    .user_pic img{
        display: block;
        width: 100%;
        height: 100%;
    }
    .voice_pic{
        position: relative;
        float: left;
        width: 3.7rem;
        height: 0.76rem;
    }
    .voice_pic img.play_box{
        display: block;
        width: 100%;
        height: 100%;
    }
    .play_state{
        position: absolute;
        left: 0.35rem;
        top:50%;
        transform: translateY(-50%);
        width: 0.35rem;
    }
    .play_state1{
        position: absolute;
        right: 0.35rem;
        top:50%;
        transform: translateY(-50%);
        width: 0.35rem;
    }
    .simple{
        width: 100%;
        
    }
    .music_player{
        position: relative;
        width: 5.8rem;
        height: 1.2rem;
        margin:0 auto;
    }
    .play{
        float: left;
        width: 40px;
    }
    .play .icon{
        display: block;
        color: #44BB00;
        font-size: 0.8rem;
    }
    .rate{
        position: absolute;
        float: left;
        width: 4.3rem;
        left: 1rem;
        top: 0.34rem;
    }
    .rate p{
        position: absolute;
        left: 0;
        top: -0.36rem;
        font-size: 0.24rem;
    }
    /* 进度条 */
    .cap_slider .cap_slide_line{
        position: relative;
        height: 2px;
        width: 100%;
        background-color: #f2f2f2;
        margin-top: 5px;
    }
    .complete_line{
        position: absolute;
        top: 0%;
        left: 0;
        background-color:rgb(68, 187, 0);
        width: 0%;
        height: 2px;
    }
    .cap_slot{
        position: absolute;
        width: 0.28rem;
        height: 0.28rem;
        border-radius: 50%;
        border: 1px solid #e5e5e5;
        top: -0.14rem;
        background-color: #fff;
        left: 0%;
    }
    .cap_slot:after{
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        margin: auto;
        width: 4px;
        height: 4px;
        border-radius: 4px;
        background: #4b0;
    }
    .times{
        font-size: 0.24rem;
        margin-top: 0.1rem;
    }
    .current_time{
        float: left;
    }
    .total_time{
        float: right;
    }
</style>
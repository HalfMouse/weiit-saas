<template>
    <div class="voice_win" v-show="isVoice">
        <div class="vocie_box">
            <div class="box_head fn-clear">
                <div class="updata">
                    <el-upload
                        class="avatar-uploader"
                        :action="getUri"
                        :show-file-list="false"
                        :on-success="handleAvatarSuccess"
                        :on-error="handleAvatarError"
                        :on-progress="handleAvatar"
                        :before-upload="beforeAvatarUpload"
                        :mmultiple="true">
                        <el-button size="small" type="primary">上传语音</el-button>
                    </el-upload>
                </div>
                <p class="voice_type">最大支持 40 MB 以内的语音 (mp3 格式)</p>
            </div>
            <div class="main_show fn-clear">
                <div class="left_nav">
                    <ul>
                        <li>未分组</li>
                    </ul>
                </div>
                <div class="right_pic">
                    <ul class="fn-clear">
                        <li v-for="(item,index) in tableData" @click="chooseVoice(index)" :class="{'choose':index == iNum}">
                            <div class="icon_box">
                                <i class="el-icon-success"></i>
                            </div>
                            <div class="vioce_icon" @click="playing($event,item)">
                                <img src="/static/images/play.png" alt="" v-if="!item.isPlay" draggable="false">
                                <img src="/static/images/playing.gif" alt="" v-else draggable="false">
                            </div>
                            <div class="voice_infor">
                                <p>{{item.name}}</p>
                                <p>2018-05-12 16:29:47<span>{{(item.size / (1024 * 1000)).toFixed(1)}}MB</span></p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="pages">
                <div class="block">
                    <el-pagination
                    :current-page="currentPage"
                    :page-size="12"
                    :pager-count="5"
                    layout="total, prev, pager, next, jumper"
                    :total="total"
                    @current-change="handleCurrentChange">
                    </el-pagination>
                </div>
                <a href="javascript:;" class="ensure" @click="choiceVioce()">确定</a>
            </div>
            <i class="icon iconfont icon-guanbi" @click="isVoice = false"></i>
        </div>
    </div>
</template>

<script>
    import {mapMutations,mapState} from 'vuex';
    export default {
        data() {
            return {
                isVoice: false,
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                iNum:-1,
                tableData:[],
                currentPage:10,
                total:0
            }
        },
        methods: {
            ...mapMutations(['startSort']),
            // 展示弹窗
            show() {
                this.isVoice = true
            },
            // 选取当前行
            choiceNav(row){
                this.isVoice = false;
            },
            // 上传成功
            handleAvatarSuccess(response,file,fileList){
                // if(fileList.length != 0){
                //     this.tableData = [];
                // }
                fileList.forEach((item) => {
                    if(this.tableData.indexOf(item) == -1){
                        this.tableData.push(item);
                    }
                })
            }, 
            // 上传失败
            handleAvatarError(err, file, fileList) {
            },
            // 文件上传
            handleAvatar(event, file, fileList){
            },
            // 上传文件设置
            beforeAvatarUpload(file) {
                var isMP3 = file.type === 'audio/mp3';
                var isLt2M = file.size / 1024 / 1024 < 40;

                if (!isMP3) {
                    this.$message.error('上传头像图片只能是 mp3 格式!');
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 40MB!');
                }
                return isMP3 && isLt2M;
            },
            // 选中音频
            chooseVoice(index){
                this.iNum = index;
                
            },
            // 播放选中音频
            playing(e,item){
                if(e && e.stopPropagation){
                    //W3C取消冒泡事件
                    e.stopPropagation();
                }else{
                    //IE取消冒泡事件
                    window.event.cancelBubble = true;
                }
                if(this.isPlay){
                    item.isPlay = !item.isPlay;
                }else{
                    item.isPlay = !item.isPlay;
                }
            },
            // 确认选中音频
            choiceVioce(){
                if(this.iNum != -1){
                    var obj = this.tableData[this.iNum].response[0];
                    this.$emit('transmit', obj);
                }
                this.isVoice = false;
            },
            //获取音频数据
            getVoice(pageIndex){
            	this.$ajax({
                    methods:'get',
                    url:'/center/file/picture/videoList',
                    params:{
                        page: pageIndex,
                        rows: 12,
                        file_type:3
                    }
                }).then(res => {
                	if(res.status == 200){
                		this.tableData = res.data.pictureSpace.list;
                		this.total = res.data.pictureSpace.total;
                	}
                }).catch(err => {
                    (err);
                })
            },
            //切换页数
            handleCurrentChange(val){
            	getVoice(val)
            }
        },
        mounted(){
            this.getVoice(1)
        },
        watch:{
            isVoice:function(curVal,oldVal){
                if(!curVal){
                    this.startSort();
                }
            }
        },
        computed:{
            ...mapState(['routerSrc']),
            getUri(){
                let token = localStorage.getItem('token');
                let url = `${this.routerSrc}/center/design/uploadFile?business_type=0&file_type=3&token=${token}`;
                return url;
            }
        }
        
        
    }
</script>

<style scoped>
    /* 外部背景层 */
    .voice_win{
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,.5);
        z-index: 9999;
    }
    /* 选择窗 */
    .vocie_box{
        position: absolute;
        left: 50%;
        top: 50%;
        width: 598px;
        background-color: #fff;
        border-radius:5px;
        border: 1px solid #ddd; 
        transform: translate(-50%,-50%);
        cursor: default;
    }
    /* 弹窗头部信息 */
    .box_head{
        padding: 10px;
        border-bottom: 1px solid #e5e5e5;
    }
    .box_head .updata{
        float: left;
    }
    .box_head .updata a{
        display: block;
        color: #fff;
        font-weight: bold;
    }
    .voice_type{
        float: left;
        line-height: 30px;
        color: #333;
        font-size: 12px;
        margin-left: 20px;
    }
    /* 弹窗主体部分 */
    /* 弹窗主体部分 */
    .left_nav,
    .right_pic{
        float: left;
    }
    /* 主体左边部分 */
    .left_nav{
        background-color: #eee;
        width: 90px;
        height: 385px;
        margin-right: 10px;
    }
    .left_nav ul li{
        position: relative;
        background-color: #fff;
        padding-left: 10px;
        height: 35px;
        line-height: 35px;
        font-size: 12px;
    }
    
    /* 主体右边部分 */
    .right_pic{
        width: 495px;
        padding-top: 18px;
    }
    .right_pic ul{
        margin-right: -20px;
    }
    .right_pic ul li{
        position: relative;
        float: left;
        width: 240px;
        border: 2px solid #ddd;
        padding: 5px;
        box-sizing: border-box;
        margin-right: 10px;
        margin-bottom: 10px;
    }
    .vioce_icon{
        width: 40px;
        height: 40px;
        float: left;
        cursor: pointer;
    }
    .vioce_icon img{
        width: 100%;
        height: 100%;
    }
    .voice_infor{
        float: left;
        width: 175px;
        margin-left: 10px;
    }
    .voice_infor p{
        line-height: 20px;
    }
    .voice_infor p span{
        float: right;
    }
    .right_pic ul li.choose{
        border-color: #07d;
    }
    .icon_box{
        position: absolute;
        display: block;
        content: " ";
        right: -1px;
        top: -2px;
        border: 14px solid #07d;
        border-left-color: transparent;
        border-bottom-color: transparent;
        z-index: 1;
        display: none;
    }
    .right_pic ul li.choose .icon_box{
        display: block;
    }
    .icon_box .el-icon-success{
        position: absolute;
        color: #fff;
        font-weight: bold;
        font-size: 12px;
        z-index: 2;
        display: none;
        right: -12px;
        top: -11px;
    }
    .right_pic ul li.choose .icon_box .el-icon-success{
        display: block;
    }
    /* 弹窗底部 */
    /* 底部分页 */
    .pages{
        position: relative;
        background-color: #f9f9f9;
        padding: 10px 15px;
        height: 30px;
    }
    .block{
        float: left;
    }
    .ensure{
        float: right;
        height: 30px;
        line-height: 30px;
        padding: 0 10px;
        color: #fff;
        background-color: #4b0;
        border-radius: 5px;
        font-size: 12px;
    }
    /* 关闭按钮 */
    .icon-guanbi{
        position: absolute;
        font-size: 18px;
        color: #ddd;
        right: 4px;
        top: 4px;
        cursor: pointer;
    }
    /* 选择按钮 */
    .choiceBtn{
        float: right;
        border: none 0;
        background-color: #2897e4;
        line-height: 30px;
        padding: 0 10px;
        color: #fff;
        border-radius: 5px;
        font-size: 12px;
        margin-right: 10px;
        cursor: pointer;
    }
</style>
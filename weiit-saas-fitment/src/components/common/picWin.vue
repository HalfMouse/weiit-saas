<template>
    <div class="bg" v-show="isOk">
        <div class="show_box">
            <i class="icon iconfont icon-guanbi" @click="closeWin"></i>
            <div class="head fn-clear">
                <div class="update">
                    <el-upload
                    class="upload-demo"
                        :action="getUri"
                        :on-success="handleSuccess"
                        :show-file-list="false"
                        :before-upload="beforeAvatarUpload"
                        :multiple="true">
                        <!--<el-button style="margin-left: 10px;" size="small" type="success" @click="submitUpload">上传到服务器</el-button>-->
                        <el-button size="small" type="primary">点击上传</el-button>
                    </el-upload>
                </div>
                <!-- <div class="extract_box fn-clear inputBtn">
                    <input type="text" placeholder="请帖入网络图片地址">
                    <button>提取</button>
                </div> -->
                <div class="search_box fn-clear inputBtn">
                    <input type="text" placeholder="输入文件名" v-model="searchTxt">
                    <button @click="searchGoods">搜索</button>
                </div>
            </div>
            <div class="main_show fn-clear">
                <div class="left_nav">
                    <ul>
                        <li>未分组</li>
                    </ul>
                </div>
                <div class="right_pic">
                    <ul>
                        <li v-for="(item,index) in pictureShow" @click="choose(index)" :class="{'choose':index == iNum}">
                            <i class="icon iconfont icon-xuanzhong"></i>
                            <div class="pic_show">
                                <img :src="imageDomaia + item.file_url" alt=""  draggable="false"/>
                            </div>
                            <div class="pic_txt">{{item.file_name}}</div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="pages">
                <div class="block">
                    <el-pagination
                    @current-change="handleCurrentChange"
                    :current-page="currentPage"
                    :page-size="18"
                    :pager-count="5"
                    layout="total, prev, pager, next, jumper"
                    :total="total">
                    </el-pagination>
                </div>
                <a href="javascript:;" class="ensure" :class="{'none': iNum == -1}" @click="choicePic()">确定</a>
            </div>
        </div>
    </div>
</template>

<script>
    import {mapMutations,mapState} from 'vuex';
    export default {
        props:['parentComponent'],
        data() {
            return {
                currentPage: 1,
                isOk:false,
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                iNum:-1,
                searchTxt:'',
                total:0,
                pictureShow:[],
                isSearch:false
            }
        },
        methods: {
            ...mapMutations(['startSort']),
            // 弹出
            show(){
                this.isOk = true
            },
            // 选中
            choose(index){
                this.iNum = index;
            },
            // 传递选择图片数据
            choicePic(){
                if(this.iNum != -1){
                    var obj = this.pictureShow[this.iNum];
                    this.$emit('choose', obj);
                    this.isOk = false;
                    this.iNum = -1;
                }
            },
            handleSuccess(response, file, fileList){
                console.log(response);
                var obj = {
                    create_time:1499939189000,
                    file_name:response[0].file_name,
                    file_url:response[0].file_url,
                    id:29,
                    parent_id:-1,
                    shop_id:-1,
                    type:0,
                    update_time:1499939189000,
                    validate_id:29,
                    validate_id_token:"c427d30ba86632f406d7efa0edca7b9b"
                }
                this.pictureShow.unshift(obj);
                if(this.pictureShow.length > 18){
                    this.pictureShow.splice(18,this.pictureShow.length-18);
                }
                
                // this.getPicture()
                // 0~18 0 19~36 1
            },
            // 搜索商品图片
            searchGoods(){
                let business_type = this.picStyle();
                this.currentPage = 1;
                this.isSearch = true;
                this.$ajax({
                    methods:'get',
                    url:'/center/file/picture/pictureSpace',
                    params:{
                        business_type: business_type,
                        page: 1,
                        rows: 18,
                        file_name: this.searchTxt
                    }
                }).then(res => {
                    this.pictureShow = res.data.pictureSpace.list;
                    this.total = res.data.pictureSpace.total;
                }).catch(err => {
                    (err);
                })
            },
            // 切换页面
            handleCurrentChange(val){
                let business_type = this.picStyle();
                this.currentPage = val;
                if(this.isSearch){
                    this.$ajax({
                        methods:'get',
                        url:'/center/file/picture/pictureSpace',
                        params:{
                            business_type:business_type,
                            page:val,
                            rows:18,
                            file_name: this.searchTxt
                        }
                    }).then(res => {
                        this.pictureShow = res.data.pictureSpace.list;
                        this.total = res.data.pictureSpace.total;
                    }).catch(err => {
                        (err);
                    })
                }else{
                    this.$ajax({
                        methods:'get',
                        url:'/center/file/picture/pictureSpace',
                        params:{
                            business_type:business_type,
                            page:val,
                            rows:18
                        }
                    }).then(res => {
                        this.pictureShow = res.data.pictureSpace.list;
                        this.iNum = -1;
                    }).catch(err => {
                        (err);
                    })
                }
            },
            // 图片类型
            picStyle(){
                let business_type;
                switch(this.parentComponent){
                    case 'nav':
                    case 'voice':
                        business_type = 3;
                        break;
                    case 'shop':
                        business_type = 5;
                        break;
                    case 'advertisement':
                        business_type = 2;
                        break;
                }
                return business_type;
            },
            // 获取图片数据
            getPicture(){
                let business_type = this.picStyle();
                this.$ajax({
                    methods:'get',
                    url:'/center/file/picture/pictureSpace',
                    params:{
                        business_type:business_type,
                        page:1,
                        rows:18
                    }
                }).then(res => {
                    this.pictureShow = res.data.pictureSpace.list;
                    this.total = res.data.pictureSpace.total;
                }).catch(err => {
                    (err);
                })
            },
            // 关闭弹窗
            closeWin(){
                this.isOk = false;
                this.iNum = -1;
            },
            beforeAvatarUpload(file) {
            	const extension = file.name.split('.')[1] === 'jpg'
			    const extension2 = file.name.split('.')[1] === 'jpeg'
			    const extension3 = file.name.split('.')[1] === 'png'
			    const extension4 = file.name.split('.')[1] === 'svg'
			    const isLt2M = file.size / 1024 / 1024 < 2
			    if (!extension && !extension2 && !extension3 && !extension4) {
			      	this.$message({
			          showClose: true,
			          message: '上传模板只能是 jpg、jpeg、png、svg 格式!',
			          type: 'warning'
			        });
			    }
			    if (!isLt2M) {
			       this.$message({
			          showClose: true,
			          message: '上传模板大小不能超过 2MB!',
			          type: 'warning'
			        });
			    }
			    return extension || extension2 || extension3 || extension4 && isLt2M
            }
        },
        created(){
            this.getPicture();
            document.addEventListener('move', function (e) {
                e.returnValue = true;
            }, false);
        },
        computed:{
            ...mapState(['routerSrc']),
            getUri(){
                let business_type = this.picStyle();
                let token = localStorage.getItem('token');
                let url = `${this.routerSrc}/center/design/uploadFile?business_type=${business_type}&file_type=0&token=${token}`;
                return url;
            }
        },
        watch:{
            isOk:function(curVal,oldVal){
                if(!curVal){
                    this.startSort();
                }
            }
        }
    }
</script>

<style scoped>
    .bg{
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,.5);
        z-index: 9999;
    }
    .show_box{
        width: 718px;
        position: absolute;
        left: 50%;
        top: 50%;
        background-color: #fff;
        transform:translate(-50%,-50%);
        border-radius: 6px;
        overflow: hidden;
        
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
    /* 弹窗头部 */
    .head{
        padding: 10px 15px;
        border-bottom: 1px solid #ddd;
    }
    .search_box,
    .extract_box,
    .update{
        position: relative;
        float: left;
    }
    .update .update_btn{
        display: block;
        padding: 5px 10px;
        color: #fff;
        font-size: 12px;
        background-color:#2897e4;
        border-radius: 5px; 
    }
    .update_btn .icon{
        font-size: 12px;
    }
    .inputBtn{
        margin-left: 20px;
        line-height: 30px;
        height: 30px;
        border-radius: 5px;
        overflow: hidden;
    }
    .inputBtn input,
    .inputBtn button{
        float: left;
        border:1px solid #ddd;
        
    }
    .inputBtn input{
        width: 153px;
        padding: 5px 10px;
        line-height: 18px;
        height: 18px;
        border-right: none 0;
        border-radius: 5px 0 0 5px;
    }
    .inputBtn button{
        display: block;
        height: 30px;
        line-height: 30px;
        padding: 0 10px;
        background-color: #fff;
        cursor: pointer;
        border-radius: 0 5px 5px 0;
    }
    .inputBtn button:hover{
        background-color: #e6e6e6;
        border-color: #adadad;
    }
    /* 弹窗主体部分 */
    .left_nav,
    .right_pic{
        float: left;
    }
    /* 主体左边部分 */
    .left_nav{
        background-color: #eee;
        width: 100px;
        height: 385px;
        margin-right: 25px;
    }
    .left_nav ul li{
        position: relative;
        background-color: #fff;
        padding-left: 10px;
        height: 35px;
        line-height: 35px;
        cursor: pointer;
        font-size: 12px;
    }
    
    /* 主体右边部分 */
    .right_pic{
        width: 593px;
        padding-top: 18px;
    }
    .right_pic ul li{
        position: relative;
        float: left;
        width: 84px;
        height: 106px;
        border: 2px solid #ddd;
        margin:0 8px 8px 0;
        cursor: pointer;
    }
    .right_pic ul li.choose{
        border-color: #459ae9;
    }
    .icon-xuanzhong{
        position: absolute;
        right: 0;
        top: 0;
        color: #459ae9;
        font-size: 14px;
        display: none;
    }
    .right_pic ul li.choose .icon-xuanzhong{
        display: block;
    }
    .right_pic ul li .pic_show{
        width: 84px;
        height: 84px;
    }
    .right_pic ul li .pic_show img{
        width: 100%;
        height: 100%;
    }
    .right_pic ul li .pic_txt{
        width: 79px;
        line-height: 22px;
        padding-left: 5px;
        font-size: 12px;
        text-overflow:ellipsis; 
        white-space:nowrap; 
        overflow:hidden; 
    }
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
    .none{
        background-color: #ddd;
    }
</style>
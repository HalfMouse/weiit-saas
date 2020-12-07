<template>
    <div class="set_advertisement">
        <div class="contol_group fn-clear">
            <span>选择模板：</span>
            <div class="setChoice">
                <div class="temp_box" @click="choiceType('temp1')" :class="{'check':temp == 'temp1'}">
                    <div class="temp_pic">
                        <img src="/static/images/advertisement1.png" alt="" draggable="false">
                    </div>
                    <p>轮播广告</p>
                </div>
                <div class="temp_box" @click="choiceType('temp2')" :class="{'check':temp == 'temp2'}">
                    <div class="temp_pic">
                        <img src="/static/images/advertisement2.png" alt="" draggable="false">
                    </div>
                    <p>一行一个</p>
                </div>
                <div class="temp_box no_margin" @click="choiceType('temp3')" :class="{'check':temp == 'temp3'}">
                    <div class="temp_pic">
                        <img src="/static/images/advertisement3.png" alt="" draggable="false">
                    </div>
                    <p>横屏滑动</p>
                </div>
                <div class="temp_box" @click="choiceType('temp4')" :class="{'check':temp == 'temp4'}">
                    <div class="temp_pic">
                        <img src="/static/images/advertisement4.png" alt="" draggable="false">
                    </div>
                    <p>一大二小</p>
                </div>
                <div class="temp_box" @click="choiceType('temp5')" :class="{'check':temp == 'temp5'}">
                    <div class="temp_pic">
                        <img src="/static/images/advertisement5.png" alt="" draggable="false">
                    </div>
                    <p>横向滑动(导航)</p>
                </div>
                <div class="temp_box no_margin" @click="choiceType('temp6')" :class="{'check':temp == 'temp6'}">
                    <div class="temp_pic">
                        <img src="/static/images/advertisement5.png" alt="" draggable="false">
                    </div>
                    <p>一行两个</p>
                </div>
                <div class="temp_box no_margin" @click="choiceType('temp7')" :class="{'check':temp == 'temp7'}">
                    <div class="temp_pic">
                        <img src="/static/images/advertisement5.png" alt="" draggable="false">
                    </div>
                    <p>一行三个</p>
                </div>
            </div>
        </div>
        <div class="contol_group fn-clear addPic">
            <a href="javascript:;" @click="addNav"><i class="icon iconfont icon-jia"></i> 添加图片</a>
            <div class="contol_group2 fn-clear">
                <span>是否留白：</span>
                <div class="setChoice">
                    <el-radio v-model="haveBlock" label="yes">是</el-radio>
                    <el-radio v-model="haveBlock" label="no">否</el-radio>
                </div>
            </div>
        </div>
        
        <p v-if="isMust && navList.length === 0" class="reminder">请选择商品</p>
        <div class="nav_list">
            <div class="add fn-clear" v-for="(item, index) in navList">
                <i class="icon iconfont icon-guanbi" @click="delNav(index)"></i>
                <div class="add_pic" @click="choicePic(index)">
                    <i class="icon iconfont icon--jia" v-if="item.img == ''"></i>
                    <span>重新选择</span>
                    <img :src="item.img" alt="" v-if="item.img != ''" draggable="false">
                </div>
                <p v-if="isMust && navList.length > 0 && item.img == ''" class="reminder1">请选择图片</p>
                <div class="choiceSize">
                    <div class="contol_group contol_group1 fn-clear">
                        <span class="demonstration demonstration1">文字：</span>
                        <div class="setChoice">
                            <el-input v-model="item.navText" placeholder="我是导航" class="navTitle"></el-input>
                        </div>
                    </div>
                    <div class="contol_group fn-clear">
                        <span class="demonstration demonstration1">显示链接：</span>
                        <div class="setChoice" v-if="item.isNavShow">
                        	<el-dropdown>
							    <span class="el-dropdown-link" :class="{'hasNo':isMust && navList.length > 0 && item.navShow == ''}">
							        	选择跳转到的页面<i class="el-icon-arrow-down el-icon--right"></i>
							    </span>
							    <el-dropdown-menu slot="dropdown">
							        <el-dropdown-item v-for="(ele,row) in options" @click.native="logoutHandle(ele,row,index,'new')">
							        	{{ele.url_content}}
							        </el-dropdown-item>
							    </el-dropdown-menu>
						    </el-dropdown>
                        </div>
                        <div v-if="!item.isNavShow && item.navShow != ''" class="choiceNav setChoice fn-clear">
                            <i class="firstNav">{{item.navShow}}</i>
                            <i v-if="item.branchLine !=''">|</i>
                            <i v-if="item.branchLine !=''" class="branchLine">{{item.branchLine}}</i>
                            <i class="icon iconfont icon-guanbi" @click="delNavChoice(item)"></i>
                        </div>
                        <p v-if="isMust && navList.length > 0 && item.navShow == ''" class="reminder2">请选择链接</p>
                        <div class="changeUrl" v-if="!item.isNavShow">
                        	<el-dropdown>
							    <span class="el-dropdown-link">
							        	修改<i class="el-icon-arrow-down el-icon--right"></i>
							    </span>
							    <el-dropdown-menu slot="dropdown">
							        <el-dropdown-item v-for="(ele,row) in options" @click.native="logoutHandle(ele,row,index,'change')">
							        	{{ele.url_content}}
							        </el-dropdown-item>
							    </el-dropdown-menu>
						    </el-dropdown>
                        </div>
                    </div>
                </div>
                <!-- 链接选择框 -->
                <div class="linkChoice" v-show="isLink">
                    <div class="choice_box" v-if="isWinName === 'InnerChain'">
                        <div class="head fn-clear">
                            <h6>选取链接</h6>
                            <i class="icon iconfont icon-cha" @click="closeLinkWin"></i>
                        </div>
                        <!--<div class="search_box">
                            <input type="text" placeholder="请输入标题">
                            <a href="javascript:;" class="search_btn" @click="searchGood">搜索</a>
                        </div>-->
                        <el-table :data="tabNavs" ref="table" row-key="id" style="width: 100%;min-height: 323px;" class="linkTab">
                            <el-table-column :prop="spcDescription" label="名称" width="450" :show-overflow-tooltip="true"></el-table-column>
                            <el-table-column fixed="right">
                                <template slot-scope="scope">
                                    <button class="choiceBtn" @click="choiceNav(scope.$index, scope.row)">选取</button>
                                </template>
                            </el-table-column>
                        </el-table>
                        <div align="right" class="page_nation">
                            <el-pagination
                                @current-change="handleCurrentChange"
                                :current-page.sync="currentPage"
                                :page-size="pagesize"
                                layout="total, prev, pager, next, jumper"
                                :total="total">
                            </el-pagination>
                        </div> 
                    </div>
                    <div class="choice_box choice_box1" v-if="isWinName === 'OuterChain'">
                        <div class="head fn-clear head1">
                            <h6>自定义链接</h6>
                            <i class="icon iconfont icon-cha" @click="closeLinkWin1"></i>
                        </div>
                        <div class="OuterContent fn-clear">
                            <span>链接地址: </span>
                            <input type="text" placeholder="http://" v-model="OuterLink">
                        </div>
                        <div class="checkButtons fn-clear">
                            <a href="javascript:;" @click="closeLinkWin1">取消</a>
                            <a href="javascript:;" @click="checkLink" class="confirm">确定</a>
                        </div>
                    </div>
                </div>
            </div>                                                      
        </div>
        <pic-win :parentComponent="'advertisement'" ref="picWin" @choose="getChoose"></pic-win>
    </div>
</template>

<script>
    // 引入组件
    import picWin from '@/components/common/picWin'
    import {mapState,mapMutations} from 'vuex';
    export default {
        props:['pageParam'],
        data(){
            return{
                // 下拉框参数
                options: [],
                // 一页显示数据
                tabNavs:[],
                // 总数据
                tableData: [],
                // 判断弹出框是否显示参数
                isLink:false,
                // 展示列表
                navList:[],
                //默认每页数据量
                pagesize: 5,
                //当前页码
                currentPage: 1,
                // 选择模式
                temp:'temp1',
                // 图片前缀
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                // 计数
                iNum:50,
                icount:-1,
                spcDescription:'',
                // 选择得路由的链接
                firstRoute:'',
                // 选择路由的名字
                url_content:'',
                linkType:'',
                isWinName:'',
                // 外链链接
                OuterLink:'',
                total:0,
                haveBlock:'no'
                
            }
        },
        methods:{
            ...mapMutations(['noState','changeState','startSort','stopSort']),
            // 添加导航
            addNav(){
                var obj = {
                    img:'',
                    navText:'',
                    url:'',
                    value:'',
                    navShow:'',
                    branchLine:'',
                    validate_id:'',
                    isNavShow:true,
                    isModify:false
                }
                if(this.navList.length == 6){
                    this.navList.length = 6;
                    return false;
                }
                this.navList.push(obj);
                this.noState();
            },
            // 选择类型
            choiceType(type){
                this.temp = type;
                this.$emit('event', type);
            },
            // 获取链接数据
            getLink(){
                this.$ajax({
                    methods:'get',
                    url:'/center/publics/publics/urlList'
                }).then(res => {
                    this.options = res.data.urlList;
                }).catch(err => {
                    (err);
                })
            },
            //选取链接项时触发弹窗
			logoutHandle(item,row,index,type){
                this.icount = index;
                this.linkType = type;
				if(this.options[row].is_open == '1'){
                    this.isLink = true;
                    this.isWinName = 'InnerChain'
                    this.firstRoute = item.url_pattern;
                    this.url_content = item.url_content;
					this.currentPage = 1;
					this.getUrlList(this.firstRoute, 1)
                }else if(this.options[row].is_open == '2'){
                    this.isLink = true;
                    this.isWinName = 'OuterChain';
                }else{
					this.navList[index].isNavShow = false;
					this.navList[index].navShow = item.url_content;
					this.navList[index].validate_id = '';
                    this.navList[index].branchLine = '';
                    this.navList[index].url = item.url_pattern;
				}
			},
			//清除选择链接
			delNavChoice(item){
                item.isNavShow = true;
                item.navShow = '';
				item.branchLine = '';
				item.url ='';
				item.validate_id = '';
			},
            searchGood(){

            },
            // 计算显示内容
            handleCurrentChange(val) {
                this.getUrlList(this.firstRoute, val);
            },
            // 删除当前项
            delNav(index){
                this.navList.splice(index,1);
                console.log(this.navList);
                if(this.navList.length === 0){
                    this.changeState()
                }
            },
            // 选取导航
            choiceNav(index,row){
                this.isLink = false;
                if(this.firstRoute == 'index'){
                    this.navList[this.icount].branchLine = row.page_name;
                }else if(this.firstRoute == 'productGroup'){
                    this.navList[this.icount].branchLine = row.group_name;
                }else if(this.firstRoute == 'detail'){
                    this.navList[this.icount].branchLine = row.product_name;
                }
                this.navList[this.icount].navShow = this.url_content;
                this.navList[this.icount].isNavShow = false;
                this.navList[this.icount].url = this.firstRoute;
                this.navList[this.icount].validate_id = row.validate_id
            },
            // 获取图片信息
            getChoose(pic){
                this.navList[this.iNum].img = this.imageDomaia + pic.file_url;
            },
            // 选中图片区
            choicePic(index){
                this.$refs.picWin.show();
                this.iNum = index;
                this.stopSort();
            },
            //获取弹窗链接
            getUrlList(type, val){
            	if(type == 'index'){
                    this.$ajax({
                        methods:'get',
                        url:'/center/design/pageList',
                        params:{
	                    	page:val,
	                    	rows:5
	                    }
                    }).then(res => {
                        let pageList = res.data.pageList;
                        this.tabNavs = pageList.list;
                        this.total = pageList.total;
                        this.spcDescription = 'page_name';
                    }).catch(err => {
                        (err);
                    })
            	}else if(type == "productGroup"){
                    this.$ajax({
                        methods:'get',
                        url:'/center/productGroup/productGroupList',
                        params:{
                        	page:val,
                        	rows:5
                        }
                    }).then(res => {
                        let productGroupList = res.data.productGroupList;
                        this.tabNavs = productGroupList.list;
                        this.total = productGroupList.total;
                        this.spcDescription = 'group_name';
                    }).catch(err => {
                        (err);
                    })
            	}else if(type == "detail"){ 
                    this.$ajax({
                        methods:'get',
                        url:'/center/product/productListForPage',
                        params:{
                        	page:val,
                        	rows:5
                        }
                    }).then(res => {
                        let productList = res.data.productList;
                        this.tabNavs = productList.list;
                        this.total = productList.total;
                        this.spcDescription = 'product_name';
                    }).catch(err => {
                        (err);
                    })
            	}	
            },
            // 初始化数据
            initData(){
                console.log(this.pageParam)
                this.temp = this.pageParam.temp;
                this.navList = this.pageParam.navList;
                this.navBigList = this.pageParam.navBigList;
                this.navSmallList = this.pageParam.navSmallList;
                this.haveBlock = this.pageParam.haveBlock;
            },
            // 关闭链接选中窗口
            closeLinkWin(){
                this.isLink = false;
                 if(this.linkType == 'new'){
                    this.navList[this.icount].navShow = '';
				    this.navList[this.icount].branchLine = '';
                }
            },
            closeLinkWin1(){
                this.isLink = false;
                // if(this.OuterLink == ''){
                //     this.OuterLink = '';
                // }
                
                 if(this.linkType == 'new'){
                    this.navList[this.icount].navShow = '';
				    this.navList[this.icount].branchLine = '';
                }
            },
            // 确定外链链接
            checkLink(){
                let reg=/^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/;
                if(reg.test(this.OuterLink)){
                    this.isLink = false;
                    this.navList[this.icount].navShow = '外链';
                    this.navList[this.icount].branchLine = this.OuterLink;
                    this.navList[this.icount].url = this.OuterLink;
                    this.navList[this.icount].isNavShow = false;
                }else{
                    this.$message({
				        showClose: true,
				        message: '请填写正确链接地址',
				        type: 'warning'
			        });
                }
            }
            
        },
        mounted(){
            this.initData()
            this.getLink();
            var adver = {
                navList:this.navList,
                haveBlock: this.haveBlock
            }
            this.$emit('getAdver', adver);
        },
        computed:{
            ...mapState(['isMust'])
        },
        // 数据更新时
        updated(){
            var adver = {
                navList:this.navList,
                temp:this.temp,
                haveBlock:this.haveBlock
            }
            this.$emit('getAdver', adver);
        },
        components:{
            picWin
        },
        watch:{
            isLink:function(curVal,oldVal){
                if(!curVal){
                    this.startSort();
                }else{
                    this.stopSort();
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
    width: 85px;
    text-align: right;
    margin-right: 10px;
    }
    .contol_group .reBack{
        font-size: 12px;
        color: #3388ff;
        width: auto;
        margin-left: 10px;
        margin-top: 3px;
    }
    .demonstration{
        margin-top: 2px;
    }
    .setChoice{
        float: left;
    }
    .temp_box{
        float: left;
        width: 100px;
        height: 100px;
        margin-right: 48px;
        margin-bottom: 8px;
        box-sizing: border-box;
        border: 1px solid #ddd;
        text-align: center;
        padding: 8px 0;
        background-color: #fff;
        cursor: pointer;
    }
    .temp_box.check{
        border-color: #38f;
    }
    .no_margin{
        margin-right: 0;
    }
    .temp_pic{
        height: 67px;
        display: table;
        padding: 0 8px;
        width: 84px;
        line-height: 67px;
        
    }
    .temp_pic img{
        width: 100%;
        vertical-align: middle;
    }
    .temp_box p{
        font-size:12px;
        color: #000; 
    }
    /* 添加图片按钮 */
    .addPic a{
        float: left;
        box-sizing: border-box;
        border: 1px solid #ddd;
        padding: 0 5px;
        font-size: 12px;
        color: #000;
        line-height: 30px;
    }
    .addPic a .icon{
        color: #38f;
    }
    .add{
        position: relative;
        width: 388px;
        background-color: #fff;
        padding: 10px;
        box-sizing: border-box;
        border:1px solid #ddd;
        border-radius: 4px;
        margin:17px auto 0;
    }
    .add .setChoice{
        width: 160px;
    }
    .add .setChoice .last{
        margin-left: 0;
        margin-top: 5px;
    } 

    .add .contol_group{
        margin-top: 10px;
    }.add .contol_group1{
        margin-top: 0;
    }
    .add .contol_group span{
        float: left;
        width:69px; 
    }
    .add_pic{
        position: relative;
        float: left;
        margin-right: 10px;
        width: 78px;
        height: 78px;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 78px;
        cursor: pointer;

    }
    .add_pic .icon--jia{
        font-size: 39px;
        color: #38f;
    }
    .add_pic img{
        width: 100%;
        height: 100%;
    }
    .add_pic span{
        position: absolute;
        left: 0;
        bottom: 0;
        background-color: rgba(0,0,0,.5);
        color: #fff;
        width: 100%;
        height: 30px;
        line-height: 30px;
        text-align: center;
        font-size: 12px;
    }
    .choiceSize{
        width: 270px;
        float: left;
    }
    .add .choiceNav{
    	width: 140px;
        position: relative;
        border-color: rgba(51, 136, 255, 0.3);
        background: rgb(226, 243, 255);
        color: rgb(102, 102, 102);
        padding: 5px;
        border-radius: 5px;
    }
    .choiceNav i{
        font-style: normal;
        float: left;
        margin-right: 5px;
    }
    .choiceNav i.icon-guanbi{
        position: absolute;
        right: 4px;
        top: 50%;
        transform: translateY(-50%);
        margin-right: 0;
    }
    .add input{
        width: 120px;
        height: 30px;
        line-height: 30px;
    }
    .icon-guanbi{
        position: absolute;
        display: block;
        font-size: 16px;
        color: #a3a3a3;
        cursor: pointer;
        right: 5px;
        top: 5px;
    }
    /* 链接选择框 */
    .linkChoice{
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,.3);
        z-index: 9999;
    }
    .choice_box{
        width: 570px;
        height: 387px;
        background-color: #fff;
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        padding:10px 0;
        border-radius: 8px;
    }
    .choice_box1{
        width: 430px;
        height: 160px;
    }
    .choice_box .head{
        padding: 0 15px;
    }
    .choice_box .head1{
        border-bottom: 1px solid #ddd;
        padding-bottom: 8px;

    }
    .choice_box .head h6{
        float: left;
        font-size: 14px;
        counter-reset: #333;
    }
    .choice_box .head .icon{
        float: right;
        cursor: pointer;
    }
    .OuterContent{
        padding: 0 15px;
        margin-top: 25px;
    }
    .OuterContent span,
    .OuterContent input{
        float: left;
        line-height: 30px;
    }
    .OuterContent input{
        height: 28px;
        padding: 0 10px;
        margin-left: 10px;
        min-width: 300px;
    }
    .checkButtons{
        padding: 0 10px;
        margin-top: 30px;
    }
    .checkButtons a{
        float: right;
        margin-right: 10px;
        height: 30px;
        line-height: 30px;
        border: 1px solid #bbb;
        padding: 0 10px;
        border-radius: 2px;
        font-size: 12px;
    }
    .checkButtons a.confirm{
        color: #fff;
        background-color: #38f;
        border-color: #38f;
    }
    .search_line{
        background-color: #F9F9F9;
        border-top: 1px solid #e5e5e5;
        border-bottom: 1px solid #e5e5e5;
        padding: 5px 0;
    }
    .search_box{
        position: absolute;
        width: 189px;
        right: 10px;
        top: 47px;
        z-index: 500;
        margin-right: 8px;
    }
    .search_box input,
    .search_box .search_btn{
        float: left;
    }
    .search_box input{
        height:20px;
        line-height: 20px;
        padding-left: 5px;
        font-size: 12px;
    }
    .search_box .search_btn{
        margin-left: -1px;
        border: 1px solid #ccc;
        line-height: 22px;
        color: #333;
        height: 22px;
        background-color: #eee;
        border-radius: 0 3px 3px 0;
        padding: 0 10px;
    }
    .search_line .title{
        float: left;
    }
    .search_line div{
        float: right;
    }
    .linkTab{
        padding: 0 8px;
    }
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
    }
    .choiceBtn:focus{
        border: none 0;
    }
    .nav_list{
        margin-bottom: 15px;
    }
    .add_nav{
        float: left;
        padding: 0 5px;
        border: 1px solid #ccc;
        margin-left: 6px;
        border-radius: 3px;
        font-size: 12px;
        line-height: 26px;
        background-color: #fff;
    }
    .add_nav .icon{
        font-size: 12px;
    }
    .page_nation{
        margin-top: 10px;
    }
    .add .contol_group .el-dropdown span{
    	width: 130px;
    	text-align: left;
    	color: #38f;
    	margin-top: 2px;
    }
    .add .contol_group .el-dropdown span.hasNo{
        color:#f44;  
    }
    .el-dropdown-menu{
    	height: 200px;
    	overflow-y: scroll;
    }
    .changeUrl{
    	width: 30px;
    	float: left;
    	overflow: hidden;
    	margin-left: 5px;
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        font-size: 12px;
    }
    .reminder1{
        position: absolute;
        color: #f44;
        font-size: 12px;
        bottom: 8px;
        left: 103px;
    }
    .reminder2{
        position: absolute;
        color: #f44;
        font-size: 12px;
        right: 15px;
        top: 53px;
    }
    .branchLine{
        max-width: 85px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .contol_group2{
        float: left;
        margin-top: 5px;
    }
</style>
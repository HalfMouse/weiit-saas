<template>
    <div class="set_title">
        <div class="contol_group fn-clear">
            <span class="demonstration" :class="{'hasNo':isMust && inputTitle == ''}">请填写：</span>
            <div class="setChoice">
                <el-input v-model="inputTitle" placeholder="请输入标题"></el-input>
            </div>
        </div>
        <p v-if="isMust && inputTitle == ''" class="reminder" :class="{'hasNo':isMust && inputTitle == ''}">标题不能为空</p>
        <div class="contol_group fn-clear">
            <span>显示样式：</span>
            <div class="setChoice">
                <el-radio v-model="titleStyle" label="style1">样式1</el-radio>
                <el-radio v-model="titleStyle" label="style2">样式2</el-radio>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span>显示更多按钮：</span>
            <div class="setChoice">
                <el-radio v-model="more" label="isHave">有</el-radio>
                <el-radio v-model="more" label="noHave">否</el-radio>
            </div>
        </div>
        <div class="contol_group fn-clear" v-if="more == 'isHave'">
            <span class="demonstration demonstration1">显示链接：</span>
            <div class="setChoice" v-if="titleNav.isNavShow" :class="{'isJump':titleNav.isNavShow}">
                <el-dropdown>
                    <span class="el-dropdown-link" :class="{'hasNo':isMust && titleNav.navShow == ''}">
                            选择跳转到的页面<i class="el-icon-arrow-down el-icon--right"></i>
                    </span>
                    
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item v-for="(ele,row) in options" @click.native="logoutHandle(ele,row,'new')">
                            {{ele.url_content}}
                        </el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
                <p v-if="isMust && titleNav.navShow == ''" class="reminder reminder1">请选择链接</p>
            </div>
            <div v-if="!titleNav.isNavShow && titleNav.navShow != ''" class="choiceNav setChoice fn-clear">
                <i class="firstNav">{{titleNav.navShow}}</i>
                <i v-if="titleNav.branchLine !=''">|</i>
                <i v-if="titleNav.branchLine !=''" class="branchLine">{{titleNav.branchLine}}</i>
                <i class="icon iconfont icon-guanbi" @click="delNavChoice()"></i>
            </div>
            <div class="changeUrl" v-if="!titleNav.isNavShow">
                <el-dropdown>
                    <span class="el-dropdown-link">
                            修改<i class="el-icon-arrow-down el-icon--right"></i>
                    </span>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item v-for="(ele,row) in options" @click.native="logoutHandle(ele,row,'change')">
                            {{ele.url_content}}
                        </el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
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
</template>

<script>
    import {mapState,mapMutations} from 'vuex';
    export default {
        props:['pageParam'],
        data(){
            return {
                titleStyle:'style1',
                more:'isHave',
                inputTitle:'',
                titleNav:{
                    url:'',
                    navShow:'',
                    branchLine:'',
                    validate_id:'',
                    isNavShow:true,
                    isModify:false
                },
                spcDescription:'',
                // 选择得路由的链接
                firstRoute:'',
                // 选择路由的名字
                url_content:'',
                linkType:'',
                options: [],
                // 判断弹出框是否显示参数
                isLink:false,
                 // 一页显示数据
                tabNavs:[],
                // 总数据
                tableData: [],
                // 判断弹出框是否显示参数
                isLink:false,
                //默认每页数据量
                pagesize: 5,
                //当前页码
                currentPage: 1,
                 // 标识打开哪个窗口
                isWinName:'',
                // 外链链接
                OuterLink:'',
                total:0
            }
        },
        updated(){
            var title = {
                titleStyle:this.titleStyle,
                more:this.more,
                inputTitle:this.inputTitle,
                titleNav:this.titleNav
            }
            this.$emit('event', title);
        },
        methods:{
            ...mapMutations(['noState','changeState','startSort','stopSort']),
            // 初始化数据
            initData(){
                this.titleStyle = this.pageParam.titleStyle;
                this.more = this.pageParam.more;
                this.inputTitle = this.pageParam.inputTitle;
                this.titleNav = this.pageParam.titleNav;
            },
            //选取链接项时触发是否有弹窗
			logoutHandle(item,row,type){
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
					this.titleNav.isNavShow = false;
					this.titleNav.navShow = item.url_content;
					this.titleNav.validate_id = '';
                    this.titleNav.branchLine = '';
                    this.titleNav.url = item.url_pattern;
				}
            },
            //清除选择链接
			delNavChoice(){
                this.titleNav.isNavShow = true;
                this.titleNav.navShow = '';
				this.titleNav.branchLine = '';
				this.titleNav.url ='';
				this.titleNav.validate_id = '';
            },
            // 选取导航
            choiceNav(index,row){
                this.isLink = false;
                if(this.firstRoute == 'index'){
                    this.titleNav.branchLine = row.page_name;
                }else if(this.firstRoute == 'productGroup'){
                    this.titleNav.branchLine = row.group_name;
                }else if(this.firstRoute == 'detail'){
                    this.titleNav.branchLine = row.product_name;
                }
                this.titleNav.navShow = this.url_content;
                this.titleNav.isNavShow = false;
                this.titleNav.url = this.firstRoute;
                this.titleNav.validate_id = row.validate_id
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
            closeLinkWin(){
                this.isLink = false;
                 if(this.linkType == 'new'){
                    this.titleNav.navShow = '';
				    this.titleNav.branchLine = '';
                }
            },
            searchGood(){

            },
            // 计算显示内容
            handleCurrentChange(val) {
                this.getUrlList(this.firstRoute, val);
                
            },
            closeLinkWin1(){
                this.isLink = false;
                // if(this.OuterLink == ''){
                //     this.OuterLink = '';
                // }
                
                 if(this.linkType == 'new'){
                    this.titleNav.navShow = '';
				    this.titleNav.branchLine = '';
                }
            },
            // 确定外链链接
            checkLink(){
                let reg=/^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/;
                if(reg.test(this.OuterLink)){
                    this.isLink = false;
                    this.titleNav.navShow = '外链';
                    this.titleNav.branchLine = this.OuterLink;
                    this.titleNav.url = this.OuterLink;
                    this.titleNav.isNavShow = false;
                }else{
                    this.$message({
				        showClose: true,
				        message: '请填写正确链接地址',
				        type: 'warning'
			        });
                }
            }
        },
        computed:{
            ...mapState(['isMust'])
        },
        watch:{
            inputTitle:function(curVal,oldVal){
                if(curVal.length == 0){
                    this.changeState();
                }else{
                    this.noState();
                }
            },
            isLink:function(curVal,oldVal){
                if(!curVal){
                    this.startSort();
                }else{
                    this.stopSort();
                }
            }
        },
        mounted(){
            this.initData();
            this.getLink();
        }
    }
</script>

<style scoped>
    .contol_group {
        margin-top: 17px;
    }
    .empty{
        border-color: #a94442;
        color: #a94442;
    }
    .contol_group span {
        float: left;
        width: 110px;
        text-align: right;
        margin-right: 10px;
    }
    .demonstration{
        margin-top: 7px;
    }
    .setChoice{
        float: left;
    }
    .hasNo{
        color:#f44; 
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        padding-left: 120px;
        font-size: 12px;
    }
    .reminder1{
        padding-left: 5px;
    }
    .demonstration{
        margin-top: 2px;
    }
    .contol_group span {
    float: left;
    width: 100px;
    text-align: right;
    margin-right: 10px;
}

.contol_group .el-dropdown span {
    text-align: left;
    color: #38f;
    margin-top: 2px;
    margin-left: 5px;
}
.contol_group .el-dropdown span.hasNo{
    color: #f44;
}
.el-dropdown-menu {
    height: 200px;
    overflow-y: scroll;
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
        margin-left: -300px;
        margin-top: -200px;
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
    .set_title .choiceNav {
        width: 140px;
        position: relative;
        border-color: rgba(51, 136, 255, 0.3);
        background: rgb(226, 243, 255);
        color: rgb(102, 102, 102);
        padding: 5px;
        border-radius: 5px;
    }
    .choiceNav i {
        font-style: normal;
        float: left;
        margin-right: 5px;
    }
    .branchLine {
        max-width: 85px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .choiceNav i.icon-guanbi {
        position: absolute;
        right: 4px;
        top: 50%;
        -webkit-transform: translateY(-50%);
        transform: translateY(-50%);
        margin-right: 0;
    }
    .isJump .el-dropdown span{
       width: 120px; 
    }
</style>
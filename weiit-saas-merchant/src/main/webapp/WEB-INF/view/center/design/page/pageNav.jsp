<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@include file="../../common/header.jsp" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/nav/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/nav/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/nav/index.css">
<script src="${pageContext.request.contextPath}/resource/js/nav/vue.min.js"></script>
<script src="${pageContext.request.contextPath}/resource/js/nav/index.js"></script>


<style>
    .no-have {
        position: absolute;
        color: #f44;
    }

    .no-url {
        right: -44px;
        top:5px;
    }

    .no-url1 {
        right: 13px;
    }

    .no-picture {
        left: 17px;
        top: 86px;
    }
    .no-txt {
        right: 87px;
        top: 36px;
    }
    .item:last-child {
        margin-top: 11px;
    }
    .item span{
        margin-top:8px;
    }
</style>

<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
    <div class="sidebar-content">
        <!-- Sub navigation -->
        <div class="sidebar-category">
            <div class="category-title">
                <span>店铺装修</span>
            </div>
            <div class="category-content no-padding">
                <ul class="navigation navigation-alt navigation-accordion">
                    <li ><a href="${pageContext.request.contextPath}/center/design/page/pageList"><i
                            class="icon-html5"></i>微页面</a></li>
                    <li ><a href="${pageContext.request.contextPath}/center/design/page/globalStyle"><i
                            class="icon-color-sampler"></i>全店风格</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/design/page/bottomMenu"><i
                            class="icon-cube4"></i>底部菜单</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/center/design/page/navEdit"><i
                            class="icon-cube3"></i>底部导航</a></li>
                </ul>
            </div>
        </div>
        <!-- /sub navigation -->
    </div>
</div>
<!-- /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title" style="height:70px;padding-top:20px;">
                <h4>
                    <i class="icon-arrow-left52 position-left"></i> <span
                        class="text-semibold">导航设置 </span>
                </h4>
            </div>
        </div>
    </div>
    <!-- /page header -->

    <!-- Content area -->
    <div class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="">
                    <div class="alert alert-primary no-border">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
                        <span class="text-semibold"> 修改底部导航,小程序会重新发布审核成功才更新（工作日2~3小时,），公众号立即刷新</span><br>
                        <br>温馨提醒：<span class="text-danger">每个底部导航链接只可以选择一种链接类型</span>
                    </div>

                    <div id="app">
                        <div id="tel_show" class="tel_show">
                            <div class="phone-headset">

                            </div>
                            <div class="phone-screen">
                                <div class="design-preview">
                                    <div class="wp-config">
                                        <div class="wp-comp">
                                            <h1>
                                                <span>westore</span>
                                            </h1>
                                            <img src="${pageContext.request.contextPath}/resource/images/nav/titlebar.png" alt=""
                                                 draggable="false">
                                        </div>
                                    </div>
                                    <div id="right-defaults" class="sortTable">
                                        <div class="list-group">

                                        </div>
                                    </div>
                                </div>
                                <div class="nav-bottom" id="nav-bottom">
                                    <div class="nav-item" v-for="(item, index) in navList">
                                        <img src="${pageContext.request.contextPath}/resource/images/nav/tag-icon.png" alt=""
                                             v-if="item.img == ''">
                                        <img :src="imageDomaia + item.img" alt="" v-if="item.img != ''">
                                        <span v-if="item.nav_name == ''">我是导航</span>
                                        <span v-if="item.nav_name != ''">{{item.nav_name}}</span>

                                    </div>
                                    <!-- <div class="nav-item">
                                        <img src="./images/tag-icon.png" alt="">
                                        <span>我是导航</span>
                                    </div>
                                    <div class="nav-item">
                                        <img src="./images/tag-icon.png" alt="">
                                        <span>我是导航</span>
                                    </div>
                                    <div class="nav-item">
                                        <img src="./images/tag-icon.png" alt="">
                                        <span>我是导航</span>
                                    </div> -->
                                </div>
                            </div>
                            <div class="phone-home"></div>
                        </div>
                        <div class="setting-box">
                            <div class="head">
                                底部导航
                            </div>
                            <div>
                                <a href="javascript:;" class="add-nav" @click="addNav">
                                    <i class="glyphicon glyphicon-plus"></i>
                                    添加导航
                                </a>
                                <ul class="nav-list" id="nav-list">
                                    <li class="fn-clear" v-for="(item, index) in navList">
                                        <i class="glyphicon glyphicon-remove-circle del-nav" @click="delNav(index)"></i>
                                        <div class="add_pic" @click="openWin(index)">
                                            <img src="${pageContext.request.contextPath}/resource/images/nav/tag-icon.png" alt=""
                                                 width="100%" v-if="item.img == ''">
                                            <img :src="imageDomaia + item.img" alt="" width="100%" v-if="item.img != ''">
                                            <span>重新选择</span>
                                        </div>
                                        <p class="no-have no-picture" v-if="item.img == '' && !isFlag">请选择图片</p>
                                        <div class="choiceSize">
                                            <div class="item fn-clear">
                                                <span class="title">文字：</span>
                                                <input type="text" placeholder="填写导航名" class="nav-name form-control" v-model="item.nav_name"
                                                       maxlength="5">
                                                <p class="no-have no-txt" v-if="item.nav_name == '' && !isFlag">请填写导航名</p>
                                            </div>
                                            <div class="item fn-clear">
                                                <span class="title">显示链接：</span>
                                                <div class="setChoice" v-if="item.isNavShow && index !== 0">
                                                    <el-dropdown>
                                        <span class="el-dropdown-link link-btn">
                                                选择跳转到的页面<i class="glyphicon glyphicon-menu-down"></i>
                                        </span>
                                                        <el-dropdown-menu slot="dropdown">
                                                            <el-dropdown-item v-for="(ele,row) in options"
                                                                              @click.native="logoutHandle(ele,row,index,'new')">
                                                                {{ele.url_content}}
                                                            </el-dropdown-item>
                                                        </el-dropdown-menu>
                                                    </el-dropdown>
                                                </div>
                                                <div class="setChoice" v-if="item.isNavShow && index === 0">
                                <span class="el-dropdown-link link-btn" @click="getIndexList(index)">
                                        选择微页面<i class="glyphicon glyphicon-menu-down"></i>
                                </span>
                                                </div>
                                                <p class="no-have no-url" :class="{'no-url1':index === 0}" v-if="item.url == '' && !isFlag">
                                                    请选择链接</p>
                                                <div v-if="!item.isNavShow && item.navShow != ''" class="choiceNav setChoice fn-clear">
                                                    <i class="firstNav">{{item.navShow}}</i>
                                                    <i v-if="item.branchLine !=''">|</i>
                                                    <i v-if="item.branchLine !=''" class="branchLine">{{item.branchLine}}</i>
                                                    <i class="glyphicon glyphicon-remove-circle" @click="delNavChoice(item)"></i>
                                                </div>
                                                <div class="changeUrl" v-if="!item.isNavShow && index !== 0"
                                                     style="float: left;margin-left: 5px;">
                                                    <el-dropdown>
                                        <span class="el-dropdown-link1" style="width: 32px;margin-right: 0;">
                                                修改
                                        </span>
                                                        <el-dropdown-menu slot="dropdown">
                                                            <el-dropdown-item v-for="(ele,row) in options"
                                                                              @click.native="logoutHandle(ele,row,index,'edit')">
                                                                {{ele.url_content}}
                                                            </el-dropdown-item>
                                                        </el-dropdown-menu>
                                                    </el-dropdown>
                                                </div>
                                                <div class="changeUrl" v-if="!item.isNavShow && index === 0">
                                <span class="el-dropdown-link1" style="width: 32px;margin-right: 0;"
                                      @click="getIndexList(index)">
                                        修改
                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                                <p class="tips">可添加导航数量2~5</p>
                            </div>
                        </div>
                        <!-- 导航图标选择框 -->
                        <div class="bg" v-show="isShow" style="display: none;">
                            <div class="show-box">
                                <h2>选择导航</h2>
                                <div class="picture-list">
                                    <ul>
                                        <li class="pic-item" v-for="(item, index) in iconPic" @click="iNum = index"
                                            :class="{'active':index == iNum}">
                                            <div class="picture_img">
                                                <img :src="imageDomaia + item.url" alt="" width="100%">
                                            </div>
                                            <div class="picture_title">
                                                {{item.remark}}
                                            </div>
                                            <i class="glyphicon glyphicon-ok-sign check" v-if="index == iNum"></i>
                                        </li>
                                    </ul>
                                </div>
                                <i class="glyphicon glyphicon-remove-circle close-win" @click="closeIconWIn"></i>
                                <a href="javascript:;" class="comfirm" :class="{'none': iNum == -1}" @click="ensure(iNum)"
                                   style="padding: 0;text-align: center;width: 52px;">确 定</a>
                            </div>
                        </div>
                        <!-- 链接选择框 -->
                        <div class="linkChoice" v-show="isLink" style="display: none;">
                            <div class="choice_box">
                                <div class="head fn-clear">
                                    <h6>选取链接</h6>
                                    <i class="glyphicon glyphicon-remove-circle icon" @click="closeLinkWin"></i>
                                </div>
                                <!--<div class="search_box">
                                    <input type="text" placeholder="请输入标题">
                                    <a href="javascript:;" class="search_btn" @click="searchGood">搜索</a>
                                </div>-->
                                <el-table :data="tabNavs" ref="table" row-key="id" style="width: 100%;min-height: 323px;" class="linkTab">
                                    <el-table-column :prop="spcDescription" label="名称" width="450"
                                                     :show-overflow-tooltip="true"></el-table-column>
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
                        </div>
                        <a href="javascript:;" class="save" @click="save()">保 存</a>
                    </div>
                </div>
                <!-- /form validation -->
            </div>
        </div>


    </div>
    <!-- /content area -->

</div>

<!-- /main content -->
<%@include file="../../common/footer.jsp" %>
<script>
    var app = new Vue({
        el: '#app',
        data: {
            navList: [],
            isShow: false,
            options: [],
            // 一页显示数据
            tabNavs: [],
            isLink: false,
            // 外链链接
            OuterLink: '',
            spcDescription: '',
            //默认每页数据量
            pagesize: 5,
            //当前页码
            currentPage: 1,
            total: 0,
            iconPic: [],
            // 图片前缀
            imageDomaia: 'http://wstore-1255653546.image.myqcloud.com',
            iNum: -1,
            icount: -1,
            linkObj: null,
            isFlag: true
        },
        methods: {
            // 添加导航
            addNav: function () {
                var navObj = {
                    img: '',
                    nav_name: '',
                    url: '',
                    value: '',
                    navShow: '',
                    nav_icon_id: '',
                    branchLine: '',
                    nav_value: '',
                    isNavShow: true
                }
                if (this.navList.length >= 5) {
                    this.$message.error('超过添加最大数量');
                    return false;
                }
                this.navList.push(navObj);
            },
            // 删除导航数量
            delNav: function (index) {
//                if(this.navList.length <= 2){
//                    alert('超过添加最小数量');
//                    return false;
//                }
                if (index != 0 && index != this.navList.length - 1) {
                    this.navList.splice(index, 1);
                }


            },
            // 获取导航链接
            getLink: function () {
                var _this = this;
                jQuery.ajax({
                    type: 'GET',
                    url: "/center/design/page/navOptionalUrl",
                    dataType: 'json',
                    async: true,
                    success: function (res) {
                        _this.options = res.data.filter(function (item) {
                            return item.url_pattern !== 'index'
                        })
                    }
                });
            },
            // 获取图标图片
            getNavPic: function () {
                var _this = this;
                $.ajax({
                    type: 'GET',
                    url: '/center/design/page/navIconList',
                    dataType: 'json',
                    async: false,
                    success: function (res) {
                        _this.iconPic = res.data;
                    }
                })
            },
            // 初始化数据
            initData: function () {
                var _this = this;
                $.ajax({
                    type: 'GET',
                    url: '/center/design/page/navInfo',
                    dataType: "json",
                    success: function (res) {
                        res.data.forEach(function(item){
                            item.value= '';
                            item.navShow =  item.nav_name;
                            if(item.navShow == ''){
                                item.isNavShow = true;
                            }else{
                                item.isNavShow = false;
                            }
                            _this.navList.push(item)
                        })
                    }
                })
            },
            //选取链接项时触发
            logoutHandle: function (item, row, index, type) {
                this.linkType = type
                this.icount = index;
                var isFlag = true;
                this.navList.forEach(function (ele, iCount) {
                    if (ele.url == item.url_pattern && index != iCount) {
                        isFlag = false
                    }
                })
                // 判断是否选取重复链接
                if (isFlag) {
                    //判断是否有多项选择
                    if (this.options[row].is_open == 1) {
                        this.isLink = true;
                        this.firstRoute = item.url_pattern;
                        this.url_content = item.url_content;
                        this.currentPage = 1;
                        this.getUrlList(this.firstRoute, 1);


                    } else if (this.options[row].is_open == 0) {
                        this.navList[index].isNavShow = false;
                        this.navList[index].navShow = item.url_content;
                        this.navList[index].nav_value = '';
                        this.navList[index].branchLine = '';
                        this.navList[index].url = item.url_pattern;
                    }
                } else {
                    this.$message.error('只能选取一种链接');
                }


            },
            closeIconWIn: function () {
                this.iNum = -1;
                this.isShow = false
            },
            // 关闭链接选中窗口
            closeLinkWin: function () {
                this.isLink = false;
                if (this.linkType == 'new') {
                    this.navList[this.icount].navShow = '';
                    this.navList[this.icount].branchLine = '';
                }
            },


            //获取弹窗链接
            getUrlList: function (type, val) {
                if (type == 'index') {
                    var _this = this;
                    $.ajax({
                        type: 'GET',
                        url: '/center/design/pageListNotoken',
                        data: {
                            page: val,
                            rows: 5
                        },
                        dataType: 'json',
                        success: function (res) {
                            _this.tabNavs = res.pageList.list;
                            _this.total = res.pageList.total;
                            _this.spcDescription = 'page_name';
                        }
                    })
                } else if (type == "productGroup") {
                    var _this = this;
                    $.ajax({
                        type: 'GET',
                        url: '/center/productGroup/productGroupListNotoken',
                        data: {
                            page: val,
                            rows: 5
                        },
                        dataType: 'json',
                        success: function (res) {
                            _this.tabNavs = res.productGroupList.list;
                            _this.total = res.productGroupList.total;
                            _this.spcDescription = 'group_name';
                        }
                    })
                } else if (type == "detail") {
                    var _this = this;
                    $.ajax({
                        type: 'GET',
                        url: '/center/product/productListForPageNotoken',
                        data: {
                            page: val,
                            rows: 5
                        },
                        dataType: 'json',
                        success: function (res) {
                            _this.tabNavs = res.productList.list;
                            _this.total = res.productList.total;
                            _this.spcDescription = 'product_name';
                        }
                    })
                }
            },
            // 获取首页微页面
            getIndexList: function (index) {
                if (index == 0) {
                    this.firstRoute = 'index';
                    this.url_content = '首页';
                    this.icount = index;
                    this.isLink = true;
                    var _this = this;
                    $.ajax({
                        type: 'GET',
                        url: '/center/design/pageListNotoken',
                        data: {
                            page:index,
                            rows: 5
                        },
                        dataType: 'json',
                        success: function (res) {
                            _this.tabNavs = res.pageList.list;
                            _this.total = res.pageList.total;
                            _this.spcDescription = 'page_name';
                        }
                    })
                }
            },
            // 计算显示内容
            handleCurrentChange: function (val) {
                this.getUrlList(this.firstRoute, val)
            },
            //清除选择链接
            delNavChoice: function (item) {
                item.isNavShow = true;
                item.navShow = '';
                item.branchLine = '';
                item.url = '';
                item.nav_value = '';
            },
            // 选取导航
            choiceNav: function (index, row) {
                this.isLink = false;
                if (this.firstRoute == 'index') {
                    this.navList[this.icount].branchLine = row.page_name;
                } else if (this.firstRoute == 'productGroup') {
                    this.navList[this.icount].branchLine = row.group_name;
                } else if (this.firstRoute == 'detail') {
                    this.navList[this.icount].branchLine = row.product_name;
                }
                this.navList[this.icount].navShow = this.url_content;
                this.navList[this.icount].isNavShow = false;
                this.navList[this.icount].url = this.firstRoute;
                this.navList[this.icount].nav_value = row.validate_id;
            },
            // 确认选择
            ensure: function (index) {
                this.iNum = -1;
                this.isShow = false;
                this.navList[this.icount].img = this.iconPic[index].url;
                this.navList[this.icount].nav_icon_id = this.iconPic[index].id;
            },
            // 打开图标选择弹窗
            openWin: function (index) {
                this.isShow = true;
                this.icount = index;

            },
            // 保存数据
            save: function () {
                var _this = this;
                this.navList.forEach(function (item) {
                    if (item.nav_name == '') {
                        _this.$message.error('请填写导航');
                        _this.isFlag = false;
                    } else if (item.img == '') {
                        _this.$message.error('请选择图片图标');
                        _this.isFlag = false;
                        return false
                    } else if (item.url == '') {
                        _this.$message.error('请选择导航链接');
                        _this.isFlag = false;
                        return false
                    }else{
                        _this.isFlag = true;
                    }
                })
                if(this.isFlag){
                    $.ajax({
                        type: 'POST',
                        url: '/center/design/page/saveNav',
                        data: {
                            nav: JSON.stringify(_this.navList)
                        },
                        success: function (res) {
                            console.log(res);
                            if (res =='success'){
                                new PNotify({title: '提示操作',text: '保存成功',addclass: 'bg-info'})
                            }else {
                                new PNotify({title: '提示操作',text: '操作太频繁',addclass: 'bg-danger'})
                            }

                        },
                        error: function (err) {
                            new PNotify({title: '提示操作',text: '保存失败',addclass: 'bg-danger'})
                        }
                    })
                }

            },

        },
        mounted: function () {
            this.initData();
            this.getLink();
            this.getNavPic();
        }
    })


    function notify() {
        new PNotify({title: '提示操作',text: '${text}',addclass: 'bg-info'});

    }
</script>


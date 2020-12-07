<template>
  <div id="app">
    <div class="fn-clear new_box">
        <div class="navigation_box">
            <!-- 左侧功能选择导航 -->
            <div class="navigation wrapper">
                <ul class="dowebok fn-clear" id="left-defaults">
                    <li :key="index" v-for="(item,index) in iconArr" class="item" @mousedown="init()" @mousemove="over($event,index)" @mouseup="out($event,index,item)">
                        <div class="nav_icon">
                            <!-- <img :src="'./'" alt=""> -->
                            <img :src="'static/images/' + item.type + '.png'" alt="" draggable="false">
                        </div>
                        <span class="nav_txt">{{item.name}}</span>
                        <!-- <show-tabel :keyWords="item.pic" :index="index" ref="showTable" :keyText="item.name"></show-tabel> -->
                    </li>
                </ul>
            </div>
            <!-- 中间手机展示 -->
            <div class="tel_show" id="tel_show" v-loading="loading">
                <div class="phone-headset"></div>
                <div class="phone-screen">
                    <div class="design-preview" ref="showNav">
                        <div class="wp-config">
                            <div class="wp-comp" @click="headShow">
                                <h1>
                                    <span v-if="pageName == ''">自定义模板</span>
                                    <span v-else>{{pageName}}</span>
                                    
                                </h1>
                                <img src="static/images/titlebar.png" alt="" draggable="false"/>
                            </div>
                        </div>
                        <div class="sortTable container" id="right-defaults">
                        	<draggable v-model="tabs" @end="datadragEnd" :options="{disabled:isSortable,draggable: '.sortChunk'}" class="list-group">
	                            <div class="sortChunk" :key="item.id" v-for="(item,index) in tabs" @click="choice(item,index)" :class="{'focus':index == iNum}">
	                            	
	                                <div class="close" :class="{'active':index == iNum}">
	                                    <i class="icon iconfont icon-guanbi" @click="checked(index)"></i>
	                                </div>
	                                <show-tabel class="show" :keyWords="item.type" :keyText="item.name" :tempId="item.id" :pageParam="item.pageParam"></show-tabel>
	                                <div class="del_box" v-show="index == s">
	                                    <h5>确定删除？</h5>
	                                    <div>
	                                        <el-button class="del_btn" type="primary" @click="deletes(index, $event)">确认</el-button>
	                                        <el-button @click="close($event)">取消</el-button>
	                                    </div>
	                                </div>
	                              
	                            </div>
                         </draggable>
                        </div>
                     </div>
                </div>
                <div class="phone-home">
                    
                </div>
            </div>
        </div>
        <p class="tips-txt">建议自定义装修图片宽度为750px</p>
        <!-- 设置店招 -->
        <div class="modify_box1" v-show="tabs.length == 0 || isHeadShow">
            <set-head @event="getHead"></set-head>
        </div> 
        <div class="footer" :class="{'sublayer':isZIndex}">
            <div class="foot">
                <a href="javascript:;" class="save" @click="save()">保存</a>
                <a href="javascript:;" class="reBack" @click="reBack()">返回</a>
            </div>
        </div>
    </div>
  </div>
</template>

<script>
import $ from "jquery";
// 中间展示模板
import showTabel from "@/components/show/showTable";
// 设置客服
import setHead from "@/components/set/setHead";
// 引入vuex
import store from "@/vuex/store";
import { mapState, mapActions, mapMutations } from "vuex";
import { getQueryString } from "../static/js/getQueryString";
import draggable from "vuedraggable";
import Sortable from "sortablejs";
import toast from "@/components/common/toast";
import axios from "axios";
import qs from "qs";
export default {
  name: "App",
  data() {
    return {
      s: -1,
      flag: false,
      iconArr: [
        { type: "shop_signs", name: "店招" },
        { type: "search", name: "搜索框" },
        { type: "auxiliary_blank", name: "辅助空白" },
        { type: "auxiliary_lines", name: "辅助线" },
        { type: "nav", name: "图文导航" },
        { type: "coupon", name: "优惠卷" },
        { type: "Commodity_sort", name: "商品分组" },
        { type: "Commodity_list", name: "商品列表" },
        { type: "title", name: "标题" },
        { type: "text", name: "文本" },
        { type: "text_box", name: "富文本" },
        { type: "advertisement", name: "广告模块" },
        { type: "voice", name: "语音" },
        { type: "video", name:'视频'},
        { type: "fight", name: "拼团" },
        { type: "bargain", name: "砍价" },
        { type: "notice", name: "公告" },
        { type: "tel", name: "客服电话" }
      ],
      w: 0,
      h: 0,
      l1: 0,
      t1: 0,
      l2: 0,
      t2: 0,
      tabs: [],
      iNum: -1,
      isEdit: true,
      pageName: "",
      pageDesc: "",
      bgcolor: "#FF0099",
      newTabs: [],
      isHeadShow: false,
      templateId: "",
      validateIdToke: "",
      validateId: null,
      pass: true,
      tips: "",
      template_img: "",
      isCreate: false,
      pageStyle: "",
      token: "",
      loading: false
    };
  },
  components: {
    draggable,
    Sortable,
    showTabel,
    setHead,
    toast
  },
  methods: {
    ...mapActions(["delData", "addData"]),
    ...mapMutations([
      "changeState",
      "unseal",
      "noState",
      "stopSort",
      "startSort"
    ]),
    // 初始化事件
    init: function() {
      $(".item").draggable({
        revert: true,
        revertDuration: 200,
        beforeStop: function() {
          this.flag = false;
        }
      });
    },
    // 鼠标拖动
    over: function(e, index) {
      $(".item")
        .css("zIndex", 1)
        .eq(index)
        .css("zIndex", 5);
      var oEvent = e || event;
      var x = oEvent.clientX;
      var y = oEvent.clientY;
      if (x > this.l1 && x < this.l2 && y > this.t1 && y < this.t2) {
        this.flag = true;
      } else {
        this.flag = false;
      }
    },
    // 鼠标放开
    out: function(e, index, item) {
      // this.len = $("#right-defaults ul li").length;
      this.flag = false;
      var oEvent = e || event;
      var x = oEvent.clientX;
      var y = oEvent.clientY;
      var h3 = 0;
      this.h = $("#right-defaults").height();
      this.t2 = this.t1 + this.h;
      if (x > this.l1 && x < this.l2 && y > this.t1 && y < this.t2) {
        var obj = {
          name: item.name,
          type: item.type,
          id: new Date().getTime()
        };
        this.tabs.push(obj);
        this.noState();
        var len = this.tabs.length;
        this.iNum = len - 1;
        $("#right-defaults .sortChunk")
          .eq(len - 1)
          .addClass("focus");
        $("#right-defaults .nav_des .modify_box")
          .eq(len - 1)
          .show();
      }
    },
    // 删除当前项
    deletes(index, e) {
      e.stopPropagation();
      this.delData(index);
      this.tabs.splice(index, 1);
      if (this.tabs.length == 0) {
        this.noState();
      }

      this.s = -1;
      this.startSort();
    },
    // 打开删除弹窗
    checked(index) {
      this.s = index;
      this.stopSort();
    },
    // 关闭删除弹窗
    close(e) {
      this.s = -1;
      e.stopPropagation();
      this.startSort();
    },
    // 选中展示框
    choice(item, index) {
      this.isHeadShow = false;
      this.iNum = index;
    },
    // 初始化信息
    initial() {
      this.token = getQueryString("token");
      var killErrors = function(value) {
        return true;
      };
      window.onerror = null;
      this.w = $("#right-defaults").width();
      this.l1 = $("#right-defaults").offset().left;
      this.t1 = $("#right-defaults").offset().top;
      this.l2 = this.l1 + this.w;
    },
    // 保存数据
    saveData(fileDate) {
      var formData = new FormData();
      let that = this;
  //  let url = "http://merchant.woyoulian.com";
   let url = "http://merchant.wstore.me";
      if (this.pageName == "") {
        this.pageName = "自定义模板";
      }
      this.loading = true;
      if (this.pageStyle == "create" && !this.isCreate) {
        formData.append("fileDate", fileDate);
        formData.append("page_name", this.pageName);
        formData.append("page_desc", this.pageDesc);
        formData.append("page_layout", JSON.stringify(this.styleList));
        formData.append("bgcolor", this.bgcolor);
        formData.append("token", this.token);
        // formData.append('token','13FF7ABE13B23843');
        $.ajax({
          type: "POST",
          url: url + "/center/design/savePageInfo",
          processData: false,
          contentType: false,
          data: formData,
          success: function(res) {
            
            that.$message({
              message: "保存成功",
              type: "success"
            });
            that.validateId = res.validate_id;
            that.validateIdToke = res.validate_id_token;
            that.isCreate = true;
            that.loading = false;
          }
        });
      } else {
        formData.append("fileDate", fileDate);
        formData.append("page_name", this.pageName);
        formData.append("page_desc", this.pageDesc);
        formData.append("page_layout", JSON.stringify(this.styleList));
        formData.append("bgcolor", this.bgcolor);
        formData.append("validate_id", this.validateId);
        formData.append("validate_id_token", this.validateIdToke);
        formData.append("token", this.token);
        // formData.append('token','13FF7ABE13B23843');
        $.ajax({
          type: "POST",
          url: url + "/center/design/editPageInfo",
          processData: false,
          contentType: false,
          data: formData,
          success: function(res) {
            that.$message({
              message: "保存成功",
              type: "success"
            });
            that.loading = false;
          }
        });
      }
    },
    //保存数据到后台
    save() {
      // 检测数据是否符合规则
      let _this = this;
      for (var i = 0; i < _this.styleList.length; i++) {
        if (_this.styleList[i].type == "nav") {
          // 导航检测
          let isThrough = true;
          let isNav = true;
          if (_this.styleList[i].pageParam.navList.length == 0) {
            _this.iNum = i;
            _this.tips = "请选择导航";
            _this.pass = false;
            break;
          }
          for (
            var j = 0;
            j < _this.styleList[i].pageParam.navList.length;
            j++
          ) {
            if (_this.styleList[i].pageParam.navList[j].img == "") {
              isThrough = false;
              break;
            }
          }
          for (
            var j = 0;
            j < _this.styleList[i].pageParam.navList.length;
            j++
          ) {
            if (_this.styleList[i].pageParam.navList[j].url == "") {
              isNav = false;
              break;
            }
          }
          if (!isThrough) {
            _this.iNum = i;
            _this.tips = "请选择一张图片";
            _this.pass = false;
            break;
          } else if (!isNav) {
            _this.iNum = i;
            _this.tips = "请选择导航链接";
            _this.pass = false;
            break;
          }
          _this.pass = true;
        } else if (
          _this.styleList[i].type == "Commodity_list" &&
          _this.styleList[i].pageParam.addFun == "manual" &&
          _this.styleList[i].pageParam.productIds.length === 0
        ) {
          //商品列表检测
          _this.tips = "请选择一张商品图片";
          _this.iNum = i;
          _this.pass = false;
          break;
        } else if (
          _this.styleList[i].type == "coupon" &&
          _this.styleList[i].pageParam.addFun == "manual" &&
          _this.styleList[i].pageParam.coupon_ids.length == 0
        ) {
          //优惠券检测
          _this.tips = "请选择优惠券";
          _this.iNum = i;
          _this.pass = false;
          break;
        } else if (_this.styleList[i].type == "title") {
          //标题检测
          if (_this.styleList[i].pageParam.inputTitle == "") {
            _this.tips = "请填写标题";
            _this.iNum = i;
            _this.pass = false;
          } else if (
            _this.styleList[i].pageParam.titleNav.url == "" &&
            _this.styleList[i].pageParam.more == "isHave"
          ) {
            _this.tips = "请填写表填链接";
            _this.iNum = i;
            _this.pass = false;
          }
          break;
        } else if (
          _this.styleList[i].type == "text" &&
          _this.styleList[i].pageParam.textarea == ""
        ) {
          //文本检测
          _this.tips = "文本不能为空";
          _this.iNum = i;
          _this.pass = false;
          break;
        } else if (_this.styleList[i].type == "advertisement") {
          //广告模块检测
          let isThrough = true;
          let isNav = true;
          if (_this.styleList[i].pageParam.navList.length == 0) {
            _this.tips = "请添加块";
            _this.iNum = i;
            _this.pass = false;
            break;
          }
          for (
            var j = 0;
            j < _this.styleList[i].pageParam.navList.length;
            j++
          ) {
            if (_this.styleList[i].pageParam.navList[j].img == "") {
              isThrough = false;
              break;
            }
          }
          // for(var j=0; j<_this.styleList[i].pageParam.navList.length; j++){
          //     if(_this.styleList[i].pageParam.navList[j].url == ""){
          //         isNav = false;
          //         break;
          //     }
          // }
          if (!isThrough) {
            _this.tips = "请选择一张图片";
            _this.iNum = i;
            _this.pass = false;
            break;
          }
          // else if(!isNav){
          //     _this.tips = '请选择导航链接';
          //     _this.iNum = i
          //     _this.pass = false;
          //     break;
          // }
          _this.pass = true;
        } else if (
          _this.styleList[i].type == "voice" &&
          !_this.styleList[i].pageParam.voiceData
        ) {
          //音频检测
          _this.tips = "选择一个音频文件";
          _this.iNum = i;
          _this.pass = false;
          break;
        } else if (_this.styleList[i].type == "video" &&_this.styleList[i].pageParam.videoUrl == "") {
          //视频检测
          _this.tips = "请填写视频链接";
          _this.iNum = i;
          _this.pass = false;
          break;
        } else if (
          _this.styleList[i].type == "fight" &&
          _this.styleList[i].pageParam.addFun == "manual" &&
          _this.styleList[i].pageParam.groupon_ids.length == 0
        ) {
          //拼团商品检测
          _this.tips = "请选择商品";
          _this.iNum = i;
          _this.pass = false;
          break;
        } else if (
          _this.styleList[i].type == "bargain" &&
          _this.styleList[i].pageParam.addFun == "manual" &&
          _this.styleList[i].pageParam.bargain_ids.length == 0
        ) {
          //砍价商品检测
          _this.tips = "请选择商品";
          _this.iNum = i;
          _this.pass = false;
          break;
        } else if (
          _this.styleList[i].type == "notice" &&
          _this.styleList[i].pageParam.noticeTxt == ""
        ) {
          //公告检测
          _this.tips = "请填写公告";
          _this.iNum = i;
          _this.pass = false;
          break;
        } else if (_this.styleList[i].type == "tel") {
          //客服电话检测
          if (isNaN(Number(_this.styleList[i].pageParam.custom_tel))) {
            _this.tips = "请填写正确号码";
            _this.iNum = i;
            _this.pass = false;
            break;
          } else if (!_this.styleList[i].pageParam.custom_tel) {
            _this.tips = "请填写电话";
            _this.iNum = i;
            _this.pass = false;
            break;
          }
          _this.pass = true;
        } else {
          _this.pass = true;
        }
      }

      // 到不符合规则的高度
      if (!this.pass) {
        let index = this.iNum;
        let ScrollTop = $(".sortChunk")
          .eq(index)
          .offset().top;
        $("body,html").scrollTop(ScrollTop - 30);
      }
      // 检测数据情况
      if (this.styleList.length == 0) {
        this.$message.error("微页面内容不可为空，请添加组件");
      } else if (this.pass) {
        this.clip();
      } else {
        this.unseal();
        this.changeState();
        this.tipsMessage();
      }
    },
    //提示信息
    tipsMessage() {
      this.$message.error({
        message: this.tips,
        type: "error",
        center: true,
        duration: 2000
      });
    },
    // 右侧页面标题设置
    getHead(obj) {
      this.pageName = obj.pageName;
      this.pageDesc = obj.pageDesc;
    },
    // 微页面标题设置
    headShow() {
      this.isHeadShow = true;
      this.iNum = -1;
    },
    // 获取模板信息
    getResource() {
      this.$ajax({
        methods: "get",
        url: "/center/design/page/getTemplatePageJson",
        params: {
          templateId: this.templateId
        }
      })
        .then(res => {
          if (res.data.template_json == "") {
            this.tabs = [];
          } else {
            this.tabs = JSON.parse(res.data.template_json);
          }
          this.pageName = res.data.template_name;
          this.template_img = res.data.template_img;
        })
        .catch(err => {
          err;
        });
    },
    // 拖动排序
    datadragEnd(evt) {
      var obj = this.styleList[evt.oldIndex];
      if (evt.newIndex > evt.oldIndex) {
        // 往下拖动的时候
        this.styleList.splice(evt.newIndex + 1, 0, obj);
        this.styleList.splice(evt.oldIndex, 1);
      } else {
        // 网上拖动的时候
        this.styleList.splice(evt.newIndex, 0, obj);
        this.styleList.splice(evt.oldIndex + 1, 1);
      }
      // 拖动之后展示框所在位置的改变
      if (evt.oldIndex < this.iNum && evt.newIndex >= this.iNum) {
        this.iNum -= 1;
      } else if (evt.oldIndex > this.iNum && evt.newIndex <= this.iNum) {
        this.iNum += 1;
      } else if (this.iNum == evt.oldIndex) {
        this.iNum = evt.newIndex;
      }
    },
    // 获取编辑信息
    getEditNews() {
      this.$ajax({
        methods: "get",
        url: "/center/design/weiPage",
        params: {
          templateId: this.templateId
        }
      })
        .then(res => {
          
          this.validateId = res.data.pageInfo.validate_id;
          this.validateIdToke = res.data.pageInfo.validate_id_token;
          this.tabs = JSON.parse(res.data.pageInfo.page_layout);
          this.pageName = res.data.pageInfo.page_name;
        })
        .catch(err => {
          err;
        });
    },
    // 返回功能
    reBack() {
      window.history.go(-1);
    },
    //截取图片
    clip() {
      let that = this;
      html2canvas(this.$refs.showNav, { useCORS: true, height: 500 }).then(
        function(canvas) {
          var dataURL = canvas.toDataURL("image/png");
          var fileDate = that.dataURLtoFile(
            dataURL,
            new Date().getTime() + ".png"
          );
          that.saveData(fileDate);
        }
      );
    },
    dataURLtoFile(dataurl, filename) {
      var arr = dataurl.split(","),
        mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]),
        n = bstr.length,
        u8arr = new Uint8Array(n);
      while (n--) {
        u8arr[n] = bstr.charCodeAt(n);
      }
      return new File([u8arr], filename, { type: mime });
    }
  },
  computed: {
    ...mapState(["styleList", "isSortable", "isZIndex"])
  },
  created() {
      this.templateId = getQueryString('templateId');
      this.pageStyle = getQueryString('pageStyle');
  },
  mounted() {
    this.initial();
    if (this.pageStyle == "create") {
      this.getResource();
    } else if (this.pageStyle == "edit") {
      this.getEditNews();
    }
  },
  store
};
</script>

<style scoped>
#app{
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
}
.new_box {
  padding-top: 20px;
  padding-left: 26px;
  height: calc(100% - 20px);
}
.navigation_box {
  height: calc(100% - 52px);
}
.dads-children-placeholder {
  display: none;
}
/* 左侧功能选择 */
.navigation {
  position: fixed;
  width: 140px;
  padding-right: 25px;
  border-right: 1px solid #eee;
  top: 20px;
  z-index: 5;
}
.navigation .dowebok {
  position: relative;
}
.navigation .dowebok .item {
  float: left;
  width: 60px !important;
  height: 54px !important;
  box-sizing: border-box;
  border: 1px dotted #60a6e4;
  margin-right: 10px;
  margin-bottom: 10px;
  background-color: #fbfbfb;
  padding-top: 6px;
  border-radius: 6px;
  cursor: move;
  z-index: 5;
}
#right-defaults .sortChunk {
  position: relative;
  cursor: move;
  width: 318px;
  margin: 0 auto;
  /*z-index: 4;*/
}
.nav_icon {
  width: 30px;
  height: 30px;
  text-align: center;
  margin: 0 auto;
}
.nav_txt {
  display: block;
  text-align: center;
  font-size: 12px;
  color: #000;
  margin-top: -3px;
}

/* 中间手机展示部分 */
.tel_show {
  position: absolute;
  box-sizing: border-box;
  width: 336px;
  margin-left: 35px;
  border: 1px solid #e5e5e5;
  padding: 50px 0 60px 0;
  border-radius: 30px;
  margin-bottom: 220px;
  left: 200px;
}
.tel_show .phone-headset {
  position: absolute;
  top: 20px;
  left: 50%;
  margin-left: -25px;
  border-radius: 5px;
  width: 50px;
  height: 6px;
  background: #dad8d8;
}
.tel_show .phone-home {
  position: absolute;
  bottom: 10px;
  left: 50%;
  margin-left: -20px;
  width: 40px;
  height: 40px;
  border: 1px solid #e5e5e5;
  border-radius: 100%;
}
.tel_show .phone-screen {
  position: relative;
  width: 320px;
  margin: 0 auto;
  min-height: 200px;
  border: 1px solid #f5f5f5;
  background-color: #f8f8f8;
}
.design-preview {
  position: relative;
}
.design-preview .wp-comp {
  position: relative;
  width: 320px;
  cursor: pointer;
  height: 55px;
}
.design-preview .wp-config h1 {
  position: absolute;
  width: 320px;
  top: 0;
  margin: 0;
  line-height: 36px;
  font-size: 16px;
  color: #fff;
  font-weight: 700;
  text-align: center;
  background-size: 320px 55px;
  z-index: 3;
  padding-top: 19px;
}
.design-preview .wp-config img {
  position: absolute;
  width: 320px;
  top: 0;
}
/* 主要展示区 */
.sortTable {
  position: relative;
  min-height: 400px;
}
/* 更改区域 */
.modify {
  float: left;
  position: relative;
}
/* 头部更改 */

/* 底部按钮 */
.footer {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  z-index: 4;
}
.sublayer {
  z-index: 4;
}
.foot {
  width: 96%;
  margin: 0 auto;
  display: table;
  text-align: center;
  padding: 5px 0;
  background-color: #fff;
}
.foot a {
  display: inline-block;
  text-align: center;
  line-height: 18px;
  width: 68px;
  box-sizing: border-box;
  font-size: 12px;
  border-radius: 3px;
  padding: 5px 10px;
}
.foot a.save {
  background-color: #2897e4;
  color: #fff;
  margin-right: 5px;
}
.foot a.reBack {
  border: 1px solid #ccc;
  color: #333;
}
.no-more {
  width: 100%;
  height: 30px;
  box-sizing: border-box;
  border: 1px #cd6e00 dashed;
}
/* 右侧设置 */
.modify_box1 {
  position: absolute;
  left: 572px;
  top: 72px;
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
.icon-guanbi {
  position: absolute;
  font-size: 20px;
  color: #a3a3a3;
  cursor: pointer;
  height: 20px;
  left: -2px;
  top: -6px;
}

.close {
  position: absolute;
  top: -6px;
  right: -7px;
  background-color: #fff;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  z-index: 5;
  display: none;
}
.close.active {
  display: block;
}
#right-defaults div:focus .close {
  display: block;
}
.focus .nav_des .showBox .modify_box {
  display: block;
}
.del_box {
  position: absolute;
  right: 38px;
  top: -19px;
  background-color: #fff;
  padding: 10px 20px;
  border-radius: 6px;
  z-index: 990;
  border: 1px solid #ccc;
}
.del_box h5 {
  text-align: center;
  color: #333;
  margin-bottom: 10px;
}
.el-button {
  padding: 6px 12px;
}
.sortChunk {
  margin-bottom: 3px;
  margin-top: 3px;
}
.toast {
  position: fixed;
  left: 50%;
  transform: translateX(-50%);
  z-index: 10000;
  color: #fff;
  font-size: 18px;
  line-height: 30px;
  padding: 0 50px;
  background-color: rgba(256, 0, 0, 0.6);
  animation: myfirst 2s;
  -moz-animation: myfirst 2s; /* Firefox */
  -webkit-animation: myfirst 2s; /* Safari and Chrome */
  -o-animation: myfirst 2s; /* Opera */
}
.list-group {
  left: 0;
  position: relative;
  top: 0;
}
.list-group .sortable-chosen {
  opacity: 0.8;
}
.list-group .sortable-ghost {
  opacity: 0.8;
}
.Mask {
  position: fixed;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
  z-index: 10;
}
/* 建议 */
.tips-txt{
  position: absolute;
  color: red;
  top: 40px;
  left: 600px;
}
</style>

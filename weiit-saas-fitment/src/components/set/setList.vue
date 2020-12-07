<template>
    <div class="set_list">
        <div class="contol_group fn-clear">
            <span>添加方式：</span>
            <div class="setChoice">
                <el-radio v-model="addFun" label="manual">手动获取商品</el-radio>
                <el-radio v-model="addFun" label="automatic">自动获取商品</el-radio>
                <!-- <el-radio v-model="addFun" label="automatic">商品分组</el-radio> -->
            </div>
        </div>
        <!-- 商品选项 -->
        <div class="add">
            <div class="contol_group contol_group1 fn-clear" v-if="addFun == 'manual'">
                <span class="add_title" :class="{'hasNo':isMust}">商品：</span>
                <div class="add_main fn-clear">
                    <ul class="seckill_list">
                        <li :key="index" v-for="(item,index) in showGoods">
                            <i class="icon iconfont icon-guanbi" @click="del(index)"></i>
                            <img :src="imageDomaia+item.product_img" alt="" draggable="false"/>
                        </li>
                        <li>
                            <div class="setChoice add_voice" @click="choiceGoods">
                                <i class="icon iconfont icon-jia"></i>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <p v-if="addFun == 'manual' && isMust" class="reminder">请选择商品</p>
            <div class="contol_group contol_group1 fn-clear" v-if="addFun == 'automatic'">
            	<span class="demonstration">显示个数：</span>
                <div class="setChoice">
                    <el-input v-model="showNum" placeholder="最多显示30个" type="number" :max="30" maxlength="2"></el-input>
                </div>
            </div>
        </div>
        <!-- 商品分组选项 -->        
        <!-- <div class="add" v-if="addFun == 'automatic'">
            <div class="contol_group contol_group1 fn-clear">
                <span>商品分组：</span>
                <div class="setChoice">
                    <a href="javascript:;">从商品分组中选择</a>
                </div>
            </div>
            <div class="contol_group fn-clear">
                <span>显示个数：</span>
                <div class="setChoice">
                    <el-input v-model="showNum" class="showNumber"></el-input>
                    <i>最多显示50个</i>
                </div>
            </div>
        </div> -->
        <div class="contol_group fn-clear">
            <span>列表样式：</span>
            <div class="setChoice list">
                <el-radio v-model="listStyle" label="big">大图</el-radio>
                <el-radio v-model="listStyle" label="small">小图</el-radio>
                <el-radio v-model="listStyle" label="zigzag">一大两小</el-radio>
                <el-radio v-model="listStyle" label="detailed">详细列表</el-radio>
                <el-radio v-model="listStyle" label="more" class="last">一行三个</el-radio>
                <el-radio v-model="listStyle" label="scroll">横向滚动</el-radio>
            </div>
        </div>
        <div class="add add1">
            <div class="contol_group contol_group1 fn-clear">
                <span>显示内容：</span>
                <div class="setChoice">
                    <el-checkbox v-model="goodName">商品名称</el-checkbox>
                    <div v-if="goodName && listStyle == 'detailed'" class="des">
                        <el-radio v-model="goodDes" label="des">商品简介</el-radio>
                    </div>
                </div>
            </div>
            <div class="setChoice1">
                <el-checkbox v-model="goodPrice">商品价格</el-checkbox>
            </div>
            <div class="setChoice1 buyBtn" v-if="listStyle == 'big' || listStyle == 'zigzag' || listStyle == 'detailed'">
                <el-checkbox v-model="buyBtn">购买按钮</el-checkbox>
                <div v-if="buyBtn" class="des">
                    <el-radio v-model="btnStyle" label="btn1">样式1</el-radio>
                    <el-radio v-model="btnStyle" label="btn2">样式2</el-radio>
                    <el-radio v-model="btnStyle" label="btn3">样式3</el-radio>
                    <el-radio v-model="btnStyle" label="btn4" class="last">样式4</el-radio>
                </div>
                <el-input v-model="btnTxt3" placeholder="马上抢" v-if="btnStyle == 'btn3' && buyBtn" class="btn_txt" maxlength="4"></el-input>
                <el-input v-model="btnTxt4" placeholder="购买" v-if="btnStyle == 'btn4' && buyBtn" class="btn_txt" maxlength="4"></el-input>
                <div class="tips1" v-if="(btnStyle == 'btn3' || btnStyle == 'btn4')  && buyBtn">
                    <el-tooltip class="item" effect="light" content="自定义购买按钮文案，最多输入四个字" placement="top" >
                        <i class="icon iconfont icon-iconfontwenhao1"></i>
                    </el-tooltip>
                </div>
            </div>
            <div class="setChoice1">
                <el-checkbox v-model="cornerMark">商品角标</el-checkbox>
                <div v-if="cornerMark" class="des">
                    <el-radio v-model="corner" label="new">新品</el-radio>
                    <el-radio v-model="corner" label="hot">热卖</el-radio>
                    <el-radio v-model="corner" label="news">NEW</el-radio>
                    <el-radio v-model="corner" label="hots">HOT</el-radio>
                    <!-- <el-radio v-model="corner" label="auto" class="last">自定义</el-radio> -->
                </div>
            </div>
        </div>
        <p class="tips">*小程序仅支持显示非分销的实物、虚拟、电子卡券商品</p>
        <!-- 商品选择弹出窗 -->
        <div class="goodChoiceBox" v-if="isGood">
            <div class="goodChoice">
                <i class="icon iconfont icon-cha" @click="isGood = false"></i>
                <div class="head fn-clear">
                    <span class="title">选择商品</span>
                    <!--<div class="selectSort">
                        <el-select v-model="value8" filterable placeholder="请选择" class="selectbox">
                            <el-option
                            v-for="item in options"
                            :key="item.group_id"
                            :label="item.group_name"
                            :value="item.group_id" @change="changeValue">
                            </el-option>
                        </el-select>
                    </div>-->
                    <div class="searchBox">
                        <el-input v-model="searchtitle" placeholder="请输入标题" class="search_box"></el-input>
                        <a href="javascript:;" class="search_btn" @click="searchGoods">搜索</a>
                    </div>
                </div>
                <el-table
                    ref="multipleTable"
                    :data="tableGoods"
                    tooltip-effect="dark"
                    @selection-change="handleSelectionChange">
                    <el-table-column width="30"
                        type='selection'>
                    </el-table-column>
                    <el-table-column 
                        prop="product_img" 
                        width="70">
                        <template slot-scope="scope">
                            <img :src="imageDomaia + scope.row.product_img" alt="" width="50" height="50" draggable="false">
                        </template>
                    </el-table-column>
                    <el-table-column width="280"
                        prop="product_name"
                        label="商品">
                    </el-table-column>
                    <el-table-column width="80"
                        sortable
                        prop="sale_price"
                        label="价格"
                        align="center">
                    </el-table-column>
                    <el-table-column width="80"
                        sortable
                        prop="stock"
                        label="库存"
                        align="center">
                    </el-table-column>
                    <el-table-column width="80"
                        sortable
                        prop="sale_count"
                        label="销量"
                        align="center">
                    </el-table-column>
                </el-table>
                <div class="pages fn-clear">
                    <div class="block">
                        <el-pagination
                            @current-change="handleCurrentChange"
                            :current-page.sync="currentPage"
                            :page-size="pagesize"
                            layout="total, prev, pager, next, jumper"
                            :total="total">
                        </el-pagination>
                    </div> 
                    <a class="ensure_btn" @click="ensure()">确定</a>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import {mapState,mapMutations} from 'vuex';
    export default {
        props:['pageParam'],
        data() {
            return {
                addFun: 'manual',
                showNum:'',
                listStyle:'big',
                goodName:true,
                goodDes:'des',
                goodPrice:true,
                buyBtn:true,
                btnStyle:'btn1',
                cornerMark:true,
                corner:'new',
                // 按钮样式3时候文字
                btnTxt3:'马上抢',
                // 按钮样式4时候文字                
                btnTxt4:'购买',
                // 商品选择框判断值
                isGood:false,
                // 下拉框数据
                options: [],
                value8: '',
                multipleSelection: [],
                // 搜索关键词
                searchtitle:'',
                // 表格显示当前页数据
                tableGoods:[],
                //默认每页数据量
                pagesize: 5,
                //当前页码
                currentPage: 1,
                // 传递展示选择内容
                showGoods:[],
                
                // 图片前缀名
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                productIds:[],
                total:0,
                isSearch:false
            }
        },
        updated(){
            console.log(this.productIds);
            var list = {
               addFun: this.addFun,
               showNum: this.showNum,
                // 列表样式
                listStyle: this.listStyle,
                // 商品名称状态 boolean
                goodName: this.goodName,
                 // 商品描述状态 boolean
                goodDes: this.goodDes,
                // 商品价格 boolean
                goodPrice: this.goodPrice,
                // 按钮状态 boolean
                buyBtn: this.buyBtn,
                // 按钮样式
                btnStyle: this.btnStyle,
                // 角标 boolean
                cornerMark: this.cornerMark,
                // 角标样式
                corner: this.corner,
                // 角标3文字
                btnTxt3: this.btnTxt3,
                // 角标4文字
                btnTxt4: this.btnTxt4,
                // 商品展示列表
                showGoods: this.showGoods,
                // 商品id
                productIds:this.productIds
            }
            this.$emit('event', list);
        },
        methods:{
            ...mapMutations(['noState', 'changeState', 'startSort', 'stopSort']),
            // 表格计算获取选择的内容
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            //选择分页
            handleCurrentChange(val) {
            	if(this.isSearch){
            		this.$ajax({
	                    methods:'get',
	                    url:'/center/product/productListForPage',
	                    params:{
	                        page:val,
	                        rows:5
	                    }
	               }).then(res => {
	                	let productList = res.data.productList;
	                    this.tableGoods = productList.list;
	                    this.total = productList.total;
	                }).catch(err => {
	                    (err);
	                })
            	}else{
            		this.$ajax({
	                    methods:'get',
	                    url:'/center/product/productListForPage',
	                    params:{
	                    	product_name: this.searchtitle,
	                        page:val,
	                        rows:5
	                    }
	               }).then(res => {
	                	let productList = res.data.productList;
	                    this.tableGoods = productList.list;
	                    this.total = productList.total;
	                }).catch(err => {
	                    (err);
	                })
            	}
            	
            },
            //从服务器读取数据
            loadData(){
                this.$ajax({
                    methods:'get',
                    url:'/center/product/productListForPage',
                    params:{
                        page:1,
                        rows:5
                    }
                }).then(res => {
                	let productList = res.data.productList;
                    this.tableGoods = productList.list;
                    this.total = productList.total;
                }).catch(err => {
                    (err);
                })
            },
            // 确定选择内容
            ensure(){
                this.isGood = false;
                this.multipleSelection.forEach((item) => {
                    this.showGoods.push(item);
                    this.productIds.push(item.product_id);
                })
                if(this.productIds.length > 0){
                    this.noState();
                }
            },
            choiceGoods(){
                // this.$refs.multipleTable.clearSelection();
                this.isGood = true;
            },
            // 删除选项
            del(index){
                this.productIds.splice(index,1);
                this.showGoods.splice(index,1);
                if(this.productIds.length == 0){
                    this.changeState();
                }
            },
            // 搜索商品列表
            searchGoods(){
            	this.isSearch = true;
            	this.currentPage = 1;
                this.$ajax({
                    methods:'get',
                    url:'/center/product/productListForPage',
                    params:{
                        product_name: this.searchtitle,
                        page:1,
                        rows:5
                    }
                }).then(res => {
                    let productList = res.data.productList;
                    this.tableGoods = productList.list;
                    this.total = productList.total;
                }).catch(err => {
                    (err);
                })
            },
            // sortGoods(){
            //     this.$ajax({
            //         methods:'get',
            //         url:'/center/product/getProductListByIds'
            //     }).then(res => {
            //         this.showGoods = res.data.productInfo;
            //     }).catch(err => {
            //         (err);
            //     })
            // },
            changeValue(val){
            },
            // 初始化数据
            initData(){
                this.addFun = this.pageParam.addFun;
                this.showNum = this.pageParam.showNum;
                this.btnStyle = this.pageParam.btnStyle;
                this.btnTxt3 = this.pageParam.btnTxt3;
                this.buyBtn = this.pageParam.buyBtn;
                this.corner = this.pageParam.corner;
                this.cornerMark = this.pageParam.cornerMark;
                this.goodDes = this.pageParam.goodDes;
                this.goodName = this.pageParam.goodName;
                this.goodPrice = this.pageParam.goodPrice;
                this.listStyle = this.pageParam.listStyle;
                if(this.pageParam.productIds.length > 0 && this.pageParam.productIds){
                	this.productIds = this.pageParam.productIds;
                }else{
                	this.productIds = [];
                }
                if(this.pageParam.addFun == 'manual'){
                    if(this.productIds.length == 0){
                        this.showGoods = [];
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/product/getProductListByIds',
                            params:{
                                productIds:JSON.stringify(this.productIds),
                                productGetType:0
                            }
                        }).then(res => {
                            
                            this.showGoods = res.data.productInfo;
                        }).catch(err => {
                            (err);
                        })
                    }
                }
            }
        },
        computed:{
            ...mapState(['isMust'])
        },
        mounted(){
            this.loadData();
            // this.sortGoods();
            this.initData();
        },
        watch:{
            isGood:function(curVal,oldVal){
                if(!curVal){
                	
                    this.startSort()
                }else{
                    this.stopSort()
                }
            },
            addFun:function(curVal, oldVal){
                if(curVal != oldVal){
                    this.productIds = [];
                    this.showGoods = [];
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
        margin-top: 4px;
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
    .add ul li{
        width: 50px;
        height: 50px;
        float: left;
        margin-right: 7px;
        margin-bottom: 7px;
    }
    .add ul li img{
        width: 100%;
        height: 100%;
    }
    .add1{
        margin-top: 12px;
    }
    .add .setChoice{
        width: 285px;
    }
    .add .setChoice .last{
        margin-left: 0;
        margin-top: 5px;
    } 
    .add .contol_group1{
        margin-top: 0;
    }
    .add .contol_group span{
        float: left;
        width:69px; 
    }
    .demonstration1{
        margin-top: 10px;
    }
    .tips{
        color: #666;
        font-size: 12px;
        margin-top: 10px;
        padding-left: 8px;
    }
    .add .add_voice{
        width: 53px;
        height: 53px;
        box-sizing: border-box;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 53px;
        cursor: pointer;
    }
    .add .add_voice .icon{
        font-size: 20px;
        color: #3388ff;
    }
    .addTips{
        margin-top: 8px;
        margin-left: 79px;
        color: #666;
    }
    .list{
        width:300px;
    }
    .list .el-radio+.el-radio{
        margin-left: 8px;
        margin-bottom: 5px;
    }

    .des{
        margin-left: 25px;
        margin-top: 5px;
    }
    .setChoice1{
        margin-left: 80px;
        margin-top: 5px;
    }
    .setChoice1 .el-radio+.el-radio{
        margin-left: 8px;
        margin-top: 5px;
    }
    .set_list .add .el-radio+.el-radio.last,
    .set_list .list .el-radio+.el-radio.last{
        margin-left: 0;
    }
    .showNumber{
        width: 70px;
        margin-right: 10px;
    }
    .setChoice input{
        height: 30px;
        line-height: 30px;
    }
    .setChoice i{
        font-style: normal;
    }
    .btn_txt{
        width: 90px;
        margin-left: 25px;
        margin-top: 8px;
    }
    .icon-iconfontwenhao1{
        font-size: 16px;
        color: #999;
    }
    .tips1{
        position: absolute;
        bottom: 107px;
        right: 172px;
    }
        /* 物品选择弹窗 */
    .goodChoiceBox{
        position: fixed;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
        z-index: 9999;
        background-color: rgba(0,0,0,.3);
    }
    .goodChoice{
        position: absolute;
        width: 620px;
        background-color: #fff;
        border-radius: 8px;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
    }
    .goodChoice .icon-cha{
        position: absolute;
        right: 8px;
        top: 8px;
        font-size: 16px;
        color: #ccc;
        cursor: pointer;
    }
    .goodChoice .icon-cha:hover{
        color: #333;
    }
    .goodChoice .head .title,
    .goodChoice .head .selectSort,
    .goodChoice .head .searchBox{
        float: left;
    }
    .goodChoice .head .title{
        margin-left: 15px;
        line-height: 30px;
        font-size: 14px;
        color: #333;
    }
    .goodChoice .head{
        padding:10px 0;
    }
    .goodChoice .head .selectSort{
        margin-left:20px;
        margin-right: 10px;
    }
    .search_box{
        width: 150px;
    }
    .selectbox{
        width: 150px;
    }
    .search_btn{
        display: inline-block;
        padding:0 20px;
        border: 1px solid #ddd;
        border-radius: 3px;
        line-height: 28px;
        height: 30px;
        box-sizing: border-box;
    }
    /* 分页 */
    .pages{
        padding: 10px 10px 10px 10px;
    }
    .block{
        float: left
    }
    .ensure_btn{
        float: right;
        background-color: #38f;
        color: #fff;
        border-radius: 6px;
        font-size: 12px;
        line-height: 30px;
        padding: 0 10px;
        border:none 0;
        cursor: pointer;
    }
    .ensure_btn:focus{
        border:none 0;
    }
    .add_title{
        float: left;
        margin-right: 10px;
    }
    .hasNo{
        color: #f44;
    }
    .add_main{
        float:left;
        width: 286px;
    }
    .add_main ul,
    .add_main div.add_voice{
        float: left;
    }
    /* 右侧展示选中图片 */
    .seckill_list{
        
        float: left;
    }
    .seckill_list li{
        position: relative;
        width: 78px;
        height: 78px;
        float: left;
        margin-right: 5px;
        margin-bottom: 5px;
        box-sizing: border-box;
        z-index: 20;
        cursor: pointer;
    }
    .seckill_list li:hover .icon-guanbi{
        display: block;
    }
    .seckill_list li img{
        width: 78px;
        height: 78px;
        box-sizing: border-box;
        border: 1px solid #ddd;
    }
    .add_voice{
        width: 78px;
        height: 78px;
        box-sizing: border-box;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 78px;
        float: left;
        cursor: pointer;
        
    }
    .icon-guanbi{
        position: absolute;
        display: block;
        font-size: 16px;
        color: #a3a3a3;
        cursor: pointer;
        right: 0;
        top: -5px;
        cursor: pointer;
        display: none;
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        padding-left: 78px;
        font-size: 12px;
    }
    .searchBox{
    	margin-left: 10px;
    }
</style>
<template>
    <div class="goodChoiceBox" v-show="isSeckill">
        <div class="goodChoice">
            <i class="icon iconfont icon-cha" @click="isSeckill = false"></i>
            <div class="head fn-clear">
                <span class="title" v-if="parentComponent == 'fight'">选择拼团活动</span>
                <span class="title" v-if="parentComponent == 'bargain'">选择砍价活动</span>
                <div class="search_box fn-clear inputBtn">
                    <input type="text" placeholder="输入文件名" v-model="searchTxt">
                    <button @click="searchGoods">搜索</button>
                </div>
            </div>
            <el-table
                ref="multipleTable"
                :data="tableGoods"
                tooltip-effect="dark"
                @selection-change="handleSelectionChange">
                <el-table-column 
                    type='selection' width="50">
                </el-table-column>
                <el-table-column 
                    prop="product_img" 
                    width="80">
                    <template slot-scope="scope">
                        <img :src="imageDomaia + scope.row.product_img" alt="" width="60" height="60" draggable="false">
                    </template>
                </el-table-column>
                <el-table-column
                    prop="product_name"
                    label="商品">
                </el-table-column>
            </el-table>
            <div class="pages fn-clear">   
                <div class="block">
                    <el-pagination
                        @current-change="handleCurrentChange"
                        :current-page.sync="currentPage"
                        :page-size="pagesize"
                        layout="total, prev, pager, next, jumper"
                        :pager-count="5"
                        :total="tableData.length">
                    </el-pagination>
                </div> 
                <a href="javascript:;" class="ensure" @click="ensure()">确定</a>
            </div>
        </div>
    </div>
</template>

<script>
    import {mapMutations} from 'vuex'
    export default {
        props:['parentComponent'],
        data() {
            return {
                isSeckill: false,
                searchtitle:'',
                // 选中的商品
                multipleSelection: [],
                // 表格显示当前页数据
                tableGoods:[],
                //后台商品总数据
                tableData: [],
                //默认每页数据量
                pagesize: 3,
                //当前页码
                currentPage: 1,
                // 图片前缀地址
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                // 选中传递的商品
                seckillGoods:[],
                // 搜索词
                searchTxt:'',
                groupon_ids:[],
                bargain_ids:[]
                
            }
        },
        methods: {
            ...mapMutations(['startSort']),
            // 表格计算获取选择的内容
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            handleCurrentChange(val) {
                // val =1 0~4 val=2 5~9
                this.tableGoods=this.tableData.slice((val-1)*this.pagesize,val*this.pagesize);
            },
            // 确定选择内容
            ensure(){
                this.isSeckill = false;
                this.multipleSelection.forEach((item) => {
                    this.groupon_ids.push(item.groupon_id);
                    this.bargain_ids.push(item.bargain_id)
                })
                if(this.parentComponent == 'fight'){
                    this.$emit('choice', this.groupon_ids);
                }else if(this.parentComponent == 'bargain'){
                    this.$emit('choice', this.bargain_ids);
                }
            },
            // 弹出框展示
            show() {
                this.$refs.multipleTable.clearSelection();
                this.isSeckill = true
                this.groupon_ids = [];
                this.bargain_ids = [];
            },
            // 获取总的数据
            getTabs(){
                if(this.parentComponent == 'fight'){
                    // 拼团数据
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/activityProductList',
                        params:{
                            activityType:2
                        }
                    }).then(res => {
                        this.tableData = res.data.activityProductList;
                    }).catch(err => {
                        (err);
                    })
                }else if(this.parentComponent == 'bargain'){
                    // 砍价数据
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/activityProductList',
                        params:{
                            activityType:1
                        }
                    }).then(res => {
                        this.tableData = res.data.activityProductList;
                    }).catch(err => {
                        (err);
                    })
                }
                
            },
            // 获取单页数据
            getGoods(){
                if(this.parentComponent == 'fight'){
                    // 拼团数据
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/activityProductList',
                        params:{
                            activityType:2,
                            page:1,
                            rows:3
                        }
                    }).then(res => {
                        this.tableGoods = res.data.activityProductList;
                    }).catch(err => {
                        (err);
                    })
                }else if(this.parentComponent == 'bargain'){
                    // 砍价数据
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/activityProductList',
                        params:{
                            activityType:1,
                            page:1,
                            rows:3
                        }
                    }).then(res => {
                        this.tableGoods = res.data.activityProductList;
                    }).catch(err => {
                        (err);
                    })
                }
            },
            // 搜索商品
            searchGoods(){
                this.$ajax({
                    methods:'get',
                    url:'/center/ump/activityProductList',
                    params:{
                        activityType:1,
                        page:1,
                        rows:3,
                        product_name: this.searchTxt
                    }
                }).then(res => {
                    this.tableGoods = res.data.activityProductList;
                }).catch(err => {
                    (err);
                })
            }
        },
        mounted(){
            this.getTabs();
            this.getGoods();
        },
        watch:{
            isSeckill:function(curVal,oldVal){
                if(!curVal){
                    this.startSort();
                }
            }
        }
    }
</script>

<style scoped>
    /* 秒杀商品弹出框 */
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
        width: 600px;
        background-color: #fff;
        border-radius: 8px;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
        overflow: hidden;
    }
    /* 弹出框头部 */
    .goodChoice .head{
        height: 30px;
        padding: 10px 15px;
    }
    .goodChoice .head span.title{
        float: left;
        margin-right: 30px;
        line-height: 30px;
        font-size: 14px;
        color: #333;
    }
    .goodChoice .head div.search_box{
        float: left;
        width: 300px;
    }
    div.search_box input,
    div.search_box button{
        float: left;
        border:1px solid #ddd;
        
    }
    div.search_box input{
        width: 153px;
        padding: 5px 10px;
        line-height: 18px;
        height: 18px;
        border-right: none 0;
        border-radius: 5px 0 0 5px;
    }
    div.search_box button{
        display: block;
        height: 30px;
        line-height: 30px;
        padding: 0 10px;
        background-color: #fff;
        cursor: pointer;
        border-radius: 0 5px 5px 0;
    }
    div.search_box button:hover{
        background-color: #e6e6e6;
        border-color: #adadad;
    }
    /* 删除按钮 */
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
    /* 选择主体内容 */
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
        padding:8px 20px;
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
    .goodChoice .tabPic img{
        width: 60px;
        height: 60px;
    }
</style>
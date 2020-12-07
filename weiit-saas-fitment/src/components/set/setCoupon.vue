<template>
    <div class="set_coupon">
        <div class="contol_group fn-clear">
            <span>添加方式：</span>
            <div class="setChoice">
                <el-radio v-model="addFun" label="manual">手动获取</el-radio>
                <el-radio v-model="addFun" label="automatic" @change="autoChoice">自动获取</el-radio>
            </div>
        </div>
        <div class="coupon_list" v-if="addFun == 'manual'">
            <ul>
                <li class="add" v-for="(item,index) in showGoods">
                    <i class="icon iconfont icon-guanbi" @click="del(index)"></i>
                    优惠券：{{item.coupon_name}}(满{{item.condition_price}}元{{item.coupon_discount}}折)
                </li>
            </ul>
        </div>
        <div class="add add1" v-if="addFun == 'manual'" @click="addCoupon()">
            <p><i class="icon iconfont icon-jia"></i> 添加优惠券</p>
        </div>
        <div class="add" v-if="addFun == 'automatic'">
            <div class="contol_group fn-clear">
                <span>券活动数：</span>
                <div class="setChoice">
                	<input type="text" class="showNum" v-model="showNum" placeholder="请输入显示的券活动数">
                    <!--<el-radio v-model="couponChoice" label="all">全部</el-radio>
                    <el-radio v-model="couponChoice" label="automatic">
                        <input type="text" v-model="showNum" placeholder="请输入显示的券活动数">
                    </el-radio>-->
                </div>
            </div>
        </div>
        <p v-if="addFun == 'manual'" class="tips">最多添加10张优惠券</p>
        <p v-if="isMust && addFun == 'manual'" class="reminder">请选择优惠券</p>
        <div class="contol_group fn-clear">
            <span>更多设置：</span>
            <div class="setChoice">
                <el-checkbox v-model="hideCoupon">隐藏已抢完券</el-checkbox>
                <i>勾选后不显示已抢完的优惠券</i>
            </div>
        </div>
        <div class="coupon_win" v-show="isOk">
            <div class="show_box">
                <div class="head fn-clear">
                    <span class="title">优惠券</span>
                    <i class="icon iconfont icon-cha" @click="isOk=false"></i>
                </div>
                <!-- <div class="setting fn-clear">
                    <div class="btn_box">
                        <a href="javascript:;" class="create">新建</a>
                        <a href="javascript:;" class="refresh" @click="refresh()">刷新</a>
                    </div>
                    <div class="search">
                        <i class="icon iconfont icon-sousuo1"></i>
                        <input type="text" v-model="searchTxt">
                        <i class="icon iconfont icon-guanbi" v-show="searchTxt != ''" @click="searchTxt=''"></i>                        
                    </div>
                </div> -->
                <div class="tabs">
                    <el-table
                        ref="multipleTable"
                        :data="tableGoods"
                        tooltip-effect="dark"
                        style="width: 100%"
                        @selection-change="handleSelectionChange">
                        <el-table-column
                        type="selection"
                        width="55">
                        </el-table-column>
                        <el-table-column
                        prop="coupon_name"
                        label="名称"
                        show-overflow-tooltip>
                        </el-table-column>
                        <el-table-column
                        label="价值"
                        prop="coupon_value">
                        </el-table-column>
                        <el-table-column
                        prop="coupon_condition"
                        label="使用条件"
                        show-overflow-tooltip>
                        </el-table-column>
                        <el-table-column
                        prop="startTime"
                        label="创建时间">
                        </el-table-column>
                    </el-table>
                </div>
                <div class="pages">
                    <span class="choiceNum">
                        已选择{{multipleSelection.length}}个
                    </span>
                    <div class="block">
                        <el-pagination
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page.sync="currentPage"
                        :page-size="pagesize"
                        :pager-count="5"
                        layout="total, prev, pager, next, jumper"
                        :total="couponList.length">
                        </el-pagination>
                    </div>
                    <a href="javascript:;" class="ensure" @click="choicePic()">确定</a>
                </div>
            </div>
        </div>
        <p class="tips tips1">当页面无可显示的优惠券时，优惠券区块将隐藏</p>
    </div>
</template>

<script>
    // 引入时间计算
    import {getTime} from '../../../static/js/getTime.js'
    import {mapState,mapMutations} from 'vuex'
    export default {
         props:['pageParam'],
        data() {
            return {
                addFun: 'manual',
                hideCoupon:true,
                showNum:'',
                searchTxt:'',
                tableData: [],
                multipleSelection: [],
                currentPage:1,
                tableGoods:[],
                isOk:false,
                pagesize:8,
                showGoods:[],
                coupon_ids: [],
                couponList:[]
            }
        },
        methods: {
            ...mapMutations(['noState','changeState','stopSort','startSort']),
            // 点击展示弹出框
            addCoupon() {
                this.getAllCoupons();
                this.$refs.multipleTable.clearSelection();
                this.isOk=true;
                
            },
            // 跳转页数
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            // 确认选择
            choicePic(){
            	
                this.isOk = false;
                let _this = this;
                this.multipleSelection.forEach((item) => {
                	if(_this.showGoods.length > 0){
                		_this.showGoods.forEach((ele) => {
	                		if(item.coupon_id != ele.coupon_id){
	                			_this.showGoods.push(item);
	                			_this.showGoods.forEach((item) => {
				                    _this.coupon_ids.push(item.coupon_id);
				                })
	                		}
	                	})
                	}else{
                		_this.showGoods.push(item);
                		_this.showGoods.forEach((item) => {
		                    _this.coupon_ids.push(item.coupon_id);
		                })
                	}
                })
                if(this.showGoods.length >= 10){
                    this.showGoods.length = 10;
                }
                if(this.showGoods.length > 0){
                    this.noState();
                }else{
                    this.changeState();
                }
				
            },
            // 计算当前页面展示数据
            handleCurrentChange(val) {
                // val =1 0~4 val=2 5~9
                this.tableGoods=this.couponList.slice((val-1)*this.pagesize,val*this.pagesize);
            },
            handleSizeChange(){

            },
            //获取全部优惠券数据
            getAllCoupons(){
                this.$ajax({
                    methods:'get',
                    url:'/center/ump/coupons/getCouponList'
                }).then(res => {
                    // console.log(res);
                    this.couponList = res.data.couponList.filter(item => item.state == 1);
                    console.log(this.couponList);
            		this.couponList.forEach((item) => {
                        switch(item.type){
                            case 1:
                                item.coupon_value = item.coupon_price + '元';
                                break;
                            case 2:
                                item.coupon_value = item.coupon_discount + '折';
                                break
                        }
                        switch(item.is_condition){
                            case -1:
                                item.coupon_condition = '无条件';
                                break;
                            case 1:
                                item.coupon_condition = '满' + item.condition_price + '元可用';
                                break;
                        }
                        item.startTime = getTime(item.create_time)
                    })
                    this.tableGoods = this.couponList.slice(0,8);
                }).catch(err => {
                    (err);
                })
            },
            // 刷新数据
            refresh(){
                this.getCoupons();
            },
            // 删除选中的优惠券
            del(index){
                this.showGoods.splice(index,1);
                if(this.showGoods.length == 0){
                    this.changeState()
                }
            },
            // 切换到自动获取
            autoChoice(val){
                if(val == 'automatic'){
                    this.coupon_ids = [];
                    this.showGoods = [];
                    let coupon = {
                        addFun: this.addFun,
                        coupon_ids:this.coupon_ids,
                        showNum: parseInt(this.showNum),
                        hideCoupon:this.hideCoupon
                    }
                    this.$emit('event', coupon);
                }
                
            },
            // 传递数据
            setData(){
                var coupon = {
                    addFun: this.addFun,
                    coupon_ids:this.coupon_ids,
                    showNum:parseInt(this.showNum),
                    hideCoupon:this.hideCoupon
                }
                this.$emit('event', coupon);
            },
            // 初始化数据
            initData(){
                this.addFun = this.pageParam.addFun;
                this.coupon_ids = this.pageParam.coupon_ids;
                if(this.addFun == 'manual'){
                    if(this.coupon_ids.length == 0){
                        this.showGoods = []
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/ump/coupons/couponListByIds',
                            params:{
                                coupon_ids:this.coupon_ids,
                                couponGetType: 0
                            }
                        }).then(res => {
                            this.showGoods = res.data.data;
                        }).catch(err => {
                            (err);
                        })
                    }
                }
            }
        },
        updated(){
            this.setData();
        },
        computed:{
            ...mapState(['isMust'])
        },
        watch:{
            isOk:function(curVal,oldVal){
                if(!curVal){
                    this.startSort();
                }else{
                    this.stopSort();
                }
            },
            addFun:function(curVal,oldVal){
                if(curVal != oldVal){
                    this.coupon_ids = [];
                    this.couponList = [];
                }
            }
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
    .setChoice i{
        font-style: normal;
        font-size: 12px;
        color: #999;
    }
    .add{
        width: 388px;
        background-color: #fff;
        padding: 10px;
        box-sizing: border-box;
        border:1px solid #ddd;
        border-radius: 4px;
        margin:17px auto 0;
        cursor: pointer;
    }
    .add .setChoice .last{
        margin-left: 0;
        margin-top: 5px;
    } 
    .add .contol_group{
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
        margin-top: 10px;
        padding-left: 8px;
        color: #999;
        font-size: 12px;
    }
    .tips1{
        padding-left: 50px;
    }
    .add .add_voice{
        width: 53px;
        height: 53px;
        box-sizing: border-box;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 53px;
        
    }
    .add .add_voice .icon{
        font-size: 20px;
        color: #3388ff;
    }
    .no_share{
        padding-left: 78px;
    }
    /* 优惠券选择弹窗 */
    .coupon_win{
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,.5);
        z-index: 9999;
    }
    .show_box{
        position: absolute;
        left: 50%;
        top: 50%;
        width: 810px;
        padding: 20px;
        padding-bottom: 0;
        background-color: #fff;
        border-radius: 4px;
        transform: translate(-50%,-50%);
    }
    /* 弹框头部信息 */
    .show_box .head{
        padding-bottom: 10px;
        border-bottom: 1px solid #e5e5e5;
        /* margin-bottom: 20px; */
    }
    .show_box .head .title{
        float: left;
        color: #333;
        font-size: 14px;
        font-weight: 700;
    }
    .show_box .head .icon-cha{
        float: right;
        color: #ddd;
        font-size: 12px;
        cursor: pointer;
    }
    .setting{
        margin-bottom: 10px;
    }
    /* 按钮输入框 */
    .btn_box{
        float: left;
    }
    .btn_box a{
        display: inline-block;
        background-color: #fff;
        border: 1px solid #bbb;
        font-size: 12px;
        color: #333;
        line-height: 30px;
        padding: 0 10px;
        margin-right: 10px;
    }
    .search{
        position: relative;
        float: right;
    }
    .search input{
        line-height: 30px;
        height: 30px;
        padding:0 27px;
        font-size: 12px;
        color: #333;
        border: 1px solid #bbb; 
        min-width: 80px;
    }
    .search .icon{
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
    }
    .icon-sousuo1{
        left: 8px;
        color: #333;
        font-weight: 700;
    }
    .icon-guanbi{
        right: 13px;
        cursor: pointer;
    }
    /* 底部分页 */
    .pages{
        position: relative;
        background-color: #f9f9f9;
        padding: 10px 15px;
        height: 30px;
    }
    .choiceNum{
        float: left;
        margin-right: 20px;
        line-height: 30px;
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
    .coupon_list ul li.add{
        position: relative;
        border-style: dotted;
        cursor: default;
    }
    .coupon_list ul li .icon{
        position: absolute;
        right: -10px;
        top: -15px;
        font-size: 20px;
        color: #bbb;;
        cursor: pointer;
        display: none;
    }
    .coupon_list ul li:hover .icon{
        display: block;
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        padding-left: 8px;
        font-size: 12px;
    }
</style>
<template>
    <div class="showBox">
        <div class="good_sort blankShow">
            <!-- 当导航在顶部时 -->
            <div class="sort_top" v-if="navPos == 'top'">
                <!-- 导航 -->
                <div class="sort_nav" v-if="navShow == 'yes'">
                    <ul>
                        <li v-for="(item,index) in orderListName" :class="{'current':index==0}">
                            {{item.group_name}}
                        </li>
                    </ul>
                </div>
                <!-- 商品列表 -->
                <div class="goods_list">
                    <ul class="fn-clear" :class="[{'goodBig':goodStyle == 'big'},{'matrix':goodStyle == 'matrix'},{'list':goodStyle == 'list'}]" v-if="goodsList.length == 0">
                        <li>
                            <good :goods="goods" :item="'none'"></good>
                        </li>
                        <li>
                            <good :goods="goods" :item="'none'"></good>
                        </li>
                        <li>
                            <good :goods="goods" :item="'none'"></good>
                        </li>
                        <li>
                            <good :goods="goods" :item="'none'"></good>
                        </li>
                    </ul>
                    <ul class="fn-clear" :class="[{'goodBig':goodStyle == 'big'},{'matrix':goodStyle == 'matrix'},{'list':goodStyle == 'list'}]" v-else>
                        <li v-for="item in goodsList">
                            <good :goods="goods" :item="item"></good>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- 当导航在左侧时 -->
            <div class="sort_left fn-clear" v-if="navPos == 'left'">
                <!-- 导航 -->
                <div class="sort_nav" v-if="navShow == 'yes'">
                    <ul v-if="orderListName.length == 0">
                        <!-- <li v-for="(item,index) in sortValue" :class="{'current':index==0}">{{item}}</li> -->
                        <li class="current">商品组一</li>
                        <li>商品组二</li>
                        <li>商品组三</li>
                        <li>商品组四</li>
                    </ul>
                    <ul v-else>
                        <li v-for="(item,index) in orderListName" :class="{'current':index==0}">{{item.group_name}}</li>
                    </ul>
                </div>
                <!-- 商品列表 -->
                <div class="goods_list">
                    <ul v-if="orderListName.length == 0">
                        <li>
                            <h6>商品组一</h6>
                            <dl>
                                <dd>
                                    <goods :item="'none'"></goods>
                                </dd>
                                <dd class="last">
                                    <goods :item="'none'"></goods>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <h6>商品组二</h6>
                            <dl>
                                <dd>
                                    <goods :item="'none'"></goods>
                                </dd>
                                <dd class="last">
                                    <goods :item="'none'"></goods>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <h6>商品组三</h6>
                            <dl>
                                <dd>
                                    <goods :item="'none'"></goods>
                                </dd>
                                <dd class="last">
                                    <goods :item="'none'"></goods>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <h6>商品组四</h6>
                            <dl>
                                <dd>
                                    <goods :item="'none'"></goods>
                                </dd>
                                <dd class="last">
                                    <goods :item="'none'"></goods>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                    <ul v-for="(item,index) in orderListName" :class="{'current':index==0}"  v-else>
                        <li>
                            <h6>{{item.group_name}}</h6>
                            <dl v-if="goodsList.length == 0">
                                <dd>
                                    <goods :item="'none'"></goods>
                                </dd>
                                <dd class="last">
                                    <goods :item="'none'"></goods>
                                </dd>
                            </dl>
                            <dl v-if="goodsList.length > 0">
                                <dd v-for="ele in goodsList.slice(0,2)">
                                    <goods :item="ele"></goods>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- 设置分组 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-sort @event="getData" :pageParam="pageParam"></set-sort>
        </div> 
    </div>
</template>

<script>
    // 设置分组
    import setSort from '@/components/set/setSort'
    // 设置头部
    import headModify from '@/components/common/headModify'
    // 引入顶部商品组件
    import good from '@/components/common/good';
    // 引入左侧商品组件
    import goods from '@/components/common/goods';
    import List from '../../../static/js/List'
    import {mapActions} from 'vuex'
    export default {
        props:{
            keyText:String,
            tempId:Number,
            keyWords:String,
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        navPos:'top',
                        sortChose:'',
                        showNum:'',
                        sortOrder:'sale',
                        goodStyle:'big',
                        checkedBuyBtn:true,
                        checkedPrice:true,
                        checkedSummary:true,
                        checkedGoodName:true,
                        btnStyle: 'button1',
                        isFill:'yes',
                        btnTxt3:'马上抢',
                        btnTxt4:'购买',
                        options:[],
                        orderListName:[],
                        goodsList:[],
                        navShow:"yes"
                    }
                }
            }
        },
        data() {
            return {
                navPos:'top',
                sortChose:'',
                showNum:'',
                sortOrder:'sale',
                goodStyle:'big',
                checkedBuyBtn:true,
                checkedPrice:true,
                checkedSummary:true,
                checkedGoodName:true,
                btnStyle: 'button1',
                // isFill:'yes',
                btnTxt3:'马上抢',
                btnTxt4:'购买',
                options:[],
                count:2,
                group_ids:[],
                orderListName:[],
                goodsList:[],
                leftGoodsList:[],
                navShow:'yes'
            }
        },
        computed:{
            goods(){
                var good = {
                    'goodStyle':this.goodStyle,
                    'checkedGoodName':this.checkedGoodName,
                    'checkedPrice':this.checkedPrice,
                    'checkedBuyBtn':this.checkedBuyBtn,
                    'btnStyle':this.btnStyle,
                    'btnTxt3':this.btnTxt3,
                    'btnTxt4':this.btnTxt4,
                    
                }
                return good
            }
        },
        components:{
            good,
            goods,
            headModify,
            setSort
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(good){
                this.navPos = good.navPos;
                this.sortChose = good.sortChose;
                this.showNum = good.showNum ? good.showNum : 20;
                this.sortOrder = good.sortOrder;
                this.goodStyle = good.goodStyle;
                this.checkedBuyBtn = good.checkedBuyBtn;
                this.checkedPrice = good.checkedPrice;
                this.checkedSummary = good.checkedSummary;
                this.checkedGoodName = good.checkedGoodName;
                this.btnStyle = good.btnStyle;
                this.isFill = good.isFill;
                this.btnTxt3 = good.btnTxt3;
                this.btnTxt4 = good.btnTxt4;
                this.navShow = good.navShow;
                this.group_ids = good.group_ids;
                if(good.group_ids){
                    if(this.pageParam.group_ids == 0){
                        this.orderListName = [];
                        this.leftGoodsList = [];
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/productGroup/getProductByGroupIds',
                            params:{
                                group_ids:JSON.stringify(good.group_ids)
                            }
                        }).then(res => {
                            this.orderListName = res.data.data;
                            if(res.data.data.productInfo.length > 2){
		            			this.leftGoodsList = res.data.data.productInfo.splice(0, 2);
		            		}else{
		            			this.leftGoodsList = res.data.data.productInfo;
		            		}
		            		
                        }).catch(err => {
                            (err);
                        })
                    }
                	this.getGoods();
                }
                
                // 修改数据
                this.changeData({id:this.tempId,op:good})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.navPos = this.navPos;
                list.pageParam.sortChose = this.sortChose;
                list.pageParam.showNum = this.showNum ? this.showNum : 20;
                list.pageParam.sortOrder = this.sortOrder;
                list.pageParam.goodStyle = this.goodStyle;
                list.pageParam.checkedBuyBtn = this.checkedBuyBtn;
                list.pageParam.checkedPrice = this.checkedPrice;
                list.pageParam.checkedSummary = this.checkedSummary;
                list.pageParam.checkedGoodName = this.checkedGoodName;
                list.pageParam.btnStyle = this.btnStyle;
                list.pageParam.navShow = this.navShow;
                // list.pageParam.isFill = this.isFill;
                list.pageParam.btnTxt3 = this.btnTxt3;
                list.pageParam.btnTxt4 = this.btnTxt4;
                // list.pageParam.options = this.options;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.navPos = this.pageParam.navPos;
                this.sortChose = this.pageParam.sortChose;
                this.showNum = this.pageParam.showNum ? this.pageParam.showNum : 20;
                this.sortOrder = this.pageParam.sortOrder;
                this.goodStyle = this.pageParam.goodStyle;
                this.checkedBuyBtn = this.pageParam.checkedBuyBtn;
                this.checkedPrice = this.pageParam.checkedPrice;
                this.checkedSummary = this.pageParam.checkedSummary;
                this.checkedGoodName = this.pageParam.checkedGoodName;
                this.btnStyle = this.pageParam.btnStyle;
                this.navShow = this.pageParam.navShow;
                // this.isFill = this.pageParam.isFill;
                this.btnTxt3 = this.pageParam.btnTxt3;
                this.btnTxt4 = this.pageParam.btnTxt4;
                this.group_ids = this.pageParam.group_ids
                if(this.pageParam.group_ids){
                    if(this.pageParam.group_ids == 0){
                        this.orderListName = [];
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/productGroup/getProductByGroupIds',
                            params:{
                                group_ids:JSON.stringify(good.group_ids)
                            }
                        }).then(res => {
                            this.orderListName = res.data.data;
                        }).catch(err => {
                            (err);
                        })
                    }
                }
            },
            getGoods(){
            	if(this.group_ids.length > 0){
            		this.$ajax({
	            		methods:'POST',
	            		url:'/center/product/getProductByGroupId',
	            		params:{
	            			page:1,
	            			rows:5,
	            			group_id:this.group_ids[0]
	            		}
	            	}).then(res => {
	            		let goods = res.data.data.productInfo;
	            		this.goodsList = goods.splice(0, this.showNum);
	            		
	            	}).catch(err => {
	            		(err);
	            	})
            	}else{
            		this.goodsList = [];
            	}
        		
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .sort_top .sort_nav{
        background-color: #fff;
    }
    .sort_top .sort_nav ul{
        display: flex;
        
    }
    .sort_top .sort_nav ul li {
        flex: 1;
        text-align: center;
        line-height: 48px;
        box-sizing: border-box;
        border-bottom: 1px solid #e5e5e5
    }
    .sort_top .sort_nav ul li.current{
        color: #dd2727;
        border-bottom: 1px solid #dd2727;
    }
    .sort_top .goods_list{
        padding-bottom: 5px;
    }
    .sort_top .goods_list ul{
        padding: 0 10px;
    }
    .sort_top .goods_list ul li{
        margin-top: 10px;
        box-sizing: border-box;
    }
    .sort_top .goods_list ul.matrix li{
        float: left;
        margin-right: 10px;
        width: 48%;
    }
    .sort_top .goods_list ul.matrix li:nth-child(even){
    	margin-right: 0;
    }
    .sort_left{
        background-color: #f2f2f2;
    }
    .sort_left .sort_nav{
        float: left;
        width: 80px;
    }
    .sort_left .sort_nav ul li{
        line-height: 50px;
        box-sizing: border-box;
        text-align: center;
        font-size: 12px;
        color: #666;
        background-color: #f8f8f8;
        margin-bottom: 1px;
    }
    .sort_left .sort_nav ul li.current{
        color: #333;
        background-color: #fff;
        border-left: 2px solid #f44;
    }
    .sort_left .goods_list{
        width: 237px;
        float: right;
        margin-left: 1px;
    }
    .sort_left .goods_list ul li h6{
        padding: 0 10px 0 15px;
        background-color: #f8f8f8;
        line-height: 30px;
        color: #666;
        font-size: 12px;
    }
    .sort_left .goods_list ul li dl{
        background-color: #fff;
        padding: 0 10px;
    }
    .sort_left .goods_list ul li dl dd.last{
        border-top: 1px solid #eee;
    }
    /* 右侧设置 */
    .modify_box {
        position: absolute;
        right: -450px;
        top:0;
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
    .sort_nav ul li{
        white-space : nowrap
    }
</style>
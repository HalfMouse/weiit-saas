<template>
    <div class="showBox">
        <div class="good_sort blankShow">
            <!-- 当导航在顶部时 -->
            <div class="sort_top" v-if="navPos == 'top'">
                <!-- 导航 -->
                <div class="sort_nav" v-if="navShow == 'yes'">
                    <ul>
                        <li v-for="(item,index) in orderListName" :class="{'current':index==iNum}" @click="listShow(index)">
                            {{item.group_name}}
                        </li>
                    </ul>
                </div>
                <!-- 商品列表 -->
                <div class="goods_list">
                    <ul v-for="(item,index) in orderListName" class="fn-clear" :class="[{'goodBig':goodStyle == 'big'},{'matrix':goodStyle == 'matrix'},{'list':goodStyle == 'list'}]" v-show="index == iNum">
                        <li v-for="(ele,index) in item.productInfo" @click="lookDetail(ele.product_id)">
                            <good :goods="goods" :item="ele"></good>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- 当导航在左侧时 -->
            <div class="sort_left fn-clear" v-if="navPos == 'left'">
                <!-- 导航 -->
                <div class="sort_nav" v-if="navShow == 'yes'">
                    <ul>
                        <li v-for="(item,index) in orderListName" :class="{'current':index==iNum}" @click="choiceList(index)">{{item.group_name}}</li>
                    </ul>
                </div>
                <!-- 商品列表 -->
                <div class="goods_list">
                    <div id="sort">
                        <div v-for="(item,index) in orderListName" class="groupSort groupSort1">
                            <h6>{{item.group_name}}</h6>
                            <ul>
                                <li v-for="(ele,iNum) in item.productInfo" :class="{'last':iNum == orderListName.length-1}" @click="lookDetail(ele.product_id)">
                                    <goods :goods="ele"></goods>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    import qs from 'qs'
    // 引入顶部商品组件
    import good from '@/views/common/good';
    // 引入左侧商品组件
    import goods from '@/views/common/goods';
    export default {
        props:{
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
                        group_ids:[],
                        navShow:'yes'
                    }
                },
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
                count:2,
                orderListName:[],
                group_ids:[],
                group_names:[],
                iNum:0,
                navShow:'yes'
            }
        },
        methods:{
            // 点击展示商品列表
            listShow(index){
                this.iNum = index
            },
            // 初始化页面数据
            origain(){
                this.navPos = this.pageParam.navPos;
                this.sortChose = this.pageParam.sortChose;
                this.showNum = this.pageParam.showNum != 0 ? this.pageParam.showNum : 6
                this.sortOrder = this.pageParam.sortOrder;
                this.goodStyle = this.pageParam.goodStyle;
                this.checkedBuyBtn = this.pageParam.checkedBuyBtn;
                this.checkedPrice = this.pageParam.checkedPrice;
                this.checkedSummary = this.pageParam.checkedSummary;
                this.checkedGoodName = this.pageParam.checkedGoodName;
                this.navShow = this.pageParam.navShow;
                this.btnStyle = this.pageParam.btnStyle;
                this.btnTxt3 = this.pageParam.btnTxt3;
                this.btnTxt4 = this.pageParam.btnTxt4;
                this.group_ids = this.pageParam.group_ids;
                let group_ids =  this.pageParam.group_ids.join(',');
                axios.post('/api/product/getProductByGroupIds',qs.stringify({
                    group_ids: group_ids,
                    sortOrder:this.sortOrder
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.orderListName = res.data.data;
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 查看商品详情
            lookDetail(product_id){
                this.$router.push({
                    path:'/detail',
                    name:'detail',
                    query:{
                        product_id:product_id
                    }
                })
            },
            // 选择商品分组
            choiceList(index){
                this.iNum = index;
                // let sort = document.querySelector('#sort');
                // let sortList = document.querySelectorAll('.groupSort1');
                // sort.scrollTop = sortList[index].offsetTop;
                // const cateItem = document.querySelectorAll('.groupSort');
                // let total = cateItem[index].offsetTop;
                // let distance = this.container.scrollTop // 获取到顶部的距离(this.container便是.cate-list,为了方便存起来了)
                // let step = total / 50;
                // this.isActive = index; // 菜单列表显示当前样式
                // const _this = this;
                // if (total > distance) {
                //     smoothDown()
                // } else {
                //     let newTotal = distance - total
                //     step = newTotal / 50
                //     smoothUp()
                // }
                // function smoothDown () {
                //   if (distance < total) {
                //     distance += step
                //     _this.scrollTop = distance;
                //     setTimeout(smoothDown, 10);
                //   } else {
                //     _this.scrollTop = total
                //   }
                // }
                // function smoothUp () {
                //   if (distance > total) {
                //     distance -= step
                //     _this.scrollTop = distance
                //     setTimeout(smoothUp, 10)
                //   } else {
                //     _this.scrollTop = total
                //   }
                // } 
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
                    'btnTxt4':this.btnTxt4
                }
                return good
            }
        },
        components:{
            good,
            goods
        },
        mounted(){
            this.origain();
           
        }
    }
</script>

<style scoped>
    .sort_top .sort_nav{
        background-color: #fff;
    }
    .sort_top .sort_nav ul{
        display: flex;
        display: -webkit-flex;
    }
    .sort_top .sort_nav ul li {
        flex: 1;
        text-align: center;
        line-height: 0.96rem;
        box-sizing: border-box;
        border-bottom: 1px solid #e5e5e5;
        font-size: 0.3rem;
    }
    .sort_top .sort_nav ul li.current{
        color: #dd2727;
        border-bottom: 1px solid #dd2727;
    }
    .sort_top .goods_list{
        padding-bottom: 0.1rem;
    }
    .sort_top .goods_list ul{
        padding: 0 0.2rem;
    }
    .sort_top .goods_list ul li{
        margin-top: 0.2rem;
        box-sizing: border-box;
    }
    .sort_top .goods_list ul.matrix li{
        float: left;
        width: 49%;
        margin-top: 0.1rem;
    }
    .sort_top .goods_list ul.matrix li:nth-child(even){
        float:right;
    }
    .sort_left{
        background-color: #f2f2f2;
    }
    .sort_left .sort_nav{
        float: left;
        width: 1.6rem;
    }
    .sort_left .sort_nav ul li{
        box-sizing: border-box;
        text-align: center;
        font-size: 0.3rem;
        color: #333;
        background-color: #f8f8f8;
        margin-bottom: 1px;
        line-height: 0.8rem;
    }
    .sort_left .sort_nav ul li.current{
        color: #333;
        background-color: #fff;
        border-left: 2px solid #f44;
    }
    .sort_left .goods_list{
        position: relative;
        width: 5.8rem;
        float: right;
        margin-left: 1px;
        max-height: 7.6rem;
        overflow-y: scroll;
    }
    .sort_left .goods_list ul li h6{
        padding: 0 0.2rem 0 0.3rem;
        background-color: #f8f8f8;
        line-height: 0.6rem;
        color: #666;
        font-size: 0.36rem;
    }
    .sort_left .goods_list ul li dl{
        background-color: #fff;
        padding: 0 0.2rem;
    }
    .sort_left .goods_list ul li dl dd.last{
        border-top: 1px solid #eee;
    }
    .sort_nav ul li{
        white-space : nowrap
    }
    .groupSort h6{
        font-size: 0.3rem;
        padding: 0.1rem 0;
        padding-left: 0.1rem;
    }
</style>
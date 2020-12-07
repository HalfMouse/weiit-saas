<template>
    <div class="payments">
        <div class="nav">  
            <mt-navbar v-model="active">
                <mt-tab-item id="all">全部</mt-tab-item>
                <mt-tab-item id="used">已支出</mt-tab-item>
                <mt-tab-item id="overstayed">已收入</mt-tab-item>
            </mt-navbar>
        </div>
        <loading v-show="isLoading"></loading>
        <div v-show="!isLoading">
            <div class="page-tab-container">  
                <mt-tab-container class="page-tabbar-tab-container" v-model="active">  
                    <!-- 全部收入支出 -->
                    <mt-tab-container-item id="all" > 
                        <div v-if="payList.length > 0" class="pay_list">
                            <ul v-infinite-scroll="loadMore"
                                infinite-scroll-disabled="loading"
                                infinite-scroll-distance="10" class="clearfix">
                                <li :key="index" v-for="(item, index) in payList">
                                    <single-detail :singleScore="item" :top="top"></single-detail>
                                </li>
                            </ul>
                            <loading v-show="isLoading"></loading>
                        </div> 
                        <explain :item="top" v-else></explain>
                    </mt-tab-container-item> 
                    <!-- 全部收入  -->
                    <mt-tab-container-item id="used"> 
                        <div v-if="payList.length > 0" class="pay_list">
                            <ul>
                                <li v-for="item in incomes">
                                    <single-detail :singleScore="item" :top="top"></single-detail>
                                </li>
                            </ul>
                        </div> 
                        <explain :item="top" v-else></explain>
                    </mt-tab-container-item>  
                    <!-- 全部支出 -->
                    <mt-tab-container-item id="overstayed">  
                        <div v-if="payList.length > 0" class="pay_list">
                            <ul>
                                <li v-for="item in pays">
                                    <single-detail :singleScore="item" :top="top"></single-detail>
                                </li>
                            </ul>
                        </div> 
                        <explain :item="top" v-else></explain>
                    </mt-tab-container-item>  
                </mt-tab-container>  
            </div> 
        </div>   
    </div>
</template>

<script>
    //引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs' 
    // 引入时间转换js
    // import {getTime} from '../../../static/js/getTime'
    // 从mint-ui中引用TabContainer, TabContainerItem,Navbar
    import { TabContainer, TabContainerItem, Navbar, Loadmore } from 'mint-ui';
    // 引入一条消费详情
    import singleDetail from '@/components/singleDetail'
    // 引入底部解释
    import explain from '@/components/explain'
    // 引入加载组件
    import loading from '@/components/loading'
    export default {
        data(){
            return {
                active:'all',
                singleScore:-5,
                payList:[],
                pays:[],
                incomes:[],
                top:'wallet',
                scrollMode:"auto", //移动端弹性滚动效果，touch为弹性滚动，auto是非弹性滚动,
                allLoaded: false, //是否可以上拉属性，false可以上拉，true为禁止上拉，就是不让往上划加载数据了
                pageNo:1,
                pageSize:10,
                isLoading:true,
                loading:true
            }
        },
        components:{
            singleDetail,
            explain,
            loading
        },
        methods:{
            // 获取收支明细列表
            getWallet(){
                axios.post('/api/user/myBalanceLog',qs.stringify({
                    page_number:this.pageNo
                })).then((res) => {
                        if(res.data.code == '0'){
                            let list = res.data.data.list;
                            list.forEach(item => {
                                this.payList.push(item);
                            })
                            // 进项
                            this.pays = this.payList.filter((item) => {
                               return item.balance >= 0;
                            })
                            // 出项
                            this.incomes = this.payList.filter((item) => {
                                return item.balance < 0;
                            })
                            if(!res.data.data.hasNextPage){
                                this.loading = true;
                            }else{
                                this.loading = false;
                            }
                            this.isLoading = false;
                        }
                    }).catch((err) => {
                        console.log(err)
                    })
            },
            loadMore(){
                this.pageNo++;
                this.isPass = false;
                this.getWallet();
            }
            
        },
        created(){
            this.getWallet();
        }
    }
</script>

<style scoped lang="scss">

    .payments{
        height: 100%;
        overflow-y: scroll;
        .nav{
            border-bottom: 2px solid #f2f2f2
        }
        .page-tab-container{
            background-color: #fff;
            height: calc(100% - 1rem);
            .pay_list{
                height: 100%;
                overflow-y: scroll;
            }
        }
    }
</style>
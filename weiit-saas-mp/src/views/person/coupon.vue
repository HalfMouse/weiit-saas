<template>
    <div class="coupon_box">
        <div class="nav">  
            <mt-navbar v-model="active">
                <mt-tab-item id="all">全部</mt-tab-item>
                <mt-tab-item id="used">已使用</mt-tab-item>
                <mt-tab-item id="overstayed">已过期</mt-tab-item>
            </mt-navbar>
        </div> 
        <div class="page-tab-container">  
            <mt-tab-container class="page-tabbar-tab-container" v-model="active">  
                <mt-tab-container-item id="all" class="tab_item">  
                     <!-- 全部优惠券 -->
                     <div class="coupon_all">
                        <mt-loadmore :bottom-method="loadBottom" :bottomDropText="bottomText" :bottom-all-loaded="allLoaded" :auto-fill="false" ref="loadmore">
                            <ul class="coupon_list">
                                <li :key="index" v-for="(item, index) in allCoupon">
                                    <usage :coupon="item" :couponRootly="couponRootly"></usage>
                                </li>
                            </ul>
                            <no-more :types="allCoupon" v-if="allLoaded && allCoupon.length > 0"></no-more>
                            
                        </mt-loadmore>
                        
                     </div>
                     <loading v-show="isLoading"></loading>
                     <div class="empty" v-if="allCoupon.length == 0 && !isLoading">
                         <empty :fatherComponent="'coupon'"></empty>
                     </div>
                     
                </mt-tab-container-item>  
                <mt-tab-container-item id="used" class="tab_item"> 
                     <!-- 已使用优惠券 -->
                     <div class="coupon_all">
                         <ul class="coupon_list">
                            <li :key="index" v-for="(item, index) in useCoupon">
                                <usage :coupon="item" :couponRootly="couponRootly"></usage>
                            </li>
                        </ul>
                        <no-more :types="useCoupon" v-show="useCoupon.length > 0"></no-more>
                        <div class="empty empty_txt" v-if="allCoupon.length == 0 && !isLoading">
                            没有已使用的优惠券~
                        </div>
                     </div>
                </mt-tab-container-item>  
                <mt-tab-container-item id="overstayed" class="tab_item">  
                    <!-- 已过期优惠券 -->
                    <div class="coupon_all">
                        <ul class="coupon_list">
                            <li :key="index" v-for="(item, index) in overdueCoupon">
                                <usage :coupon="item" :couponRootly="couponRootly"></usage>
                            </li>
                        </ul>
                        <no-more :types="overdueCoupon" v-show="overdueCoupon.length > 0"></no-more>
                        <div class="empty empty_txt" v-if="allCoupon.length == 0 && !isLoading">
                            没有已过期的优惠券~
                        </div>
                    </div>
                </mt-tab-container-item>  
            </mt-tab-container>  
        </div> 
        <div class="foot_nav" v-show="!isLoading"> 
        </div> 
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 引入mint-ui中TabContainer,TabContainerItem,Navbar作为选项卡切换
    import { TabContainer, TabContainerItem, Navbar, Loadmore } from 'mint-ui';
    // 引入每一条优惠券组件
    import usage from '@/components/usage'
    // 引入没有更多了组件
    import noMore from '@/components/noMore'
    // 引入当内容为空时组件
    import empty from '@/components/empty'
    // 引入加载组件
    import loading from '@/components/loading'
    export default {
        data(){
            return {
                active:'all',
                allCoupon:[],
                useCoupon:[],
                overdueCoupon:[],
                isUsed:0,
                couponRootly:'coupon',
                isLoading:true,
                scrollMode:"auto", //移动端弹性滚动效果，touch为弹性滚动，auto是非弹性滚动,
                allLoaded: false, //是否可以上拉属性，false可以上拉，true为禁止上拉，就是不让往上划加载数据了
                totalpage:0,
                pageNo:1,
                pageSize:10,
                bottomText: '加载中...',
                scrollMode: "touch"
            }
        },
        methods:{
            // 获取所有优惠券
            getCounpon(){
                axios.post('/api/user/myCoupons',qs.stringify({
                    page:this.pageNo
                })).then((res) => {
                        if(res.data.code == '0'){
                            this.allCoupon = res.data.data.list;
                            this.isLoading = false;
                            if(!res.data.data.hasNextPage){
                                this.allLoaded = true;
                            }
                            // 已使用优惠券
                            this.useCoupon = this.allCoupon.filter((item) => {
                                return item.state == '1'
                            });
                            // 已过期优惠券
                            this.overdueCoupon = this.allCoupon.filter((item) => {
                                return item.state == '-1'
                            })
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            },
            // 上拉加载
            loadBottom() {
                this.more();// 上拉触发的分页查询
                this.$refs.loadmore.onBottomLoaded();// 固定方法，查询完要调用一次，用于重新定位
            },
            // 添加数据
            more(){
                this.pageNo = parseInt(this.pageNo) + 1;
                axios.post('/api/order/orderRefundList',qs.stringify({
                    page_number:this.pageNo
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.allCoupon = this.allCoupon.concat(res.data.data.list);
                        // 已使用优惠券
                        this.useCoupon = this.allCoupon.filter((item) => {
                            return item.state == '1'
                        });
                        // 已过期优惠券
                        this.overdueCoupon = this.allCoupon.filter((item) => {
                            return item.state == '-1'
                        })
                        if(!res.data.data.hasNextPage){
                            this.allLoaded = true;
                        }
                    }
                })
                .catch((err) => {
                    console.log(err)
                })
            }
        },
        components:{
            usage,
            noMore,
            empty,
            loading
        },
        mounted(){
            this.getCounpon()
        }
    }
</script>

<style scoped lang="scss">
    .coupon_box{
        position: relative;
        .nav{
            border-bottom: 2px solid #f2f2f2;
        }
        .page-tab-container{
            min-height:8.5rem;
            .tab_item{
                position: relative;
                height: 100%;
                overflow: hidden;
                .empty{
                    min-height:7.8rem;
                    &.empty_txt{
                        text-align: center;
                        font-size: 0.28rem;
                        color: #333;
                        line-height: 7.8rem;
                    }
                }
                .coupon_all{
                    .coupon_list{
                        li{
                            margin-top: 0.2rem;
                            border-radius:  0.1rem; 
                            overflow: hidden;
                        }
                    }
                }
            }
        }
        // .foot_nav{
        //     position: absolute;
        //     bottom: 0.5rem;
        //     left: 0;
        //     width: 100%;
        // }
    }
</style>
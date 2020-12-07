<template>
    <div class="returnGoods">
        <div v-show="!isLoading" class="returnGoods_list">
            <ul
                v-infinite-scroll="loadMore"
                infinite-scroll-disabled="loading"
                infinite-scroll-distance="10" class="clearfix">
                <li :key="index" v-for="(item,index) in returnGoods">
                    <header>退货单号:{{item.refund_num}}</header>
                    <good-infor :goodinfor="item" class="goods_return" :goodsRootly="fatherComponent"></good-infor>
                    <p class="return_tips">
                        {{returnState(item.state)}} 
                    </p>
                    <p class="more clearfix">
                        <a href="javascript:;" @click="cancleReturn(item)" class="cancelReturn" v-if="item.state == 0 || item.state == 1">取消退货</a>
                        <a href="javascript:;" @click="lookDetail(item)">查看详情</a>
                    </p>
                </li>
            </ul>
            <no-more v-if="allLoaded && returnGoods.length > 0"></no-more>
        </div>
        <loading v-show="isLoading"></loading>
        <empty v-if="returnGoods.length == 0 && !isLoading" :fatherComponent="fatherComponent"></empty>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 从mint-ui中引入MessageBox
    import { MessageBox } from 'mint-ui';
    // 引入商品信息
    import GoodInfor from '@/components/goodInfor'
    // 引入内容为空时
    import empty from '@/components/empty'
    // 引入加载组件
    import loading from '@/components/loading'
    import noMore from '@/components/noMore'
    export default {
        data(){
            return {
                returnGoods:[],
                fatherComponent:'return',
                isLoading:true,
                allLoaded: false, //是否可以上拉属性，false可以上拉，true为禁止上拉，就是不让往上划加载数据了
                pageNo:1,
                loading:true
            }
        },
        components:{
            GoodInfor,
            empty,
            loading,
            noMore
        },
        methods:{
            // 确认取消退货弹窗
            cancleReturn(item,index){
                let state = item.state.toString();
                let refund_id = item.refund_id.toString();
                MessageBox.confirm('',{
                    width:500,
                    height:600,
                    title:'',
                    message:'确认取消退货?',
                    cancelButtonClass:'cancelButton',
                    confirmButtonClass:'confirmButton',
                    confirmButtonText:'确认',
                    cancelButtonText:'取消'
                }).then((action) => {
                    if (action == 'confirm') {
                        axios.post('/api/order/orderRefundCancel',qs.stringify({
                            state:state,
                            refund_id:refund_id
                        }))
                    }
                    item.state = -1;
                }).catch((err) => {
                    if (err == 'cancel') {
                        console.log('123');
                    }
                });
            },
            // 获取退货信息
            getReturn(){
                axios.post('/api/order/orderRefundList', qs.stringify({
                    page:this.pageNo
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach(item => {
                            this.returnGoods.push(item);
                        }) 
                        this.returnGoods.forEach((item) => {
                            item.isHaveCompony = '';
                        })

                        this.hasNextPage = res.data.data.hasNextPage;
                        if(!this.hasNextPage){
                            this.loading = true;
                            this.allLoaded = true
                        }else{
                            this.loading = false;
                        }
                        this.isLoading = false;
                        this.isPass = true
                        
                    }
                })
                .catch((err) => {
                    console.log(err);
                })
            },
            // 判断退货状态
            returnState(state){
                switch(state){
                    case 0:
                        return '等待卖家同意';
                        break;
                    case 1:
                        return '等待买家补充中';
                        break;
                    case 2:
                        return '等待卖家退换';
                        break;
                    case -1:
                        return '退换关闭';
                        break;
                    case 3:
                        return '退换完成';
                        break;
                    case 4:
                        return '退换驳回';
                        break;
                }
                // 退换状态，0表示待审核，1表示退换中，2表示退换完成，-1表示退换取消
            },
            // 点击之后查看详情
            lookDetail(item){
                // 存储退换ID
                localStorage.setItem('refund_id',item.refund_id);
                // 跳转到详情页
                this.$router.push({
                    path:'/viewDetails',
                    name:'viewDetails',
                    params:{
                        refund_id:item.refund_id,
                        isHaveCompony:item.isHaveCompony
                    }
                })
            },
            // 上拉加载
            loadBottom() {
                this.more();// 上拉触发的分页查询
                this.$refs.loadmore.onBottomLoaded();// 固定方法，查询完要调用一次，用于重新定位
            },
            more(){
                this.pageNo = parseInt(this.pageNo) + 1;
                axios.post('/api/order/orderRefundList',qs.stringify({
                    page:this.pageNo
                })).then((res) => {
                    if(res.data.code == '0'){
                        res.data.data.list.forEach((item) => {
                            item.isHaveCompony = '';
                        })
                        this.returnGoods = this.returnGoods.concat(res.data.data.list);
                        if(!res.data.data.hasNextPage){
                            this.allLoaded = true;
                        }
                    }
                })
                .catch((err) => {
                    console.log(err)
                })
            },
            loadMore(){
                this.pageNo++;
                this.isPass = false;
                this.getReturn();
            }
        },
        mounted(){
            this.getReturn();
        }
    }
</script>

<style scoped lang="scss">
    .returnGoods{
        background-color: #F5F5F5;
        ul{
            padding-bottom: 0.2rem;
            li{
                background-color: #fff;
                margin-top: 0.2rem;
                &:first-child{
                    margin-top: 0;
                }
                header{
                    background-color: #fff;
                    font-size: 0.28rem;
                    color: #333;
                    padding: 0.2rem 0 0.2rem 0.2rem;
                    i{
                        display: inline-block;
                        font-size: 0.24rem;
                        columns: #666;
                        margin-left: 0.2rem;
                    }
                }
                .goods_return{
                    background-color: #f5f5f5;
                }
                .return_tips{
                    padding-left: 0.4rem;
                    font-size: 0.28rem;
                    padding:0.1rem 0 0.1rem 0.4rem;
                    color:#333;
                }
                .more{
                    border-top:2px solid #f5f5f5;
                    padding: 0.1rem 0;
                    a{
                        float: right;
                        width: 1.48rem;
                        height: 0.4rem;
                        border:2px solid #666;
                        margin-right: 0.2rem;
                        text-align: center;
                        line-height: 0.4rem;
                        font-size: 0.28rem;
                        color: #333;
                        border-radius: 0.1rem;
                        &.cancelReturn{
                            right: 1.84rem;
                        }
                    }
                    
                }
            }
        }
    }
    .returnGoods_list{
        min-height:9.5rem;
    }
</style>
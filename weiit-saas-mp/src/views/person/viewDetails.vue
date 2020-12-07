<template>
    <div class="viewDetails">
        <div v-show="!isLoading">
            <div class="refunds_tips">
                <h3>{{returnState(good.state)}}</h3>
                <p class="refunds_time">{{time}}</p>
            </div>
            <h4 class="refunds_title">退款信息</h4>
            <good :good="good"></good>
            <div class="return_reason">
                <p>退款原因：{{good.refund_reason}}</p>
                <p>退款金额：￥{{good.refund_money}}</p>
                <p>申请时间：{{time}}</p>
                <p>退款编号：{{good.refund_num}}</p>
                <div class="clearfix" v-if="good.state == 1">
                    <a href="javascript:;" class="add_logistics" @click="addLogistics()">补充物流信息</a>
                </div>
                <div class="clearfix" v-if="good.state == 2 || good.state == 3">
                    <a href="javascript:;" class="logistics" @click="logistics()">查看物流</a>
                </div>
            </div>
        </div>
        <loading v-show="isLoading"></loading>
    </div>
</template>

<script>
    // 引入axios 
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 引入商品信息介绍
    import good from '@/components/good'
    // 引入计算时间
    import {getTime} from '../../../static/js/getTime'
    // 引入加载组件
    import loading from '@/components/loading'
    export default {
        data(){
            return {
                good:{},
                isHaveCompany:this.$route.params.isHaveCompony ? this.$route.params.isHaveCompony : localStorage.getItem('isHaveCompany'),
                isLoading:true,
                time:''
            }
        },
        methods:{
            // 获取订单退货详情
            getRefund(){
                let refund_id = localStorage.getItem('refund_id');
                axios.post('/api/order/orderRefundDetail', qs.stringify({
                    refund_id:localStorage.getItem('refund_id')
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.good = res.data.data;
                        this.isLoading = false;
                        this.time = getTime(this.good.create_time);
                    } 
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 判断当前状态
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
            // 查看物流
            logistics(){
                
                this.$router.push({
                    path:'/logistics',
                    name:'logistics',
                    params:{
                        express_code:this.good.express_code,
                        express_num:this.good.express_num,
                        express_name:localStorage.getItem('isHaveCompany'),
                        
                    }
                }) 
            },
            // 补充物流信息
            addLogistics(){
                this.$router.push({
                    path:'/addLogistics',
                    name:'addLogistics'
                })
            }
        },
        components:{
            good,
            loading
        },
        mounted(){
            let id = this.$route.params.refund_id;
            let company = this.$route.params.isHaveCompony;
            if(id){
                localStorage.setItem('refund_id',id)
            }
            if(company == ''){
                localStorage.setItem('isHaveCompany',company)
            }
            this.getRefund();
        }
    }
</script>

<style scoped lang="scss">
.viewDetails{
    position: relative;
    .refunds_tips{
        height: 1.3rem;
        background: #fc0317;
        color: #fff;
        padding: 0.4rem 0 0 0.5rem;
        h3{
            font-size: 0.3rem;
            font-weight: bold;
            line-height: 0.3rem;
            margin-bottom: 0.16rem;
        }
        
        .refunds_time{
            font-size: 0.26rem;
            line-height: 0.3rem;
        }
    }
    .refunds_title{
        font-size: 0.3rem;
        background-color: #fff;
        padding: 0.15rem 0 0.15rem 0.24rem;
    }
    
    .return_reason{
        background-color: #fff;
        padding: 0.2rem;
        padding-bottom: 0.1rem;
        p{
            color: #999;
            line-height: 0.3rem;
            font-size: 0.28rem;
            margin-bottom: 0.2rem;
        }
    }
    a{
        float: right;
        font-size: 0.28rem;
        color: #333;
        padding:0 0.1rem;
        line-height: 0.46rem;
        box-sizing: border-box;
        border-radius: 0.04rem;
        margin-right: 0.1rem;
        margin-bottom: 0.2rem;
        &.logistics{
            background-color: #ffdc4b;
            margin-top: -0.2rem;
        }
        &.add_logistics{
            border: 1px solid #666;
            margin-bottom: 0.1rem;
        }
    }
}
</style>
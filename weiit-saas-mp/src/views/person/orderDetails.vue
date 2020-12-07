<template>
    <div class="orderDetails">
        <loading v-show="isloading"></loading>
        <div v-show="!isloading">
            <header>
                <span>{{goodsMation(orders.state)}}</span>
                <i v-if="orders.state == '1' || orders.state == '2' || orders.state == '3' || orders.state == '4'" class="icon iconfont icon-yishiyong1"></i>
            </header>
            <div class="signed">
                <div v-if="orders.state == '4'">   
                    <h6>已签收,感谢使用XX快递，期待下次为您服务</h6>
                    <p class="time">2010-01-01 13:25:00</p>
                </div>
                <div class="sign_user clearfix">
                    <span class="user_name">收件人：{{orders.consignee}}</span>
                    <span class="user_tel">{{orders.phone}}</span>
                </div>
                <p class="address">收件地址：{{orders.address}}</p>
            </div>
            <div class="order_goods">
                <h6>
                    <i class="icon iconfont icon-dianpu"></i>
                    <span>活动专区1</span>
                    <i class="icon iconfont icon-youjiantouda"></i>
                </h6>
                <div class="goods_infor">
                    <ul>
                        <li v-for="item in orders.item"  @click="detail(item.product_id)">
                            <good-infor :state="orders.state" :goodinfor="item" :goodsRootly="goodsRootly" :rangeType="rangeType"></good-infor>
                        </li>
                    </ul>
                </div>
                <!-- <div class="refure_box" v-if="rangeType == 1" @click="applyRefure">
                    <a href="javascript:;">申请售后</a>
                </div> -->
                <div class="goods_cost">
                    <ul>
                        <li>
                            <span>运费</span>
                            <span v-if="orders.express_money">￥{{orders.express_money}}</span>
                            <span v-else>￥0</span>
                        </li>
                        <li>
                            <span>优惠卷抵扣</span>
                            <span>¥{{couponPrice}}</span>
                        </li>
                        <li>
                            <span>实付款（含运费）</span>
                            <span class="money">￥{{orders.pay_price}}</span>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- <div class="customer">
                <a href="javascript:;" class="seller_btn">
                    <i class="icon iconfont icon-kujialeqiyezhan_zaixiankefu-"></i>
                    <span>联 系 卖 家</span>
                </a>
                <a href="javascript:;" class="customer_btn">
                    <i class="icon iconfont icon-dianhua"></i>
                    <span>联 系 客 服</span>
                </a>
            </div> -->
            <div class="order_num">
                <p>订单编号:{{orders.order_num}}</p>
                <p>创建时间:{{create_time}}</p>
                <p v-if="orders.state == '2' || orders.state == '3' || orders.state == '4'">发货时间:{{deliver_time}}</p>
                <p v-if="orders.state == 4">成交时间:{{pay_time}}</p>
                <div class="goods_btn clearfix">
                    <a href="javascript:;" @click="lookLogistics()" v-if="orders.state == '2' || orders.state == '3' || orders.state == '4'">查看物流</a>
                </div>
            </div>
        </div>
        
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 引入单个商品详情介绍组件
    import goodInfor from '@/components/goodInfor'
    // 引入计算时间
    import {getTime} from '../../../static/js/getTime'
    // 引入加载组件
    import loading from '@/components/loading';
    import { Toast } from 'mint-ui';
    export default {
        data(){
            return {
                orders:{},
                isHaveHeader:'no',
                goodsRootly:'orderDetails',
                create_time:'',
                deliver_time:'',
                pay_time:'',
                order_num:'',
                isloading:true,
                goodPicture:'',
                couponPrice:0,
                rangeType:0,
                refureState:''
            }
        },
        methods:{
            // 获取当前订单详情数据
            getOrderDetails(){
                this.order_num = this.$route.query.order_num;
                axios.post('/api/order/orderDetail',qs.stringify({
                    order_num:this.order_num
                    // order_num:
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.orders = res.data.data;
                        localStorage.setItem('order_item_id',this.orders.order_id);
                        this.create_time = getTime(this.orders.create_time);
                        this.deliver_time = getTime(this.orders.deliver_time);
                        this.pay_time = getTime(this.orders.pay_time);
                        this.isloading = false;
                        this.refursGood = this.orders.item;
                        this.goodPicture = this.orders.item[0].product_img;
                        // this.refureState = 
                        if(this.orders.couponInfo){
                            this.couponPrice = this.orders.couponInfo.coupon_price;
                            this.rangeType = this.orders.couponInfo.product_range_type;
                        }else{
                            this.couponPrice = 0;
                            this.rangeType = 0
                        }
                        
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 计算当前状态值
            goodsMation(state){
                switch(state){
                    case -1:return '交易取消';break;
                    case 0: return '待付款';break;
                    case 1: return '待发货';break;
                    case 2: return '待收货';break;
                    case 3: return '待评价';break;
                    case 4: return '交易完成';break;
                    default:return '待付款'
                }
            },
            // 查看物流详情
            lookLogistics(){
                this.$router.push({
                    path:'/logistics',
                    name:'logistics',
                    params:{
                        express_code:this.orders.express_code,
                        express_num:this.orders.express_num,
                        express_name:this.orders.express_name,
                        goodPicture:this.goodPicture
                    }
                })
            },
            // 跳转
            detail(id){
                this.$router.push({
                    path:'/detail',
                    name:'detail',
                    query:{
                        product_id:id
                    }
                })
            },
            // 申请售后
            applyRefure(){
                if(this.orders.item[0].state !== null){
                    Toast('商家正在受理中~')
                }else{
                    this.$router.push({
                        path:'/afterSales',
                        name:'afterSales',
                        params:{
                            refursGood:this.refursGood,
                            rangeType:this.rangeType,
                            refursPrice:(this.orders.pay_price - this.orders.express_money).toFixed(2)
                        }
                    })
                }
            }
        },
        components:{
            goodInfor,
            loading
            
        },
        mounted(){
            this.getOrderDetails();
        },
        watch: {
            '$route' (to, from) {
                // 刷新参数放到这里里面去触发就可以刷新相同界面了
                this.getOrderDetails();
            }
        }
    }
</script>

<style scoped lang="scss">
    .orderDetails{
        font-family:'PingFang-SC-Regular';
        header{
            width: 6.9rem;
            height: 1.54rem;
            background: linear-gradient(90deg, #F33A20, #F7D333);
            padding: 0 0.3rem;
            line-height: 1.54rem;
            span{
                float: left;
                color: #f5f5f5;
                font-size: 0.36rem;
                
            }
            i{
                float: right;
                font-size: 1.5rem;
                color: #F33A20;
            }
        }
        .signed{
            background-color: #fff;
            padding: 0.2rem 0.4rem;
            margin-bottom: 0.2rem;
            h6{
                color: #60a75a;
                font-size: 0.28rem;
            }
            .time{
                color: #999;
                font-size: 0.24rem;
                margin-top: 0.03rem;
                margin-bottom: 0.3rem;
            }
            .sign_user{
                span{
                    font-size: 0.28rem;
                    color: #333;
                    &.user_name{
                        float: left;
                    }
                    &.user_tel{
                        float: right;
                    }
                }
            }
            .address{
                font-size:  0.28rem;
                color: #333;
                margin-top: 0.05rem;
            }
        }
        .order_goods{
            margin-bottom: 0.2rem;
            h6{
                height:0.56rem;
                background-color: #fff;
                line-height: 0.56rem; 
                padding-left: 0.2rem;
                .icon-dianpu{
                    float: left;
                    font-size: 0.28rem;
                    color: #666;
                }
                span{
                    float: left;
                    color: #333;
                    font-size: 0.24rem;
                    margin:-0.03rem 0.2rem 0;
                }
                .icon-youjiantouda{
                    float: left;
                    font-size: 0.2rem;
                    color: #666;
                }
            }
            .goods_btn{
                text-align: right;
                a{
                    float: right;
                    background-color: #f5f5f5;
                    width: 1.31rem;
                    height: 0.4rem;
                    border-radius: 0.04rem;
                    border:1px solid #666;
                    font-size: 0.26rem;
                    margin-right: 0.2rem;
                    text-align: center;
                }
            }
            .refure_box{
                background-color: #fff;
                padding: 0.2rem;
                overflow: hidden;
                a{
                    float: right;
                    background-color: #fff;
                    padding: 0 0.1rem;
                    height: 0.46rem;
                    line-height: 0.46rem;
                    border-radius: 0.04rem;
                    border: 1px solid #bbb;
                    font-size: 0.28rem;
                    color: #666;
                    font-size: 0.3rem;
                    z-index: 99;
                }
            }
            .goods_cost{
                background-color: #fff;
                margin-top: 0.2rem;
                font-size: 0.28rem;
                color: #333;
                padding:0.1rem 0.2rem 0;
                ul{
                    overflow: hidden;
                    li{
                        overflow: hidden;
                        margin-bottom: 0.1rem;
                        span{
                            float: left;
                            &:last-child{
                                float: right;
                            }
                            &.money{
                                font-size: 0.28rem;
                                color: #e75453;
                                font-family:'PingFang-SC-Regular';
                                font-weight: bold;
                            }
                        }
                    }
                }
            }
        }
        .customer{
            background-color: #fff;
            height: 1.06rem;
            overflow: hidden;
            padding:0 0.15rem;
            margin-bottom: 0.2rem;
            a{
                float: left;
                width: 3.48rem;
                height: 0.83rem;
                border:1px solid #999;
                border-radius: 0.1rem;
                margin-top: 0.11rem;
                margin-right: 0.15rem;
                font-size: 0.3rem;
                color: #333;
                line-height: 0.83rem;
                box-sizing: border-box;
                text-align: center;
                &:last-child{
                    margin-right: 0;
                }
                i{
                    font-size: 0.48rem;
                    color: #55ADFF;
                    font-weight: bold;
                    display: inline-block;
                    margin-right: 0.1rem;
                }
            }
        }
        .order_num{
            background-color: #fff;
            padding:0.2rem 0.2rem;
            p{
                font-size: 0.28rem;
                color: #666;
                margin-bottom: 0.1rem;
            }
            .goods_btn{
                text-align: right;
                a{
                    float: right;
                    background-color: #fff;
                    padding:0 0.1rem;
                    line-height: 0.5rem;
                    border-radius: 0.04rem;
                    border:1px solid #666;
                    font-size: 0.3rem;
                    margin-left: 0.2rem;
                    text-align: center;
                }
            }
        }
    }
</style>
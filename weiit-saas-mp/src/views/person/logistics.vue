<template>
    <div class="logistics">
        <div class="logistics_goods clearfix">
            <div class="logistics_pic">
                <img :src="$url + baseInfo.express_logo" alt="">
            </div>
            <div class="logistics_txt">
                <h6 class="logistics_state">已签收</h6>
                <p class="">快递公司：{{baseInfo.express_name}}</p>
            </div>
        </div>
        <div class="logistics_list">
            <!-- <div class="delivery_address clearfix">
                <i class="icon iconfont icon-weizhi"></i>
                <p class="address_information">[收货地址]{{order_address}}</p>
            </div> -->
            <ul class="logistics_des">
                <li :key="index" class="clearfix" v-for="(item,index) in logisticsList">
                    <div class="time">
                        <span class="date">{{item.time}}</span>
                    </div>
                    <div class="state_icon">
                        <i class="icon iconfont" :class="index == 0 ? 'icon-iconcorrect':'icon-shangla'"></i>
                    </div>
                    <div class="des_txt">
                        <p>{{item.status}}</p>
                    </div>
                    <div class="line"></div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    export default {
        data(){
            return {
                express_code:this.$route.params.express_code ? this.$route.params.express_code : localStorage.getItem('express_code'),
                express_num:this.$route.params.express_num ? this.$route.params.express_num : localStorage.getItem('express_num'),
                logisticsList:[],
                baseInfo:{}
            }
        },
        methods:{
            getLogistics(){
                axios.post('/api/order/orderExpress', qs.stringify({
                    express_code:localStorage.getItem('express_code'),
                    express_num:localStorage.getItem('express_num')
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.baseInfo = res.data.data.expressBaseInfo;
                        this.logisticsList = JSON.parse(res.data.data.expressInfo.result.list);
                    }
                }).catch((err) => {
                    console.log(err)
                })
            }
        },
        mounted(){
            let express_code = this.$route.params.express_code;
            let express_num = this.$route.params.express_num;
            if(express_code){
                // 存储订单物流公司编码
                localStorage.setItem('express_code',this.$route.params.express_code);
            }
            if(express_num){
                // 存储订单物流单号
                localStorage.setItem('express_num',this.$route.params.express_num);
            }
            this.getLogistics();
        }
    }
</script>

<style scoped lang="scss">
    .logistics{
        .logistics_goods{
            background-color: #fff;
            padding:0.2rem;
            .logistics_pic{
                float: left;
                width: 2.4rem;
                height: 0.75rem;
                border:1px solid #f0f0f0;
                box-sizing: border-box;
                img{
                    display: block;
                    width: 100%;
                    height: 100%;
                }
            }
            .logistics_txt{
                float: left;
                margin-left: 0.2rem;
                .logistics_state{
                    font-size: 0.32rem;
                    color: #fa871c;
                }
                p{
                    font-size: 0.24rem;
                    color: #666;
                    margin-top: 0.1rem;
                }
            }
        }
        .logistics_list{
            margin-top: 0.2rem;
            background-color: #fff;
            padding:0.2rem;
            position: relative;
            .delivery_address{
                color: #FA871C;
                margin-left: 1.65rem;
                position: relative;
                height: 0.76rem;
                .icon{
                    float: left;
                    font-size: 0.37rem;
                    position: relative;
                    top: 50%;
                    transform: translateY(-50%);
                }
                .address_information{
                    float: left;
                    width: 4.8rem;
                    margin-left: 0.2rem;
                    font-size: 0.28rem;
                    font-family: 'PingFang-SC-Regular';
                }
            }
            .logistics_des{
                position: relative;
                z-index: 30;
                // margin-top: 0.4rem;
                li{
                    position: relative;
                    &:last-child{
                        .line{
                            height: 0;
                        }
                    }
                    margin-bottom: 0.4rem;
                    .time{
                        float: left;
                        font-size: 0.26rem;
                        width: 1.5rem;
                        text-align: right
                    }
                    .state_icon{
                        float: left;
                        width: 0.29rem;
                        height: 0.25rem;
                        text-align: center;
                        line-height: 0.25rem;
                        margin:0 0.2rem;
                        margin-top: 0.08rem;
                        .icon{
                            font-size: 0.29rem;
                            display: block;
                            position: relative;
                            z-index: 30;
                            background-color: #fff;
                            &.icon-iconcorrect{
                                color: #FA871C;
                            }
                            &.icon-shangla{
                                color: #d3d3d3;
                            }
                        }
                        
                    }
                    .des_txt{
                        width: 4.8rem; 
                        float: left;
                        font-size: 0.26rem;
                    }
                    .line{
                        position: absolute;
                        width: 2px;
                        background-color: #d3d3d3;
                        height: calc(100% + 0.3rem);
                        left: 1.82rem;
                        top: 0.2rem;
                        z-index: 20;
                    }
                }
            }
            
        }
    }
</style>
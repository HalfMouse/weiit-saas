<template>
    <div class="addLogistics">
        <!-- 快递公司选择 -->
        <div class="logistics_company clearfix" @click="company = true">
            <h5>快递公司</h5>
            <p v-if="logisticsCompany == ''">请选择<i class="icon iconfont icon-youjiantouda"></i></p>
            <p v-else>{{logisticsCompany}}<i class="icon iconfont icon-youjiantouda"></i></p>
        </div>
        <!-- 物流单号 -->
        <p class="logistics_code">
            <input type="number" placeholder="请填写快递/物流单号" v-model="logisticsCode">
        </p>
        <!-- 底部按钮 -->
        <button class="ensure" @click="ensure()">确定</button> 
        <!-- 快递公司弹出框 -->
        <mt-popup v-model="company" position="bottom" class="state_win">
            <header>快递公司</header>
            <div class="company_box">
                <ul>
                    <li :key="index" @click="choose(item, index)" v-for="(item,index) in companys">
                        <label class="mint-radiolist-label">
                            <span class="mint-radio">
                                <input type="radio" class="mint-radio-input" :value="item.express_company" v-model="logisticsCompany"> 
                                <span class="mint-radio-core"></span>
                            </span> 
                            <div class="mint-radio-label">
                                <h6>{{item.express_company}}</h6>
                            </div>
                        </label>
                    </li>
                </ul>
            </div>
        </mt-popup>  
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    // 从mint-ui中调用Popup
    import { Popup,Toast } from 'mint-ui';
    export default {
        data(){
            return {
                logisticsCode:'',
                company:false,
                logisticsCompany:null,
                companys:[],
                expressTemplateId:''
            }
        },
        methods:{
            // 确认选择
            ensure(){
                
                if(this.expressTemplateId != ''){
                    if(this.logisticsCompany){
                        if(this.logisticsCode.length > 8 && this.logisticsCode.length < 14){
                            this.Logistics()
                        }
                    }else{
                        Toast('请输入快递单号')
                    }
                }else{
                    Toast('请选择快递公司')
                }
                
            },
            // 获取快递公司
            getCompany(){
                axios.post('/api/order/expressCompany', null)
                    .then((res) => {
                        if(res.data.code == '0'){
                            this.companys = res.data.data;
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            },
            // 选择
            choose(item, index){
                this.company = false;
                this.expressTemplateId = item.express_template_id;             
            },
            // 确认物流信息
            Logistics(){
                axios.post('/api/order/addOrderRefundExpress', qs.stringify({
                    express_template_id:this.expressTemplateId,
                    express_num:this.logisticsCode,
                    refund_id:localStorage.getItem('refund_id')
                })).then((res) => {
                    if(res.data.code == '0'){
                        this.$router.push({
                            path:'/viewDetails',
                            name:'viewDetails',
                        })
                        localStorage.setItem('isHaveCompany',this.logisticsCompany);
                    }
                }).catch((err) => {
                    console.log(err);
                })
            }
        },
        mounted(){
            this.getCompany()
        }
    }
</script>

<style scoped lang="scss">
    .addLogistics{
        background-color: #fff;
        .logistics_company{
            border-bottom: 2px solid #f5f5f5;
            font-size: 0.28rem;
            color: #333;
            line-height: 0.88rem;
            padding:0 0.2rem;
            h5{
                float: left;
            }
            p{
                float: right;
               
                i{
                    display: inline-block;
                    margin-left: 0.15rem;
                    font-size: 0.3rem;
                }
            }
        }
        .logistics_code{
             line-height: 0.88rem;
             padding:0 0.2rem;
            input{
                display: block;
                font-size: 0.28rem;
                color: #333;
                line-height: 0.88rem;
            }
        }
        .state_win{
            min-height: 5rem;
            padding-bottom: 0.4rem;
            header{
                padding-top: 0.2rem;
                text-align: center;
                color: #333;
                font-weight: bold;
                font-size: 0.34rem;
                font-family: 'PingFang-SC-Bold';
            }
            ul{
                padding:0 0.2rem;
                li{
                    position: relative;
                    border-bottom: 2px solid #ddd;
                    height: 1rem;
                    &:last-child{
                        border: none 0;
                    }
                    .mint-radiolist-label{
                        position: relative;
                        overflow: hidden;
                        height: 1rem;
                        .mint-radio{
                            float: right;
                            text-align: right;
                            margin-right: 0.05rem;
                            margin-top: 0.3rem;
                            .mint-radio-core{
                                display: block;
                            }
                        }
                        .mint-radio-label{
                            float: left;
                            text-align: left;
                            position: relative;
                            top: 50%;
                            transform: translateY(-50%);
                            h6{
                                font-size: 0.34rem;
                                color: #666;
                            }
                            p{
                                font-size: 0.24rem;
                                color: #999;
                            }
                        }
                    }
                    
                }
            }
        }
        .company_box{
            height: 5rem;
            overflow-y: scroll;
        }
        .ensure{
            position: fixed;
            width: 6.91rem;
            height: 0.89rem;
            background-color: #ffdc4b;
            border-radius: 0.19rem;
            font-size: 0.32rem;
            color: #333;
            font-family: 'PingFang-SC-Bold';
            left: 50%;
            transform: translateX(-50%);
            bottom: 0.4rem;
        }
    }
</style>
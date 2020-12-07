<template>
    <div class="postal_box">
        <div class="postal_choose">
            <h5>可提现金额(元)</h5>
            <p class="postal_money">
                <span v-show="money > 0">￥</span>
                <span class="money_num">{{money}}</span>   
            </p>
            <p class="postal_mode" @click="choosePostal()">
                <span class="mode">{{costChoose}}</span> 
                <i class="icon iconfont icon-xiangxiajiantou"></i>
            </p>
            <form action="">
                <p v-if="costChoose == '支付宝'">
                    <input type="text" placeholder="请输入需要提现的支付宝账号" v-model="accountNum">
                </p>
                <p>
                    <input type="number" placeholder="请选择需要提现的金额" v-model="postalNum">
                </p>
            </form>
        </div>
        <button class="withdrawals_btn" :class="{current : complete()}" @click="postal()">提现</button>
        <div class="b_bg" v-show="isOk">
            <div class="choose_box">
                <h3>选择账户</h3>
                <mt-radio v-model="value" :options="['支付宝','微信']"></mt-radio>
                <div class="choose_btn clearfix">
                    <a href="javascript:;" class="cancel_btn" @click="isOk = false">取消</a>
                    <a href="javascript:;" class="ensure_btn" @click="choose()">确认</a>
                </div>
                <i class="icon iconfont icon-cha" @click="isOk = false"></i>
            </div>
        </div>
        <!-- <p style="text-align:left">
            <input type="radio" id="Alipay" name="cost" v-model="value">
            <label for="Alipay">支付宝</label>
        </p>
        <p style="text-align:left">
            <input type="radio" id="WeChat" name="cost" v-model="value">
            <label for="WeChat">微信</label>
        </p> -->
    </div>
</template>

<script>
    // 从mint-ui中引入Toast
    import { Toast } from 'mint-ui';
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    // 从mint-ui中引入Radio,Cell组件
    import { Radio,Cell } from 'mint-ui';
    export default {
        data(){
            return {
                accountNum:'',
                postalNum: '',
                costChoose:'微信',
                value:'微信',
                isOk:false,
                money:localStorage.getItem('balance') ? localStorage.getItem('balance'):0
            }
        },
        methods:{
            // 确认提现
            postal(){
                let Alipay_num = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;//验证邮箱
                let tel = /^1[3|4|5|8][0-9]\d{8}$/;//验证手机号
                let reg = /^([1-9][0-9]*)+(.[0-9]{1,2})?$/;//验证输入金额
                if(this.complete()){
                    localStorage.setItem('costChoose',this.costChoose);
                    // 提现金额
                    let balance = this.postalNum;
                    // 提现账号
                    let accoNum = '';
                    if(localStorage.getItem('costChoose') == '支付宝'){
                        accoNum = this.accountNum; 
                    }else{
                        accoNum = '微信账号'; 
                    }
                    // 如果是支付宝账户时候
                    if(localStorage.getItem('costChoose') == '支付宝'){
                        // 判断输入内容是否为正确格式
                        if((Alipay_num.test(this.accountNum) || tel.test(this.accountNum)) && reg.test(this.postalNum)){
                            // 判断输出金额是否大于可提现金额总数
                            if(parseFloat(this.postalNum) > parseFloat(this.money)){
                                Toast('您输入金额不得大于总的可提现金额');    
                            }else{
                                axios.post('/api/user/myBalanceExtract',qs.stringify({
                                    balance:balance
                                })).then((res) => {
                                    localStorage.setItem('confirmRooty','postal')
                                    
                                    this.$router.push({
                                        path:'/Progress',
                                        name:'confirm',
                                        params:{
                                            money:balance,
                                            accoNum:accoNum
                                        }
                                    })
                                }).catch((err) => {
                                    console.log(err)
                                })
                            }
                        }else{
                            Toast('您输入得格式不正确');
                        }
                    }
                    // 如果是微信账户时候                    
                    if(localStorage.getItem('costChoose') == '微信'){
                        // 输出金额是否为两位小数
                        if(reg.test(this.postalNum)){
                            // 判断提现金额是否大于总金额
                            if(parseFloat(this.postalNum) > parseFloat(this.money)){
                                Toast('您输入金额不得大于总的可提现金额');    
                            }else{
                                axios.post('/api/user/myBalanceExtract',qs.stringify({
                                    cash_money:balance
                                })).then((res) => {
                                    // 判断是否已经进行过提现操作
                                    localStorage.setItem('confirmRooty','postal')
                                    
                                    this.$router.push({
                                        path:'/Progress',
                                        name:'confirm',
                                        params:{
                                            money:balance,
                                            accoNum:accoNum
                                        }
                                    })
                                }).catch((err) => {
                                    console.log(err)
                                })
                            }
                        }else{
                            Toast('您输入得格式不正确');
                        }
                    }
                }
            },
            // 打开选择框
            choosePostal(){
                this.isOk = true;
                this.accountNum = '';
                this.postalNum = '';
            },
            // 选择支付方式
            choose(){
                this.costChoose = this.value;
                this.isOk = false;
            },
            // 判断支付选择添加按钮样式
            complete(){
                if(this.costChoose == '支付宝'){
                    if(this.accountNum&&this.postalNum){
                        return true
                    }else{
                        return false
                    }
                }
                if(this.costChoose == '微信'){
                   if(this.postalNum){
                        return true
                    }else{
                        return false
                    } 
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .postal_box{
        .postal_choose{
            background-color: #fff;
            padding-left: 0.2rem;
            padding-right: 0.2rem;
            padding-top: 0.3rem;
            h5{
                line-height: 0.38rem;
                font-size: 0.34rem;
                color: #333;
                margin-bottom: 0.1rem;
            }
            p{
                position: relative;
                height: 0.8rem;
                line-height: 0.8rem;
                box-sizing: border-box;
                border-bottom: 2px solid #ddd;
                padding-left: 0.1rem;
                &:last-child{
                    border-bottom: none 0;
                }
                &.postal_money{
                    color: #ec534e;
                    font-size: 0.34rem;
                    font-weight: bold;
                    padding-left: 0;
                    .money_num{
                        font-size: 0.46rem;
                        font-weight: normal;
                    }
                }
                &.postal_mode{
                    .mode{
                        font-size: 0.34rem;
                        color: #333;
                        float: left;
                    }
                    .icon{
                        position: absolute;
                        font-size: 0.3rem;
                        top: 0.04rem;
                        right: 0.2rem;
                    }
                }
                input{
                    display: block;
                    line-height: 0.76rem;
                    border: none 0;
                    color: #333 !important;
                    font-size: 0.36rem;
                    width: 100%;
                }
                
                input[placeholder], [placeholder], *[placeholder] { 
                    color:#ddd; 
                } 
                
            }
        }
        .withdrawals_btn{
            display: block;
            width: 6.91rem;
            margin: 0.5rem auto 0;
            border-radius: 0.19rem;
            background-color: #d4d4d4;
            color: #fff;
            font-size: 0.32rem;
            font-weight: bold;
            font-family: 'PingFang-SC-Bold';
            border: none 0;
            height: 0.89rem;
            &.current{
                background-color:#FFDC4B;
                color: #333;
            }
        }
        .b_bg{
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,.5);
            .choose_box{
                position: absolute;
                left: 50%;
                top: 50%;
                width: 4.6rem;
                background-color: #fff;
                transform: translate(-50%,-50%);
                border-radius: 0.2rem;
                padding-top: 0.2rem;
                padding-bottom: 0.2rem;
                h3{
                    color:#333;
                    font-size: 0.36rem;
                    font-weight: bold;
                    font-family:'PingFang-SC-Bold'; 
                    text-align: center;
                }
                .choose_btn{
                    display: table;
                    
                    text-align: center;
                    margin:0.32rem auto 0;
                    a{
                        float: left;
                        box-sizing: border-box;
                        width: 1.88rem;
                        height: 0.63rem;
                        color: #333;
                        border-radius: 0.1rem;
                        border:none 0;
                        font-size: 0.3rem;
                        text-align: center;
                        line-height: 0.63rem;
                        &.cancel_btn{
                            border:1px solid #666;
                            margin-right: 0.2rem;
                            background-color: #fff;
                        }
                        &.ensure_btn{
                            background-color: #ffdc48;
                        }
                    }
                }
                .icon{
                    position: absolute;
                    font-size: 0.28rem;
                    color: #999;
                    top: 0.2rem;
                    right: 0.2rem;
                }
            }
        }
    }
    
</style>
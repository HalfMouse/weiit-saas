<template>
    <div class="verification">
        <ul>
            <li class="clearfix">
                <input type="number" placeholder="请输入新的手机号" class="new_tel" v-model="newTel"/>
                <span class="get_code" @click="getCode()">获取验证码</span>
            </li>
            <li>
                <input type="number" maxlength="6" placeholder="请输入验证码" class="inp_code">
            </li>
        </ul>
        <button class="ensure" @click="ensure()">确定</button>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 从mint-ui中引入popup
    import { Popup } from 'mint-ui';
    export default {
        data(){
            return {
                newTel:'',
                code:'123456'
            }
        },
        methods:{
            // 判断是否为正确手机号码
            isTel(){
                let reg = /^1[3|4|5|8][0-9]\d{8}$/;
                if (reg.test(this.newTel)) {
                    return true;
                }
            },
            // 获取新手机号验证码
            getCode(){
                if (this.isTel()) {
                    let user_account = this.newTel;
                   axios.post('/api/user/verificationCode',qs.stringify({
                       user_account:user_account
                   }))
                }
            },
            // 确认修改信息
            ensure(){
                let user_account = this.newTel;
                if(this.code.length == 6 && this.isTel()){
                    axios.post('/api/user/updateUserInfo',qs.stringify({
                        code:'123456',
                        user_account:this.newTel
                    })).then((res) => {
                        let msg = res.data.message;
                        if(msg == "修改成功"){
                            this.$router.push({
                                path:'/Personal'
                            })
                        }else{
                            
                        }
                    }).catch((err) => {
                        console.log(err)
                    })
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .verification{
        padding-top: 0.2rem;
        ul{
            background-color: #fff;
            li{
                box-sizing: border-box;
                height: 1rem;
                padding: 0 0.2rem;
                font-size: 0.26rem;
                line-height: 0.98rem;
                border-bottom: 1px solid #f5f5f5;
                input{
                    line-height: 0.98rem;
                }
                .new_tel{
                    float: left;
                    width: 70%;
                    
                }
                .get_code{
                    width: calc(30% - 0.3rem);
                    float: right;
                    font-size: 0.26rem;
                    color: #333;
                    height: 0.26rem;
                    border-left: 1px solid #666;
                    box-sizing: border-box;
                    line-height: 0.26rem;
                    margin-top: 0.36rem;
                    padding-left: 0.3rem;
                }
                .inp_code{
                    width: 100%;
                }
            }
        }
        .ensure{
            display: block;
            width:6.91rem;
            height:0.89rem;
            background:rgba(255,220,75,1);
            border-radius: 0.19rem ; 
            color: #333;
            font-size: 0.32rem;
            margin: 0.4rem auto 0;
        }
    }
</style>
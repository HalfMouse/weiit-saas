<template>
    <div class="setPerson">
        <div class="person_information">
            <ul>
                <li>
                    <p class="information">头像</p>
                    <div class="set_tel">
                        <div class="person_pic">
                            <img :src="personPic" alt="">
                        </div>
                        <i class="icon iconfont icon-youjiantouda"></i>
                    </div>
                </li>
                <li>
                    <div class="user_tel">
                        <label>昵称</label>
                        <p>{{userName}}</p>
                    </div>
                </li>
                <li>
                    <div class="user_tel">
                        <label>生日</label>
                        <p>{{userBirthday}}</p>
                    </div>
                </li>
                <li>
                    <p class="information">性别</p>
                    <div class="set_sex">
                        <label class="mint-radiolist-label">
                            <span class="mint-radio">
                                <input type="radio" class="mint-radio-input" value="man" v-model="sexSet"> 
                                <span class="mint-radio-core"></span>
                            </span> 
                            <span class="mint-radio-label">男</span>
                        </label>
                        <label class="mint-radiolist-label">
                            <span class="mint-radio">
                                <input type="radio" class="mint-radio-input" value="women" v-model="sexSet"> 
                                <span class="mint-radio-core"></span>
                            </span> 
                            <span class="mint-radio-label">女</span>
                        </label>
                    </div>
                </li>
                <li>
                    <div class="user_tel" v-if="user_phone && user_phone !== ''">
                        <label>电话号码</label>
                        <p>{{user_tel}}</p>
                    </div>
                    <div class="user_tel" v-else>
                        <label>电话号码</label>
                        <input type="number" v-model="user_tel" placeholder="请输入手机号码"/>
                        <a href="javascript:;" class="getCode" @click="getCode()">获取验证码</a>
                    </div>
                    
                </li>
            </ul>
        </div>
        <div class="popup-win" v-show="isCoding">
            <div class="input-code">
                <input type="number" placeholder="请输入短信验证码" v-model="inputCode">
                <a href="javascript:;" @click="ensuerBinding()">确认绑定</a>
            </div>
            
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    import qs from 'qs';
    // 从mint-ui中引入radio
    import {Radio,Toast} from 'mint-ui'
    export default {
        data(){
            return{
                personPic:'',
                sexSet:'man',
                userName:'',
                userBirthday:'',
                user_tel:'',
                inputCode:'',
                isCoding:false,
                user_phone:''
            }
        },
        methods:{
            // 获取个人信息
            getuserInfo(){
                axios.post('/api/user/userInfo',null)
                    .then((res) => {
                        if(res.data.code == '0'){
                            console.log(res);
                            this.userBirthday = res.data.data.user_birthday;
                            this.userName = res.data.data.user_name;
                            this.personPic = res.data.data.user_img;
                            this.user_phone = res.data.data.user_phone;
                            if(res.data.data.user_sex == '1'){
                                this.sexSet = 'man';
                            }else{
                                this.sexSet = 'women'
                            }
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            },
            // 获取短信验证码
            getCode(){
                let tel = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
                if(tel.test(this.user_tel)){
                    axios.post('/api/integral/getValidateCode',qs.stringify({
                        mobilePhone:this.user_tel
                    })).then(res => {
                        
                    }).catch(err => {
                        console.log(err);
                    }) 
                    this.isCoding = true;
                }else{
                    Toast('请输入电话正确格式')
                }
            },
            // 绑定账户
            ensuerBinding(){
                axios.post('/api/integral/updateUserPhoneInfo',qs.stringify({
                    mobilePhone:this.user_tel,
                    validateCode:this.inputCode
                })).then(res => {
                    if(res.data.code == '0'){
                        Toast('绑定成功');
                        this.inputCode = '';
                        this.isCoding = false;
                        this.user_phone = this.user_tel
                    }else{
                        Toast(res.data.message);
                        this.inputCode = '';
                    }
                    
                }).catch(err => {
                    console.log(err);
                })
            }
        },
        mounted(){
            this.getuserInfo()
        }
    }
</script>

<style scoped lang="scss">
    .setPerson{
        .person_information{
            background-color: #fff;
            ul{
                li{
                    border-bottom: 2px solid #d9d9d9;
                    padding: 0 0.2rem;
                    line-height: 1rem;
                    height: 1rem;
                    overflow: hidden;
                    &:last-child{
                        border:none 0;
                    }
                    .information{
                        color: #333;
                        font-size: 0.26rem;
                        float: left;
                        input{
                            margin-left: 0.1rem;
                        }
                    }
                    .set_tel{
                        float: right;
                        color: #666;
                        font-size: 0.26rem;
                        overflow: hidden;
                        .person_pic{
                            float: left;
                            width: 0.81rem;
                            height: 0.81rem;
                            border-radius: 50%;
                            overflow: hidden;
                            display: inline-block;
                            margin-top: 0.1rem;
                            img{
                                width: 100%;
                                height: 100%;
                            }
                        }
                        .icon{
                            float: right;
                            font-size: 0.23rem;
                            color: #aaa;
                            display: inline-block;
                            margin-left: 0.2rem;
                        }
                    }
                    .set_sex{
                        float: right;
                        height: 1rem;
                        line-height: 1rem;
                        .mint-radiolist-label{
                            height: 1rem;
                            line-height: 1rem;
                            float: left;
                            padding: 0;
                            margin-left: 0.4rem;
                            margin-right: 0.05rem;
                            .mint-radio{
                                float: left;
                                .mint-radio-core{
                                    display: block;
                                    margin-top: 0.3rem;
                                }
                            }
                            .mint-radio-label{
                                float: left;
                                font-size: 0.26rem;
                                color: #333;
                                margin-left: 0.2rem;
                            }
                        }
                    }
                    .user_tel{
                        overflow: hidden;
                        position: relative;
                        label,input{
                            float: left;
                            font-size: 0.3rem;
                        }
                        input{
                            margin-left: 0.2rem;
                            padding-left: 0.1rem;
                            line-height: 0.6rem;
                            margin-top:0.2rem;
                            width: 3.3rem;
                        }
                        a{
                            position: absolute;
                            border: 1px solid #666;
                            color: #666;
                            font-size: 0.3rem;
                            right: 0.1rem;
                            line-height: 0.5rem;
                            height: 0.5rem;
                            border-radius: 0.1rem;
                            padding: 0 0.2rem;
                            top: 50%;
                            transform: translateY(-50%);
                        }
                        p{
                            float: right;
                            font-size: 0.3rem;
                        }
                    }
                }
            }
        }
        .popup-win{
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, .8);
            z-index: 20; 
            .input-code{
                position: absolute;
                left: 50%;
                top: 50%;
                width: 80%;
                transform: translate(-50%, -50%);
                input{
                    width: 100%;
                    margin-bottom: 0.2rem;
                    line-height: 0.6rem;
                    height: 0.6rem;
                    font-size: 0.3rem;
                    text-align: center;
                    border-bottom: 1px solid #666;
                }
                a{
                    display: block;
                    width: 90%;
                    margin: 0 auto;
                    color: #fff;
                    background-color: #38f;
                    text-align: center;
                    line-height: 0.8rem;
                    border-radius: 0.2rem;
                    font-size: 0.3rem;
                    border-radius: 0.1rem;
                }
            }
        }
    }
</style>
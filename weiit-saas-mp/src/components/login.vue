<template>
    <div class="login_bg" v-show="isLogin">
        <div class="login_win" v-show="isShow">
            <h3>登陆</h3>
            <input id="tel" type="number" placeholder="请输入手机号" class="tel_num" v-model="code" autofocus="autofocus">
            <button class="next_step" @click="next()" :class="{active : isTel()}">下一步</button>
            <p class="choose_login">
                <a href="javascript:;">微信及其他登陆方式</a>
            </p>
            <i class="icon iconfont icon-cha" @click="isLogin = false"></i>
        </div>
        <div class="input_code" v-show="!isShow">
            <h3>输入验证码</h3>
            <div class="code_box clearfix">
                <div class="tel_information clearfix">
                    <span class="tel_code fl">{{code}}</span>
                    <button class="resend fl">重新发送</button>
                    <a href="javascript:;" class="not_received fl clearfix">
                        <span>没收到</span>  
                        <i class="icon iconfont icon-sanjiaoright"></i>
                    </a>
                </div>
                <div class="verificationCode_box clearfix" ref="verification">
                    <!-- <input type="number" max="1" class="verificationCode" ref="var1" v-model="var1">
                    <input type="number" max="1" class="verificationCode" v-model="var2">
                    <input type="number" max="1" class="verificationCode" v-model="var3">
                    <input type="number" max="1" class="verificationCode" v-model="var4">
                    <input type="number" max="1" class="verificationCode" v-model="var5">
                    <input type="number" max="1" class="verificationCode" v-model="var6" @keyup="login()"> -->
                    <input type="text" class="verification_input" maxlength="6" v-model="verCode" @keyup="Verification()">
                    <i class="verificationCode"></i>
                    <i class="verificationCode"></i>
                    <i class="verificationCode"></i>
                    <i class="verificationCode"></i>
                    <i class="verificationCode"></i>
                    <i class="verificationCode"></i>
                    <!-- <div class="sms_input">
                        <div v-for="n in sms.numbers-1"><input v-if="sms.show[n-1]" disabled="true" v-model="sms.msg[n-1]"></div>
                        <div><input v-if="sms.show[sms.numbers-1]" v-model="sms.msg[sms.numbers-1]" pattern="[0-9]*" type="number" ref="sms_input" @keyup="sms_input($event)" oninput="if(value.length>1)value=value.slice(0,1)"></div>
                        <div v-for="n in sms.numbers-1"><input v-if="sms.show[n+sms.numbers-1]" disabled="true"></div>
                    </div> -->
                </div>
            </div>
            <i class="icon iconfont icon-arrow-left" @click="isShow = true"></i>
            <i class="icon iconfont icon-cha" @click="close()"></i>
        </div>
        
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs'
    export default {
        data(){
            return {
                isLogin:false,
                isShow:true,
                code:'',
                verCode:'',
                sms: {
                    numbers: 4,
                    msg: [],
                    show: [],
                    position: 0
                },
            }
        },
        methods:{
            isTel(){
                let reg = /^1[3|4|5|8][0-9]\d{8}$/;
                if (reg.test(this.code)) {
                    return true;
                }
            },
            next(){
                if(this.isTel()){
                    this.isShow = false;
                    axios.post('/api/verificationCode', qs.stringify({
                        user_account:this.code
                    }))
                    .then(function (res) {
                        this.$router.push({
                            path:'/Personal'
                        })
                        this.verCode = '';
                        this.code = '';
                    })
                    .catch(function (error) {
                        console.log(error);
                    });
                }
            },
            show(){
                this.isLogin = true;
            },
            close(){
                this.isLogin = false;
                this.isShow = true;
                this.code = '';
                this.verCode = '';
            },
            touch(){
                // var childs = this.$refs.verification.children;
                // childs.forEach((element,index) => {
                // });
                // for(var i=0; i<this.$refs.verification.children.length; i++){
                //     i.addEventListener('touchend', 
                //         () => {
                //         var next = this.nextSibling;
                //         if(next.length > 0) {
                //                 next.focus();
                //             }
                //         }
                //     , false);
                // }
                
            },
            // 获取登陆验证码
            Verification(){
                if(this.verCode.length == 6){
                    axios.post('/api/login',qs.stringify({
                            user_account:this.code,
                            code:'123456'
                    })).then((res) => {
                        this.isLogin = false;
                        let user = res.data;
                        if(user.code == "0"){
                            let user_infor = user.data;
                            for(var x in user_infor){
                                localStorage.setItem(x,user_infor[x]);
                            }
                        }
                        this.$parent.existence();
                    }).catch((error) => {
                        console.log(error);
                    })
                }
            }
            // 验证码输入
            // _setSmsInputDisplay () {
            //    var arr = []
            //    for (var i = 0; i < this.sms.numbers * 2 - 1; i++) {
            //     arr.push(i >= this.sms.numbers - 1 - this.sms.position && i < this.sms.numbers - 1 - this.sms.position + this.sms.numbers ? 1 : 0)
            //    }
            //    this.sms.show = arr
            //   },
            //   _resetSms () {
            //    this.sms.msg = []
            //    for (var i = 0; i < this.sms.numbers; i++) {
            //     this.sms.msg.push(null)
            //    }
            //    this.sms.position = 0
            //    this._setSmsInputDisplay()
            //    this.$nextTick(function () {
            //     this.$refs.sms_input.focus()
            //    })
            //   },
            //   submit () {
            //    this.$api.post('signin', {
            //     mobile: this.mobile,
            //     captcha: this.captcha
            //    }, r => {
            //     this.$router.push('/main')
            //    })
            //   },
            //   sms_input (e) {
            //    if (e.keyCode === 8) { // 删除
            //     if (this.sms.position > 0) {
            //      this.sms.position--
            //      this.sms.msg.splice(-2, 1)
            //      this.sms.msg.unshift(null)
            //      this._setSmsInputDisplay()
            //     }
            //    } else if (e.keyCode >= 48 && e.keyCode <= 57) { // 仅可以输入数字
            //     if (this.sms.position < this.sms.numbers - 1) {
            //      this.sms.position++
            //      this.sms.msg.splice(-1, 1, String.fromCharCode(e.keyCode))
            //      this.sms.msg.shift()
            //      this.sms.msg.push(null)
            //      this._setSmsInputDisplay()
            //     } else {
            //      document.activeElement.blur() // hide keyboard for iOS
            //      this.submit()
            //     }
            //    } else {
            //     this.$refs.sms_input.value = '' // remove NaN
            //    }
            //   }
        },
        mounted(){
        }
        
    }
</script>

<style scoped lang="scss">
    @mixin login_title{
        text-align: center;
        font-size: 0.28rem;
        color: rgba(51,51,51,1);
        line-height: 0.26rem;
    }
    .login_bg{
        position: fixed;
        background: rgba(0, 0, 0, .65);
        z-index: 100;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        .login_win{
            position: absolute;
            width: 4.6rem;
            height: 3.2rem;
            background: #fff;
            border-radius: .1rem;
            left: 50%;
            top: 50%;
            margin-left: -2.3rem;
            margin-top: -1.6rem;
            padding-top: 0.16rem;
            h3{
                @include login_title;
            }
            .tel_num{
                display: block;
                width: 3.14rem;
                border-bottom: 1px solid #f00;
                line-height: 0.31rem;
                margin: 0.6rem auto 0.4rem;
                padding-left: 0.06rem;
                font-size: 0.22rem;
            }
            .next_step{
                display: block;
                width: 3.4rem;
                height: 0.6rem;
                background-color: rgba(212,212,212,1);
                border-radius: 0.1rem;
                color: #fff;
                font-size: 0.24rem;
                line-height: 0.6rem;
                font-size: 0.24rem;
                border:none 0;
                margin:0 auto;
                &.active{
                    background-color: rgba(255,220,75,1);
                    color:rgba(51,51,51,1);
                }
            }
            .choose_login{
                margin-top:0.4rem;
                text-align: center; 
                font-size: 0.22rem;
                a{
                    color: #333
                }
            }
        }
        .input_code{
            position: absolute;
            width: 4.6rem;
            height: 2.4rem;
            left: 50%;
            top: 50%;
            background-color: #fff;
            border-radius: 0.1rem;
            margin-left: -2.3rem;
            margin-top: -1.2rem;
            padding-top: 0.18rem;
            h3{
                @include login_title;
                margin-bottom: 0.6rem;
            }
            .code_box{
                .resend{
                    width: 1rem;
                    height: 0.4rem;
                    text-align: center;
                    line-height: 0.4rem;
                    margin:0 0.2rem;
                    border: 1px solid #000;
                    border-radius: 2px;
                    background-color: #fff;
                    font-size: 0.2rem;
                    margin-top: -0.05rem;
                }
                .not_received{
                    font-size: 0.2rem;
                    color:rgba(102,102,102,1);
                    .icon{
                        float: left;
                        font-size: 0.13rem;
                        color:#333;
                        line-height: 0.25rem;
                        margin-top: 0.05rem;
                    }
                    span{
                        float: left;
                    }
                }
                .verificationCode_box{
                    width:4.28rem;
                    margin:0.4rem auto 0;
                    text-align: center;
                    position: relative;
                    .verification_input{
                        position: absolute;
                        left: 0;
                        top: 0;
                        background-color: rgba(256,256,256,0);
                        height: 0.56rem;
                        width: calc(100% - 0.24rem);
                        padding-left: 0.24rem;
                        letter-spacing:0.61rem;
                        font-size: 0.2rem;
                    }
                    .verificationCode{
                        float: left;
                        width: 0.56rem;
                        height: 0.56rem;
                        background: #fff;
                        border:1px solid #999;
                        margin-right: 0.18rem;
                        box-sizing: border-box;
                        text-align: center;
                        line-height: 0.56rem;
                        &:last-child{
                            margin-right: 0;
                        }
                        &.current{
                            border-color: #333;
                        }
                    }
                }
            }
        }
        .tel_information{
            width: 86%;
            margin:0 auto;
            font-size: 0.2rem;
            color: #333;
            .icon-sanjiaoright{
                font-size: 0.13rem;
            }
        }
        .icon-cha{
            font-size: 0.2rem;
            position: absolute;
            top: 0.2rem;
            right: 0.2rem;
            color: #999;
        }
        .icon-arrow-left{
            position: absolute;
            left: 0.2rem;
            top: 0.2rem;
            font-size: 0.2rem;
            color: #999;

        }
    }
</style>
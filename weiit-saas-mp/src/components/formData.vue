<template>
    <div>
        <van-loading type="spinner" class="white loading"></van-loading>
    </div>
</template>

<script>
    import {getQueryString} from '../../static/js/getQueryString';
    import cookie from '../../static/js/cookies';
    import axios from 'axios';
    import qs from 'qs';
    export default {
        data(){
            return {  
            }
        },
        mounted(){
            let code = getQueryString("code");
            axios.post('/api/firewall',qs.stringify({
                url:location.href.split('#')[0]
            })).then((res) => {
                if(res.data.code == '0'){
                    let appId = res.data.data.appId;
                    let component_appid = res.data.data.component_appid;
                    let shop_name = res.data.data.shop_name;
                    let shop_logo = res.data.data.shop_logo;
                    localStorage.setItem('appid',appId);
                    localStorage.setItem('shop_name',shop_name);
                    localStorage.setItem('shop_logo',shop_logo)
                    let url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId + "&redirect_uri=" + location.href.split('#')[0] + "&response_type=code&scope=snsapi_userinfo&state=1&component_appid=" + component_appid + "&connect_redirect=1#wechat_redirect";
                    if(!code){
                        window.location.href = url;
                    }else{
                        this.getUser(code,appId);
                    }
                    axios.post('/api/initParam',qs.stringify({
                        appid:appId
                    })).then(res => {
                        if(res.data.code == '0'){
                            let navMenu = res.data.data.bottomMenuList;
                            let globalStyle = res.data.data.globalStyle;
                            localStorage.setItem('bottomMenuList',JSON.stringify(navMenu));
                            localStorage.setItem('bg1',globalStyle.global_bg1);
                            localStorage.setItem('bg2',globalStyle.global_bg2);
                        }
                    }).catch(err => {
                        console.log(err)
                    }) 
                }
            }).catch((err) => {
                console.log(err)
            })
            
        },
        methods: {
            

            // 获取个人信息
            getUser(code,appid){
                let url = localStorage.getItem('fromUrl');
                let share_user_id = localStorage.getItem('userId') ? localStorage.getItem('userId') : '';
                axios.post('/api/mpLogin',qs.stringify({
                    code:code,
                    appid:appid,
                    share_user_id:share_user_id
                })).then((res) => {  
                    if(res.data.code == '0'){
                        let token = res.data.data.token;
                        cookie.set('token',token + '');
                        localStorage.setItem('user_id',res.data.data.user_id);
                        localStorage.setItem('user_img',res.data.data.user_img);
                        localStorage.setItem('user_name',res.data.data.user_name);
                        window.location.href = url;
                    }
                }).catch((err) => {
                    console.log(err)
                })
            }
        },
    }
</script>

<style scoped>
    .loading{
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
    }
</style>
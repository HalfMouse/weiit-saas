<template>
    <div>
        <router-view></router-view>
    </div>
</template>

<script>
    //引入axios 
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    export default {
        beforeRouteEnter:(to,from,next)=>{
            var u = navigator.userAgent;
            //ios终端
            var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
            // XXX: 修复iOS版微信HTML5 History兼容性问题
            // if (isiOS && to.path !== location.pathname) {
            //     // 此处不可使用location.replace
            //     location.assign(to.fullPath)
            // } else {
            //     next()
            // }
            if (to.path !== location.pathname) {
                // 此处不可使用location.replace
                location.assign(to.fullPath)
            } else {
                next()
            }
             axios.post('/weixin/JSSDKWxConfig',qs.stringify({
                    currentUrl:location.href.split('#')[0],
                    appid:localStorage.getItem('appid')
                })).then((res) => {
                    wx.config({
                        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                        appId: res.data.data.appId, // 必填，公众号的唯一标识
                        timestamp: res.data.data.timeStamp, // 必填，生成签名的时间戳
                        nonceStr: res.data.data.nonceStr, // 必填，生成签名的随机串
                        signature: res.data.data.signature,// 必填，签名
                        jsApiList: [
                                    "onMenuShareTimeline",//分享朋友圈接口
                                    "onMenuShareAppMessage",//分享给朋友接口  
                                    "chooseWXPay"
                        ] // 必填，需要使用的JS接口列表
                    });
                }).catch((err) => {
                    console.log(err);
                })
            next();
        }
    }
</script>

<style scoped>

</style>
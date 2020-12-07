<template>
    <div class="fight_detail">
        <header class="fn-clear">
            <div class="tips">
                <h6>拼单成功</h6>
                <p>预计拼单成功后48小时内发货</p>
            </div>
            <div class="icon_pic">
                <img src="static/images/fightSuccess.png" alt="">
            </div>
        </header>
        <div class="address">
            <i class="icon iconfont icon-dizhi"></i>
            <div class="recipients">
                <p class="recipients_person">
                    <span>陈xx</span>
                    <span>1358888888</span>
                </p>
                <p class="recipients_address">广东省 深圳市 xx区 xx镇 xxxxxxx</p>
            </div>
        </div>
        <div class="partaker">
            <h5>拼团成功</h5>
            <ul class="clearfix">
                <li>
                    <div class="part_user">
                        <img src="static/images/person.jpg" alt="">
                    </div>
                </li>
                <li>
                    <div class="part_user">
                        <i class="icon iconfont icon-weizhiyonghu"></i>
                    </div>
                </li>
            </ul>
            <a href="javascript:;" class="customer_service">申请售后</a>
        </div>
        <div class="good_detail">
            <h6>折扣活动<i class="icon iconfont icon-youjiantouda"></i></h6>
            <div class="fightGoods">
                <div class="goods fn-clear">
                    <div class="goods_pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="goods_txt">
                        <div class="goods_info fn-clear">
                            <p class="goods_name">JEEP 吉普长袖衬衫男2018春季新款男士纯棉衬衣</p>
                            <div>
                                <span>￥166.6</span>
                                <i>x1</i>
                            </div>
                        </div>
                        <p class="goods_size">尺码：M 颜色：蓝色</p>
                    </div>
                </div>
                <div class="apply_btn">
                    <a href="javascript:;">申请退款</a>
                </div>
            </div>
            <p class="total_price">实付款：<span>￥166.6</span>（免运费）</p>
        </div>
        <div class="customer">
            <a href="javascript:;" class="seller_btn">
                <i class="icon iconfont icon-kujialeqiyezhan_zaixiankefu-"></i>
                <span>联 系 卖 家</span>
            </a>
            <a href="javascript:;" class="customer_btn">
                <i class="icon iconfont icon-dianhua"></i>
                <span>联 系 客 服</span>
            </a>
        </div>
        <div class="order_num">
            <p>订单编号:11111111111111111111111</p>
            <p>创建时间:8012-02-02 14:20:14</p>
            <p>发货时间:8012-02-02 14:20:14</p>
            <p>成交时间:8012-02-02 14:20:14</p>
            <div class="goods_btn clearfix">
                <button @click="lookLogistics()">查看物流</button>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        created(){
            this.$router.beforeEach((to, from, next) => {
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
                                    "startRecord",
                                    "stopRecord",
                                    "onVoiceRecordEnd",
                                    "playVoice",
                                    "pauseVoice",
                                    "chooseWXPay"
                        ] // 必填，需要使用的JS接口列表
                    });
                }).catch((err) => {
                    console.log(err);
                })
                wx.ready(function(res) {
                    wx.onMenuShareAppMessage({
                        title: "测试",
                        desc:"测试描述",
                        link: location.href.split('#')[0],
                        imgUrl: "http://wstore-1255653546.image.myqcloud.com//weiit_shop_platform/2018-04-27/e6b8750b-3ae5-4247-845f-77d45c110a25.jpg",
                        trigger: function(res) {},
                        success: function(res) {},
                        cancel: function(res) {},
                        fail: function(res) {}
                    });
                    wx.onMenuShareTimeline({
                        title: "测试",
                        desc:"测试描述",
                        link: location.href.split('#')[0],
                        imgUrl: "http://wstore-1255653546.image.myqcloud.com//weiit_shop_platform/2018-04-27/e6b8750b-3ae5-4247-845f-77d45c110a25.jpg",
                        trigger: function(res) {},
                        success: function(res) {},
                        cancel: function(res) {},
                        fail: function(res) {}
                    });
                });
                next()
            })
        }
    }
</script>

<style scoped lang="scss">
    .fight_detail{
        header{
            background-color: #E02E24;
            height: 1.76rem;
            padding: 0.3rem;
            margin-bottom:0.2rem;
            .tips{
                float: left;
                color: #fff;
                font-size: 0.3rem;
                margin-top: 0.35rem;
                h6{
                    margin-bottom: 0.2rem;
                }
            }
            .icon_pic{
                float: right;
                width: 1.58rem;
                img{
                    width: 100%;
                }
            }
        }
        .address{
            position: relative;
            background-color: #fff;
            height: 1.34rem;
            margin-bottom: 0.2rem;
            padding-left: 0.8rem;
            i.icon{
                position: absolute;
                color: #E1554D;
                font-size: 0.4rem;
                left: 0.2rem;
                top: 50%;
                transform: translateY(-50%);
            }
            .recipients{
                position: relative;
                top: 50%;
                transform: translateY(-50%);
                text-align: left;
                color: #333;
                width: 5.5rem;
                p{
                    color: #333;
                    font-size: 0.3rem;
                    width: 100%;
                }
            }
        }
        .partaker{
            position: relative;
            margin-bottom: 0.2rem;
            background-color: #fff;
            padding: 0.2rem 0.8rem;
            h5{
                font-size: 0.28rem;
                color: #333;
            }
            ul{
                margin-top: 0.3rem;
                li{
                    display: inline-block;
                    margin-right: 0.2rem;
                    margin-bottom: 0.2rem;
                    &:last-child{
                        margin-left: 0.05rem;
                    }
                    .part_user{
                        width: 1.05rem;
                        height: 1.05rem;
                        border-radius: 50%;
                        overflow: hidden;
                        img{
                            display: block;
                            width: 100%;
                            height: 100%;
                        }
                        i{
                            display: block;
                            font-size: 1.25rem;
                            color: #C1C1C1;
                            margin-top: -0.1rem;
                            margin-left: -0.05rem;
                        }
                    }
                }
            }
            .customer_service{
                position: absolute;
                bottom: 0.75rem;
                right: 0.2rem;
                height: 0.4rem;
                box-sizing: border-box;
                border: 1px solid #bbb;
                text-align: center;
                color: #666;
                font-size: 0.26rem;
                padding: 0 0.1rem;
                line-height: 0.4rem;
            }
        }
        .good_detail{
            margin-bottom: 0.2rem;
            background-color: #fff;
            h6{
                line-height: 0.56rem;
                padding-left: 0.2rem;
                color: #333;
                font-size: 0.24rem;
                i{
                    display: inline-block;
                    font-size: 0.13rem;
                    margin-left: 0.15rem;
                }
            }
            .fightGoods{
                background-color: #fafafa;
                padding: 0.2rem;
                padding-bottom: 0.1rem;
                .goods{
                    .goods_pic{
                        float: left;
                        width: 1.31rem;
                        height: 1.31rem;
                        img{
                            width: 100%;
                            height: 100%;
                        }
                    }
                    .goods_txt{
                        float: left; 
                        width: 5.6rem;
                        margin-left: 0.15rem;
                        border-bottom: 1px solid #ddd;
                        padding-bottom: 0.24rem;
                        .goods_info{
                            overflow: hidden;
                            p.goods_name{
                                float: left;
                                width: 4rem;
                                font-size:0.24rem;
                                color: #333; 
                            }
                            div{
                                float: right;
                                font-size: 0.24rem;
                                color: #666;
                                span{
                                    display: block;
                                }
                                i{
                                    display: block;
                                    text-align: right;
                                    font-style: normal;
                                }
                            }
                        }
                        .goods_size{
                            font-size: 0.24rem;
                            color: #666;
                            margin-top: 0.1rem;
                        }
                    }
                }
                .apply_btn{
                    padding: 0.1rem 0;
                    overflow: hidden;
                    a{
                        float:right;
                        font-size: 0.26rem;
                        color: #ec534e;
                        border: 1px solid #ec534e;
                        line-height: 0.4rem;
                        padding:0 0.1rem;
                    }
                }
            }
            .total_price{
                background-color: #fff;
                line-height: 0.56rem;
                text-align: right;
                font-size: 0.28rem;
                color: #666;
                span{
                    color: #ec534e;
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
                font-size: 0.36rem;
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
                font-size: 0.22rem;
                color: #666;
                margin-bottom: 0.05rem;
            }
            .goods_btn{
                text-align: right;
                button{
                    float: right;
                    background-color: #fff;
                    width: 1.31rem;
                    height: 0.4rem;
                    border-radius: 0.04rem;
                    border:1px solid #666;
                    font-size: 0.26rem;
                    margin-left: 0.2rem;
                }
            }
        }
    }
</style>
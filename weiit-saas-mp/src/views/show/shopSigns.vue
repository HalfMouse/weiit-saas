<template>
    <div class="showBox">
        <div class="shop_signs blankShow">
            <div class="type type1" v-if="showStyle == 'type1'">
                <div class="htBg">
                    <div class="bgPic">
                        <img src="static/images/bg.png" alt="" v-if="pageParam.bgPic == ''">
                        <img :src="bgPic" alt="" v-else>
                    </div>
                    <div class="bg">
                        
                    </div>
                </div>
                
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p>
                            <span class="discount_name">满减</span>
                            <span class="discount_txt">在线支付满150减30，满100减20</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="type type2" v-if="showStyle == 'type2'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="" v-if="pageParam.bgPic == ''">
                            <img :src="bgPic" alt="" v-else>
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p class="fn-clear">
                            <span class="discount_name">全部商品</span>
                            <span class="nt">|</span>
                            <span class="discount_txt">上新30</span>
                        </p>
                    </div>
                </div>
                <div class="more"></div>
            </div>
            <div class="type type2 type3" v-if="showStyle == 'type3'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="" v-if="pageParam.bgPic == ''">
                            <img :src="bgPic" alt="" v-else>
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p>
                            <span class="discount_name">全部商品</span>
                            <span class="nt">|</span>
                            <span class="discount_txt">上新30</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="type type4" v-if="showStyle == 'type4'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="" v-if="pageParam.bgPic == ''">
                            <img :src="bgPic" alt="" v-else>
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p class="fn-clear">
                            <span class="discount_name">全部商品</span>
                            <span class="nt">|</span>
                            <span class="discount_txt">上新30</span>
                        </p>
                    </div>
                </div>
                <div class="more"></div>
            </div>
            <div class="type type4 type5" v-if="showStyle == 'type5'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="" v-if="pageParam.bgPic == ''">
                            <img :src="bgPic" alt="" v-else>
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p>
                            <span class="discount_name">全部商品</span>
                            <span class="nt">|</span>
                            <span class="discount_txt">上新30</span>
                        </p>
                    </div>
                    <span class="line"></span>
                </div>
            </div>
        </div>
    </div> 
</template>

<script>
    export default {
        props:{
            pageParam:{
                type:Object,
                default:() => {
                    return {showStyle:'type3',bgPic:''}
                },
            }
            
        },
        data() {
            return {
                showStyle: 'type1',
                isOk:false,
                bgPic:'',
                count:2
            }
        },
        mounted(){
            this.showStyle = this.pageParam.showStyle;
            this.bgPic = this.pageParam.bgPic.replace(this.$url,'');
        }
    }
</script>

<style scoped>
    .type{
        position: relative;
    }
    
    .htBg{
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
    }
    .bg{
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,.3);
        z-index: 2;
    }
    .bgPic img{
        position: absolute;
        width: 100%;
        height: 100%;
        z-index: 1;
    }
    /* 样式1 */
    .type1{
        height: 3.7rem;
        background-size: 100% 100%;
    }
    .type2 .shop_info,
    .type1 .shop_info{
        position: absolute;
        z-index: 5;
        bottom: 0.2rem;
        padding-left: 0.3rem;
    }
    .type2 .shop_info .pic,
    .type1 .shop_info .pic{
        float: left;
        width: 1.16rem;
        height: 1.16rem;
        border: 1px solid #fff;
    }
    .type2 .shop_info .pic img,
    .type1 .shop_info .pic img{
        width: 100%;
        height: 100%;
    }
    .type2 .shop_info .txt,
    .type1 .shop_info .txt{
        margin-left: 1.4rem;
        font-size: 0.3rem;
    }
    .type2 .shop_info .txt h5,
    .type1 .shop_info .txt h5{
        margin-top: 0.2rem;
        max-width: 4.4rem;
        font-size: 0.36rem;
        line-height: 0.44rem;
        font-weight: 700;
        color: #fff;
        text-shadow: 0 1px 0.3rem rgba(0,0,0,.5);
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        /*! autoprefixer: off */
        -webkit-box-orient: vertical;
        /* autoprefixer: on */
    }
    .type1 .shop_info .txt p{
        position: relative;
        margin: 0.16rem 0.3rem 0 0;
        padding-right: 0.2rem;
        color: #fff;
        cursor: pointer;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        /*! autoprefixer: off */
        -webkit-box-orient: vertical;
        /* autoprefixer: on */
    }
    .type1 .shop_info .txt p .discount_name{
        display: inline-block;
        background-color: #f44;
        padding: 0 0.04rem;
        font-size: 0.3rem;
    }
    /* 样式2 */
    .type2{
        height: 4.8rem;
    }
    .type2 .type_bg{
        position: relative;
        height: 3.7rem;
        background-size: 100% 100%;
    }
    .type2 .type_bg .htBg{
        position: absolute;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
        background-color: transparent;
        background-image: -ms-gradient(linear,left bottom,left top,from(#000),to(transparent));
        background-image: -webkit-linear-gradient(bottom,#000,transparent);
        background-image: -moz-linear-gradient(bottom,#000,transparent);
        background-image: linear-gradient(0deg,#000,transparent);
    }
    .type2 .shop_info{
        bottom: 0.54rem;
    }
    .type2 .shop_info .pic{
        border-radius: 50%;
        overflow: hidden;
    }
    .type2 .shop_info .txt h5{
        margin-top: 0.1rem;
    }
    .type2 .shop_info p{
        margin-top: 0.3rem;
    }
    .type2 .shop_info p span{
        float: left;
        color: #999;
        font-size: 0.24rem;
    }
    .type2 .shop_info p span.nt{
        margin: 0 0.2rem;
    }
    .type2 .more{
        position: absolute;
        left: 0;
        top: 3.7rem;
        width: 100%;
        background-color: #fff;
        height: 1.06rem;
    }
    /* 样式3 */
    .type3{
        height: 3.7rem;
    }
    .type3 .shop_info{
        bottom: 0.2rem;
    }
    .type3 .shop_info .pic{
        border-radius: 0;
        
    }
    /* 样式4 */
    .type4{
        position: relative;
        height: 5.2rem;
    }
    .type4 .type_bg{
        position: relative;
        height: 3rem;
        background-size: 100% 100%;
    }
    .type4 .more{
        position: absolute;
        left: 0;
        top: 3rem;
        width: 100%;
        background-color: #fff;
        height: 2.16rem;
    }
    .type4 .shop_info{
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        text-align: center;
        z-index: 5;
        top: 2.4rem;
    }
    .type4 .shop_info .pic{
        width: 1.16rem;
        height: 1.16rem;
        border: 1px solid #fff;
        border-radius: 50%;
        overflow: hidden;
        margin: 0 auto;
    }
    .type4 .shop_info .pic img{
        width: 100%;
        height: 100%;
    }
    .type4 .shop_info .txt{
        margin-top: -0.4rem;
    }
    .type4 .shop_info .txt h5{
        display: inline-block;
        max-width: 100%;
        color: #333;
        text-shadow: none;
        font-size: 0.36rem;
        line-height: 0.44rem;
        font-weight: 700;
        overflow: hidden;
        text-overflow: ellipsis;
        -webkit-line-clamp: 1;
        /*! autoprefixer: off */
        -webkit-box-orient: vertical;
        /* autoprefixer: on */
    }
    .type4 .shop_info .txt p span{
        display: inline-block;
        color: #999;
        font-size: 0.36rem;
    }
    .type4 .shop_info .txt p span.nt{
        margin: 0 0.2rem;
    }
    /* 样式5 */
    .type5{
      height: 5rem;
    }
    .type5 .type_bg{
        height: 5rem;
    }
    .type5 .shop_info{
        top:50%;
        transform: translate(-50%,-50%);
    }
    .type5 .shop_info .txt p span{
        color: #fff;
    } 
    .type5 .shop_info .txt h5{
        color: #fff;
    }
    .type5 .line{
        position: absolute;
        top: 2.18rem;
        left: 50%;
        margin-left: -1.3rem;
        width: 2.6rem;
        height: 1px;
        background-color: #fff;
    }
    
</style>
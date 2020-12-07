<template>
    <div class="goods">
        <!-- 详情选择 -->
        <div class="bargain_good fn-clear" v-if="goods.goodStyle == 'detail'">
            <div class="goods_list">
                <ul v-if="bargainGoods.length == 0">
                    <li class="fn-clear">
                        <div class="goods_pic">
                            <img src="static/images/user.jpg" alt="" draggable="false">
                        </div>
                        <div class="goods_mations">
                            <div class="time fn-clear" v-if="goods.countDown">
                                <span>2</span>
                                <span>3</span>
                                <span class="symbol">:</span>
                                <span>5</span>
                                <span>9</span>
                            </div>
                            <p class="des">2018春季新2018春季新2018春季新</p>
                            <div class="goods_content">
                                <span class="good_price">￥166.6</span>
                                <span class="good_stock" v-if="goods.stock">剩余15件</span>
                            </div>
                        </div>
                        <a href="javascript:;" class="help" v-if="goods.bargainBtn && goods.btnStyle == 'style1'">帮我砍价</a>
                        <a href="javascript:;" class="help help1" v-if="goods.bargainBtn && goods.btnStyle == 'style2'">帮我砍价</a>
                    </li>
                </ul>
                <ul v-else>
                    <li v-for="(item,index) in bargainGoods" class="fn-clear">
                        <div class="goods_pic">
                            <img :src="imageDomaia + item.product_img" alt="" draggable="false">
                        </div>
                        <div class="goods_mations">
                            <div class="time fn-clear" v-if="goods.countDown">
                                <span>2</span>
                                <span>3</span>
                                <span class="symbol">:</span>
                                <span>5</span>
                                <span>9</span>
                            </div>
                            <p class="des">{{item.product_name}}</p>
                            <div class="goods_content">
                                <span class="good_price">￥{{item.max_price}}</span>
                                <span class="good_stock" v-if="goods.stock">剩余{{item.stock}}件</span>
                            </div>
                        </div>
                        <a href="javascript:;" class="help" v-if="goods.bargainBtn && goods.btnStyle == 'style1'">帮我砍价</a>
                        <a href="javascript:;" class="help help1" v-if="goods.bargainBtn && goods.btnStyle == 'style2'">帮我砍价</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- 大图列表 -->
        <div class="bargain_good1 fn-clear" v-if="goods.goodStyle == 'big'">
            <!--<div class="remaining_time">
                <p class="time_title">距离本场砍价结束还剩</p>
                <p class="times"><i class="icon iconfont icon-shijian"></i>2天10时10分10秒</p>
            </div>-->
            <div class="goods_list1">
                <ul v-if="bargainGoods.length == 0" class="fn-clear">
                    <li>
                        <div class="goodsPic">
                            <img src="static/images/user.jpg" alt="" draggable="false">
                        </div>
                        <p>邦购美特斯邦威2018a春装新款防风夹克男户外运动...</p>
                        <div class="goods_content">
                            <span class="good_price">￥166.6</span>
                            <span class="good_stock" v-if="goods.stock">剩余15件</span>
                        </div>
                        <a href="javascript:;" class="help" v-if="goods.bargainBtn && goods.btnStyle == 'style1'">砍价</a>
                        <a href="javascript:;" class="help help1" v-if="goods.bargainBtn && goods.btnStyle == 'style2'">砍价</a>
                    </li>
                </ul>
                <ul v-else>
                    <li v-for="(item,index) in bargainGoods" class="fn-clear">
                        <div class="goodsPic">
                            <img :src="imageDomaia + item.product_img" alt="" draggable="false">
                        </div>
                        <p>{{item.product_name}}</p>
                        <div class="goods_content">
                            <span class="good_price">￥{{item.max_price}}</span>
                            <span class="good_stock" v-if="goods.stock">剩余{{item.stock}}件</span>
                        </div>
                        <a href="javascript:;" class="help" v-if="goods.bargainBtn && goods.btnStyle == 'style1'">砍价</a>
                        <a href="javascript:;" class="help help1" v-if="goods.bargainBtn && goods.btnStyle == 'style2'">砍价</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data(){
            return{
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
            }
        },
        props:['goods','bargainGoods']
    }
</script>

<style scoped>
    .bargain_good{
        background-color: #fff;
        padding: 0 6px;
    }
    .goods_pic,
    .goods_mations,
    .help{
        float: left;
    }
    /* 商品图片 */
    .goods_pic{
        width: 66px;
        height: 66px;
    }
    .goods_pic img{
        width: 100%;
        height: 100%;
    }
    /* 商品主要信息 */
    .goods_mations{
        width: 180px;
        margin:0 2px;
    }
    .goods_mations .time{
        display: table;
        margin: 0 auto;
    }
    .goods_mations .time span{
        float: left;
        width: 18px;
        height: 20px;
        line-height: 20px;
        text-align: center;
        background-color: #000;
        color: #fff;
        margin-right: 3px;
        border-radius: 3px;
    }
    .goods_mations .time span.symbol{
        background-color: #fff;
        color: #000;
        width: 8px;
    }
    .goods_mations p.des{
        text-overflow:ellipsis;
        white-space:nowrap;
        overflow:hidden;
        margin:4px 0;
    }
    .goods_content span{
        display: inline-block;
        font-size: 12px;
    }
    .goods_content .good_price{
        color: #ec534e;
    }
    .goods_content .good_stock{
        color: #999; 
    }
    /* 帮忙砍价 */
    .goods_list ul li .help{
        width: 44px;
        height: 44px;
        text-align: center;
        padding: 6px;
        background-color: #ff5151;
        border-radius: 4px;
        color: #fff;
        font-size: 15px;
        margin-top: 21px;
        box-sizing: border-box;
        border: 1px solid #ff5151;
        line-height: 16px;
    }
    .goods_list ul li .help1{
        background-color:#fff;
        color: #ff5151;
    }
    .goods_list ul li,
    .goods_list1 ul li{
        margin-bottom: 15px;
    }
    /* 详情列表 */
    .bargain_good1{
        background-color: #fafafa;
        padding: 0 6px;
    }
    .remaining_time{
        margin-top: 10px;
        text-align: center;
        margin-bottom: 20px;
    }
    .time_title{
        font-size: 14px;
        color: #999;
        margin-bottom: 5px;
    }
    .times{
        font-size: 16px;
        color: #666;
        line-height: 20px;
    }
    .times .icon{
        font-size: 20px;
        display: inline-block;
        margin-right: 5px;
        color: #666;
    }
    .goods_list1 ul{
        margin-right: -5px;
    }
    .goods_list1 ul li{
        float: left;
        position: relative;
        width: 150px;
        background-color: #fff;
        padding-bottom: 10px;
        margin-right: 5px;
    }
    .goods_list1 ul li .goodsPic{
        height: 145px;
        margin:0 auto;
    }
    .goods_list1 ul li .goodsPic img{
        width: 100%;
        height: 100%;
    }
    .goods_list1 ul li p{
        width: 160px;
        text-overflow:ellipsis;
        white-space:nowrap;
        overflow:hidden;
        color: #333;
        font-size: 14px;
        margin-top: 10px; 
        margin-bottom: 5px;
    }
    .goods_list1 ul li .help{
        position: absolute;
        right: 0px;
        bottom: 7px;
        height: 25px;
        color: #fff;
        font-size: 14px;
        line-height: 100%;
        box-sizing: border-box;
        border: 1px solid #ff5151;
        background-color: #ff5151;
        line-height: 22px;
        padding: 0 5px;
    }
    .goods_list1 ul li .help1{
        background-color: #fff;
        color: #ff5151;
    }
</style>
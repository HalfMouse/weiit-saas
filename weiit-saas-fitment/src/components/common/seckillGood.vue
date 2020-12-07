<template>
    <div class="goods">
        <div class="good_box fn-clear" :class="[{'big_good':goodStyle == 'big'},{'matrix_good':goodStyle == 'matrix'},{'list_good':goodStyle == 'list'}]">
            <div class="goodShow">
                <img src="static/images/goods.png" alt="" draggable="false">
                <div class="seckill_infor fn-clear" v-if="goodStyle == 'big'">
                    <span>秒杀</span>
                    <div class="cap-ump-seckill-goods__tag-countdown">
                        <span class="cap-ump-seckill-goods__countdown-text">距结束仅剩</span>
                        <div class="cap-countdown cap-countdown--white">
                            <span class="cap-countdown__hour">00</span>
                            <span class="cap-countdown__time-text">:</span>
                            <span class="cap-countdown__minute">00</span>
                            <span class="cap-countdown__time-text">:</span>
                            <span class="cap-countdown__second">00</span>
                        </div>
                    </div>
                </div>
                <div class="matrix_seckill fn-clear" v-if="goodStyle == 'matrix' && seckill.fightTime">
                    <span class="seckill_txt">距结束仅剩</span>
                    <div class="seckill_time">
                        <span class="seckill_time_hour">00</span>
                        <span class="seckill_time_txt">:</span>
                        <span class="seckill_time_minute">00</span>
                        <span class="seckill_time_txt">:</span>
                        <span class="seckill_time_second">00</span>
                    </div>
                </div>
                <div class="matrix_seckill fn-clear" v-if="goodStyle == 'list' && seckill.fightTime">
                    <span class="seckill_txt">仅剩</span>
                    <div class="seckill_time">
                        <span class="seckill_time_hour">00</span>
                        <span class="seckill_time_txt">:</span>
                        <span class="seckill_time_minute">00</span>
                        <span class="seckill_time_txt">:</span>
                        <span class="seckill_time_second">00</span>
                    </div>
                </div>
            </div>
            <div class="good_infor" v-if="goodStyle == 'big'">
                <p class="goodName">此处显示商品名称</p>
                <p class="remainder">
                    <span class="discount">立减20.00元</span>
                    <span class="stock" v-if="seckill.fightNum">仅剩20件</span>
                </p>
                <div class="price fn-clear">
                   <span class="title">秒杀价：</span>
                   <p>￥<span class="present">59</span>.99<span class="original">￥79.99</span></p>
                </div>
            </div>
            <div class="good_infor" v-if="goodStyle == 'matrix'">
                <p class="goodName"><span class="discount">立减20.00元</span>此处显示商品名称</p>
                <div class="price fn-clear">
                   <span class="title">秒杀价：</span>
                   <p>￥<span class="present">59.99</span></p>
                </div>
                <p class="active_done">活动结束价￥79.99</p>
                <span class="stock" v-if="seckill.fightNum">仅剩20件</span>
            </div>
            <div class="good_infor" v-if="goodStyle == 'list'">
                <p class="goodName">此处显示商品名称</p>
                <p class="remainder">
                    <span class="discount">立减20.00元</span>
                    <span class="stock" v-if="seckill.fightNum">仅剩20件</span>
                </p>
                <div class="price fn-clear">
                   <span class="title">秒杀价：</span>
                   <p>￥<span class="present">59.99</span></p>
                </div>
                <p class="active_done">活动结束价￥79.99</p>
            </div>
            <button class="go_seckill" v-if="goodStyle == 'big' && seckill.buyBtn" :class="[{'btnStyle1':seckill.btnStyle == 'btn1'},{'btnStyle2':seckill.btnStyle == 'btn2'},{'btnStyle3':seckill.btnStyle == 'btn3'},{'btnStyle4':seckill.btnStyle == 'btn4'}]">马上秒杀</button>
            <button class="go_seckill" v-if="goodStyle == 'matrix' && seckill.buyBtn" :class="[{'btnStyle1':seckill.btnStyle == 'btn1'},{'btnStyle2':seckill.btnStyle == 'btn2'},{'btnStyle3':seckill.btnStyle == 'btn3'},{'btnStyle4':seckill.btnStyle == 'btn4'}]">马上秒</button>
            <button class="go_seckill" v-if="goodStyle == 'list' && seckill.buyBtn" :class="[{'btnStyle1':seckill.btnStyle == 'btn1'},{'btnStyle2':seckill.btnStyle == 'btn2'},{'btnStyle3':seckill.btnStyle == 'btn3'},{'btnStyle4':seckill.btnStyle == 'btn4'}]">马上秒</button>
        </div>
    </div>
</template>

<script>
    export default {
        props:['goodStyle'],
    }
</script>

<style scoped>

    .big_good{
        box-sizing: border-box;
        border:1px solid #ddd;
        background-color: #fff;
        padding: 10px;
    }
    .good_box{
        position: relative;
        margin-bottom: 10px;
    }
    .goodShow img{
        width: 100%;
    }
    .good_infor p{
        margin-top: 6px;
        font-size: 14px;
        color: #333;
        padding-left: 10px;
    }
    .good_infor p span{
        color: #f44;
    }
    .shop{
        position: absolute;
        border: 1px solid #f44;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        text-align: center;
        line-height: 24px;
    }
    .shop .icon-gouwuche{
        font-size: 16px;
        color: #f44;
    }
    .seckill_infor{
        height: 40px;
        padding: 0 10px;
        background: -ms-gradient(linear,left top,right top,from(#f44),to(#ff8b8b));
        background: -webkit-linear-gradient(left,#f44,#ff8b8b);
        background: -moz-linear-gradient(left,#f44,#ff8b8b);
        background: linear-gradient(90deg,#f44,#ff8b8b);
        color: #fff;  
    }
    .seckill_infor span{
        line-height: 40px;
        font-size: 16px;
    }
    .cap-ump-seckill-goods__tag-countdown {
        float: right;
        font-size: 10px;
    }
    .seckill_infor .cap-ump-seckill-goods__countdown-text {
        margin-right: 10px;
        font-size: 11px;
        color: #fff;
    }
    .cap-countdown--white {
        color: #ff4343;
    }
    .cap-countdown {
        display: inline-block;
    }
    .cap-countdown .cap-countdown__hour, .cap-countdown .cap-countdown__minute, .cap-countdown .cap-countdown__second {
        background-image: -ms-gradient(linear,left top,left bottom,from(#fff),color-stop(45%,#fff),color-stop(55%,#f0f0f0));
        background-image: -webkit-linear-gradient(top,#fff,#fff 45%,#f0f0f0 55%);
        background-image: -moz-linear-gradient(top,#fff,#fff 45%,#f0f0f0 55%);
        background-image: linear-gradient(180deg,#fff,#fff 45%,#f0f0f0 55%);
        font-size: 11px;
        border-radius: 3px;
        padding: 0 2px;
    }
    .cap-countdown .cap-countdown__time-text {
        padding: 0 2px;
        color: #fff;
    }
    .good_infor .remainder{
        display: inline-block;
        margin-top: 6px;
        line-height: 14px;
        background-color: #fff;
        border: 1px solid rgba(255,68,68,.1);
        border-radius: 2px;
        font-size: 0; 
        padding-left: 0;
        margin-left: 10px;
    }
    .remainder span{
        display: inline-block;
        vertical-align: middle;
        height: 14px;
        line-height: 14px;
        padding: 0 5px;
        border-radius: 2px;
        color: #f44;
        font-size: 10px;
        text-align: center;
    }
    .remainder span.discount{
        background-color: rgba(255,68,68,.1); 
    }
    .price{
        padding-left: 10px;
        margin-top: 10px;
    }
    .price p,
    .price .title{
        float: left;
    }
    .price .title{
        color: #f44;
        font-size: 14px;
    }
    .price p{
        margin-top: -8px;
        padding-left: 0;
        font-size: 14px;
        color: #f44;
    }
    .price p span{
        display: inline-block;
        font-size: 12px;
    }
    .price p span.present{
        font-size: 22px;
    }
    .price p span.original{
        color: #999;
        text-decoration: line-through;
    }
    .go_seckill{
        position: absolute;
        right: 8px;
        bottom: 13px;
        border: 1px solid #f44;
        border-radius: 20px;
        width: 70px;
        height: 22px;
    }
    .good_box .go_seckill.btnStyle1{
        background-color: #fff;
        color: #f44;
    }
    .good_box .go_seckill.btnStyle2{
        background-color: #f44;
        color: #fff;
    }
    .good_box .go_seckill.btnStyle3{
        border-radius: 0;
        background-color: #fff;
        color: #f44;
    }
    .good_box .go_seckill.btnStyle4{
        border-radius: 0;
        background-color: #f44;
        color: #fff;
    }
    /* 大图 */
    .big_good .shop{
        right: 10px;
        bottom: 10px;
    }
    .big_good .goodShow{
        width: 100%
    }
    .big_good .goodShow img{
        display: block;
        width: 200px;
        height: 200px;
        margin:0 auto;
    }
    /* 距正 */
    .matrix_good{
        background-color: #fff;
        width: 157px;
        padding-bottom: 8px;
    }
    .matrix_good .shop{
        right: 4px;
        bottom: 3px;
    }
    .matrix_good .good_infor{
        padding: 0 10px;
    }
    .matrix_good .good_infor .goodName{
        font-size: 12px;
    }
    .matrix_good .good_infor p{
        padding-left: 0;
    }
    .matrix_good .remainder{
        margin-left: 0;
    }
    .matrix_good .price{
        margin-left: 0;
        padding-left: 0;
        margin-top: 5px;
    }
    .matrix_good .price p{
        margin-top: -3px;
    }
    .matrix_good .price p .present{
        font-size: 18px;
    }
    .matrix_good .goodShow img{
        display: block;
        width: 100%;
    }
    .matrix_good .matrix_seckill{
        padding: 2px 3px;
        background: -ms-gradient(linear,left top,right top,from(#f44),to(#ff8b8b));
        background: -webkit-linear-gradient(left,#f44,#ff8b8b);
        background: -moz-linear-gradient(left,#f44,#ff8b8b);
        background: linear-gradient(90deg,#f44,#ff8b8b);
        color: #fff;  
    }
    .matrix_good .matrix_seckill .seckill_txt{
        float: left;
    }
    .matrix_good .matrix_seckill .seckill_time{
        float: left;
        margin-left: 6px;
    }
    .matrix_good .active_done{
        font-size: 12px;
        color: #999;
        margin-top: 0;
    }
    .matrix_good .stock{
        display: block;
        font-size: 12px;
        color: #999;
    }
    .seckill_time_hour,.seckill_time_minute,.seckill_time_second{
        color: #f44;
        background: #fff;
        padding: 0 2px;
        border-radius: 3px;
    }
    .seckill_time_txt{
        color: #fff;
    }
    .matrix_good .go_seckill{
        position: absolute;
        border: 1px solid #f44;
        color: #f44;
        font-size: 12px;
        width: 50px;
        height: 18px;
        right: 5px;
        bottom: 9px;
        line-height: 16px;
    }
    /* 列表 */
    .list_good{
        background-color: #fff;
        padding:2px 5px;
    }
    .list_good .goodShow{
        float: left;
        width: 115px;
        margin-right: 15px;
    }
    .list_good .goodShow{
        position: relative;
        display: block;
    }
    .list_good .good_infor{
        float: left;
    }
    .list_good .matrix_seckill{
        position: absolute;
        left: 0;
        bottom: 5px;
        padding: 2px;
        width: 111px;
        background: -ms-gradient(linear,left top,right top,from(#f44),to(#ff8b8b));
        background: -webkit-linear-gradient(left,#f44,#ff8b8b);
        background: -moz-linear-gradient(left,#f44,#ff8b8b);
        background: linear-gradient(90deg,#f44,#ff8b8b);
        color: #fff;  
    }
    .list_good .matrix_seckill .seckill_txt,
    .list_good .matrix_seckill .seckill_time{
        float: left;
    }
    .list_good .matrix_seckill .seckill_txt{
        margin-right: 5px;
    }
    .list_good .good_infor p{
        padding-left: 0;
    }
    .list_good .shop{
        right: 12px;
        bottom: 7px;
    }
    .list_good .remainder{
        margin-left: 0;
    }
    .list_good .price{
        margin-left: 0;
        padding-left: 0;
        margin-top: 17px;
    }
    .list_good .price p{
        margin-top: -3px;
    }
    .list_good .price .present{
        font-size: 18px;
    }
    .list_good .active_done{
        color: #666;
        font-size: 12px;
    }
    .list_good .go_seckill{
        width: 50px;
        right: 11px;
        bottom: 5px;
    }
</style>
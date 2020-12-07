<template>
    <div class="goodInfor">
        <a href="javascript:;" class="return_main">
            <div class="return_image">
                <img :src="$url + goodinfor.product_img" alt="" v-if="goodinfor.product_img">
                <img src="static/images/goods.png" alt="" v-else>
                <span>{{goodinfor.count}}件商品</span>
            </div>
            <div class="return_txt">
                <h4>{{goodinfor.product_name}}</h4>
                <p>{{goodinfor.spec_content}}</p>
            </div>
            <div class="return_money">
                <span>￥{{goodinfor.pay_price}}</span>
                <span class="current">￥{{goodinfor.smarket_price}}</span>
            </div>
        </a>
        <a href="javascript:;" class="apply" @click="afterSales($event)" v-if="goodsRootly == 'orderDetails' && (state == 1 || state == 2 || state == 3 || state == 4)">申请售后</a>
    </div>
</template>

<script>
    import { Toast } from 'mint-ui';
    export default {
        data(){
            return{
                
            }
        },
        props:['goodinfor','goodsRootly','state','rangeType'],
        methods:{
            // 申请售后
            afterSales(e){
                if(this.goodinfor.state !== null){
                    Toast('商家正在受理中~')
                }else{
                    this.$router.push({
                        path:'/afterSales',
                        name:'afterSales',
                        params:{
                            goodinfor:this.goodinfor,
                            rangeType:this.rangeType,
                            refursPrice:this.goodinfor.pay_price
                        }
                    })
                }
                // 0表示等待卖家同意，1表示等待买家补充物流信息，2表示等待卖家退换，3表示退换完成，4表示退换驳回，-1表示退换关闭'
                e.stopPropagation();
            }
        }
    }
</script>

<style scoped lang="scss">
    .goodInfor{
        position: relative;
        .return_main{
            display: block;
            // background: #fff;
            overflow: hidden;
            padding: 0.2rem 0 0.2rem 0.2rem;
            position: relative;
            .return_image{
                float: left;
                width: 2rem;
                height: 2rem;
                margin-right: 0.3rem;
                box-sizing: border-box;
                position: relative;
                img{
                    width: 100%;
                    height: 100%;
                }
                span{
                    position: absolute;
                    left: 0;
                    bottom: 0;
                    width: 100%;
                    height: 0.4rem;
                    line-height: 0.4rem;
                    color: #fff;
                    background-color: rgba(0,0,0,0.6);
                    font-size: 0.24rem;
                    text-align: center;
                }
            }
            .return_txt{
                float: left;
                width: 3.4rem;
                margin-right: 0.4rem;
                
                h4{
                    font-size:0.28rem;
                    // height: 0.7rem;
                    color:#333;
                    display: -webkit-box;
                    /*! autoprefixer: off */
                    -webkit-box-orient: vertical;
                    /* autoprefixer: on */
                    -webkit-line-clamp: 2;
                    overflow: hidden;
                }
                p{
                    position: absolute;
                    font-size:0.28rem;
                    color:rgba(102,102,102,1);
                    width: 3.2rem;
                    bottom: 0.2rem;
                    display: -webkit-box;
                    /*! autoprefixer: off */
                    -webkit-box-orient: vertical;
                    /* autoprefixer: on */
                    -webkit-line-clamp: 2;
                    overflow: hidden;
                }
            }
            .return_money{
                float: right;
                margin-top: 0.05rem;
                margin-right: 0.2rem;
                span{
                    display: block;
                    line-height: 0.3rem;
                    color: rgba(51,51,51,1);
                    font-weight: bold;
                    font-size: 0.3rem;
                    &.current{
                        color: rgba(153,153,153,1);
                        text-decoration: line-through;
                        font-weight: normal;
                        margin-top: 0.05rem;
                    }
                }
                
            }
        }
        .apply{
            position: absolute;
            right: 0.2rem;
            bottom: 0.15rem;
            background-color: #fff;
            padding: 0 0.1rem;
            height: 0.46rem;
            line-height: 0.46rem;
            border-radius: 0.04rem;
            border: 1px solid #bbb;
            font-size: 0.28rem;
            color: #666;
            font-size: 0.3rem;
            z-index: 99;
        }
    }
</style>
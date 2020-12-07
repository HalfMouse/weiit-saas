<template>
    <div class="usage_box">
        <div class="usage_list clearfix" :class="{'used':isUseAble}">
            <div class="preferential">
                <div class="sum" v-if="coupon.type == 1 || coupon.type == 3">
                    ￥<span>{{coupon.coupon_content}}</span>
                </div>
                <div class="sum" v-if="coupon.type == 2">
                    <span>{{coupon.coupon_content}}</span>折
                </div>
                <p class="condition">{{coupon.condition}}</p>
            </div>
            <div class="explain">
                <h3 class="explain_use">{{coupon.coupon_name}}</h3>
                <p class="explain_time">{{time}}</p>
                <p class="explain_goods">{{coupon.product}}</p>
                <span class="explain_condition" v-if="coupon.coupon_desc != '' && coupon.is_useable">{{coupon.coupon_desc}}</span>
                <p v-if="!coupon.is_useable">{{coupon.reason}}</p>
                <a href="javascript:;" class="toUse" @click="toUse()" v-if="couponRootly == 'coupon'">去使用</a>
            </div>
            <i class="icon iconfont icon-yishiyong" v-if="coupon.state == '1'"></i>
            <i class="icon iconfont icon-yiguoqi1" v-if="coupon.state == '-1'"></i>
            <i class="icon iconfont icon-weishengxiao" v-if="coupon.state == '-2'"></i>
        </div>
    </div>
</template>

<script>
    export default {
        props:['coupon','couponRootly'],
        data(){
            return {
                time:'',
                isUseAble:false
            }
        },
        methods:{
            toUse(){
                if(this.coupon.state == 0){
                    this.$router.push({
                        path:'/search',
                        name:'search'
                    })
                }
            },
            useAble(){
               if(this.couponRootly == 'coupon'){
                   if(this.coupon.state == '1' || this.coupon.state == '-1'){
                       this.isUseAble = true
                   }
               }else{
                   if(!this.coupon.is_useable){
                       this.isUseAble = true
                   }
               }
            }
        },
        mounted(){
            this.useAble();
            let reg = /\s\d{2}\:\d{2}\:\d{2}\.\d/g;
            this.time = this.coupon.time.replace(reg,'');
        }
    }
</script>

<style scoped lang="scss">
    .usage_box{
        padding: 0 0.2rem;
        .usage_list{
            position: relative;
            .preferential{
                float: left;
                width: 1.95rem;
                text-align: center;
                background: linear-gradient(45deg, #fb4359, #fb6299);
                color: #fff;
                height: 1.58rem;
                padding-top: 0.3rem;
                border-radius: 0.2rem 0 0 0.2rem;
                .sum{
                    text-align: center;
                    font-size: 0.3rem;
                    margin-bottom: 0.2rem;
                    span{
                        font-size: 0.48rem;
                    }
                }
                .condition{
                    font-size: 0.32rem;
                }
            }
            .explain{
                width: calc(100% - 1.95rem);
                float: left;
                height: 1.78rem;
                background-color: #fff;
                position: relative;
                padding-top: 0.05rem;
                border-radius: 0 0.2rem 0.2rem 0;
                h3{
                    margin-left: 0.2rem;
                    font-size: 0.34rem;
                    color: #333;
                    margin-left: 0.2rem;
                }
                p{
                font-size: 0.28rem;
                color: #666;
                margin-left: 0.2rem;
                margin-top: 0.05rem;
                }
                .explain_condition{
                    float: left;
                    margin-left: 0.2rem;
                    border:1px solid #FF4256;
                    color: #FF4256;
                    font-size: 0.28rem;
                    border-radius: 0.2rem;
                    margin-top: 0.05rem;
                    padding:0 0.1rem;
                    height: 0.4rem;
                    text-align: center;
                    line-height: 0.4rem;
                    box-sizing: border-box;
                    text-overflow:ellipsis;
                    white-space:nowrap;
                    overflow:hidden;
                    max-width: 2rem;
                }
                .toUse{
                    position: absolute;
                    right: 0.2rem;
                    bottom: 0.2rem;
                    color: #fff;
                    background-color: #FF4152;
                    border-radius: 0.17rem; 
                    height: 0.4rem;
                    text-align: center;
                    line-height: 0.4rem;
                    font-size: 0.28rem;
                    padding:0 0.1rem
                }
            }
            &.used{
                .preferential{
                    background: #ccc;
                }
                .explain{
                    .explain_condition{
                        border:1px solid #ccc;
                        color: #ccc;
                        display: block;
                    }
                    .toUse{
                        background-color: #ccc;
                    }
                }
            }
            .icon{
                position: absolute;
                font-size: 1rem;
                top: 0.06rem;
                right: 0.1rem;
                color: #ccc;
            }
        }
    }
</style>
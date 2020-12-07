<template>
    <div class="my_fight">
        <ul>
            <li>
                <div class="fightGoods fn-clear">
                    <div class="fight_pic">
                        <img src="static/images/person.jpg" alt="">
                        <div class="choice">
                            <i class="icon iconfont icon-cha"></i>
                        </div>
                    </div>
                    <div class="fight_txt">
                        <h6>联想ThinkPad 翼480（0VCD）14英寸轻薄窄边框笔记本电...</h6>
                        <span>成功拼团</span>
                    </div>
                </div>
                <div class="again_btn">
                    <a href="javascript:;">再拼一次</a>
                </div>
            </li>
        </ul>
        <div class="no_more fn-clear">
            <span class="line"></span>
            <p>我是有底线的</p>
            <span class="line"></span>
        </div>
        <foot-btn></foot-btn>
    </div>
</template>

<script>
    // 引入底部按钮组件
    import footBtn from '@/components/footBtn'
    export default {
        data() {
            return {
                myFightType:this.$route.params.rootly ? this.$route.params.rootly : localStorage.getItem('myFightType'),
                orderId:this.$route.params.g_order_id ? this.$route.params.g_order_id : localStorage.getItem('gOrderId')
            }
        },
        components:{
            footBtn
        },
        methods: {
            // 保存初始数据
            saveData() {
                
                let myFightType = this.$route.params.rootly;
                let g_order_id = this.$route.params.g_order_id;
                if(myFightType){
                    localStorage.setItem('myFightType',myFightType)
                }
                if(g_order_id){
                    localStorage.setItem('gOrderId',g_order_id)
                }
            }
        },
        mounted(){
            this.saveData()
        }
    }
</script>

<style scoped lang="scss">
    .my_fight{
        ul{
            li{
                padding: 0.1rem 0.2rem;
                background-color: #fff;
                margin-bottom: 0.24rem;
                .fightGoods{
                    margin-bottom: 0.2rem;
                    .fight_pic{
                        position: relative;
                        float: left;
                        width: 1.86rem;
                        height: 1.86rem;
                        img{
                            width: 100%;
                            height: 100%;
                        }
                        .choice{
                            position: absolute;
                            width: 1.49rem;
                            height: 1.49rem;
                            left: 50%;
                            top: 50%;
                            transform: translate(-50%,-50%);
                            border-radius: 50%;
                            background-color: rgba(0,0,0,0.5);
                            text-align: center;
                            // line-height: 1.49rem;
                            .icon{
                                position: absolute;
                                left: 50%;
                                top: 50%;
                                transform: translate(-50%,-50%);
                                font-size: 0.6rem;
                                font-weight: bold;
                            }
                            .icon-gougou{
                                color: #09BB07;
                            }
                            .icon-cha{
                                font-size: 0.8rem;
                                color: #f4333c;
                            }
                        }
                    }
                    .fight_txt{
                        float: left;
                        width: 4.96rem;
                        margin-left: 0.28rem;
                        border-bottom: 1px solid #ddd;
                        padding-bottom: 0.2rem;
                        h6{
                            font-size: 0.28rem;
                            color: #666;
                        }
                        span{
                            display: block;
                            color: #ec534e;
                            font-size: 0.28rem;
                            margin-top: 0.5rem;
                        }
                    }
                }
                .again_btn{
                    height: 0.57rem;
                    a{
                        float: right;
                        height: 0.48rem;
                        line-height: 0.48rem;
                        color: #333;
                        background-color: #ffdc4b;
                        padding: 0 0.15rem;
                        font-size: 0.3rem;
                        border-radius: 0.1rem;
                    }
                }
            }
        }
        .no_more{
            width: 7.3rem;
            margin:0 auto;
            .line{
                float: left;
                height: 1px;
                width: 2.11rem;
                background-color: #ddd;
                margin-top: 0.15rem;
            }
            p{
                float: left;
                font-size: 0.26rem;
                color: #ddd;
                margin:0 0.7rem;
            }
        }
        
    }
</style>
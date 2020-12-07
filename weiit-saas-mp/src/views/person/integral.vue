<template>
    <div class="integral_box">
        <header :class="{isBorder:integralScore}">
            <div class="integral_score">
                <span>当前积分：</span>
                <span class="score">{{integralScore}}</span>
            </div>
            <span class="integral_rule" @click="toRule()">积分规则</span>
        </header>
        <div class="record_list" v-if="integralScore > 0">
            <ul>
                <li v-for="item in integrals">
                    <single-detail :singleScore="item" :top="'integral'"></single-detail>
                </li>
            </ul>
        </div>
        <div class="bottom-btn">
            <a href="javascript:;" class="toMall" @click="toMall()">前往兑换中心</a>
            <a href="javascript:;" class="toIntegralList" @click="toIntegralList()">前往积分列表</a>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 引入底部解释
    import explain from '@/components/explain'
    // 引入一条积分详情
    import singleDetail from '@/components/singleDetail'
    export default {
        data(){
            return {
                integralScore:localStorage.getItem('integral'),
                integrals:[],
                top:'integral'
            }
        },
        components:{
            explain,
            singleDetail   
        },
        methods:{
            getIntegral(){
                axios.post('/api/user/myIntegralLog', null)
                    .then((res) => {
                        console.log(res);
                        if(res.data.code == '0'){
                            this.integrals = res.data.data;
                            
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    }) 
            },
            toRule(){
                this.$router.push({
                    path:'/IntegralRule',
                    name:'IntegralRule',
                })
            },
            toMall(){
                this.$router.push({
                    path:'/IntegralMall',
                    name:'IntegralMall',
                })
            },
            toIntegralList(){
                this.$router.push({
                    path:'/IntegralList',
                    name:'IntegralList'
                })
            }
        },
        mounted(){
            this.getIntegral();
        }
    }
</script>

<style scoped lang="scss">
    .integral_box{
        height: 100%;
        
        header{
            background-color: #fff;
            box-sizing: border-box;
            position: relative;
            height: 1rem;
            z-index: 20;
            padding: 0 0.2rem;
            font-size: 0.3rem;
            &.isBorder{
                border-bottom: 2px solid #ddd;
            }
            .integral_score{
                float: left;
                line-height: 0.95rem;
                span.score{
                    color: #ec534e;
                    font-size: 0.4rem;
                }
            }
            .integral_rule{
                float: right;
                line-height: 1rem;
            }
            // span{
            //     display: inline-block;
            //     font-size: 0.3rem;
            //     color: #333;
            //     &.integral_score{
            //         font-size: 0.5rem;
            //         color: #ec534e;
            //     }
            //     &.integral_rule{
            //         float: right;
            //         margin-right: 0.2rem;
            //         line-height: 0.6rem;
            //     }
            // }
        }
        .no_record{
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%,-50%);
            font-size: 0.28rem;
            line-height: 0.7rem;
            color: #999;
        }
        .record_list{
            height: calc(100% - 1.2rem);
            background: #fff;
            overflow-y: scroll;
        }
        .bottom-btn{
            position: fixed;
            width: 100%;
            left: 0;
            bottom: 0.3rem;
            height: 0.7rem;
            .toMall,.toIntegralList{
                position: absolute;
                top: 0;
                font-size: 0.28rem;
                padding: 0.1rem;
                border-radius: 0.1rem;
                border: 1px solid #ff4c6b;
                color: #ff4c6b;
            }
            .toMall{
                left: 22%;
            }
            .toIntegralList{
                right: 22%;
            }
        }
    }
</style>
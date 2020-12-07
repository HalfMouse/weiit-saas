<template>
    <div class="detail_box" @click="tailed(singleScore.balance)">
        <div class="integral_main">
            <span class="integral_txt">{{singleScore.remark}}</span>
            <span class="integral_time">{{time}}</span>
        </div>
        <div class="integral_single" :class="singleScore.state == 0 ? 'plus' : 'minus'" v-if="top == 'integral'">
            <span v-if="singleScore.state == 0">+</span>
            <span v-if="singleScore.state == -1">-</span>
            <span class="single_num">{{singleScore.integral}}</span>
        </div>
        <div class="integral_single" :class="singleScore.balance > 0 ? 'plus' : 'minus'" v-if="top == 'wallet'">
            <span v-show="singleScore.balance > 0">+</span>
            <span class="single_num">{{singleScore.balance}}</span>
        </div>
    </div>
</template>

<script>
    // 引入getTime
    import {getTime} from '../../static/js/getTime'
    export default {
        data(){
            return {
                time:''
            }
        },
        props:['singleScore','top'],
        methods:{
            tailed(money){
                if(this.singleScore.remark.indexOf('提现') != -1){
                    localStorage.setItem('confirmRooty','tailed');
                    localStorage.setItem('singleMoney',money)
                    this.$router.push({
                        path:'/Progress',
                        name:'confirm'
                    })
                }
            }
        },
        mounted(){
            this.time = getTime(this.singleScore.create_time);
        }
    }
</script>

<style scoped lang="scss">
    .detail_box{
        border-bottom: 2px solid #ddd;
        position: relative;
        height: 1.2rem;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        padding: 0.2rem 0 0.2rem 0.2rem;
        .integral_main{
            height: auto;
            span{
                display: block;
                &.integral_txt{
                    font-size: 0.32rem;
                    color: #333;
                }
                &.integral_time{
                    font-size: 0.24rem;
                    color: #999;
                    margin-top: 0.08rem;
                    margin-bottom: 0.2rem;
                }
            }
        }
        .integral_single{
            position: absolute;
            right: 0.2rem;
            top: 50%;
            transform: translateY(-50%);
            &.plus{
                color: #00bd00;
            }
            &.minus{
                color: #ec453e;
            }
            span{
                font-size: 0.36rem;
                float: left;
                &.single_num{
                    margin-left: -0.06rem;
                }
            }
        }
    }
</style>
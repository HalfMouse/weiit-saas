<template>
    <div class="feedback_box">
        <div class="feedback_win">
            <textarea name="" class="feedback" v-model="feedMsg" placeholder="请写下您宝贵的意见吧~"></textarea>
        </div>
        <button class="feed_btn" :class="{current:feedMsg}" @click="toPerson()">提交</button>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 从mint-ui中引入MessageBox组件
    import { MessageBox,Toast } from 'mint-ui';
    export default {
        data(){
            return {
                feedMsg:''
            }
        },
        methods:{
            // 跳转到个人中心页面
            toPerson(){
                let suggest = this.feedMsg;
                if(this.feedMsg){
                    axios.post('/api/user/addSuggest', qs.stringify({
                       suggest: suggest
                    }))
                    .then((res) => {
                        // 确认意见回馈，跳回个人中心
                        MessageBox.alert('您的宝贵意见我们已收到',{
                            confirmButtonClass:'confirmButton',
                            confirmButtonText:'确认',
                        }).then(action => {
                                this.$router.push({
                                    path:'/Personal'
                                })
                                // console.log(123);
                        });
                        
                        this.feedMsg = '';
                    })
                    .catch((err) => {
                        console.log(err);
                    })
                    
                }else{
                    Toast('请写上您宝贵的意见~')
                }
            }
        }
    }
</script>

<style scoped lang="scss">
.feedback_box{
    width: 100%;
    padding-top: 0.2rem;
    .feedback_win{
        width: 100%;
        padding: 0.2rem;
        background-color:#fff; 
        .feedback{
            width: calc(100% - 0.6rem);
            height: 3.2rem;
            background-color: #f5f5f5;
            font-size: 0.28rem;
            color: #333;
            resize:none;
            border:none 0;
            padding:0.15rem;
            line-height: 0.32rem;
        }
    }
    .feed_btn{
        display: block;
        width: 6.91rem;
        margin: 0.5rem auto 0;
        border-radius: 0.2rem;
        background-color: #d4d4d4;
        color: #fff;
        font-size: 0.32rem;
        font-weight: bold;
        font-family: 'PingFang-SC-Bold';
        border: none 0;
        height: 0.89rem;
        &.current{
            background-color:#FFDC4B;
            color: #333;
        }
    }
}
    
</style>
<template>
    <div class="member_box">
        <div class="member_card">
            <ul>
                <li v-for="item in cardList">
                    <card :cardnum="cardnum"></card>
                </li>
            </ul>
            <no-more :types="cardList"></no-more>
            <loading v-show="isLoading"></loading>
        </div>
    </div>
</template>

<script>
    // 引入better-scroll组件
    import BScroll from 'better-scroll'
    // 引入会员卡 
    import card from '@/components/card'
    // 引入没有更多了
    import noMore from '@/components/noMore'
    // 引入加载组件
    import loading from '@/components/loading'
    export default {
        data(){
            return{
                cardnum:1,
                cardList:[1,1,1,1,1,1,1,1,1,1,1,1],
                isLoading:false
            }
        },
        components:{
            card,
            noMore,
            loading
        },
        mounted(){
            // this.scroll = new BScroll(this.$refs.wrapper, {})
        }
    }
</script>

<style scoped lang="scss">
    .member_box{
        width: 100%;
        padding-top: 0.2rem;
        height: calc(100% - 0.2rem);
        .member_card{
            width: calc(100% - 0.8rem);
            padding: 0.2rem 0.4rem;
            background-color: #fff;
            height: calc(100% - 0.4rem);
            overflow-y: scroll;
            ul{
                padding-bottom: 0.2rem;
                li{
                    margin-bottom: 0.2rem;
                }
            }
        }
    }
</style>
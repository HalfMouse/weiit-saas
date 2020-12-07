<template>
    <div class="text_nav">
        <ul>
            <li v-for="item in navMenu">
                <a href="javascript:;"  @click="skip(item)">{{item.nav_name}}</a>
            </li>
        </ul>
        <p>
            <span class="logo"></span>
            <span class="text">蜗店提供技术支持</span> 
        </p>
    </div>
</template>

<script>
    import axios from 'axios'
    import qs from 'qs';
    export default {
        data(){
            return {
                navMenu:JSON.parse(localStorage.getItem('bottomMenuList'))
            }
        },
        methods:{
            // 跳转路由
            skip(item){
                if(item.target_url == 'index'){
                    this.$router.push({
                        path:'/' + item.target_id,
                        name:'home1',
                        params:{
                            page_id:item.target_id
                        }
                    })
                }else if(item.target_url == 'zidingyi'){
                    window.location.href = item.target_id
                }else{
                    this.$router.push({
                        path:'/' + item.target_url,
                        name:item.target_url,
                        query:{
                            target_id:item.target_id
                        }
                    }); 
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .text_nav{
        padding-bottom: 0.3rem;
        margin-top: 0.3rem;
        ul{
            display: table;
            margin: 0 auto;
            overflow: hidden;
            li{
                float: left;
                font-size: 0.26rem;
                color: #333;
                border-right: 1px solid #ccc;
                padding: 0 0.15rem;
                &:first-child{
                    margin-left: 0;
                }
                &:last-child{
                   border:none 0;
                }
            }
        }
        .logo{
            width: 1.2rem;
            img{
                display: block;
                width: 100%;
            }
        }
        p{
            display: table;
            margin: 0.4rem auto 0.2rem;
            overflow: hidden;
            font-size: 0.26rem;
            color: #999;
            span{
                float: left;
                
                &.logo{
                    width: 0.3rem;
                    height: 0.28rem;
                    background-image: url(../../static/images/logo1.png);
                    background-size: 100% 100%;
                    margin-right: 0.1rem;
                }
                &.text{
                    line-height: 0.28rem;
                }
            }
        }
    }
</style>
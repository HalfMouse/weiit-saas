<template>
    <footer>
        <ul class="clearfix">
            <li v-for="(item, index) in navList">
                <a href="javascript:;" @click="skip(item)" :class="{'red':routing == item.nav_url}">
                    <i class="icon iconfont" :class="item.public_path"></i>
                    <span>{{item.nav_name}}</span>
                </a>
            </li>
        </ul>
    </footer>
</template>

<script>
	import axios from 'axios'
	import qs from 'qs'
    export default {
        props:['parents'],
        data(){
            return {
                isCome:'home',
                navList:[],
                routing:''
            }
        },
        methods:{
        	// 跳转路由
            skip(item){
                if(item.nav_url == 'index'){
                    if(item.nav_value){
                        this.$router.push({
                            path:'/' + item.nav_value,
                            name:'home1',
                            params:{
                                page_id:item.nav_value
                            }
                        })
                        
                    }else{
                        this.$router.push({
                            path:'/',
                            name:'home'
                        })
                    }
                    
                }else{
                	if(item.nav_url == 'Order'){
                		localStorage.setItem('orderStyle','all')
                	}
                    this.$router.push({
                        path:'/' + item.nav_url,
                        name:item.nav_url,
                        params:{
                            target_id:item.nav_value
                        }
                    }); 
                }
            },
            //获取导航信息
            getNavList(){
            	axios.post('/api/navParam',qs.stringify({
            		appid:localStorage.getItem('appid')
            	})).then(res => {
            		if(res.data.code == '0'){
            			this.navList = res.data.data.navInfoList;
            		}
            	}).catch(err => {
            		console.log(err)
            	})
            },
            //当前路由
            getRoute(){
            	if(this.$route.path.split('/')[1] && typeof(this.$route.path.split('/')[1])== 'string'){
            		this.routing = this.$route.path.split('/')[1];
            	}else{
            		this.routing = 'index';
            	}
            }
        },
        mounted(){
        	this.getRoute();
        	this.getNavList();
        }
    }
</script>

<style scoped lang="scss">
    footer{
        padding: 0.1rem 0;
        position: fixed;
        left: 0;
        bottom: 0;
        width: 100%;
        background: #fff;
        z-index: 999;
        border-top: 1px solid #ddd;
        ul{
            display: flex;
            display: -webkit-flex;
            li{
                flex: 1;
                a{
                    display: block;
                    text-align: center;
                    color: #333;
                    &.red{
                       color: #ec534e;
                    }
                    i{
                        display: block;
                        font-size: 0.44rem;
                        margin-bottom: 0.02rem;
                    }
                    span{
                        display: block;
                        font-size:0.28rem;
                    }
                }
            }
        }
    }
</style>
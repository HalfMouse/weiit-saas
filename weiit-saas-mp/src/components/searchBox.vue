<template>
    <div class="search_box">
        <input type="text" placeholder="搜索品牌，商家或商品" v-model="searchGood" :class="{new_search:fatherComponent == 'home'}" autofocus>
        <a href="javascript:;" class="search_btn" @click="search()" v-if="fatherComponent != 'home'">搜索</a>
        <i class="icon iconfont icon-sousuo"></i>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    export default {
        props:['fatherComponent'],
        data(){
            return {
                searchGood:'',
                goods:[],
                pageNo:1,
                isloading:false
            }
        },
        methods:{
            // 搜索物品
            search(){
                let searchGood = this.searchGood;
                if(searchGood){
                    this.isloading = true
                    axios.post('/api/product/search',qs.stringify({
                        key:searchGood,
                        page:this.pageNo
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.goods = res.data.data.list;
                            this.isloading = false
                            this.$emit('test',this.goods,searchGood)
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .search_box{
        position: relative;
        width: 96%;
        height: 0.6rem;
        margin: 0 auto;
        input{
            width: 75%;
            float: left;
            height: 0.6rem;
            line-height: 0.6rem;
            font-size: 0.28rem;
            padding-left: 0.8rem;
            border-radius: 0.1rem;
            &.new_search{
                width: 6.4rem;
            }
        }
        .search_btn{
            float: right;
            font-size: 0.3rem;
            font-family:'MicrosoftYaHei';
            color: #666;
            border:none 0;
            line-height: 0.6rem;
            margin-right: 0.2rem;
            background: #f5f5f5;
            text-align: center;
        }
        .icon{
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            font-size: 0.4rem;
            color: #A5A5A5;
            left: 0.2rem;
        }
    }
</style>
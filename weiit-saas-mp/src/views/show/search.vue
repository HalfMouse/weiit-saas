<template>
    <div class="showBox">
        <div class="search blankShow" @click="toSearch()">
            <div class="search_box" v-if="searchStyle == 'ordinary'">
                <div class="ordinary_search fn-clear">
                    <i class="icon iconfont icon-sousuo"></i>
                    <input type="text" placeholder="在店铺内搜索" disabled>
                </div>
            </div>
            <div class="search_box1" v-if="searchStyle == 'top'" :style="{backgroundColor:searchColor_outside}">
                <div class="top_search fn-clear">
                    <i class="icon iconfont icon-sousuo"></i>
                    <input type="text" placeholder="在店铺内搜索" :style="{backgroundColor:searchColor_inside}">
                    <i class="icon iconfont icon-personnone"></i>
                </div>
            </div>
        </div>
    </div>
    
</template>

<script>
    export default {
        props:{
            keyText:String,
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        searchStyle:'ordinary',
                        searchColor_outside:'#FF6633',
                        searchColor_inside:'#E64514'
                    }
                }
            },
            tempId:Number,
            keyWords:String
        },
        data(){
            return {
                searchStyle:'ordinary',
                searchColor_outside:'#FF6633',
                searchColor_inside:'#E64514',
                count:2
            }
        },
        methods:{
            toSearch(){
                this.$router.push({
                    path:'/search',
                    name:'search'
                })
            }
        },
        mounted(){
            this.searchStyle = this.pageParam.searchStyle;
            this.searchColor_outside = this.pageParam.searchColor_outside;
            this.searchColor_inside = this.pageParam.searchColor_inside;
        }
    }
</script>

<style scoped>
    .search_box{
        padding:0.1rem 0.15rem;
        background-color: #fafafa;

    }
    .search_box .ordinary_search{
        position: relative;
        box-sizing: border-box;
        padding:0.17rem 0.3rem 0.15rem 0.6rem;
        border: 1px solid #e5e5e5;
        border-radius: 0.04rem;
        background-color: #fff;
        height: 0.68rem;
    }
    .search_box .ordinary_search .icon{
        position: absolute;
        font-size: 0.3rem;
        left: 0.13rem;
        top: 0.15rem;
        color: #333;
    }
    .search_box .ordinary_search input{
        display: block;
        width: 100%;
        font-size: 0.28rem;
        color: #666;
        border: none;
        background-color: #fff;
    }
    .search_box1{
        padding:0.2rem 0.3rem;
        background-color: #FF6633;
    }
    .search_box1 .top_search{
        position: relative;
    }
    .search_box1 .top_search .icon-sousuo{
        position: absolute;
        color: #fff;
        font-size: 0.32rem;
        left: 0.26rem;
        top: 0.19rem;
    }
    .search_box1 .top_search input{
        width: 5.25rem;
        height: 0.72rem;
        display: block;
        color: #fff;
        border-radius: 0.36rem;
        border: none 0;
        background-color: #E64514;
        padding-left: 0.7rem;
        line-height: 0.72rem;
        font-size: 0.36rem;
    }
    .search_box1 .top_search input:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
        color: #fff; opacity:1; 
    }

    .search_box1 .top_search input::-moz-placeholder { /* Mozilla Firefox 19+ */
        color: #fff;opacity:1;
    }

    .search_box1 .top_search input:-ms-input-placeholder{
        color: #fff;opacity:1;
    }

    .search_box1 .top_search input::-webkit-input-placeholder{
        color: #fff;opacity:1;
    }
    .search_box1 .top_search .icon-personnone{
        position: absolute;
        color: #fff;
        font-size: 0.72rem;
        right: 0rem;
        top: 0rem;
    }
</style>
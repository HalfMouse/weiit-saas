<template>
    <div class="showBox">
        <div class="search blankShow">
            <div class="search_box" v-if="searchStyle == 'ordinary'">
                <div class="ordinary_search fn-clear">
                    <i class="icon iconfont icon-sousuo1"></i>
                    <input type="text" placeholder="在店铺内搜索" disabled="disabled">
                </div>
            </div>
            <div class="search_box1" v-if="searchStyle == 'top'" :style="{backgroundColor:searchColor_outside}">
                <div class="top_search fn-clear">
                    <i class="icon iconfont icon-sousuo1"></i>
                    <input type="text" placeholder="在店铺内搜索" :style="{backgroundColor:searchColor_inside}" disabled="disabled">
                    <i class="icon iconfont icon-personnone"></i>
                </div>
            </div>
        </div>
        <!-- 设置搜索框 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-search @event="getData" :pageParam="pageParam"></set-search>
        </div> 
    </div>
    
</template>

<script>
    // 设置头部
    import headModify from '@/components/common/headModify'
     // 设置搜索框
    import setSearch from '@/components/set/setSearch'
    import List from '../../../static/js/List'
    import {mapActions,mapState} from 'vuex'
    export default {
        props:{
            keyText:String,
            tempId:Number,
            keyWords:String,
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        searchStyle:'ordinary',
                        searchColor_outside:'#FF6633',
                        searchColor_inside:'#E64514'
                    }
                }
            }
        },
        data(){
            return {
                searchStyle:'ordinary',
                searchColor_outside:'#FF6633',
                searchColor_inside:'#E64514'
            }
        },
        components:{
            headModify,
            setSearch
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(obj){
                this.searchStyle = obj.searchStyle;
                this.searchColor_outside = obj.searchColor_outside;
                this.searchColor_inside = obj.searchColor_inside;
                // 修改数据
                this.changeData({id:this.tempId,op:obj})
            },
            // 存储数据
           
            saveData(){
                let list = new List();
                list.pageParam.searchStyle = this.searchStyle;
                list.pageParam.searchColor_outside = this.searchColor_outside;
                list.pageParam.searchColor_inside = this.searchColor_inside;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
               this.searchStyle = this.pageParam.searchStyle;
                this.searchColor_outside = this.pageParam.searchColor_outside;
                this.searchColor_inside = this.pageParam.searchColor_inside; 
            }
        },
        computed:{
        	...mapState(['styleList'])
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .search_box{
        padding:10px 15px;
        background-color: #fafafa;

    }
    .search_box .ordinary_search{
        position: relative;
        box-sizing: border-box;
        padding: 8px 24px 8px 35px;
        border: 1px solid #e5e5e5;
        border-radius: 4px;
        background-color: #fff;
        height: 34px;
    }
    .search_box .ordinary_search .icon{
        position: absolute;
        font-size: 16px;
        left: 13px;
        top: 4px;
    
    }
    .search_box .ordinary_search input{
        display: block;
        width: 100%;
        height: 16px;
        line-height: 16px;
        font-size: 14px;
        color: #666;
        border: none
    }
    .search_box1{
        padding:10px 15px;
        background-color: #FF6633;
    }
    .search_box1 .top_search{
        position: relative;
    }
    .search_box1 .top_search .icon-sousuo1{
        position: absolute;
        color: #fff;
        font-size: 16px;
        left: 13px;
        top: 6px;
    }
    .search_box1 .top_search input{
        width: 210px;
        height: 36px;
        display: block;
        color: #fff;
        border-radius: 36px;
        border: none 0;
        background-color: #E64514;
        padding-left: 35px;
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
        font-size: 36px;
        right: -5px;
        top: -8px;
    }
    /* 右侧设置信息 */
    .modify_box {
        position: absolute;
        right: -450px;
        top:0;
        padding: 12px 10px;
        min-height: 28px;
        background: #f8f8f8;
        border-radius: 5px;
        border: 1px solid #e5e5e5;
        width: 420px;
        margin-left: 20px;
        font-size: 12px;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        z-index: 5;
    }
    .modify_box:after, 
    .modify_box:before {
        right: 100%;
        top: 20px;
        border: solid transparent;
        content: " ";
        height: 0;
        width: 0;
        position: absolute;
        pointer-events: none;
    }
    .modify_box:before {
        border-color: transparent;
        border-right-color: #e5e5e5;
        border-width: 7px;
        margin-top: -7px;
    }
</style>
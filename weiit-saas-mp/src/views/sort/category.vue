<template>
    <div class="category">
        <loading v-show="isLoading"></loading>
        <ul class="showList" v-show="!isLoading">
            <li :key="index" v-for="(item, index) in categorys">
                <show-table :item="item" :keyWords="item.type" :pageParam="item.pageParam"></show-table>
            </li>
        </ul>
        <nav-footer :parents="'item'"></nav-footer>
    </div>
</template>

<script>
    // 引入底部导航
    import NavFooter from '@/components/footer'
    // 引入展示模板
    import showTable from '@/views/show/showTable'
    // 引入加载组件
    import loading from '@/components/loading'
    // 引入数据交互工具
    import axios from 'axios'
    import qs from 'qs'
    export default {
        data(){
            return {
                categorys:[],
                isLoading:true
            }
        },
        components:{
            NavFooter,
            showTable,
            loading
            
        },
        created(){
            axios.post('/api/page/tehuimai',null)
            .then((res) => {
                if(res.data.code == '0'){
                    document.title = res.data.data.page_name;
                    this.styleList = res.data.data;
                    this.categorys = JSON.parse(this.styleList.page_layout);
                    this.isLoading = false;
                }
            })
            .catch((err) => {
                console.log(err);
            })
        }
    }
</script>

<style scoped>
    .category{
        padding-bottom: 1rem;
    }
</style>
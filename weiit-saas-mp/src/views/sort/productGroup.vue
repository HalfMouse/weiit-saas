<template>
    <div class="productGroup">
        <loading v-show="isLoading"></loading>
        <div v-show="!isLoading" class="groups">
            <div class="title_header clearfix">
                <span class="line line1"></span>
                <h5>{{groupName}}</h5>
                <span class="line line2"></span>
            </div>
            <ul class="productGroupList clearfix">
                <li v-for="item in productGroup" @click="lookDetail(item)">
                    <div class="good_pic">
                        <img class="goodsPic" :src="$url + item.product_img" alt="">
                        <!-- <div class="cornerMark">
                            <img :src="'static/images/' + corner + '.png'" alt="">
                        </div> -->
                    </div>
                    <div class="good_txt">
                        <h5>{{item.product_name}}</h5>
                        <span>￥{{item.sale_price}}</span>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
    // 引入顶部商品组件
    import good from '@/views/common/good';
    import axios from 'axios';
    import qs from 'qs';
    import loading from '@/components/loading'
    export default {
        data() {
            return {
                productGroup: [],
                groupName:'',
                isLoading:true,
                groupIds:this.$route.params.target_id ? this.$route.params.target_id : localStorage.getItem('groupIds')
            }
        },
        methods:{
            getProductGroup(){
                let group_ids = this.groupIds;
                axios.post('/api/product/getProductByGroupIds',qs.stringify({
                    group_ids:group_ids
                })).then((res) => {
                    if(res.data.code == '0'){
                        let groups = res.data.data;
                        this.groupName = groups[0].group_name;
                        this.productGroup = groups[0].productInfo;
                        this.isLoading = false;
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            lookDetail(item){
                this.$router.push({
                    path:'/detail',
                    name:'detail',
                    query:{
                        product_id:item.product_id
                    }
                })
            }
        },
        mounted(){
            
            let groupIds = this.$route.params.target_id;
            if(groupIds){
                localStorage.setItem('groupIds',groupIds);
            }
            this.getProductGroup();
        },
        components:{
            loading
            
        }
    }
</script>

<style scoped lang="scss">
    .productGroup{
        .groups{
            min-height: 9.95rem;
        }
        .title_header{
            position: relative;
            line-height: 1rem;
            h5{
                text-align: center;
                font-size: 0.32rem;
                color: #333;
            }
            .line{
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                height: 1px;
                width: 2rem;
                background-color: #333;
                &.line1{
                    left: 0.5rem;
                }
                &.line2{
                    right: 0.5rem;
                }
            }
        }
        .productGroupList{
            padding-left: 0.15rem;
            li{
                border:1px solid #999;
                float: left;
                margin-right: 0.3rem;
                margin-bottom: 0.2rem;
                border-radius: 0.1rem;
                overflow: hidden;
                &:nth-child(even){
                    margin-right: 0;
                }
                .good_pic{
                    position: relative;
                    width: 3.4rem;
                    height: 3.4rem;
                    .goodsPic{
                        width: 100%;
                        height: 100%;
                    }
                }
                .good_txt{
                    width: 3.3rem;
                    font-size: 0.28rem;
                    color: #333;
                    padding: 0 0.05rem;
                    h5{
                        margin: 0.1rem 0;
                        overflow : hidden;
                        text-overflow: ellipsis;
                        display: -webkit-box;
                        -webkit-line-clamp: 2;
                        /*! autoprefixer: off */
                        -webkit-box-orient: vertical;
                        /* autoprefixer: on */
                    }
                    span{
                        color: #ec534e;
                    }
                }
            }
        }
    }
</style>
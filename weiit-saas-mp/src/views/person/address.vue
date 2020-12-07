<template>
    <div class="address">
        <div class="address_choose">
            <ul
                v-infinite-scroll="loadMore"
                infinite-scroll-disabled="loading"
                infinite-scroll-distance="10" class="clearfix">
                <li :key="index" v-for="(item, index) in addressList" @click="chooseAddress(item)">
                    <div class="address_information">
                        <div class="people_infor">
                            <div class="personal clearfix">
                                <span class="people_name">{{item.consignee}}</span>
                                <span class="people_tel">{{item.phone}}</span>
                            </div>
                            <p class="people_address">{{item.province}} {{item.city}} {{item.district}} {{item.address_detail}}</p>
                        </div>
                        <div class="address_setting fn-clear">
                            <div class="default">
                                <label class="mint-checklist-label">
                                    <span class="mint-checkbox">
                                        <input type="checkbox" class="mint-checkbox-input" :checked="item.is_default == 0" @click="checked(index)"> 
                                        <span class="mint-checkbox-core"></span>
                                    </span> 
                                    <span class="mint-checkbox-label">默认选择</span>
                                </label>
                            </div>
                            <div class="setting clearfix">
                                <div class="edit" @click="editAddress(item,$event)">
                                    <i class="icon iconfont icon-icon6"></i>
                                    <span>编辑</span>
                                </div>
                                <div class="del" @click="delChoose(index,$event)">
                                    <i class="icon iconfont icon-shanchu-copy"></i>
                                    <span>删除</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
            <loading v-show="isLoading"></loading>
            <!-- <mt-loadmore :bottom-method="loadBottom" :bottomDropText="bottomText" :bottom-all-loaded="allLoaded" :auto-fill="false" ref="loadmore">
                <ul>
                    <li v-for="(item, index) in addressList" @click="chooseAddress(item)">
                        <div class="address_information">
                            <div class="people_infor">
                                <div class="personal clearfix">
                                    <span class="people_name">{{item.consignee}}</span>
                                    <span class="people_tel">{{item.phone}}</span>
                                </div>
                                <p class="people_address">{{item.province}} {{item.city}} {{item.district}} {{item.address_detail}}</p>
                            </div>
                            <div class="address_setting fn-clear">
                                <div class="default">
                                    <label class="mint-checklist-label">
                                        <span class="mint-checkbox">
                                            <input type="checkbox" class="mint-checkbox-input" :checked="item.is_default == 0" @click="checked(index)"> 
                                            <span class="mint-checkbox-core"></span>
                                        </span> 
                                        <span class="mint-checkbox-label">默认选择</span>
                                    </label>
                                </div>
                                <div class="setting clearfix">
                                    <div class="edit" @click="editAddress(item,$event)">
                                        <i class="icon iconfont icon-icon6"></i>
                                        <span>编辑</span>
                                    </div>
                                    <div class="del" @click="delChoose(index,$event)">
                                        <i class="icon iconfont icon-shanchu-copy"></i>
                                        <span>删除</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </mt-loadmore>
            <loading v-show="isLoading"></loading> -->
        </div>
        
        <a href="javascript:;" class="add_address" @click="toAddSite()" :style="{background:color1,color:'#fff'}">新增收获地址</a>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs'
    //从mint-ui中引入Checklist,MessageBox组件 
    import { Checklist,MessageBox,Loadmore } from 'mint-ui';
    // 引入加载组件
    import loading from '@/components/loading'
    export default {
        data(){
            return {
                value:[1],
                options:[{
                    label:'默认选择',
                    value:'1'
                }],
                addressList:[],
                isLoading:true,
                loading:true,
                isPass:true,
                pageNo:1,
                color1:localStorage.getItem('bg1'),
                color2:localStorage.getItem('bg2')
            }
        },
        methods:{
            // 新增地址，rootly跳转来源
            toAddSite(){
                
                this.$router.push({
                    path:'/addSite',
                    name:'addSite'
                })
            },
            // 编辑地址，item传递地址内容，rootly跳转来源
            editAddress(item,e){
                localStorage.setItem('addressRootly','edit')
                this.$router.push({
                    path:'/addSite',
                    name:'addSite',
                    params: {  
                        address: item
                    }
                })
                // 阻止事件冒泡
                e.stopPropagation();
            },
            // 删除地址
            delChoose(index,e){
                let id = this.addressList[index].id
                MessageBox.confirm('',{
                    title:'',
                    message:'确认删除此地址？',
                    cancelButtonClass:'cancelButton',
                    confirmButtonClass:'confirmButton',
                    confirmButtonText:'确认',
                    cancelButtonText:'取消'
                }).then((action) => {
                    if (action == 'confirm') {
                        this.addressList.splice(index,1);
                        axios.post('/api/user/myAddressDelete',qs.stringify({
                            id:id
                        }))
                    }
                }).catch((err) => {
                    if (err == 'cancel') {
                        console.log('123');
                    }
                });
                // 阻止事件冒泡
                e.stopPropagation();
            },
            // 获取地址信息
            getAddress(){
                axios.post('/api/user/myAddressList',qs.stringify({
                    page:this.pageNo
                })).then((res) => {
                    if(res.data.code == '0'){
                        let list = res.data.data.list;
                        list.forEach(item => {
                            this.addressList.push(item);
                        })
                        this.hasNextPage = res.data.data.hasNextPage;
                        if(!this.hasNextPage){
                            this.loading = true;
                        }else{
                            this.loading = false;
                        }
                        this.isLoading = false;
                        this.isPass = true
                    }
                }).catch((err) => {
                    console.log(err);
                })
            },
            // 设置默认按钮
            checked(index){
                let id = this.addressList[index].id;
                this.addressList.forEach((item,i) => {
                    item.is_default = -1
                })
                this.addressList[index].is_default = 0;
                axios.post('/api/user/myAddressSetDefault',qs.stringify({
                    is_default:'0',
                    id:id
                })).then((res) => {
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            },
            //选择收货人地址
            chooseAddress(item){
                if(localStorage.getItem('addressRootly') == 'shop'){
                    localStorage.setItem('recipients',JSON.stringify(item));
                    localStorage.setItem('toshop','address');
                    localStorage.setItem('address_id',item.id);
                    this.$router.push({
                        path:'/shopCar',
                        name:'shopCar',
                        params:{
                            toshop:'address'
                        }
                    })
                }
                if(localStorage.getItem('addressRootly') == 'fightShop'){
                    localStorage.setItem('fightRecipients',JSON.stringify(item));
                    localStorage.setItem('toFightshop','address');
                    localStorage.setItem('address_id',item.id);
                    this.$router.push({
                        path:'/fightShop',
                        name:'fightShop',
                        params:{
                            toFightshop:'address'
                        }
                    })
                }
                if(localStorage.getItem('addressRootly') == 'IntegralCar'){
                    localStorage.setItem('fightRecipients',JSON.stringify(item));
                    localStorage.setItem('toIntegralCar','address');
                    localStorage.setItem('address_id',item.id);
                    this.$router.push({
                        path:'/IntegralCar',
                        name:'IntegralCar',
                        params:{
                            toFightshop:'address'
                        }
                    })
                }
            },
            loadMore(){
                this.pageNo++;
                this.isPass = false;
                this.getAddress();
            }
        },
        components:{
            loading
        },
        mounted(){
            this.getAddress();
        }
    }
</script>

<style scoped lang="scss">
    .mint-checkbox-input:checked + .mint-checkbox-core{
        background-color: #FFDC4B !important;
        border-color: #FFDC4B !important;
    }
    .address{
        height: 100%;
        .add_address{
            position: fixed;
            left: 50%;
            bottom: 0.2rem;
            width: 6.91rem;
            height: 0.89rem;
            text-align: center;
            line-height: 0.89rem;
            background-color: #FFDC4B;
            font-size: 0.32rem;
            color: #333;
            transform: translateX(-50%);
            border-radius: .18rem;
            border:none 0;
        }
    }
    .address_choose{
        height: 9.2rem;
        overflow-y: auto;
        ul{
            li{
                padding-left: 0.2rem;
                padding-top: 0.2rem;
                background-color: #fff;
                margin-bottom: 0.2rem;
                &:last-child{
                    margin-bottom: 0;
                }
                .people_infor{
                    border-bottom: 2px solid #ddd;
                    padding-bottom: 0.34rem;
                    .personal{
                        margin-bottom: 0.2rem;
                        .people_name{
                            float: left;
                            font-size:0.28rem;
                            color:#333;
                            line-height:0.4rem;
                            margin-right: 0.8rem;
                        }
                        .people_tel{
                            float: left;
                            color: #333;
                            font-size: 0.3rem;
                            line-height: 0.4rem;
                        }
                    }
                    .people_address{
                        font-size: 0.28rem;
                        color: #333;
                    }
                }
                .address_setting{
                    .default{
                        float: left;
                        margin-top: 0.3rem;
                        .choose_default{
                            color: #666;
                        }
                    }
                    .setting{
                        color: #999;
                        float: right;
                        margin-top: 0.35rem;
                        div {
                            float: left;
                            &.del{
                                margin-left: 0.16rem;
                                margin-right: 0.16rem;
                            }
                            .icon{
                                float: left;
                                font-size: 0.28rem;
                            }
                            span{
                                float: left;
                                font-size: 0.28rem;
                                margin-left: 0.1rem;
                                margin-top: -0.05rem;
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
</style>
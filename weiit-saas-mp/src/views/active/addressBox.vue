<template>
    <div class="address_box">
        <div class="address_choose">
            <h6>请选择收货地址</h6>
            <div class="address_list">
                <ul>
                    <li v-for="item in addressList" @click="ensureAddress(item)">
                        <p>
                            <span>{{item.consignee}}</span>
                            <span>{{item.phone}}</span>
                        </p>
                        <p>{{item.province}} {{item.city}} {{item.district}} {{item.address_detail}}</p>
                        <i class="icon iconfont icon-youjiantouda"></i>
                    </li>
                    <li @click="addAddress()">
                        添加新收获地址
                        <i class="icon iconfont icon-youjiantouda"></i>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios';
    // 引入qs
    import qs from 'qs';
    // 从mint-ui中引入MessageBox
    import { MessageBox } from 'mint-ui';
    export default {
        data() {
            return {
                bargain_id: this.$route.params.bargain_id ? this.$route.params.bargain_id : localStorage.getItem('bargain_id'),
                addressList:[]
            }
        },
        methods: {
            // 获取其实信息
            saveData(){
                let bargain_id = this.$route.params.bargain_id;
                if(bargain_id){
                    localStorage.setItem('bargain_id',bargain_id);
                }
            },
            // 获取地址信息
            getAddress() {
                axios.post('/api/user/myAddressList', null)
                .then((res) => {
                    if(res.data.code == '0'){
                        this.addressList = res.data.data.list;
                    }
                })
                .catch((err) => {
                    console.log(err);
                })
            },
            // 添加地址
            addAddress(){
                localStorage.setItem('addressRootly','addressBox')
                this.$router.push({
                    path:'/addSite',
                    name:'addSite'
                })
            },
            // 确认砍价收货地址
            ensureAddress(item){
                let hmls = `<p style="text-align:center;width:3rem;margin:0 auto;line-height:0.28rem;color:#666;font-size:0.28rem;margin-top:0.1rem">${item.province+item.city+item.district+item.address_detail}</p>`;
                MessageBox.confirm('',{
                    title:'确认您得收货地址',
                    message:hmls,
                    cancelButtonClass:'cancelButton',
                    confirmButtonClass:'confirmButton',
                    confirmButtonText:'确认',
                    cancelButtonText:'取消'
                }).then((action) => {
                    if (action == 'confirm') {
                        axios.post('/api/bargain/bargainOrder',qs.stringify({
                            bargain_id:this.bargain_id,
                            address_id:item.id
                        })).then((res) => {
                            if(res.data.code == '0'){
                                let order_id = res.data.data.b_order_id;
                                this.$emit('order',order_id);
                                localStorage.setItem('order_id',order_id);
                                localStorage.setItem('bargain_id',this.bargain_id);
                                this.$router.push({
                                    path:'/freeGet',
                                    name:'freeGet'
                                })
                            }
                        }).catch((err) => {
                            console.log(err);
                        })
                        
                    }
                }).catch((err) => {
                    if (err == 'cancel') {
                        console.log('取消');
                    }
                });
            }
        },
        mounted(){
            this.saveData();
            this.getAddress();
        }
    }
</script>

<style scoped lang="scss">
    .address_box{
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, .5);
        .address_choose{
            position: absolute;
            left: 0;
            bottom: 0;
            width: 100%;
            background-color: #fff;
            h6{
                line-height: 1rem;
                text-align: center;
                border-bottom: 1px solid #ddd;
                box-sizing: border-box;
                font-size: 0.3rem;
                color: #333;
            }
            .address_list{
                padding-bottom: 0.3rem;
                height: 5.5rem;
                overflow-y: scroll;
                ul{
                    li{
                        position: relative;
                        border-bottom: 1px solid #ddd;
                        box-sizing: border-box;
                        font-size: 0.28rem;
                        color: #333;
                        padding:0.3rem 0.8rem 0.3rem 0.3rem;
                        &:last-child{
                            padding: 0.4rem 0 0.4rem 0.3rem;
                        }
                        .icon-youjiantouda{
                            position: absolute;
                            top: 50%;
                            right: 0.15rem;
                            transform: translateY(-50%);
                        }
                    }
                }
            }
        }
    }
</style>
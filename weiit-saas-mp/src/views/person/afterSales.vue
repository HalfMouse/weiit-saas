<template>
    <div class="afterSales">
        <!-- 申请售后物品信息 -->
        <div>
            <good :facomponent="'afterSales'" :good="goodinfor"></good>
            <!-- <ul v-else>
                <li v-for="item in refursGood">
                    <good :facomponent="'afterSales'" :good="item"></good>
                </li>
            </ul> -->
        </div>
        <!-- 选择售后货品状态 -->
        <div class="choose_kind">
            <ul>
                <li class="clearfix" @click="state = true"> 
                    <span class="kinds">货品状态</span>
                    <div class="clearfix">
                        <span>{{stateValue}}</span>
                        <i class="icon iconfont icon-youjiantouda"></i>
                    </div>
                </li>
                <li class="clearfix" @click="after = true">
                    <span class="kinds">售后类型</span>
                    <div class="clearfix">
                        <span>{{afterValue}}</span>
                        <i class="icon iconfont icon-youjiantouda"></i>
                    </div>
                </li>
            </ul>
        </div>
        <!-- 退还金额及退还说明 -->
        <div class="return_money">
            <p>退款金额：<span>￥{{refursPrice}}</span></p>
            <p>最多￥{{refursPrice}}，含发货邮费￥0.00</p>
            <p>售后说明：<input type="text" placeholder="选填" v-model="remarks"></p>
        </div>
        <!-- 上传照片凭证 -->
        <div class="prove">
            <h6>上传凭证</h6>
            <div class="pic">
                <div class="upload">
                    <i class="icon iconfont icon-zhaoxiangji"></i>
                    <p>添加图片</p>
                    <p>(最多三张)</p>
                    <input type="file" class="upload" name="file" multiple @change="uploadFile($event)" ref="files">
                </div>
            </div>
            <ul class="pic_show">
                <li v-for="item in imgSrc">
                    <img :src="$url + item" alt="">
                    <!-- <img :src="$url + '/weiit_shop_platform/2018-06-04/f22bdc2a-84c3-43c4-9cbf-985f6e945050.jpg'" alt=""> -->
                </li>
            </ul>
        </div>
        <a href="javascript:;" class="apply_btn" @click="refer()">提交</a>
        <!-- 货品状态选择弹出框 -->
        <mt-popup v-model="state" position="bottom" class="state_win">
            <header>货品状态</header>
            <ul>
                <li @click="state = false">
                    <label class="mint-radiolist-label">
                        <span class="mint-radio">
                            <input type="radio" class="mint-radio-input" value="未收到货" v-model="stateValue"> 
                            <span class="mint-radio-core"></span>
                        </span> 
                        <div class="mint-radio-label">
                            <h6>未收到货</h6>
                        </div>
                    </label>
                </li>
                <li @click="state = false">
                    <label class="mint-radiolist-label">
                        <span class="mint-radio">
                            <input type="radio" class="mint-radio-input" value="已收到货" v-model="stateValue"> 
                            <span class="mint-radio-core"></span>
                        </span> 
                        <div class="mint-radio-label">
                            <h6>已收到货</h6>
                        </div>
                    </label>
                </li>
            </ul>
        </mt-popup>
        <!-- 售后类型选择弹出框 -->        
        <mt-popup v-model="after" position="bottom" class="state_win after_win">
            <header>售后类型</header>
            <ul>
                <li @click="choiceAfter('只退款')">
                    <label class="mint-radiolist-label">
                        <span class="mint-radio">
                            <input type="radio" class="mint-radio-input" value="只退款" v-model="afterValue"> 
                            <span class="mint-radio-core"></span>
                        </span> 
                        <div class="mint-radio-label">
                            <h6>仅退款</h6>
                            <p>未收到货(包括未签收)，或卖家协商同意前提下</p>
                        </div>
                    </label>
                </li>
                <li @click="choiceAfter('退款并退货')">
                    <label class="mint-radiolist-label">
                        <span class="mint-radio">
                            <input type="radio" class="mint-radio-input" value="退款并退货" v-model="afterValue"> 
                            <span class="mint-radio-core"></span>
                        </span> 
                        <div class="mint-radio-label">
                            <h6>退货退款</h6>
                            <p>已收到货，需要退换已收到的货物</p>
                        </div>
                    </label>
                </li>
            </ul>
        </mt-popup>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 引入单个商品组件
    import good from '@/components/good'
    // 引入popup, Radio组件从mint-ui中
    import { Popup, Radio,Toast } from 'mint-ui';
    export default {
        data(){
            return{
                state:false,
                after:false,
                stateValue:'已收到货',
                afterValue:'只退款',
                goodinfor:this.$route.params.goodinfor ? this.$route.params.goodinfor : JSON.parse(localStorage.getItem('goodinfor')),
                refursGood:this.$route.params.refursGood ? this.$route.params.refursGood : JSON.parse(localStorage.getItem('refursGood')),
                remarks:'',
                imgSrc:[],
                imgData: {  
                    accept: 'image/gif, image/jpeg, image/png, image/jpg',  
                },
                isFlag:true,
                rangeType:this.$route.params.rangeType ? this.$route.params.rangeType : localStorage.getItem('rangeType'),
                refursPrice:this.$route.params.refursPrice ? this.$route.params.refursPrice : localStorage.getItem('refursPrice')
            }
        },
        components:{
            good
        },
        mounted(){
            let goods = JSON.stringify(this.$route.params.goodinfor);
            // let refursGood = JSON.stringify(this.$route.params.refursGood);
            // let rangeType = this.$route.params.rangeType;
            let refursPrice = this.$route.params.refursPrice;
            if(goods){
                localStorage.setItem('goodinfor',goods)
            }
            // if(refursGood){
            //     localStorage.setItem('refursGood',refursGood)
            // }
            // if(rangeType){
            //     localStorage.setItem('rangeType',rangeType)
            // }
            if(refursPrice){
                localStorage.setItem('refursPrice',refursPrice)
            }
        },
        methods:{
            // 申请售后
            refer(){
                if(this.isFlag){
                    let refund_reason = this.remarks;
                    // let refund_money = this.goodinfor.total_price;
                    // 订单id
                    // let order_id = localStorage.getItem('order_id');
                    // 订单详情id
                    // let order_item_id = localStorage.getItem('order_item_id');
                    // 订单图片
                    let refund_imgs
                    if(this.imgSrc.length == 0){
                        refund_imgs = ''
                    }else{
                        refund_imgs = this.imgSrc.join(',');
                    }
                        
                    // 退换类型
                    let refund_type;
                    let id = this.goodinfor.id;
                    if(this.afterValue == '只退款'){
                        refund_type = '1'
                    }else if(this.afterValue == '退款并退货'){
                        refund_type = '2'
                    }
                    this.isFlag = false;
                    axios.post('/api/order/addOrderRefund',qs.stringify({
                        refund_imgs:refund_imgs,
                        refund_type:refund_type,
                        remark:refund_reason,
                        id:id
                    })).then((res) => {
                        if(res.data.code == '0'){
                            Toast('提交成功');
                            this.isFlag = true;
                            this.$router.push({
                                path:'/returnGoods',
                                name:'returnGoods'
                            })
                        }
                    }).catch((err) => {
                        Toast('提交失败');
                    })
                }
                
            },
            // 上传图片
            uploadFile(e){
                let reader =new FileReader();  
                let img1=event.target.files[0];   
                let size=img1.size;//文件的大小，判断图片的大小   
                if(size>3145728){  
                    alert('请选择3M以内的图片！');  
                    return false;  
                }  
                var uri = ''  
                let form = new FormData();   
                form.append('file',img1); 
                axios.post('/api/uploadImg',form,{  
                    headers:{'Content-Type':'multipart/form-data'}  
                }).then(res => {  
                    if(res.data.code == '0'){
                        let url = res.data.data[0].img_url;
                        this.imgSrc.push(url);  
                        let length = this.imgSrc.length;
                        if(length > 3){
                           this.imgSrc = this.imgSrc.slice(length-3);
                        }
                    }
                }).catch(error => {  
                    alert('上传图片出错！');  
                })    
            },
            // 选择售后
            choiceAfter(type){
                this.after = false;
                this.afterValue = type;
            }
        }
    }
</script>

<style scoped lang="scss">
    .afterSales{
        padding-top: 0.1rem;
        .choose_kind{
            margin-top: 0.2rem;
            ul{
                
                li{
                    background-color: #fff;
                    line-height: 1rem;
                    box-sizing: border-box;
                    padding:0 0.2rem;
                    &:last-child{
                        border-top: 1px solid #ddd;
                    }
                    .kinds{
                        font-size: 0.32rem;
                        color: #333;
                        float: left;
                    }
                    div{
                        float: right;
                        font-size: 0.32rem;
                        color: #999;
                    }
                }
            }
        }
        .return_money{
            margin-top: 0.2rem;
            p{
                line-height: 1rem;
                background-color: #fff;
                font-size: 0.32rem;
                padding-left: 0.2rem;
                color: #333;
                &:nth-child(2){
                    background-color: #f5f5f5;
                    color: #999;
                }
            }
        }
        .state_win{
            min-height: 5rem;
            header{
                padding-top: 0.2rem;
                text-align: center;
                color: #333;
                font-weight: bold;
                font-size: 0.34rem;
                font-family: 'PingFang-SC-Bold';
            }
            ul{
                padding:0 0.2rem;
                li{
                    border-bottom: 2px solid #ddd;
                    height: 1rem;
                    &:last-child{
                        border: none 0;
                    }
                    .mint-radiolist-label{
                        position: relative;
                        overflow: hidden;
                        height: 1rem;
                        .mint-radio{
                            float: right;
                            text-align: right;
                            margin-right: 0.05rem;
                            margin-top: 0.3rem;
                            .mint-radio-core{
                                display: block;
                            }
                        }
                        .mint-radio-label{
                            float: left;
                            text-align: left;
                            position: relative;
                            top: 50%;
                            transform: translateY(-50%);
                            h6{
                                font-size: 0.34rem;
                                color: #666;
                            }
                            p{
                                font-size: 0.24rem;
                                color: #999;
                            }
                        }
                    }
                    
                }
            }
        }
        .apply_btn{
            display: block;
            margin: 0.2rem auto 0;
            width:6.91rem;
            height:0.89rem;
            background:rgba(255,220,75,1);
            border-radius: 0.19rem; 
            font-size: 0.32rem;
            color: #333;
            text-align: center;
            line-height:0.89rem; 
        }
        .prove{
            background-color: #fff;
            padding: 0.2rem;
            padding-bottom: 0.3rem;
            margin-top: 0.2rem;
            overflow: hidden;
            h6{
                font-size: 0.28rem;
                margin-bottom: 0.2rem;
            }
            .pic{
                width: 1.39rem;
                height: 1.39rem;
                border:1px dashed #d9d9d9;
                text-align: center;
                color: #d9d9d9;
                position: relative;
                float: left;
                .icon{
                    font-size: 0.51rem;
                    display: block;
                    margin-top: 0.1rem;
                }
                p{
                    font-size: 0.22rem;
                } 
                input {
                    position: absolute;
                    width: 100%;
                    right: 0;
                    top: 0;
                    opacity: 0;
                }
            }
            ul{
                float: left;
                li{
                    float: left;
                    width: 1.39rem;
                    height: 1.39rem;
                    position: relative;
                    margin-left: 0.2rem;
                    img{
                        width: 100%;
                        height: 100%;
                    } 
                }
            }
        }
    }
</style>
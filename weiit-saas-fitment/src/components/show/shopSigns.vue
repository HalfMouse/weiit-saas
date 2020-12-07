<template>
    <div class="showBox">
        <!-- <div class="shop_signs blankShow" v-if="bgPic == ''">
            <div class="type type1" v-if="showStyle == 'type1'" >
                <div class="htBg">
                    <div class="bgPic">
                        <img src="static/images/bg.png" alt="">
                    </div>
                    <div class="bg">
                        
                    </div>
                </div>
                
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p>
                            <span class="discount_name">满减</span>
                            <span class="discount_txt">在线支付满150减30，满100减20</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="type type2" v-if="showStyle == 'type2'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="">
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p>
                            <span class="discount_name">全部商品</span>
                            <span class="nt">|</span>
                            <span class="discount_txt">上新30</span>
                        </p>
                    </div>
                </div>
                <div class="more"></div>
            </div>
            <div class="type type2 type3" v-if="showStyle == 'type3'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="">
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p>
                            <span class="discount_name">全部商品</span>
                            <span class="nt">|</span>
                            <span class="discount_txt">上新30</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="type type4" v-if="showStyle == 'type4'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="">
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p>
                            <span class="discount_name">全部商品</span>
                            <span class="nt">|</span>
                            <span class="discount_txt">上新30</span>
                        </p>
                    </div>
                </div>
                <div class="more"></div>
            </div>
            <div class="type type4 type5" v-if="showStyle == 'type5'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="">
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img src="static/images/user.jpg" alt="">
                    </div>
                    <div class="txt">
                        <h5>zhangxiaoxiao</h5>
                        <p>
                            <span class="discount_name">全部商品</span>
                            <span class="nt">|</span>
                            <span class="discount_txt">上新30</span>
                        </p>
                    </div>
                    <span class="line"></span>
                </div>
            </div>
            
        </div> -->
        <div class="shop_signs blankShow">
            <div class="type type1" v-if="showStyle == 'type1'">
                <div class="htBg">
                    <div class="bgPic">
                        <img src="static/images/bg.png" alt="" v-if="bgPic == ''" draggable="false">
                        <img :src="bgPic" alt="" v-else draggable="false">
                    </div>
                    <div class="bg">
                        
                    </div>
                </div>
                
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img :src="shop_logo" alt="" draggable="false">
                    </div>
                    <div class="txt">
                        <h5>{{shopName}}</h5>
                        <p class="signature">{{signature}}</p>
                    </div>
                </div>
            </div>
            <div class="type type2" v-if="showStyle == 'type2'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="" v-if="bgPic == ''" draggable="false">
                            <img :src="bgPic" alt="" v-else draggable="false">
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img :src="shop_logo" alt="" draggable="false">
                    </div>
                    <div class="txt">
                        <h5>{{shopName}}</h5>
                        <p class="signature">{{signature}}</p>
                    </div>
                </div>
                <div class="more"></div>
            </div>
            <div class="type type2 type3" v-if="showStyle == 'type3'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="" v-if="bgPic == ''" draggable="false">
                            <img :src="bgPic" alt="" v-else draggable="false">
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img :src="shop_logo" alt="" draggable="false">
                    </div>
                    <div class="txt">
                        <h5>{{shopName}}</h5>
                        <p class="signature">{{signature}}</p>
                    </div>
                </div>
            </div>
            <div class="type type4" v-if="showStyle == 'type4'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img src="static/images/bg.png" alt="" v-if="bgPic == ''" draggable="false">
                            <img :src="bgPic" alt="" v-else draggable="false">
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img :src="shop_logo" alt="" draggable="false">
                    </div>
                    <div class="txt">
                        <h5>{{shopName}}</h5>
                        <p class="signature">{{signature}}</p>
                    </div>
                </div>
                <div class="more"></div>
            </div>
            <div class="type type4 type5" v-if="showStyle == 'type5'">
                <div class="type_bg">
                    <div class="htBg">
                        <div class="bgPic">
                            <img :src="shop_logo" alt="" v-if="bgPic == ''" draggable="false">
                            <img :src="bgPic" alt="" v-else draggable="false">
                        </div>
                        <div class="bg">
                            
                        </div>
                    </div>
                </div>
                <div class="shop_info fn-clear">
                    <div class="pic">
                        <img :src="shop_logo" alt="" draggable="false">
                    </div>
                    <div class="txt">
                        <h5>{{shopName}}</h5>
                        <p class="signature">{{signature}}</p>
                    </div>
                    <span class="line"></span>
                </div>
            </div>
        </div>
        <!-- 设置店招 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-shop @event="getData" :pageParam="pageParam"></set-shop>
        </div>
    </div> 
</template>

<script>
    // 设置店招  
    import setShop from '@/components/set/setShop'
    // 设置头部
    import headModify from '@/components/common/headModify'
    import List from '../../../static/js/List'
    import {mapActions} from 'vuex'
    export default {
        props:{
            keyText:String,
            tempId:Number,
            keyWords:String,
            pageParam:{
                type:Object,
                default:() => {
                    return {showStyle:'type3',bgPic:'',signature:'我的店名',shopName:''}
                }
            }
        },
        data() {
            return {
                showStyle: 'type1',
                isOk:false,
                bgPic:'',
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                count:2,
                signature:'',
                shopName:'我的店名',
                shop_logo:''
            }
        },
        components:{
            setShop,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(obj){
                this.showStyle = obj.showStyle;
                this.bgPic = obj.bgPic;
                this.signature = obj.signature;
                this.shopName = obj.shopName;
                // 修改数据
                this.changeData({id:this.tempId,op:obj})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.showStyle = this.showStyle;
                list.pageParam.bgPic = this.bgPic;
                list.pageParam.signature = this.signature;
                list.pageParam.shopName = this.shopName;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.showStyle = this.pageParam.showStyle;
                this.bgPic = this.pageParam.bgPic.replace(this.imageDomaia,'');
                this.signature = this.pageParam.signature;
                this.shopName = this.pageParam.shopName;
            },
            // 获取logo
            getLogo(){
                // /center/design/shopLogo
                this.$ajax({
                    methods: "get",
                    url: "/center/design/shopLogo"
                }).then((res) => {
                    if(res.status == 200){
                        if(res.data.shopInfo.shop_logo){
                            console.log(1);
                            this.shop_logo = this.imageDomaia + res.data.shopInfo.shop_logo;
                        }else{
                            this.shop_logo = 'static/images/user.jpg'
                        }
                    }
                }).catch(err => {
                    err;
                })
            }
        },
        mounted(){
            this.saveData();
            this.initData();
            this.getLogo();
        }
    }
</script>

<style scoped>
    .type{
        position: relative;
    }
    
    .htBg{
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
    }
    .bg{
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,.3);
        z-index: 2;
    }
    .bgPic img{
        position: absolute;
        width: 100%;
        height: 100%;
        z-index: 1;
    }
    /* 样式1 */
    .type1{
        height: 185px;
        background-size: 100% 100%;
    }
    .type2 .shop_info,
    .type1 .shop_info{
        position: absolute;
        z-index: 4;
        bottom: 10px;
        padding-left: 15px;
    }
    .type2 .shop_info .pic,
    .type1 .shop_info .pic{
        float: left;
        width: 58px;
        height: 58px;
        border: 1px solid #fff;
    }
    .type2 .shop_info .pic img,
    .type1 .shop_info .pic img{
        width: 100%;
        height: 100%;
    }
    .type2 .shop_info .txt,
    .type1 .shop_info .txt{
        margin-left: 70px;
    }
    .type2 .shop_info .txt h5,
    .type1 .shop_info .txt h5{
        margin-top: 10px;
        max-width: 220px;
        font-size: 18px;
        line-height: 22px;
        font-weight: 700;
        color: #fff;
        text-shadow: 0 1px 15px rgba(0,0,0,.5);
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }
    .type1 .shop_info .txt p{
        position: relative;
        margin: 8px 15px 0 0;
        padding-right: 10px;
        color: #fff;
        cursor: pointer;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }
    .type1 .shop_info .txt p .discount_name{
        display: inline-block;
        background-color: #f44;
        padding: 0 2px;
    }
    /* 样式2 */
    .type2{
        height: 238px;
    }
    .type2 .type_bg{
        position: relative;
        height: 185px;
        background-size: 100% 100%;
    }
    .type2 .type_bg .htBg{
        position: absolute;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
        background-color: transparent;
        background-image: -ms-gradient(linear,left bottom,left top,from(#000),to(transparent));
        background-image: -webkit-linear-gradient(bottom,#000,transparent);
        background-image: -moz-linear-gradient(bottom,#000,transparent);
        background-image: linear-gradient(0deg,#000,transparent);
    }
    .type2 .shop_info{
        bottom: 27px;
    }
    .type2 .shop_info .pic{
        border-radius: 50%;
        overflow: hidden;
    }
    .type2 .shop_info .txt h5{
        margin-top: 5px;
    }
    .type2 .shop_info p{
        margin-top: 10px;
        color: #333;
    }
    .type2 .shop_info p span{
        color: #999;
        font-size: 12px;
    }
    .type2 .shop_info p span.nt{
        margin: 0 10px;
    }
    .type2 .more{
        position: absolute;
        left: 0;
        top: 185px;
        width: 100%;
        background-color: #fff;
        height: 53px;
    }
    /* 样式3 */
    .type3{
        height: 185px;
    }
    .type3 .shop_info{
        bottom: 10px;
    }
    .type3 .shop_info .pic{
        border-radius: 0;
        
    }
    .type3 .shop_info .txt p{
        color: #fff;
    }
    /* 样式4 */
    .type4{
        position: relative;
        height: 258px;
    }
    .type4 .type_bg{
        position: relative;
        height: 150px;
        background-size: 100% 100%;
    }
    .type4 .more{
        position: absolute;
        left: 0;
        top: 150px;
        width: 100%;
        background-color: #fff;
        height: 108px;
    }
    .type4 .shop_info{
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        text-align: center;
        z-index: 5;
        top: 120px;
    }
    .type4 .shop_info .pic{
        width: 58px;
        height: 58px;
        border: 1px solid #fff;
        border-radius: 50%;
        overflow: hidden;
        margin: 0 auto;
    }
    .type4 .shop_info .pic img{
        width: 100%;
        height: 100%;
    }
    .type4 .shop_info .txt h5{
        display: inline-block;
        margin-top: 10px;
        max-width: 100%;
        color: #333;
        text-shadow: none;
        font-size: 18px;
        line-height: 22px;
        font-weight: 700;
        overflow: hidden;
        text-overflow: ellipsis;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
    }
    .type4 .shop_info .txt p{
        margin-top: 3px;
        color: #333;
    }
    .type4 .shop_info .txt p span{
        display: inline-block;
        color: #999;
    }
    .type4 .shop_info .txt p span.nt{
        margin: 0 10px;
    }
    /* 样式5 */
    .type5{
      height: 250px;  
    }
    .type5 .type_bg{
        height: 250px;
    }
    .type5 .shop_info{
        top:50%;
        transform: translate(-50%,-50%);
    }
    .type5 .shop_info .txt p{
        color: #fff;
        padding: 0 10px;
        border-top: 1px solid #fff;
    }
    .type5 .shop_info .txt h5{
        color: #fff;
    }
    
    .type .shop_info .txt p{
        font-size: 14px;
    }
</style>
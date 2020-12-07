<template>
    <div class="showBox">
        <div class="coupon blankShow">
            <div class="coupon_box" v-if="showGoods.length == 0">
                <div class="couponList">
                    <div class="cap-coupon__item">
                        <div class="cap-coupon__price">
                            <span>￥</span>
                            <span class="couponPrice">100</span>
                        </div>
                        <div class="cap-coupon__desc">
                            <div>无门槛使用</div>
                        </div>
                    </div>
                    <div class="cap-coupon__item cap-coupon__item--disabled"><div class="cap-coupon__price"><span></span><span class="couponPrice">8.8</span><span> 折</span></div><div class="cap-coupon__desc"><!----><div>满299.90元可用</div></div><!----><div class="cap-coupon__disabled-text-wrap"><div class="cap-coupon__disabled-text">已领取</div></div></div>
                    <div class="cap-coupon__item cap-coupon__item--disabled"><div class="cap-coupon__price"><span></span><span class="couponPrice">8.8</span><span> 折</span></div><div class="cap-coupon__desc"><!----><div>无门槛使用</div></div><!----><div class="cap-coupon__disabled-text-wrap"><div class="cap-coupon__disabled-text">已领取</div></div></div>
                </div>  
            </div>
            <div class="coupon_box" v-else>
                <div class="couponList">
                    <div class="cap-coupon__item" v-for="item in showGoods">
                        <div class="cap-coupon__price" v-if="item.type == 1">
                            <span>￥</span>
                            <span class="couponPrice">{{item.coupon_price}}</span>
                        </div>
                        <div v-if="item.type == 2" class="discountBox">
                            <span class="discountNum">{{item.coupon_discount}}</span>
                            <span>折</span>
                        </div>
                        <div class="cap-coupon__desc" v-if="item.is_condition == -1">
                            <div>无门槛使用</div>
                        </div>
                        <div class="cap-coupon__desc" v-if="item.is_condition == 1">
                            <div>满{{item.condition_price}}减</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 设置优惠券 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-coupon @event="getData" :pageParam="pageParam"></set-coupon>
        </div>
    </div>
</template>

<script>
    // 设置优惠券
    import setCoupon from '@/components/set/setCoupon'
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
                    return {
                        addFun:'manual',
                        coupon_ids:[],
	                    showNum:this.showNum,
	                    hideCoupon:this.hideCoupon
                    }
                }
            }
        },
        data(){
            return {
                addFun:'',
                showGoods:[],
                coupon_ids:[]
            }
        },
        components:{
            setCoupon,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(coupon){
                this.addFun = coupon.addFun;
                this.coupon_ids = coupon.coupon_ids;
                this.hideCoupon = coupon.hideCoupon;
                this.showNum = parseInt(coupon.showNum)
                // 当传过来的coupon_ids长度大于0时执行
                if(this.addFun == 'manual'){
                    if(coupon.coupon_ids.length == 0){
                        this.showGoods = []
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/ump/coupons/couponListByIds',
                            params:{
                                coupon_ids:coupon.coupon_ids,
                                couponGetType: 0
                            }
                        }).then(res => {
                            this.showGoods = res.data.data;
                        }).catch(err => {
                            (err);
                        })
                    }
                }else if(this.addFun == 'automatic'){
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/coupons/couponListByIds',
                        params:{
                            couponGetType:1,
                            
                        }
                    }).then(res => {
                    	let showNum = parseInt(this.showNum);
                        this.showGoods = res.data.data.splice(0, showNum);
                    }).catch(err => {
                        (err);
                    })
                }
                // 修改数据
                this.changeData({id:this.tempId,op:coupon});
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.addFun = this.addFun;
                list.pageParam.coupon_ids = this.coupon_ids;
                list.pageParam.hideCoupon = this.hideCoupon;
                list.pageParam.showNum = this.showNum;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.addFun = this.pageParam.addFun;
                this.coupon_ids = this.pageParam.coupon_ids;
                this.showNum = parseInt(this.pageParam.showNum) != 0 ? parseInt(this.pageParam.showNum) : 6;
                this.hideCoupon = this.pageParam.hideCoupon;
                if(this.addFun == 'manual'){
                    if(this.coupon_ids.length == 0){
                        this.showGoods = []
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/ump/coupons/couponListByIds',
                            params:{
                                coupon_ids:this.coupon_ids,
                                couponGetType: 0
                            }
                        }).then(res => {
                            let showNum = parseInt(this.showNum);
                        	this.showGoods = res.data.data.splice(0, showNum);
                        }).catch(err => {
                            (err);
                        })
                    }
                }else if(this.addFun == 'automatic'){
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/coupons/couponListByIds',
                        params:{
                            couponGetType:1
                        }
                    }).then(res => {
                        this.showGoods = res.data.data;
                    }).catch(err => {
                        (err);
                    })
                }
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .coupon{
        width: 308px;
        overflow-x: hidden;
        padding: 5px;
    }
    .cap-coupon__track {
        width: 100%;
        padding: 10px 15px;
        overflow: hidden;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
    }
    .cap-coupon__item {
        color: #fff;
        float: left;
        width: 110px;
        height: 70px;
        line-height: 1;
        position: relative;
        border-radius: 4px;
        -webkit-box-orient: vertical;
        -webkit-box-direction: normal;
        -webkit-flex-direction: column;
        -moz-box-orient: vertical;
        -moz-box-direction: normal;
        -ms-flex-direction: column;
        flex-direction: column;
        -webkit-box-align: center;
        -webkit-align-items: center;
        -moz-box-align: center;
        -ms-flex-align: center;
        align-items: center;
        -webkit-box-pack: center;
        -webkit-justify-content: center;
        -moz-box-pack: center;
        -ms-flex-pack: center;
        justify-content: center;
        background: -webkit-gradient(linear,left top,right top,from(#ff6565),to(#ff8c8c));
        background: -webkit-linear-gradient(left,#ff6565,#ff8c8c);
        background: -moz-linear-gradient(left,#ff6565,#ff8c8c);
        background: linear-gradient(90deg,#ff6565,#ff8c8c);
    }
    .cap-coupon__item:before {
        left: -5px;
    }
    .cap-coupon__item:after {
        right: -5px;
    }
    .cap-coupon__item:after, .cap-coupon__item:before {
        content: "";
        top: 50%;
        z-index: 1;
        width: 10px;
        height: 10px;
        border-radius: 50px;
        margin-top: -5px;
        position: absolute;
        background-color: #fafafa;
    }
    .cap-coupon__price {
        font-size: 12px;
        padding-top: 5px;
        overflow: hidden;
        display: table;
        margin: 0px auto 10px;
    }
    .cap-coupon__price span{
        float: left;
        line-height: 30px;
    }
    .cap-coupon__desc {
        font-size: 12px;
        margin-top: 4px;
        text-align: center;
    }
    
    .cap-coupon__item:not(:last-child) {
        margin-right: 10px;
    }
    .cap-coupon__item--disabled {
        background: #d3d6d9;
    }
    .cap-coupon__item span,
    .cap-coupon__item div{
        color: #fff;
    }
    .cap-coupon__disabled-text-wrap {
        top: 0;
        right: 0;
        overflow: hidden;
        border-radius: inherit;
    }
    .cap-coupon__disabled-text, .cap-coupon__disabled-text-wrap {
        width: 40px;
        height: 40px;
        position: absolute;
    }
    .cap-coupon__disabled-text {
        top: -9px;
        right: -3px;
        line-height: 50px;
        border: 1px solid #9e9e9e;
        border-radius: 20px;
        -webkit-transform: rotate(30deg);
        -moz-transform: rotate(30deg);
        -ms-transform: rotate(30deg);
        transform: rotate(30deg);
        text-align: center;
        font-size: 12px;
    }
    .cap-coupon__item .cap-coupon__disabled-text{
        color:#9e9e9e;
    }
    .cap-coupon__item .cap-coupon__price .couponPrice{
        font-size: 30px;
    }
    .couponList .cap-coupon__item{
        float: left
    }
    .couponList{
        width: 960px;
    }
    .discountNum{
        font-size: 30px;
    }
    .discountBox{
        text-align: center;
        margin-bottom: 10px;
        margin-top: 5px;
    }
</style>
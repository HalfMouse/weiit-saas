<template>
    <div class="addSite">
        <div class="addSite_box">
            <!-- 个人信息填写 -->
            <div class="address_infor">
                <div class="nt nt1"></div>
                <ul>
                    <li>
                        <label for="">姓 名</label>
                        <input type="text" placeholder="请输入收件人姓名"  maxlength="11" v-model="username">
                        <!-- <mt-field label="姓名" placeholder="请输入收件人姓名"></mt-field> -->
                    </li>
                    <li>
                        <label for="">手机号码</label>
                        <input type="tel" placeholder="请输入收件人手机号"  maxlength="11" v-model="phone">
                        <!-- <mt-field label="手机号码" placeholder="请输入收件人手机号" type="tel" v-model="phone"></mt-field> -->
                    </li>
                    <li class="city_choose clearfix" @click="handlerArea()">
                        <div class="city">
                            <span>省 市</span>
                        </div>
                        <div class="city_address">
                            <span>{{myAddressProvince}}</span>
                            <span>{{myAddressCity}}</span>
                            <span>{{myAddresscounty}}</span>
                        </div>
                    </li>
                    <li>
                        <label for="">详细地址</label>
                        <input type="text" placeholder="请输入收件人详细地址" v-model="addressDetail">
                        <!-- <mt-field label="详细地址" placeholder="请输入收件人详细地址" v-model="address"></mt-field> -->
                    </li>
                </ul>
                <div class="nt nt2"></div>
            </div>
            <!-- 设置默认按钮 -->
            <div class="switch">
                <span class="default">设为默认地址</span>
                <mt-switch v-model="defaultly"></mt-switch>
            </div>
            <!-- 保存按钮 -->
            <button class="save" :class="{current : enough()}" @click="modify()" v-if="addressRootly == 'edit'" :style="{background:color1,color:'#fff'}">保存</button>
            <button class="save" :class="{current : enough()}" @click="add()" v-else>保存</button>
        </div>
        <div class="page-content">
            <mt-popup v-model="areaVisible" class="area-class" position="bottom">
                <div class="address_btn clearfix">
                    <a href="javascript:;" class="cancel" @click="areaVisible = false">取消</a>
                    <a href="javascript:;" class="ensure" @click="ensureAddress()">确定</a>
                </div>
                <mt-picker :slots="myAddressSlots" value-key="region_name" @change="onMyAddressChange"></mt-picker>
            </mt-popup>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
    // 从mint-ui中引入Popup,Picker组件
    import { Popup,Picker,Switch,Toast } from 'mint-ui';
    // 导入省市区数据
    import myaddress from '../../../static/json/address.json'
    export default {
        name: 'index',
        data() {
            return {
                myAddressSlots: [{
                    flex: 1,
                    defaultIndex: 1,    
                    values: myaddress,  //省份数组
                    className: 'slot1',
                    textAlign: 'center'
                }, {
                    divider: true,
                    content: '-',
                    className: 'slot2'
                }, {
                    flex: 1,
                    values: myaddress[0].child,
                    className: 'slot3',
                    textAlign: 'center'
                },
                {
                    divider: true,
                    content: '-',
                    className: 'slot4'
                },
                {
                    flex: 1,
                    values: myaddress[0].child[0].child,
                    className: 'slot5',
                    textAlign: 'center'
                }],
                // 省
                myAddressProvince:'',
                // 市
                myAddressCity:'',
                // 区
                myAddresscounty:'',
                province:'',
                city:'',
                county:'',
                // 用户姓名
                username:'' ,
                // 用户电话
                phone:'',
                // 用户详细地址
                addressDetail:'',
                // 底部地址弹出框判断
                areaVisible:false,
                // 默认值判断
                defaultly:true,
                // 跳转地址来源
                addressRootly:localStorage.getItem('addressRootly'),
                // 是否保存标识
                isFlag:true,
                city_keys:0,
                area_keys:0,
                color1:localStorage.getItem('bg1'),
                color2:localStorage.getItem('bg2'),
                recipients:{},
                fightRecipients:{},
                address_id:null
            }
        },
        methods: {
            // 地址选择
            onMyAddressChange(picker, values) {
                if(values[0]){
                    picker.setSlotValues(1,values[0].child); // Object.keys()会返回一个数组，当前省的数组
                    picker.setSlotValues(2,values[1].child); 
                    this.province = values[0].region_name;
                    this.city = values[1].region_name;
                    this.county = values[2].region_name;
                }
            },
            // 点击从下部弹出显示地址选择
            handlerArea() {
                this.areaVisible = true
            },
            // 判断是否每个条件都填写完毕
            enough(){
                
                if(this.myAddressProvince && this.username && this.addressDetail && this.phone){
                    return true
                }
                return false
            },
            // 新增地址
            add(){
                let phoneReg = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
                if(this.enough()){
                    if(phoneReg.test(this.phone)){
                        if(this.isFlag){
                            let is_default;
                            if(!this.defaultly){
                                is_default = '-1';
                            }else{
                                is_default = '0';
                            }
                            // 姓名
                            let consignee = this.username;
                            // 省
                            let province = this.myAddressProvince;
                            // 市
                            let city = this.myAddressCity;
                            // 区
                            let district = this.myAddresscounty;
                            // 详细地址
                            let address_detail = this.addressDetail;
                            // 电话号码
                            let phone = this.phone;
                            this.isFlag = false;
                            this.fightRecipients = {
                                "address_detail":address_detail,
                                "consignee":consignee,
                                "province":province,
                                "city":city,
                                "phone":phone,
                                "district":district
                            };
                            this.recipients = {
                                "address_detail":address_detail,
                                "consignee":consignee,
                                "province":province,
                                "city":city,
                                "phone":phone,
                                "district":district
                            }
                            axios.post('/api/user/myAddressSave',qs.stringify({
                                consignee: consignee,
                                province: province,
                                city: city,
                                district: district,
                                address_detail: address_detail,
                                phone: phone,
                                is_default:is_default
                            })).then((res) => {
                                if(res.data.code == '0'){
                                    this.address_id = res.data.data;
                                    localStorage.setItem('address_id',this.address_id);
                                    this.isFlag = true;
                                    this.addNewAddress()
                                }
                            }).catch((err) => {
                                console.log(err)
                            })
                        }
                    }else{
                        Toast('请输入正确的手机号码')
                    }
                }
            },
            // 修改地址
            modify(){
                let phoneReg = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
                if(this.enough()){
                    if(this.enough()){
                        // 默认值
                        let is_default;
                        if(!this.defaultly){
                            is_default = '-1';
                        }else{
                            is_default = '0';
                        }
                        // 姓名
                        let consignee = this.username;
                        // 省
                        let province = this.myAddressProvince;
                        // 市
                        let city = this.myAddressCity;
                        // 区
                        let district = this.myAddresscounty;
                        // 详细地址
                        let address_detail = this.addressDetail;
                        // 电话号码
                        let phone = this.phone;
                        // 地址id值
                        let id = this.$route.params.address.id;
                        axios.post('/api/user/myAddressUpdate',qs.stringify({
                            consignee: consignee,
                            province: province,
                            city: city,
                            district: district,
                            address_detail: address_detail,
                            phone: phone,
                            is_default:is_default,
                            id: id
                        })).then((res) => {
                            this.$router.push({
                                path:'/address',
                                name:'address'
                            })
                        }).catch((err) => {
                            console.log(err)
                        })
                    }else{
                        Toast('请输入正确的手机号码')
                    }
                }
            },
            addNewAddress(){
                if(this.addressRootly == 'fight'){
                    this.$router.push({
                        path:'/teams',
                        name:'teams',
                        params:{
                            type:'bargain'
                        }
                    })
                }else if(this.addressRootly == 'addressBox'){
                    this.$router.push({
                        path:'/addressBox',
                        name:'addressBox'
                    })
                }else if(this.addressRootly == 'shop'){
                    localStorage.setItem('recipients', JSON.stringify(this.recipients));
                    this.$router.push({
                        path:'/shopCar',
                        name:'shopCar',
                        params:{
                            toshop:'addSite'
                        }
                    })
                }else if(this.addressRootly == 'address'){
                    this.$router.push({ 
                        path:'/address',
                        name:'address'
                    })
                }else if(this.addressRootly == 'fightShop'){
                    localStorage.setItem('fightRecipients', JSON.stringify(this.fightRecipients))
                    this.$router.push({
                        path:'/fightShop',
                        name:'fightShop',
                        params:{
                            toFightshop:'addSite'
                        }
                    })
                }else if(this.addressRootly == 'IntegralCar'){
                    localStorage.setItem('fightRecipients', JSON.stringify(this.fightRecipients))
                    this.$router.push({
                        path:'/IntegralCar',
                        name:'IntegralCar',
                        params:{
                            toIntegralCar:'addSite'
                        }
                    })
                }
            },
            ensureAddress(){
                this.myAddressProvince = this.province;
                this.myAddressCity = this.city;
                this.myAddresscounty = this.county;
                this.areaVisible = false;
            }
        },
        components:{
            'mt-picker': Picker
        },
        mounted(){
            
            // this.myAddressSlots[0].child[0].defaultIndex = 2;
            // this.myAddressProvince = '湖北省';
            // this.myAddressCity = '武汉市';
            // this.myAddresscounty = '洪山区';
            
            let address = this.$route.params.address;
            // 判断是否是从编辑页面跳转过来
            if(address){
                localStorage.setItem('addressItem', JSON.stringify(address));
                let addressItem = JSON.parse(localStorage.getItem('addressItem'));
                this.username = addressItem.consignee;
                this.phone = addressItem.phone;
                this.myAddressProvince = addressItem.province;
                this.myAddressCity = addressItem.city;
                this.myAddresscounty = addressItem.district;
                this.addressDetail = addressItem.address_detail;
                myaddress.forEach((item,index) => {
                    if(item.region_name === this.myAddressProvince){
                        this.myAddressSlots[0].defaultIndex = index;
                    }
                })
                // 
                if(addressItem.is_default == '-1'){
                    this.defaultly = false;
                }else{
                    this.defaultly = true;
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .addSite{
        padding-top: 0.2rem;
        .addSite_box{
            position: relative;
            width: 95%;
            margin: 0 auto;
            z-index: 10;
            .address_infor{
                position: relative;
                height: 4rem;
                background: #fff;
                border-radius: 0.1rem;
                margin-bottom: 0.2rem;
                padding:0.04rem 0.2rem 0 0.2rem;
                box-shadow: 0px 0px 0.2rem 0px rgba(192,192,192,0.9);
                ul{
                    li{
                        border-bottom: 2px solid #ddd;
                        height: 1rem;
                        line-height: 1rem;
                        input{
                            font-size: 0.28rem;
                        }
                        &:last-child{
                            border:none 0;
                        }
                        &.city_choose{
                            .city{
                                float: left;
                                font-size: 0.32rem;
                                color: #666;
                                font-family:'PingFang-SC-Medium';
                            }
                            .city_address{
                                width: 5.5rem;
                                float: left;
                                font-size: 0.32rem;
                                margin-left: 0.4rem;
                                text-overflow:ellipsis;
                                overflow: hidden;
                                word-wrap: break-word;
                                span{
                                    display: inline-block;
                                }
                                
                            }
                        }
                        
                        .addressCity{
                            float: left;
                            
                        }
                        label{
                            float: left;
                            font-size: 0.32rem;
                            color: #666;
                            font-family:'PingFang-SC-Medium';
                        }
                        input{
                            float: left;
                            width: 68%;
                            line-height: 1rem;
                            background: rgba(256,256,256,0);
                            margin-left: 0.32rem;
                            font-size: 0.32rem;
                            text-overflow:ellipsis;
                        }
                    }
                }
            }
            .save{
                display: block;
                width: 6.91rem;
                margin: 0 auto;
                height: 0.89rem;
                border-radius: 0.2rem;
                background-color: #d4d4d4;
                font-size: 0.32rem;
                line-height: 0.4rem;
                font-weight: bold;
                color:#fff;
                font-family: 'PingFang-SC-Bold';
                border:none 0;
                margin-top: 0.5rem;
                &.active{
                    background-color:#FFDC4B; 
                    color: #333;
                }
                &.current{
                    background: #FFDC4B;
                    color: #333;
                }
            }
            .switch{
                position: relative;
                height: 1rem;
                line-height: 1rem;
                background-color: #fff;
                padding-left: 0.2rem;
                .default{
                    float: left;
                    font-size: 0.32rem;
                    color: #666;
                }
            }
        }
        .page-content{
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            padding-bottom: 0.5rem;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
            overflow-y: scroll;
            -webkit-overflow-scrolling: touch;
            .area-class {
                overflow: hidden;
                width: 100%;
                height: 35%;
                .address_btn{
                    padding:0.2rem 0.4rem 0;
                    a{
                        float: left;
                        font-size: 0.32rem;
                        color: #aaa;
                        &.ensure{
                            float: right;
                            color: #09BB07;
                        }
                    }
                }
            }
        }
    }
    .nt{
        position: absolute;
        width: 95%;
        height: 0.1rem;
        background-color: #fff;
        left: 50%;
        transform: translateX(-50%);
        z-index: 10;
        &.nt1{
            top: 0.02rem;
        }
        &.nt2{
            bottom: 0rem;
        }
    }
</style>
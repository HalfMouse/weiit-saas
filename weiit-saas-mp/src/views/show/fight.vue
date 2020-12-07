<template>
    <div class="showBox">
        <div class="fight blankShow" v-if="fightGoods.length > 0">
            <div class="fight-title" v-if="haveTitle == 'yes'">
        		<div class="title-text fn-clear">
        			<span class="line"></span>
	                <span class="title">{{fightTitle}}</span> 
	                <span class="line"></span>
        		</div>
        		<a href="javascript:;" class="look_more" @click="toFightPage()">更多 ></a>
        	</div>
            <div class="fight-title" v-if="haveTitle == 'yes'">
        		<div class="title-text fn-clear">
        			<span class="line"></span>
	                <span class="title">{{fightTitle}}</span> 
	                <!-- <span class="title" v-if="fightTitle == ''">组图拼团</span>  -->
	                <span class="line"></span>
        		</div>
        		<a href="javascript:;" class="look_more" @click="toFightPage()">更多 ></a>
        	</div>
            <ul class="fn-clear" :class="[{'goodBig':goodStyle == 'big'},{'matrix':goodStyle == 'matrix'},{'list':goodStyle == 'list'}]">
                <li :key="index" v-for="(item, index) in fightGoods" @click="toFightGood(item)">
                    <fight-good :fights="fights" :item="item"></fight-good>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios'
    // 引入qs
    import qs from 'qs'
     //引用拼团商品组件 
    import fightGood from '@/views/common/fightGood'
    export default {
        props:['pageParam'],
        data() {
            return {
                addFun:'manual',
                showNum: '',
                lookAllBtn: true,
                selectedRule:'销量越高越靠前',
                options: [{
                    value: '选项1',
                    label: '销量越高越靠前'
                }, {
                    value: '选项2',
                    label: '浏览次数越多越靠前'
                }, {
                    value: '选项3',
                    label: '开始时间越晚越靠前'
                }, {
                    value: '选项4',
                    label: '结束时间越早越靠前'
                }],
                value: '选项1',
                goodName:true,
                fightNum:true,
                saleAll:true,
                goodStyle:'big',
                fightGoods:[],   // 拼团商品内容
                fight:'',
                count:2,
                groupon_ids:[],   // 拼团id组
                fightTitle:'',
                haveTitle:'yes'
            }
        },
        components:{
            fightGood
        },
        computed:{
            fights(){
                var fights = {
                    goodStyle:this.goodStyle,
                    goodName:this.goodName,
                    fightNum:this.fightNum
                }
                return fights;
            }
        },
        methods:{
            // 初始化数据
            original(){
                
                this.addFun = this.pageParam.addFun;
                this.showNum = this.pageParam.showNum;
                this.lookAllBtn = this.pageParam.lookAllBtn;
                this.selectedRule = this.pageParam.selectedRule;
                this.options = this.pageParam.options;
                this.value = this.pageParam.value;
                this.goodName = this.pageParam.goodName;
                this.fightNum = this.pageParam.fightNum;
                this.saleAll = this.pageParam.saleAll;
                this.goodStyle = this.pageParam.goodStyle;
                this.groupon_ids = this.pageParam.groupon_ids;
                this.haveTitle = this.pageParam.haveTitle;
                let groupon_ids = this.pageParam.groupon_ids.join(',');
                this.fightTitle = (this.pageParam.fightTitle || this.pageParam.fightTitle == '') ?  this.pageParam.fightTitle : '组团拼团';
                if(this.addFun == 'manual'){
                    if(this.groupon_ids.length == 0){
                        this.fightGoods = []
                    }else{
                        axios.post('/api/groupon/grouponListByIds',qs.stringify({
                            grouponGetType: 0,
                            groupon_ids: groupon_ids
                        })).then((res) => {
                            if(res.data.code == '0'){
                                this.fightGoods = res.data.data;
                                
                            }
                        }).catch((err) => {
                            console.log(err);
                        })
                    }
                }else if(this.addFun == 'automatic'){
                    axios.post('/api/groupon/grouponListByIds',qs.stringify({
                        grouponGetType:1,
                        showNum:this.showNum
                    })).then((res) => {
                        if(res.data.code == '0'){
                            this.fightGoods = res.data.data;
                        }
                    }).catch((err) => {
                        console.log(err);
                    })
                }
                
            },
            // 跳转拼团页面
            toFightPage(){
                // var fights = JSON.stringify(this.fightGoods);
                localStorage.setItem('look_detail','home')
                this.$router.push({
                    path:'/collageList',
                    name:'collageList',
                    query:{
                        grouponIds:this.groupon_ids
                    }
                })
            },
            // 跳转到拼单详情页
            toFightGood(item){
                localStorage.setItem('look_detail','home')
                localStorage.setItem('shareFightGoodImage', item.product_img);
                localStorage.setItem('shareFightGoodName', item.product_name);
                this.$router.push({
                    path:'/fightDetail',
                    name:'fightDetail',
                    query:{
                        product_id:item.product_id,
                        groupon_id:item.groupon_id,
                        Data:new Date()
                    }
                })
            }
        },
        mounted(){
            this.original();
        }
    }
</script>

<style scoped>
    .fight{
        background-color: #f8f8f8;
        
    }
    .fight .fight-title{
    	position: relative;
        width: 100%;
        height: 0.88rem;
        background-color: #fff;
        text-align: center;
        line-height: 0.88rem;
    }
    .fight .fight-title .title-text{
    	display: table;
    	margin: 0 auto;
    }
    .fight .fight-title .title-text span{
    	float: left;
    }
    .fight .fight-title .title-text span.line{
    	width: 0.5rem;
        height: 0.04rem;
        background-color: #000;
        margin-top: 0.42rem;
    }
    .fight .fight-title .title-text span.title{
    	font-size: 0.4rem;
        font-weight: bold;
        color: #333;
        margin: 0 0.3rem;
    }
    .fight .fight-title .more{
    	position: absolute;
        right: 0.2rem;
        top: 50%;
        transform: translateY(-50%);
        font-size: 0.28rem;
        color: #ec534e;
    }
    .look_more{
        position: absolute;
        font-size: 0.28rem;
        color: #333;
        line-height: 0.64rem;
        top: 50%;
        transform: translateY(-50%);
        right: 0.2rem;
        color: #ec534e;
    }
    /* 矩阵 */
    .matrix li{
        float: left;
        width: 50%;
        margin-top: 0.2rem;
    }
    .matrix li:nth-child(even){
        margin-right: 0;
    }
</style>
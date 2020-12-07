<template>
    <div class="showBox">
        <div class="fight blankShow">
        	<div class="fight-title" v-if="haveTitle == 'yes'">
        		<div class="title-text fn-clear">
        			<span class="line"></span>
	                <span class="title">{{fightTitle}}</span> 
	                <span class="line"></span>
        		</div>
        		<a class="more" href="javascript:;">更多 ></a>
        	</div>
            <ul class="fn-clear" :class="[{'goodBig':goodStyle == 'big'},{'matrix':goodStyle == 'matrix'},{'list':goodStyle == 'list'}]" v-if="fightGoods.length == 0">
                <li>
                    <fight-good :fights="fights" :item="fight"></fight-good>
                </li>
                <li>
                    <fight-good :fights="fights" :item="fight"></fight-good>
                </li>
                <li>
                    <fight-good :fights="fights" :item="fight"></fight-good>
                </li>
                <li>
                    <fight-good :fights="fights" :item="fight"></fight-good>
                </li>
            </ul>
            <ul class="fn-clear" :class="[{'goodBig':goodStyle == 'big'},{'matrix':goodStyle == 'matrix'},{'list':goodStyle == 'list'}]"  v-else>
                <li :key="index" v-for="(item, index) in fightGoods">
                    <fight-good :fights="fights" :item="item"></fight-good>
                </li>
            </ul>
        </div>
        <!-- 设置拼团 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-fight @event="getData" :pageParam="pageParam"></set-fight>
        </div>
    </div>
</template>

<script>
    // 设置拼团
    import setFight from '@/components/set/setFight'
    // 设置头部
    import headModify from '@/components/common/headModify'
    //引用拼团商品组件 
    import fightGood from '@/components/common/fightGood'
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
                        fightGoods:[],
                        fight:'',
                        groupon_ids:[],
                        fightTitle:'',
                        haveTitle:'yes'
                    }
                }
            }
        },
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
                fightGoods:[],
                fight:'',
                count:2,
                groupon_ids:[],
                fightTitle:'',
                haveTitle:'yes'
            }
        },
        components:{
            fightGood,
            headModify,
            setFight
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(fight){
                this.addFun = fight.addFun;
                this.showNum = fight.showNum ? fight.showNum : 6;
                this.lookAllBtn = fight.lookAllBtn;
                this.selectedRule = fight.selectedRule;
                this.options = fight.options;
                this.value = fight.value;
                this.goodName = fight.goodName;
                this.fightNum = fight.fightNum;
                this.saleAll = fight.saleAll;
                this.goodStyle = fight.goodStyle;
                this.groupon_ids = fight.groupon_ids;
                this.haveTitle = fight.haveTitle;
                this.fightTitle = (fight.fightTitle == '' || !fight.fightTitle) ? '组团拼团' : fight.fightTitle
                if(fight.addFun == 'manual'){
                    if(this.groupon_ids.length == 0){
                        this.fightGoods = [];
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/ump/groupon/grouponListByIds',
                            params:{
                               groupon_ids: JSON.stringify(this.groupon_ids),
                               grouponGetType: 0
                            }
                        }).then(res => {
                        	this.fightGoods = res.data.data;
                        }).catch(err => {
                            (err);
                        })
                    }
                }else if(fight.addFun == 'automatic'){
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/groupon/grouponListByIds',
                        params:{
                            grouponGetType:1
                        }
                    }).then(res => {
                       this.fightGoods = res.data.data.splice(0, this.showNum);
                    }).catch(err => {
                        (err);
                    })
                }
                
                // 修改数据
                this.changeData({id:this.tempId,op:fight});
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.addFun = this.addFun;
                list.pageParam.showNum = this.showNum;
                list.pageParam.lookAllBtn = this.lookAllBtn;
                list.pageParam.selectedRule = this.selectedRule;
                list.pageParam.options = this.options;
                list.pageParam.value = this.value;
                list.pageParam.goodName = this.goodName;
                list.pageParam.fightNum = this.fightNum;
                list.pageParam.saleAll = this.saleAll;
                list.pageParam.goodStyle = this.goodStyle;
                list.pageParam.groupon_ids = this.groupon_ids;
                list.pageParam.fightTitle = this.fightTitle;
                list.pageParam.haveTitle = this.haveTitle;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.addFun = this.pageParam.addFun;
                this.showNum = this.pageParam.showNum ? this.pageParam.showNum : 6;
                this.lookAllBtn = this.pageParam.lookAllBtn;
                this.selectedRule = this.pageParam.selectedRule;
                this.options = this.pageParam.options;
                this.value = this.pageParam.value;
                this.goodName = this.pageParam.goodName;
                this.fightNum = this.pageParam.fightNum;
                this.saleAll = this.pageParam.saleAll;
                this.goodStyle = this.pageParam.goodStyle;
                this.fightTitle = this.pageParam.fightTitle;
                this.haveTitle = this.pageParam.haveTitle;
                if(this.pageParam.addFun == 'manual'){
                    if(this.pageParam.groupon_ids.length == 0){
                        this.fightGoods = []
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/ump/groupon/grouponListByIds',
                            params:{
                               groupon_ids: JSON.stringify(this.groupon_ids),
                               grouponGetType: 0
                            }
                        }).then(res => {
                            this.fightGoods = res.data.data;
                        }).catch(err => {
                            (err);
                        })
                    }
	                
	            }else if(this.pageParam.addFun == 'automatic'){
                    this.$ajax({
                        methods:'get',
                        url:'/center/ump/groupon/grouponListByIds',
                        params:{
                            grouponGetType:1
                        }
                    }).then(res => {
                        this.fightGoods = res.data.data.splice(0, this.showNum);
                    }).catch(err => {
                        (err);
                    })
	            }
            }
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
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .fight{
        background-color: #f8f8f8;
    }
    .fight .fight-title{
    	width: 100%;
    	height: 44px;
    	line-height: 44px;
    	position: relative;
    	background-color: #fff;
    }
    .fight .fight-title .title-text{
    	display: table;
    	margin: 0 auto;
    }
    .fight .fight-title .title-text span{
    	float: left;
    }
    .fight .fight-title .title-text span.line{
    	width: 25px;
	    height: 2px;
	    background-color: #000;
	    margin-top: 21px;
    }
    .fight .fight-title .title-text span.title{
    	font-size: 16px;
	    font-weight: bold;
	    color: #333;
	    margin: 0 15px;
    }
    .fight .fight-title .more{
    	position: absolute;
	    right: 5px;
	    top: 0;
	    color: #EC534E;
    }
    .look_more{
        display: block;
        text-align: center;
        font-size: 14px;
        color: #333;
        line-height: 34px;
    }
    .fight ul{
        padding: 0 5px;
    }
    /* 矩阵 */
    .matrix li{
        float: left;
        margin-right: 8px;
        width: 150px;
    }
    .matrix li:nth-child(even){
        margin-right: 0;
    }
    /* 右侧设置 */
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
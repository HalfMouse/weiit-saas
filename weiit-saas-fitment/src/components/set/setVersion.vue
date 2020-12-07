<template>
    <div class="set_version">
        <div class="contol_group fn-clear">
            <span :class="{'hasNo':isMust}">文本：</span>
            <div class="setChoice">
                <el-input type="textarea" :rows="4" placeholder="请输入要说明的文字，最多100字" v-model="textarea" :max="100" class="txt"></el-input>
            </div>
        </div>
        <p v-if="isMust" class="reminder">文本不能为空</p>
        <div class="contol_group fn-clear">
            <span>字体大小：</span>
            <div class="setChoice">
                <el-radio v-model="font" label="big">大</el-radio>
                <el-radio v-model="font" label="middle">中</el-radio>
                <el-radio v-model="font" label="small">小</el-radio>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span class="demonstration">文本颜色：</span>
            <div class="setChoice">
                <el-color-picker v-model="fontColor"></el-color-picker>
            </div>
            <span class="reBack" @click="fontColor = '#000'">重置</span>
        </div>
        <div class="contol_group fn-clear contol_group1">
            <span class="demonstration">背景颜色：</span>
            <div class="setChoice">
                <el-color-picker v-model="bgColor"></el-color-picker>
            </div>
            <span class="reBack" @click="bgColor = '#fff'">重置</span>
        </div>
        <!-- <div class="contol_group fn-clear contol_group1 link">
            <span class="demonstration">链接：</span>
            <div class="setChoice">
                <el-select v-model="value" placeholder="请选择">
                    <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
                </el-select>
            </div>
        </div> -->
        <div class="contol_group fn-clear contol_group1">
            <span>显示位置：</span>
            <div class="setChoice">
                <el-radio v-model="fontPos" label="left">居左</el-radio>
                <el-radio v-model="fontPos" label="center">居中</el-radio>
                <el-radio v-model="fontPos" label="right">居右</el-radio>
            </div>
        </div>
    </div>
</template>

<script>
    import {mapState,mapMutations} from 'vuex';
    export default {
    	props:['pageParam'],
        data() {
            return {
                font: 'big',
                fontPos: 'left',
                fontColor:'#000',
                bgColor:'#fff',
                textarea:'',
                options: [{
                    value: '选项1',
                    label: '黄金糕'
                }, {
                    value: '选项2',
                    label: '双皮奶'
                }, {
                    value: '选项3',
                    label: '蚵仔煎'
                }, {
                    value: '选项4',
                    label: '龙须面'
                }, {
                    value: '选项5',
                    label: '北京烤鸭'
                }],
                value: ''
            }
        },
        methods:{
            ...mapMutations(['noState','changeState']),
            // 初始化数据
            initData(){
                this.font = this.pageParam.font;
                this.fontPos = this.pageParam.fontPos;
                this.fontColor = this.pageParam.fontColor;
                this.bgColor = this.pageParam.bgColor;
                this.textarea = this.pageParam.textarea; 
            }
        },
        computed:{
            ...mapState(['isMust'])
        },
        updated(){
            var versions = {
                font: this.font,
                fontPos: this.fontPos,
                fontColor: this.fontColor,
                bgColor: this.bgColor,
                textarea: this.textarea,
            }
            this.$emit('event', versions);
        },
        watch:{
            textarea:function(curVal,oldVal){
                if(curVal.length === 0){
                    this.changeState();
                }else{
                    this.noState();
                }
            }
        },
        mounted(){
            this.initData();
        }
    }
</script>

<style scoped>
    .contol_group {
    margin-top: 17px;
    }
    .contol_group span {
    float: left;
    width: 95px;
    text-align: right;
    margin-right: 10px;
    }
    .contol_group .reBack{
        font-size: 12px;
        color: #3388ff;
        width: auto;
        margin-left: 10px;
        margin-top: 3px;
    }
    .demonstration{
        margin-top: 2px;
    }
    .setChoice{
        float: left;
    }
    .add{
        width: 388px;
        background-color: #fff;
        padding: 10px;
        box-sizing: border-box;
        border:1px solid #ddd;
        border-radius: 4px;
        margin:17px auto 0;
    }
    .add .setChoice{
        width: 285px;
    }
    .add .setChoice .last{
        margin-left: 0;
        margin-top: 5px;
    } 
    .add .contol_group1{
        margin-top: 0;
    }
    .add .contol_group span{
        float: left;
        width:69px; 
    }
    .demonstration1{
        margin-top: 10px;
    }
    .txt{
        width: 280px;
    }
    .contol_group1{
        margin-top: 2px;
    }
    .link input{
        border:none 0;
    }
    /* 提示语 */
    .reminder{
        color: #f44;
        margin-top: 5px;
        padding-left: 104px;
        font-size: 12px;
    }
    .hasNo{
        color:#f44;
    }
</style>
<template>
    <div class="set_shop">
        <div class="contol_group fn-clear">
            <span>显示样式：</span>
            <div class="setChoice">
                <el-radio v-model="showStyle" label="type1">样式1</el-radio>
                <el-radio v-model="showStyle" label="type2">样式2</el-radio>
                <el-radio v-model="showStyle" label="type3">样式3</el-radio>
                <el-radio v-model="showStyle" label="type4">样式4</el-radio>
                <el-radio v-model="showStyle" label="type5" class="last">样式5</el-radio>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span>店铺名字：</span>
            <div class="setChoice">
                <el-input v-model="shopName" placeholder="请输入店铺名称"></el-input>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span>个性签名：</span>
            <div class="setChoice">
                <el-input v-model="signature" placeholder="请输入个性签名" maxlength="30"></el-input>
            </div>
        </div>
        <div class="contol_group fn-clear">
            <span>背景图片：</span>
            <div class="setChoice add_voice" @click="choicePic" v-if="bgPic == ''">
                <i class="icon iconfont icon-jia"></i>
            </div>
            <div class="setChoice add_voice add_voice1" v-else>
                <i class="icon iconfont icon-guanbi" @click="bgPic = ''"></i>
                <img :src="bgPic" alt="" draggable="false">
            </div>
        </div>
        <pic-win :parentComponent="parentComponent" ref="picWin" @choose="getChoose"></pic-win>
        <p class="tips">建议尺寸：750x370 像素，尺寸不匹配时，图片将被压缩或拉伸以铺满画面</p>
    </div>
</template>

<script>
    import {mapMutations} from 'vuex';
    // 引入图片选择组件
    import picWin from '@/components/common/picWin'
    export default {
        props:['pageParam'],
        data() {
            return {
                showStyle: 'type1',
                // 传递给子级的参数
                parentComponent:'shop',
                // 图片前缀
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                // 背景图片
                bgPic:'',
                signature:'',
                shopName:'我的店名'
            }
        },
        updated(){
            var shop = {
                showStyle:this.showStyle,
                bgPic:this.bgPic,
                signature:this.signature,
                shopName:this.shopName
            }
            this.$emit('event', shop);
        },
        components:{
            picWin
        },
        methods: {
            ...mapMutations(['stopSort']),
            choicePic() {
                this.$refs.picWin.show();
                this.stopSort();
            },
            getChoose(pic){
                this.bgPic = this.imageDomaia + pic.file_url;
            },
            initData(){
                this.showStyle = this.pageParam.showStyle;
                this.bgPic = this.pageParam.bgPic;
                this.signature = this.pageParam.signature;
                this.shopName = this.pageParam.shopName
            }
        },
        mounted(){
            this.initData();
        }
    }
</script>

<style scoped>
    .contol_group {
        position: relative;
        margin-top: 17px;
    }
    .contol_group span {
        float: left;
        width: 85px;
        text-align: right;
        margin-right: 10px;
    }
    .setChoice{
        float: left;
        width: 300px;
    }
    .add_voice{
        position: relative;
        width: 78px;
        height: 78px;
        box-sizing: border-box;
        border: 1px dotted #ddd;
        text-align: center;
        line-height: 78px;
        cursor: pointer;
    }
    .add_voice1 {
        cursor: default;
    }
    .add_voice .icon-jia{
        font-size: 20px;
        color: #3388ff;
    }
    .add_voice1 .icon-guanbi{
        position: absolute;
        right: -7px;
        top: -37px;
        color: #a3a3a3;
        font-size: 14px;
        cursor: pointer;
    }
    .add_voice1 img{
        width: 100%;
        height: 100%;
    }
    .contol_group .el-radio+.el-radio{
        margin-left: 15px;
    }
    .contol_group .el-radio+.el-radio.last{
        margin-left: 0;
        margin-top: 8px;
    }
    .tips{
        margin-top: 10px;
        color: #999;
        padding-left: 96px;
        font-size: 12px;
    }
</style>
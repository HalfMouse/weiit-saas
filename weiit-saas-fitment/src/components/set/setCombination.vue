<template>
    <div>
        <div class="contol_group fn-clear">
            <span>边距：</span>
            <div class="setChoice">
                <el-radio v-model="picMargin" label="show">显示</el-radio>
                <el-radio v-model="picMargin" label="hide">不显示</el-radio>
            </div>
        </div>
        <div class="contol_group contol_group1 fn-clear">
            <span>背景颜色：</span>
            <div class="setChoice">
                <el-color-picker v-model="bgColor"></el-color-picker>
            </div>
        </div>
        <div class="add fn-clear">
            <div class="add_pic">
                <el-upload
                    class="avatar-uploader"
                    action="https://jsonplaceholder.typicode.com/posts/"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess">
                    <img v-if="imageUrl" :src="imageUrl" class="avatar" draggable="false">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
            </div>
            <div class="choiceSize">
                <div class="contol_group fn-clear">
                    <span class="demonstration demonstration1">图片标题：</span>
                    <div class="setChoice">
                        <el-input v-model="picTitle" placeholder="我是导航" class="navTitle"></el-input>
                    </div>
                </div>
                <div class="contol_group fn-clear">
                    <span class="demonstration demonstration1">显示链接：</span>
                    <div class="setChoice">
                        <el-select v-model="value" placeholder="请选择" class="selectLink">
                            <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                            </el-option>
                        </el-select>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                bgColor:'#f00',
                picTitle:'',
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
                picMargin:'show',
                imageUrl:'',
                value:''
            }
        },
        methods:{
            handleAvatarSuccess(){},
            beforeAvatarUpload(){}
        }
    }
</script>

<style scoped>
.contol_group {
  margin-top: 17px;
}
.contol_group span {
  float: left;
  width: 85px;
  text-align: right;
  margin-right: 10px;
}
.demonstration{
    margin-top: 2px;
}
.setChoice{
    float: left;
    width: 280px;
}
.setChoice .el-radio+.el-radio{
    margin-left: 9px;
}
.block{
    width: 225px;
    float: left;
    margin-top: -6px;
}
.contol_group span.values{
    float: left;
    width: auto;
    margin-left: 15px;
    margin-top: 1px;
}
.tips{
    margin-top: 10px;
    padding-left: 20px;
    color: #999;
    font-size: 12px;
}
.avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
     width: 104px;
    height: 104px;
    line-height: 104px;
    text-align: center;
    border: 1px dashed #eee;

  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
  .add{
    width: 388px;
    background-color: #fff;
    padding: 10px;
    box-sizing: border-box;
    border:1px solid #ddd;
    border-radius: 4px;
    margin:5px auto 0;
}
  .add .setChoice{
    width: 160px;
}
.add .setChoice .last{
    margin-left: 0;
    margin-top: 5px;
} 

.add .contol_group{
    margin-top: 17px;
}
.add .contol_group1{
    margin-top: 0;
}
.add .contol_group span{
    float: left;
    width:69px; 
}
.add_pic{
    float: left;
    margin-right: 10px;
}
.choiceSize{
    width: 239px;
    float: left;
}
.add input{
    width: 120px;
    height: 30px;
    line-height: 30px;
}
.selectLink,
.navTitle{
    width: 115px;
}
.colorChoice{
    margin-top: 2px;
    height: 30px;
}
.colorChoice1{
    float: right;
    
}
</style>
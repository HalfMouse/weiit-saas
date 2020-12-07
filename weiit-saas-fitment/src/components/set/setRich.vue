<template>
    <div class="set_rich">
        <div class="contol_group fn-clear">
            <span class="demonstration">颜色：</span>
            <div class="setChoice">
                <el-color-picker v-model="richColor" class="line_color"></el-color-picker>
            </div>
            <span class="reBack" @click="richColor = '#DDDDDD'">重置</span>
        </div>
        <div class="main_rich">
            <vue-editor v-model="content" useCustomImageHandler  @imageAdded="handleImageAdded"></vue-editor>
        </div>
        <p class="surplus">您还可以输入10000字</p>
        <p class="reference">*小程序富文本展示以实际效果为准，左侧预览仅供参考</p>
    </div>
</template>

<script>
    // 引入富文本模板
    import { VueEditor } from 'vue2-editor'
    import axios from 'axios'
    export default {
        props:['pageParam'],
        data() {
            return {
                richColor: "#f9f9f9",
                content: '' ,
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com'
            }
        },
        updated() {
            let rich = {
                richColor: this.richColor,
                content: this.content
            };
            this.$emit("event", rich);
        },
        methods:{
            initData(){
                this.content = this.pageParam.content;
                this.richColor = this.pageParam.richColor;
            },
            handleImageAdded(file, Editor, cursorLocation, resetUploader) {
		        // An example of using FormData
		        // NOTE: Your key could be different such as:
		        // formData.append('file', file)
		 		// let urlFile = 'http://merchant.woyoulian.com';
		 		let urlFile = 'http://merchant.wstore.me';
		        var formData = new FormData();
		        formData.append('fileDate', file);
				var that = this;
		 		$.ajax({
		 			type:"POST",
					url:urlFile + "/center/design/uploadPageCover",
					processData: false,
	        		contentType: false,
	        		data:formData,
	        		async:false,
	        		success:function(result){
	        			let url = that.imageDomaia + result; // Get url from response
			          Editor.insertEmbed(cursorLocation, 'image', url);
			          resetUploader();
	        		}
		 		});
		      }
        },
        components:{
            VueEditor
        },
        mounted(){
            this.initData();
        }
    };
</script>

<style scoped>
    .set_rich{
        position: relative;
        z-index: 100001;
    }
    .contol_group {
        margin-top: 17px;
    }
    .contol_group span {
        float: left;
        width: 85px;
        text-align: right;
        margin-right: 10px;
    }
    .contol_group .reBack {
        font-size: 12px;
        color: #3388ff;
        width: auto;
        margin-left: 10px;
        margin-top: 3px;
    }
    .demonstration {
        margin-top: 2px;
    }
    .setChoice {
        float: left;
    }
    .rich_text {
        background-color: #fff;
        resize: none;
        width: 388px;
        height: 312px;
        box-sizing: border-box;
        border: 1px solid #bbb;
        margin: 0 auto;
    }
    .surplus {
        width: 398px;
        height: 24px;
        line-height: 24px;
        text-align: right;
        padding: 0 10px;
        color: #000;
        font-size: 12px;
        box-sizing: border-box;
        border: 1px solid #bbb;
        border-top: none 0;
        margin-top: -4px;
        background-color: #fff;
    }
    .reference {
        width: 388px;
        text-align: center;
        color: #666;
        font-size: 12px;
        margin-top: 10px;
    }
    .main_rich{
        margin-top: 10px;
        position: relative;
    }
    #editorElem{
        position: relative;
        width: 100%;
    }
    .ql-snow .ql-toolbar button svg, .quillWrapper .ql-snow.ql-toolbar button svg {
        width: 16px;
        height: 16px;
    }
</style>
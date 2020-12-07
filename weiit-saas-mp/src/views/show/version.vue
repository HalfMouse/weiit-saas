<template>
    <div class="showBox">
        <div class="version blankShow" :style="{backgroundColor:bgColor}">
            <p :style="{color:fontColor,fontSize:fontS,textAlign:sition}">
                {{textarea}}
            </p>
        </div>
    </div>
</template>

<script>
    export default {
        props:{
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        font: 'big',
                        fontPos: 'left',
                        fontColor:'#000',
                        bgColor:'#fff',
                        textarea:''
                    }
                },
            }
        },
        data() {
            return {
                font: 'big',
                fontPos: 'left',
                fontColor:'#000',
                bgColor:'#fff',
                textarea:'',
                count:2
            }
        },
        computed:{
            fontS(){
                switch(this.font){
                    case 'big':
                        return '18px';
                        break;
                    case 'middle':
                        return '14px';
                        break;
                    case 'small':
                        return '12px';
                        break;
                }
            },
            sition(){
                switch(this.fontPos){
                    case 'left':
                        return 'left';
                        break;
                    case 'center':
                        return 'center';
                        break;
                    case 'right':
                        return 'right';
                        break;
                }
            }
        },
        mounted(){
            this.font = this.pageParam.font;
            this.fontPos = this.pageParam.fontPos;
            this.fontColor = this.pageParam.fontColor;
            this.bgColor = this.pageParam.bgColor;
            this.textarea = this.pageParam.textarea;
        }
    }
</script>

<style scoped>
    .version{
        padding: 10px 5px;
        background-color: #fff;
    }
    .version p{
        text-align: left;
        columns: #000;
        font-size: 14px;
        word-break:break-all;
    }
</style>
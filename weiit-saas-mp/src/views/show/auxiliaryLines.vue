<template>
    <div class="showBox">
        <div class="auxiliary_lines blankShow">
            <span :style="{borderColor:lineColor,width:width,borderStyle:border }"></span>
        </div> 
    </div>
</template>

<script>
    export default {
        props:{
            pageParam:{
                type:Object,
                default:() => {
                    return {haveMargin: "no_margin",manner: "solid",lineColor: "#DDDDDD"}
                },
            }
        },
        data() {
            return {
                haveMargin: "no_margin",
                manner: "solid",
                lineColor: "#DDDDDD",
                count:2
            }
        },
        computed:{
            width(){
                if(this.haveMargin == 'no_margin'){
                    return '100%';
                }else{
                    return '80%';
                }
            },
            border(){
                switch(this.manner){
                    case 'dashed':
                        return 'dashed';
                        break;
                    case 'solid':
                        return 'solid';
                        break;
                    case 'dotted':
                        return 'dotted';
                        break;
                }
            }
        },
        mounted(){
            this.haveMargin = this.pageParam.haveMargin;
            this.manner = this.pageParam.manner;
            this.lineColor = this.pageParam.lineColor;
             
        }
    }
</script>

<style scoped>
    .auxiliary_lines{
        width: 100%;
        height: 0.3rem;
        padding-top: 0.3rem;
        margin: 0 auto;
    }
    .auxiliary_lines span{
        display: block;
        border:none 0;
        border-bottom:2px solid #ddd;
        margin: 0 auto;
        padding: 0;
    }
</style>
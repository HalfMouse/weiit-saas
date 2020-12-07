<template>
    <div class="showBox">
        <div class="title fn-clear blankShow">
            <h6 v-if="inputTitle == ''" :style="{textAlign:style}" :class="{'active':titleStyle == 'style2'}">
                <span class="line" v-if="titleStyle == 'style2'"></span>
                <span class="txt">点击编辑『标题』</span>
                <span class="line" v-if="titleStyle == 'style2'"></span>                
            </h6>
            <h6 v-else :style="{textAlign:style}" :class="{'active':titleStyle == 'style2'}">
                <span class="line" v-if="titleStyle == 'style2'"></span>
                <span class="txt">{{inputTitle}}</span>
                <span class="line" v-if="titleStyle == 'style2'"></span> 
            </h6>
            <span class="more" v-if="more == 'isHave'" @click="skip()">更多></span>
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
                        titleStyle:'style1',
                        more:'isHave',
                        inputTitle:'',
                        titleNav:null
                    }
                },
            }
        },
        data() {
            return {
                titleStyle:'style1',
                more:'isHave',
                inputTitle:'',
                titleNav:null
            }
        },
        methods:{
            // 跳转路由
            skip(){
                if(item.url !== ''){
                    if(this.titleNav.url == 'index'){
                        this.$router.push({
                            path:'/' + this.titleNav.validate_id,
                            name:'home1',
                            params:{
                                page_id:this.titleNav.validate_id
                            }
                        })
                    }else if(this.titleNav.navShow == '外链'){
                        window.location.href = this.titleNav.url
                    }else{
                        this.$router.push({
                            path:'/' + this.titleNav.url,
                            name:this.titleNav.url,
                            query:{
                                target_id:this.titleNav.validate_id
                            }
                        }); 
                    }
                }
            }
        },
        computed:{
            style(){
                switch(this.titleStyle){
                    case 'style1':
                        return 'left';
                        break;
                    case 'style2':
                        return 'center';
                        break;
                }
            }
        },
        mounted(){
            this.titleStyle = this.pageParam.titleStyle;
            this.more = this.pageParam.more;
            this.inputTitle = this.pageParam.inputTitle;
            this.titleNav = this.pageParam.titleNav;
        }
    }
</script>

<style scoped>
    .title{
        position: relative;
        line-height: 44px;
        padding: 0 10px;
        background-color: #fff;
    }
    .title h6{
        position: relative;
        color: #333;
        font-size: 17px;
    }
    .title .more{
        position: absolute;
        top: 0;
        right: 10px;
        font-size: 14px;
        color: #666;
        height: 100%;
        line-height: 44px;
    }
</style>
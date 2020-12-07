<template>
    <div class="showBox">
        <div class="nav blankShow">
            <div class="nav_sort" v-if="play == 'nav'">
                <ul class="play_nav">
                    <li v-for="item in navList" :style="[{backgroundColor:item.navBgColor}]">
                        <div class="fn-clear" :class="[{'top_nav_list':iconPos == 'top'},{'left_nav_list':iconPos == 'left'},{'no_nav_list':iconPos == 'no'}]">
                            <a href="javascript:;" @click="skip(item)">
                                <div class="nav_icon" :class="[{'top_icon':iconPos == 'top'},{'left_icon':iconPos == 'left'},{'no_icon':iconPos == 'no'}]">
                                    <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" v-if="item.img == ''">
                                    <img :src="item.img" alt="" :width="iconSize+'px'" ref="icon" v-else>
                                </div>
                                <span class="nav_title" :class="[{'top_title':iconPos == 'top'},{'left_title':iconPos == 'left'},{'no_title':iconPos == 'no'}]" :style="[{color:item.navColor}]">{{item.navText}}</span>
                            </a>
                            <!-- <a href="http://www.baidu.com"></a> -->
                        </div>
                    </li>
                </ul>
            </div>
            <div class="nav_sort" v-if="play == 'sort'">
                <ul class="play_sort fn-clear">
                    <li v-for="item in navList">
                        <a href="javascript:;" @click="skip(item)">
                            <div class="nav_content fn-clear" :style="[{backgroundColor:item.navBgColor}]">
                                <div class="nav_icon">
                                    <img src="static/images/tag-icon.png" alt="" :width="iconSize*2+'px'" v-if="item.img == ''">
                                    <img :src="item.img" alt="" :width="iconSize*2+'px'" v-else>
                                </div>
                                <span class="nav_title" :style="[{color:item.navColor}]">{{item.navText}}</span>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props:['pageParam'],
        data() {
            return {
                iconSize:30,
                play:'nav',
                iconPos:'top',
                navList:[],
                count:2
            }
        },
        methods: {
            // 跳转路由
            skip(item){
                if(item.url == 'index'){
                    this.$router.push({
                        path:'/' + item.validate_id,
                        name:'home1',
                        params:{
                            page_id:item.validate_id
                        }
                    })
                }else if(item.navShow == '外链'){
                    window.location.href = item.url
                }else{
                    this.$router.push({
                        path:'/' + item.url,
                        name:item.url,
                        params:{
                            target_id:item.validate_id
                        }
                    }); 
                }
            }
        },
        mounted(){
            this.iconSize = this.pageParam.iconSize;
            this.play = this.pageParam.play;
            this.iconPos = this.pageParam.iconPos;
            this.navList = this.pageParam.navList;
            this.show = this.pageParam.show;
        }
    }
</script>

<style scoped>
.play_nav{
    display: flex;
    display: -webkit-flex;
    background-color: #fff;
    padding-top: 0.2rem;
    
}
.play_nav li{
    flex: 1;
    padding-bottom: 0.2rem;
    
}
.left_nav_list{
    display: table;
    margin:0 auto;
}
.play_nav li .nav_icon{
    text-align: center;
}
.play_nav li .no_icon{
    display: none;
}
.play_nav li .nav_icon.left_icon{
    float: left;
}
.play_nav li .nav_title{
    display: block;
    text-align: center;
    font-size: 14px;
}
.play_nav li .nav_title.left_title{
    float: left;
    margin-left: 5px;
    position: relative;
}
    /* 分组 */
    .play_sort{
        padding: 5px 0;
    }
    .play_sort li{
        float: left;
        width: 46%;
        overflow: hidden;
        padding: 0 0 0.1rem 0.1rem;
    }
    .play_sort li .nav_icon{
        float: left;
    }
    .play_sort li .nav_title{
        float: left;
        line-height: 0.3rem;
        margin-left: 0.1rem;
    }
    .nav_content{
        display: block;
        background: #fff;
        border-radius: 4px;
        color: #555;
        padding: 6px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
</style>
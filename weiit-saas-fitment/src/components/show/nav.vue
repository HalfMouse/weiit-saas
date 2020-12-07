<template>
    <div class="showBox">
        <div class="nav blankShow">
            <div class="nav_sort" v-if="play == 'nav'">
                <ul class="play_nav" v-if="navList.length == 0">
                    <li>
                        <div class="fn-clear" :class="[{'top_nav_list':iconPos == 'top'},{'left_nav_list':iconPos == 'left'},{'no_nav_list':iconPos == 'no'}]">
                            <div class="nav_icon" :class="[{'top_icon':iconPos == 'top'},{'left_icon':iconPos == 'left'},{'no_icon':iconPos == 'no'}]">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" draggable="false">
                            </div>
                            <span class="nav_title" :class="[{'top_title':iconPos == 'top'},{'left_title':iconPos == 'left'},{'no_title':iconPos == 'no'}]">标题</span>
                        </div>
                    </li>
                    <li>
                        <div class="fn-clear" :class="[{'top_nav_list':iconPos == 'top'},{'left_nav_list':iconPos == 'left'},{'no_nav_list':iconPos == 'no'}]">
                            <div class="nav_icon" :class="[{'top_icon':iconPos == 'top'},{'left_icon':iconPos == 'left'},{'no_icon':iconPos == 'no'}]">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" draggable="false">
                            </div>
                            <span class="nav_title" :class="[{'top_title':iconPos == 'top'},{'left_title':iconPos == 'left'},{'no_title':iconPos == 'no'}]">标题</span>
                        </div>
                    </li>
                    <li>
                        <div class="fn-clear" :class="[{'top_nav_list':iconPos == 'top'},{'left_nav_list':iconPos == 'left'},{'no_nav_list':iconPos == 'no'}]">
                            <div class="nav_icon" :class="[{'top_icon':iconPos == 'top'},{'left_icon':iconPos == 'left'},{'no_icon':iconPos == 'no'}]">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" draggable="false">
                            </div>
                            <span class="nav_title" :class="[{'top_title':iconPos == 'top'},{'left_title':iconPos == 'left'},{'no_title':iconPos == 'no'}]">标题</span>
                        </div>
                    </li>
                    <li>
                        <div class="fn-clear" :class="[{'top_nav_list':iconPos == 'top'},{'left_nav_list':iconPos == 'left'},{'no_nav_list':iconPos == 'no'}]">
                            <div class="nav_icon" :class="[{'top_icon':iconPos == 'top'},{'left_icon':iconPos == 'left'},{'no_icon':iconPos == 'no'}]">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" draggable="false">
                            </div>
                            <span class="nav_title" :class="[{'top_title':iconPos == 'top'},{'left_title':iconPos == 'left'},{'no_title':iconPos == 'no'}]">标题</span>
                        </div>
                    </li>
                </ul>
                <ul class="play_nav" v-else>
                    <li v-for="item in navList" :style="[{backgroundColor:item.navBgColor}]">
                        <div class="fn-clear" :class="[{'top_nav_list':iconPos == 'top'},{'left_nav_list':iconPos == 'left'},{'no_nav_list':iconPos == 'no'}]">
                            <div class="nav_icon" :class="[{'top_icon':iconPos == 'top'},{'left_icon':iconPos == 'left'},{'no_icon':iconPos == 'no'}]">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" v-if="item.img == ''" draggable="false">
                                <img :src="item.img" alt="" :width="iconSize+'px'" v-else draggable="false">
                            </div>
                            <span class="nav_title" :class="[{'top_title':iconPos == 'top'},{'left_title':iconPos == 'left'},{'no_title':iconPos == 'no'}]" :style="[{color:item.navColor}]">{{item.navText}}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="nav_sort" v-if="play == 'sort'">
                <ul class="play_sort fn-clear" v-if="navList.length == 0">
                    <li>
                        <div class="nav_content fn-clear">
                            <div class="nav_icon">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" draggable="false">
                            </div>
                            <span class="nav_title">标题</span>
                        </div>
                    </li>
                    <li>
                        <div class="nav_content fn-clear">
                            <div class="nav_icon">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" draggable="false">
                            </div>
                            <span class="nav_title">标题</span>
                        </div>
                    </li>
                    <li>
                        <div class="nav_content fn-clear">
                            <div class="nav_icon">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" draggable="false">
                            </div>
                            <span class="nav_title">标题</span>
                        </div>
                    </li>
                    <li>
                        <div class="nav_content fn-clear">
                            <div class="nav_icon">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" draggable="false">
                            </div>
                            <span class="nav_title">标题</span>
                        </div>
                    </li>
                </ul>
                <ul class="play_sort fn-clear" v-else>
                    <li v-for="item in navList">
                        <div class="nav_content fn-clear" :style="[{backgroundColor:item.navBgColor}]">
                            <div class="nav_icon">
                                <img src="static/images/tag-icon.png" alt="" :width="iconSize+'px'" v-if="item.img == ''" draggable="false">
                                <img :src="item.img" alt="" :width="iconSize+'px'" v-else draggable="false">
                            </div>
                            <span class="nav_title" :style="[{color:item.navColor}]">{{item.navText}}</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <!-- 设置图文导航 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-nav @event="getData" :pageParam="pageParam"></set-nav>
        </div> 
    </div>
</template>

<script>
    // 设置导航栏
    import setNav from '@/components/set/setNav'
    // 设置头部
    import headModify from '@/components/common/headModify'
    import List from '../../../static/js/List'
    import {mapActions} from 'vuex'
    export default {
        props:{
            keyText:String,
            pageParam:{
                type:Object,
                default:() => {
                    return {iconSize:30,play:'nav',iconPos:'top',navList:[]}
                },
            },
            tempId:Number,
            keyWords:String
        },
        data() {
            return {
                iconSize:30,
                play:'nav',
                iconPos:'top',
                navList:[],
            }
        },
        components:{
            setNav,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(obj){
                this.iconSize = obj.iconSize;
                this.play = obj.play;
                this.iconPos = obj.iconPos;
                this.navList = obj.navList;
                // 修改数据
                this.changeData({id:this.tempId,op:obj})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.iconSize = this.iconSize;
                list.pageParam.play = this.play;
                list.pageParam.iconPos = this.iconPos;
                list.pageParam.navList = this.navList;
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                this.addData(list);
            },
            // 初始化数据
            initData(){
                this.iconSize = this.pageParam.iconSize;
                this.play = this.pageParam.play;
                this.iconPos = this.pageParam.iconPos;
                this.navList = this.pageParam.navList;
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>

.play_nav{
    display: flex;
    background-color: #fff;
    
}
.play_nav li{
    flex: 1;
    padding:5px 0; 
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
        padding: 0 0 10px 10px;
    }
    .play_sort li .nav_icon{
        float: left;
    }
    .play_sort li .nav_title{
        float: left;
        line-height: 30px;
        margin-left: 10px;
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
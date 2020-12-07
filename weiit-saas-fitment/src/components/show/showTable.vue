<template>
    <!-- 中间手机部分展示内容 -->
    <div class="nav_des">
        <!-- 店招 -->
        <shop-signs :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'shop_signs'" :tempId="tempId" :pageParam="pageParam"></shop-signs>
        <!-- 搜索框 -->
        <search-show :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'search'" :tempId="tempId" :pageParam="pageParam"></search-show>
        <!-- 空白 -->
        <auxiliary-blank :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'auxiliary_blank'" :tempId="tempId" :pageParam="pageParam"></auxiliary-blank>
        <!-- 辅助线 -->
        <auxiliary-lines :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'auxiliary_lines'" :tempId="tempId" :pageParam="pageParam"></auxiliary-lines>
        <!-- 导航栏 -->
        <nav-show :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'nav'" :tempId="tempId" :pageParam="pageParam"></nav-show>
        <!-- 优惠券 -->
        <coupon-show :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'coupon'" :tempId="tempId" :pageParam="pageParam"></coupon-show>
        <!-- 商品分组 -->
        <good-sort :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'Commodity_sort'" :tempId="tempId" :pageParam="pageParam"></good-sort>
        <!-- 商品列表 -->
        <good-list :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'Commodity_list'" :tempId="tempId" :pageParam="pageParam"></good-list>
        <!-- 标题 -->
        <text-title :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'title'" :tempId="tempId" :pageParam="pageParam"></text-title>
        <!-- 文本 -->
        <version-show :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'text'" :tempId="tempId" :pageParam="pageParam"></version-show>
        <!-- 富文本 -->
        <rich-text :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'text_box'" :tempId="tempId" :pageParam="pageParam"></rich-text>
        <!-- 广告 -->
        <advertisement :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'advertisement'" :tempId="tempId" :pageParam="pageParam"></advertisement>
        <!-- 拼团 -->
        <fight-show :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'fight'" :tempId="tempId" :pageParam="pageParam"></fight-show>
        <!-- 砍价 -->
        <bargain-show :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'bargain'" :tempId="tempId" :pageParam="pageParam"></bargain-show>
        <!-- 语音 -->
        <voice-show :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'voice'" :tempId="tempId" :pageParam="pageParam"></voice-show>
        <!-- 视频 -->
        <video-show :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'video'" :tempId="tempId" :pageParam="pageParam"></video-show>
         <!-- 公告 -->
        <goods-notice :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'notice'" :tempId="tempId" :pageParam="pageParam"></goods-notice>
        <!-- 客服电话 -->
        <service-show :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'tel'" :tempId="tempId" :pageParam="pageParam"></service-show>
        <!-- 图文组合 -->
        <combination :keyText="keyText" :keyWords="keyWords" v-if="keyWords == 'combination'" :tempId="tempId" :pageParam="pageParam"></combination>
    </div>
</template>

<script>
    // 店招展示
    import shopSigns from '@/components/show/shopSigns'
    // 搜索框展示
    import searchShow from '@/components/show/search' 
    // 空白展示
    import auxiliaryBlank from '@/components/show/auxiliaryBlank'
    // 辅助线展示
    import auxiliaryLines from '@/components/show/auxiliaryLines'
    // 导航栏展示
    import navShow from '@/components/show/nav'
    // 优惠券展示
    import couponShow from '@/components/show/coupon'
    // 商品分组展示
    import goodSort from '@/components/show/goodSort'
    // 商品列表展示
    import goodList from '@/components/show/goodList'
    // 标题展示
    import textTitle from '@/components/show/title'
    // 文本展示
    import versionShow from '@/components/show/version'
    // 富文本
    import richText from '@/components/show/richText'
    // 广告展示
    import advertisement from '@/components/show/advertisement'
    // 语音展示
    import voiceShow from '@/components/show/voice'
    // 视频展示
    import videoShow from '@/components/show/video'
    // 拼团展示
    import fightShow from '@/components/show/fight'
    // 秒杀展示
    import seckillShow from '@/components/show/seckill'
    // 公告展示
    import goodsNotice from '@/components/show/notice'
    // 客服电话展示
    import serviceShow from '@/components/show/service'
    // 图文组合
    import combination from '@/components/show/combination'
    // 砍价展示
    import bargainShow from '@/components/show/bargain'
    export default {
        props:['keyWords','keyText','tempId','pageParam'],
        data(){
            return{
                delFlag:true,
                isShow:false,
                showFlag:false,
            }
        },
        components:{
            searchShow,
            auxiliaryBlank,
            auxiliaryLines,
            navShow,
            textTitle,
            goodsNotice,
            serviceShow,
            advertisement,
            goodSort,
            voiceShow,
            richText,
            videoShow,
            fightShow,
            seckillShow,
            shopSigns,
            goodList,
            versionShow,
            couponShow,
            combination,
            bargainShow
        },
        methods:{
            del(){
                this.delFlag = false;
            }
        }
    }
</script>

<style scoped>
    .nav_des{
        position: relative;
        
    }
    .icon-guanbi{
        position: absolute;
        display: block;
        font-size: 20px;
        color: #a3a3a3;
        cursor: pointer;
        height: 20px;
        left: -2px;
        top: -6px;
    }
    .close{
        position: absolute;
        top: -6px;
        right: -7px;
        background-color: #fff;
        width:16px;
        height: 16px;
        border-radius: 50%;
        z-index: 999;
    }  
    .del_box{
        position: absolute;
        right: 38px;
        top: -19px;
        background-color: #fff;
        padding: 10px 20px;
        border-radius: 6px;
        z-index: 990;
        border:1px solid #ccc;
    }
    .del_box h5{
        text-align: center;
        color: #333;
        margin-bottom: 10px;

    }
    .el-button{
        padding:6px 12px;
    }
</style>
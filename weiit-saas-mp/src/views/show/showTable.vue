<template>
    <div class="nav_des">
        <!-- 店招 -->
        <shop-signs v-if="keyWords == 'shop_signs'" :pageParam="pageParam"></shop-signs>
        <!-- 搜索框 -->
        <search-show v-if="keyWords == 'search'" :pageParam="pageParam"></search-show>
        <!-- 空白 -->
        <auxiliary-blank v-if="keyWords == 'auxiliary_blank'" :pageParam="pageParam"></auxiliary-blank>
        <!-- 辅助线 -->
        <auxiliary-lines v-if="keyWords == 'auxiliary_lines'" :pageParam="pageParam"></auxiliary-lines>
        <!-- 导航栏 -->
        <nav-show v-if="keyWords == 'nav'" :pageParam="pageParam"></nav-show>
        <!-- 优惠券 -->
        <coupon-show v-if="keyWords == 'coupon'" :pageParam="pageParam"></coupon-show>
        <!-- 商品分组 -->
        <good-sort v-if="keyWords == 'Commodity_sort'" :pageParam="pageParam"></good-sort>
        <!-- 商品列表 -->
        <good-list v-if="keyWords == 'Commodity_list'" :pageParam="pageParam"></good-list>
        <!-- 标题 -->
        <text-title v-if="keyWords == 'title'" :pageParam="pageParam"></text-title>
        <!-- 文本 -->
        <version-show v-if="keyWords == 'text'" :pageParam="pageParam"></version-show>
        <!-- 富文本 -->
        <rich-text v-if="keyWords == 'text_box'" :pageParam="pageParam"></rich-text>
        <!-- 广告 -->
        <advertisement v-if="keyWords == 'advertisement'" :pageParam="pageParam"></advertisement>
        <!-- 砍价 -->
        <bargain-show v-if="keyWords == 'bargain'" :pageParam="pageParam"></bargain-show>
        <!-- 语音 -->
        <voice-show v-if="keyWords == 'voice'" :pageParam="pageParam"></voice-show>
        <!-- 视频 -->
        <video-show v-if="keyWords == 'video'" :pageParam="pageParam"></video-show>
        <!-- 拼团 -->
        <fight-show v-if="keyWords == 'fight'" :pageParam="pageParam"></fight-show>
        <!-- 公告 -->
        <goods-notice v-if="keyWords == 'notice'" :pageParam="pageParam"></goods-notice>
        <!-- 客服电话 -->
        <service-show v-if="keyWords == 'tel'" :pageParam="pageParam"></service-show>
    </div>
</template>

<script>
    // 店招展示
    import shopSigns from '@/views/show/shopSigns'
    // 搜索框展示
    import searchShow from '@/views/show/search'
    // 空白展示
    import auxiliaryBlank from '@/views/show/auxiliaryBlank'
    // 辅助线展示
    import auxiliaryLines from '@/views/show/auxiliaryLines'
    // 导航栏展示
    import navShow from '@/views/show/nav'
    // 优惠券展示
    import couponShow from '@/views/show/coupon'
    // 商品分组展示
    import goodSort from '@/views/show/goodSort'
    // 商品列表展示
    import goodList from '@/views/show/goodList'
    // 标题展示
    import textTitle from '@/views/show/title'
    // 文本展示
    import versionShow from '@/views/show/version'
    // 富文本
    import richText from '@/views/show/richText'
    // 广告展示
    import advertisement from '@/views/show/advertisement'
    // 语音展示
    import voiceShow from '@/views/show/voice'
    // 视频展示
    import videoShow from '@/views/show/video'
    // 拼团展示
    import fightShow from '@/views/show/fight'
    // 砍价展示
    import bargainShow from '@/views/show/bargainShow'
    // 公告展示
    import goodsNotice from '@/views/show/notice'
    // 客服电话展示
    import serviceShow from '@/views/show/service'
    export default {
        props:['keyWords','pageParam'],
        components:{
            shopSigns,
            auxiliaryBlank,
            auxiliaryLines,
            navShow,
            searchShow,
            fightShow,
            goodList,
            textTitle,
            versionShow,
            goodsNotice,
            serviceShow,
            voiceShow,
            bargainShow,
            goodSort,
            couponShow,
            advertisement,
            richText,
            videoShow
        }
    }
</script>

<style scoped>

</style>
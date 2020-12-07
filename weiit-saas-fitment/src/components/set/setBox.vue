<template>
    <div class="set_box">
        <!-- 设置店招 -->
        <!-- <set-shop v-if="words == 'shop_signs'"></set-shop> -->
        <!-- 设置搜索框 -->
        <set-search v-if="words == 'search'"></set-search>
        <!-- 设置空白 -->
        <set-blank v-if="words == 'auxiliary_blank'"></set-blank>
        <!-- 设置辅助线 -->
        <set-lines v-if="words == 'auxiliary_lines'"></set-lines>
        <!-- 设置导航栏 -->
        <set-nav v-if="words == 'nav'"></set-nav>
        <!-- 设置优惠券 -->
        <set-coupon v-if="words == 'coupon'"></set-coupon>
        <!-- 设置分组 -->
        <set-sort v-if="words == 'Commodity_sort'"></set-sort>
        <!-- 设置列表 -->
        <set-list v-if="words == 'Commodity_list'"></set-list>
        <!-- 设置标题 -->
        <set-title v-if="words == 'title'"></set-title>
        <!-- 设置文本 -->
        <set-version v-if="words == 'text'"></set-version>
        <!-- 设置富文本 -->
        <set-rich v-if="words == 'text_box'"></set-rich>
        <!-- 设置广告 -->
        <set-advertisement v-if="words == 'advertisement'"></set-advertisement>
        <!-- 设置语音 -->
        <set-voice v-if="words == 'voice'"></set-voice>
        <!-- 设置视频 -->
        <set-video v-if="words == 'video'"></set-video>
        <!-- 设置拼团 -->
        <set-fight v-if="words == 'fight'"></set-fight>
        <!-- 设置秒杀 -->
        <set-seckill v-if="words == 'seckill'"></set-seckill>
        <!-- 设置公告 -->
        <set-notice v-if="words == 'notice'"></set-notice>
        <!-- 设置客服电话 -->
        <set-service v-if="words == 'tel'"></set-service>
        <!-- 设置图文组合 -->
        <set-combination v-if="words == 'combination'"></set-combination>
    </div>
</template>

<script>
    // 设置店招
    // import setShop from '@/components/set/setShop'
    // 设置搜索框
    import setSearch from '@/components/set/setSearch'
    // 设置空白块
    import setBlank from '@/components/set/setBlank'
    // 设置辅助线 
    import setLines from '@/components/set/setLines'
    // 设置导航栏
    import setNav from '@/components/set/setNav'
    // 设置优惠券
    import setCoupon from '@/components/set/setCoupon'
    // 设置分组
    import setSort from '@/components/set/setSort'
    // 设置列表
    import setList from '@/components/set/setList'
    // 设置标题
    import setTitle from '@/components/set/setTitle'
    // 设置文本
    import setVersion from '@/components/set/setVersion'
    // 设置富文本
    import setRich from '@/components/set/setRich'
    // 设置广告
    import setAdvertisement from '@/components/set/setAdvertisement' 
    // 设置语音
    import setVoice from '@/components/set/setVoice'
    // 设置视频
    import setVideo from '@/components/set/setVideo'
    // 设置拼团
    import setFight from '@/components/set/setFight'
    // 设置秒杀
    import setSeckill from '@/components/set/setSeckill'
    // 设置公告
    import setNotice from '@/components/set/setNotice'
    // 设置客服
    import setService from '@/components/set/setService'
    // 设置图文组合
    import setCombination from '@/components/set/setCombination'

    export default {
        props:['words','index'],
        components:{
            setSearch,
            setBlank,
            setLines,
            setTitle,
            setNav,
            setNotice,
            setService,
            setAdvertisement,
            setSort,
            setVoice,
            setRich,
            setVideo,
            setSeckill,
            setFight,
            setList,
            setVersion,
            setCoupon,
            setCombination
        }
    }
</script>

<style scoped>
</style>
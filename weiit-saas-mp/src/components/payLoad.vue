<template>
    <div class="loading">
		<mt-spinner color="#fff" type="snake" class="loadMore"></mt-spinner>
        <p>正在支付中...</p>
	</div>
</template>

<script>
    import { Spinner } from 'mint-ui';
    export default {
        data() {
            return {
            }
        }
    }
</script>

<style scoped lang="scss">
    .loading{
        position: fixed;
        padding: 0.2rem 0.5rem;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
        z-index: 50;
        background-color: rgba(0,0,0,0.5);
        border-radius: 0.2rem;
        text-align: center;
        p{
            text-align: center;
            font-size: 0.28rem;
            color: #fff;
            margin-top: 0.2rem;
        }
        .loadMore{
            display: table;
            margin: 0 auto;
            
        }
    } 
</style>
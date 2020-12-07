<template>
    <div class="loading">
		<mt-spinner color="#999" type="fading-circle"></mt-spinner>
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
        height: auto;
        padding: 30% 0;
        display: table;
        margin: 0 auto;
    } 
</style>
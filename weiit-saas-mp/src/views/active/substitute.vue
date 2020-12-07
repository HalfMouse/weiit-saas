<template>
    <div class="substitute">
        <div>
            <img :src="userImg" alt="">
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                userImg: localStorage.getItem('userImg')
            }
        },
    }
</script>

<style scoped>

</style>
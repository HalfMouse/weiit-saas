<template>
    <div class="goods_number">
        <div href="javascript:;" class="reduce" @click="reduce($event)">
            <i class="icon iconfont icon-jian1"></i>
        </div>
        <input class="num" v-model="num" type="num" maxlength="3" :class="{'numInp':componentFather == 'shop'}">
        <div href="javascript:;" class="add" @click="add($event)">
            <i class="icon iconfont icon-jia1"></i>
        </div>
    </div>
</template>

<script>
    // 引入axios
    import axios from 'axios';
    import qs from 'qs'; 
    export default {
        props:['count','componentFather','cartId'],
        data(){
            return{
                num:this.count
            }
        },
       methods:{
           // 增加商品数量
            add(e){
                if(this.num > 99){
                    this.num = 99;
                    return;
                }else{
                    this.num++;
                    if(this.componentFather == 'shop'){
                        let cart_id = this.cartId;
                        let count = this.num;
                        axios.post('/api/product/addUserCartCount',qs.stringify({
                            cart_id:cart_id,
                            count:count
                        }))
                    }
                }
                
                e.stopPropagation();
            },
            // 减少商品数量
            reduce(e){
                e.stopPropagation();
                if(this.num < 1){
                    return;
                }else{
                    this.num--;
                    if(this.componentFather == 'shop'){
                        let cart_id = this.cartId;
                        let count = this.num; 
                        axios.post('/api/product/addUserCartCount',qs.stringify({
                            cart_id:cart_id,
                            count:count
                        }))
                    }
                }
            }
        } 
    }
</script>

<style scoped lang="scss">
    .goods_number{
        position: absolute;
        right: 0.1rem;
        top: 0.18rem;
        text-align: center;
        line-height: 0.42rem;
        div{
            float: left;
            width: 0.49rem;
            height: 0.42rem;
            box-sizing: border-box;
            border: 1px solid #C8C8C8;
            font-size: 0.34rem;
            color: #666;
            .icon{
                display: block;
                font-size: 0.34rem;
                color: #666;
            }
        }
        input{
            float: left;
            width: 0.7rem;
            height: 0.42rem;
            box-sizing:border-box;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            font-size: 0.28rem;
            color: #444;
            text-align: center;
            line-height: 0.42rem;
            background-color: #fff;
            &.numInp{
                background-color: #FAFAFA;
            }
        }
    }
</style>
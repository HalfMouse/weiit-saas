import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);
export default new Vuex.Store({
    state:{
        styleList:[],      //总数据
        isMust:false,      //是否缺少必填项标识
        isTest:false,      //是否测试标识
        isSortable:false,  //是否拖动标识
        isZIndex:false,
        // routerSrc:'http://merchant.woyoulian.com',   //路径
        routerSrc:'http://merchant.wstore.me'   //路径
    },
    mutations:{
        // 添加数据
        addList(state,list){//这里的state对应着上面这个state
            state.styleList.push(list);
            //你还可以在这里执行其他的操作改变state
        },
        // 改变数据
        changeList(state, obj){
            for(let ele of state.styleList){
                if(ele.id == obj.id){
                    ele.pageParam = obj.op;
                }
            }
        },
        // 删除数据
        delList(state,index){
			var len = state.styleList.length;
    		state.styleList.splice(index,1);
        },
        // 检测未通过
        changeState(state){
            if(state.isTest){
                state.isMust = true;
            }
        },
        // 检测通过
        noState(state){
            state.isMust = false
        },
        // 点击保存开启检测
        unseal(state){
            state.isTest = true
        },
        stopSort(state){
            state.isSortable = true;
            state.isZIndex = true;
        },
        startSort(state){
            state.isSortable = false;
            state.isZIndex = false;
        }
    },
    actions:{
        addData(context,list){//这里的context和我们使用的$store拥有相同的对象和方法
            context.commit('addList',list);
            //你还可以在这里触发其他的mutations方法
        },
        changeData(context, list){
            context.commit('changeList', list);
        },
        delData(context, list){
            context.commit('delList', list);
        }
    }


}) 
 

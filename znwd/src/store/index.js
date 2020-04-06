import Vue from 'vue'
import Vuex from 'vuex'
import getters from './getters'
import mutations from './mutations'
import actions from './actions'

Vue.use(Vuex);


export default new Vuex.Store({
    state:{
        isMobile:false,
        fontSize:'13',//字体大小
        role:0,//老师不在线
        isSetSessionStorage:true,//是否缓存聊天内容到localstorage
        allMsg:[],
        topTenQuestion:[],//热点问题
        outputScrollPosition:0, //记录离开聊天窗口时滚动条的位置
        theme:'grey',//主题 : 'grey','blue'
        uuid:'', // 当前用户唯一标识 ,需要传给后台
        isQuestionAsked:false,
        unResolveTipsContent:''
    },
    getters,
    mutations,
    actions,
})
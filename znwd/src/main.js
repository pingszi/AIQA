// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import store from './store'
import router from './router'

import './router/handleRoute.js';

import VModal from 'vue-js-modal'

Vue.use(VModal, { dialog: true })

import './assets/common.css'

import './directives/index'
import './filters/index'

import App from './App.vue'

Vue.config.productionTip = false;


// 生成环境不打包
// process.env.NODE_ENV === 'production' || require('./mock/index.js'); 

/* eslint-disable no-new */
new Vue({
    el: '#app',
    computed:{
        theme(){
            return 'theme-'+this.$store.getters.getTheme
        }
    },
    router,
    store,
    components: { App },
    template: '<App :class="theme"/>',
})
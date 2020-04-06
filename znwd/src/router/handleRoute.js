import router from './index.js';
import store from '../store/index.js';

import { mobile_bs } from '@/utils/utils.js'

router.beforeEach((to,from,next) => {
    if(to.path ==="/"){
        if (mobile_bs.versions.mobile) {
            store.commit('SETISMOBILE',true);
            next('/mIndex')
        }else{
            next('/index')
        }
    }else{
        if(mobile_bs.versions.mobile){
            store.commit('SETISMOBILE',true);
            if(to.path.slice(1,2) !== 'm'){
                next('/m' + to.path.slice(1,2).toUpperCase() + to.path.slice(2));
            }else{
                next();
            }
    
        }else{
            store.commit('SETISMOBILE',false);
            if(to.path.slice(1,2) === 'm'){
                next('/' + to.path.slice(2,3).toLowerCase() + to.path.slice(3));
            }else{
                next();
            }
        }
        
    }
})
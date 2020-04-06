import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
    routes: [{
            path: '/index',
            name: 'AppIndex',
            component:() => import('@/pages/AppIndex'),
            meta:{
                keepAlive: true 
            }
        },
        {
            path: '/file/:id',
            name: 'AppRelatedPolicies',
            component: () => import('@/pages/AppRelatedPolicies'),
            meta:{
            }
        },
        {
            path: '/mIndex',
            name: 'MobleIndex',
            component: () => import('@/pages/MobileIndex'),
            meta:{
                keepAlive: true 
            }
        },
        {
            path: '/mFile/:id',
            name: 'MobileRelatedPolicies',
            component: () => import('@/pages/MobileRelatedPolicies'),
            meta:{
            }
        },
    ]
})
<template>
    <div>
        <the-header @finishLoading = 'getHeaderHeight'/>
        <app-window v-if="appHeaderHeight" ref="theWindow" :height="appWindowHeight" />
        <v-dialog/>
        <send-email />
    </div>
</template>

<script>
import TheHeader from '../components/TheHeader';
import AppWindow from '../components/AppWindow';
import SendEmail from '../components/common/SendEmail';


import { mapState, mapMutations } from 'vuex'
import { scrollToBottom, scrollToHeight,getNowDate,getNowTime } from '../utils/utils'

export default {
    name: 'AppIndex',
    components: { TheHeader, AppWindow,SendEmail },
    data() {
        return {
            appHeaderHeight:0,
            windowHeight:window.innerHeight
        }
    },
    computed:{
        appWindowHeight(){
            return this.windowHeight - this.appHeaderHeight
        },
        ...mapState(['outputScrollPosition'])
    },
    created(){
        window.onresize = this.resize;
    },
    methods:{
        resize(){
            this.windowHeight = window.innerHeight
        },
        getHeaderHeight(height){
            this.appHeaderHeight = height;
        },
        ...mapMutations(['ADDSESSIONITEM'])
    },
    watch:{
        "$route"(params){
            if(params.name === 'AppIndex' && this.outputScrollPosition){
                scrollToHeight(this.outputScrollPosition,false);
            }
        }
        
    }
}
</script>


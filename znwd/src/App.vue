<template>
	<keep-alive include="AppIndex,AppMobleIndex">
		<router-view/>
	</keep-alive>
</template>
<script>
import { mapState, mapMutations, mapActions } from 'vuex'
import { scrollToBottom,getNowDate,getNowTime,scrollResize } from './utils/utils'

export default {
    computed:{
        ...mapState(['allMsg', 'outputScrollPosition', 'outputScrollPosition','isSetSessionStorage'])        
    },
    methods:{
        ...mapMutations(['GETDATAFROMLOCALSTORAGE','ADDSESSIONITEM','SETUUID','SETROLE','SETISMOBILE']),
        ...mapActions(['refreshPolling'])
    },
    created() {
        let newDaySession = {
            date: getNowDate(),
            msg: [{
                host: 'ai',
                content: {
                    text: '您好，源恒智能客服小穗来啦，很高兴为您服务！<br/>希望能给您的疑问提供有效的参考。',
                    relativeFileList: null,
                    relativeQuestionList: null,
                    isSetResolve: false,
                    time: getNowTime()
                }
            }]
        }
        if(this.isSetSessionStorage){
            let allMsg = window.sessionStorage.getItem('allMsg');
            let uuid = window.sessionStorage.getItem('uuid');
            // let role = window.sessionStorage.getItem('role');
            if (uuid) {
                if(allMsg){
                    this.GETDATAFROMLOCALSTORAGE(allMsg);
                }
                this.SETUUID(uuid);
                // this.SETROLE(parseInt(role));
                // this.refreshPolling()
            }
        }
        if (this.allMsg.length == 0 || this.allMsg[this.allMsg.length - 1].date !== getNowDate()) {
            this.ADDSESSIONITEM(newDaySession)
        }

        window.onresize = this.scrollResize

    }
    

}
</script>
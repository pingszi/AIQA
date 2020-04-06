<template>
	<div class="wrap">
		<app-window-left-output :height="outputHeight"
		                        :background-color="'#eeeeee'"
                            @output-click = "inputFocus"
		                        :is-mobile="true" />
		<mobile-window-input :height="inputHeight" ref="mInput"/>
		<v-dialog :width="300"/>
		<send-email width="90%" height="350"/>
	</div>
</template>
<script>
import {mapState} from 'vuex';

export default {
  components:{
    AppWindowLeftOutput : () => import('@/components/AppWindowLeftOutput'),
    MobileWindowInput : () => import('@/components/MobileWindowInput'),
    sendEmail : () => import('@/components/common/SendEmail')
  },
  data(){
    return {
      inputHeight:50,
      windowHeight:window.innerHeight,
    }
  },
  computed:{
    outputHeight(){
      return this.windowHeight - this.inputHeight
    },
    ...mapState(['isMobile'])
  },
  methods:{
    inputFocus(){
      this.$refs.mInput.textareaBlur()
    }
  }
}
</script>

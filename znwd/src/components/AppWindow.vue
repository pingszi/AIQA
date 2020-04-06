<template>
  <div :style="myStyle">
      <app-window-left :width="leftWidth" :height="height"/>
      <app-window-right :width="rightWidth"  :height="height"/>
  </div>
</template>
<script>
import AppWindowLeft from './AppWindowLeft'
import AppWindowRight from './AppWindowRight'

export default {
    data(){
        return {
            leftWidth:'70%',
            rightWidth:'30%'
        }
    },
    computed:{
        myStyle(){
            return {
                height:this.height + 'px',
                // overflow:'hidden',
                clear:'both'
            }
        }
    },
    props:{
        'height':{
            type:Number,
            required:true
        }
    },
    components:{ AppWindowLeft ,AppWindowRight},
}
 
</script>



<template>
  <div class="wrap" :style="{width:width,height:height+'px'}">
      <app-window-left-output :height="outputHeight"/>
      <app-window-left-input :height="inputHeight"/>
  </div>
</template>
<script>
import AppWindowLeftOutput from './AppWindowLeftOutput'
import AppWindowLeftInput from './AppWindowLeftInput'
export default {
    props:{
        'width':{
            type:String,
            required:true,
            validator: function (value) {
                return /^(100|[1-9]?\d(\.\d\d?\d?)?)%$|0$/.test(value)
            }
        },
        'height':{
            type:Number,
            required:true
        }
    },
    computed:{
        outputHeight(){
            return parseInt(this.height*0.72)
        },
        inputHeight(){
            return this.height - this.outputHeight
        }
    },
    

    components:{AppWindowLeftOutput,AppWindowLeftInput}
}
</script>
<style scoped lang="scss">
.theme-blue{
    .wrap{
        float: left;
        background: #163d77;
    }
}
.theme-grey{
    .wrap{
        float: left;
        background: #f5f5f5;
    }
}
</style>
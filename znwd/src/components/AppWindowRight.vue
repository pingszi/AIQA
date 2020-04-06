<template>
  <div class="wrap" :style="{width:width,height:height+'px'}">
      <app-window-right-top :height="topHeight"/>
      <app-window-right-bottom :height="bottomHeight"/>
  </div>
</template>
<script>
import AppWindowRightTop from './AppWindowRightTop'
import AppWindowRightBottom from './AppWindowRightBottom'
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
        topHeight(){
            return parseInt(this.height*0.5)
        },
        bottomHeight(){
            return this.height - this.topHeight
        }
    },
    components:{AppWindowRightBottom,AppWindowRightTop}
}
</script>
<style scoped lang="scss">
.theme-blue{
    .wrap{
        float: left;
        background: #163d77;
        border-left:1px solid #1275a1;
        box-sizing: border-box;
    }

}
.theme-grey{
    .wrap{
        float: left;
        background: #ffffff;
        border-left:1px solid $greyThemeBorderColor;
        box-sizing: border-box;
    }

}

</style>
<template>
  <div :style="style"></div>
</template>
<script>
export default {
    props:{
        width:{
            required:true,
            type:Number
        },
        color:{
            default:'#1275a1',
            type:String,
            validator(value){
                return /^#([0-9a-f]{3}|[0-9a-f]{6})$/i.test(value)
            }
        }
    },
    computed:{
        style(){
            return {
                height:this.width+'px',
                background:this.color,
            }
        }
    }
}
    
</script>
<style scoped>
    div{
        width:100%;
    }
</style>

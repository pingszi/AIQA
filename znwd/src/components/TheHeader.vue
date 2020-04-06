<template>
  <div class="wrap">
      <div class="logoPic"><img src="../assets/logo.png" alt=""></div>
      <div class="appName">{{appName}}</div>
      <!-- <div class="btns">
        <span @click="changeThemeHandle">换肤</span>    
      </div>  -->
  </div>
</template>
<script>
import {mapMutations, mapState} from 'vuex'
export default {
    data(){
        return {
            appName:'源恒税务智能问答系统',
        }
    },
    computed:{
        ...mapState(['role'])
    },
    methods:{
        changeThemeHandle(){
            this.CHANGETHEME('blue')
        },
        ...mapMutations(['CHANGETHEME','SETROLE'])
    },
    mounted(){
        this.$emit('finishLoading',parseInt(getComputedStyle(this.$el).height))
    }

}
</script>
<style scoped lang="scss">
.theme-blue {
    .wrap{
        background: #042a6a;
        border-bottom: 3px solid #22599d;
        height: 63px;
        line-height: 60px;
        box-sizing: border-box;
        .logoPic{
            float: left;
            margin-left: 10px;
            height:60px;
            line-height: 60px;
        }
        img{
            vertical-align: middle;
            margin-top: -2px;
        }
        .appName{
            float: left;
            margin-left: 10px;
            color:#fdfdfd;
            font-size: 32px;
            height:60px;
            line-height: 60px;
        }
        .btns{
            float: right;
            margin-right: 20px;
        }
    }
}

.theme-grey {
    .wrap{
        background: #618df9;
        border-bottom: 1px solid $greyThemeBorderColor;
        height: 63px;
        line-height: 60px;
        box-sizing: border-box;
        .logoPic{
            float: left;
            margin-left: 10px;
            height:60px;
            line-height: 60px;
        }
        img{
            vertical-align: middle;
            margin-top: -2px;
        }
        .appName{
            float: left;
            margin-left: 10px;
            color:#fff;
            font-size: 32px;
            height:60px;
            line-height: 60px;
        }
        .btns{
            float: right;
            margin-right: 20px;
        }
    }
}
</style>


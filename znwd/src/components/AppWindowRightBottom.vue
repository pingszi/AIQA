<template>
    <div :style="style">
        <base-window-title title="公告信息"/>
        <div class="ggxx" id="ggxx">
            <div :style="{height:ggxxHeight}">
                <div class="icon" @click="changeTheme">
                    <div>
                        <img src="../assets/grey_gonggao.png"/>
                    </div>
                    <div>
                        <h3>工作时间：</h3>
                        <p>（周一至周五）9:00-17:30</p>
                        <p>热线电话：400-8861-778</p>
                    </div>
                </div>
                <div class="msg">您好！智能客服小穗很高兴为您服务！我能为您提供7*24小时在线智能咨询服务。您在对话框输入税务问题，然后选择问题序号就可获得回复哦，赶快试试吧！本系统支持各种现代浏览器，如果您的浏览器为IE8及以下版本，请升级您的浏览器。</div>
            </div>
        </div>
    </div>
</template>
<script>
import BaseWindowTitle from './common/BaseWindowTitle'
import {formatterElScrollBar} from '../utils/utils.js'
import {mapMutations} from 'vuex'
export default {
    components:{BaseWindowTitle},    
    props:{
        'height':{
            required:true,
            type:Number
        }
    },
    data(){
        return {
            time:0,
            timer:null,
            isGreyTheme:true
        }
    },
    computed:{
        style(){
            return {
                height:this.height-1+'px'
            }
        },
        ggxxHeight(){
            return this.height -1 -38 + 'px';
        }
    },
    mounted(){
        formatterElScrollBar("#ggxx")
    },

    methods:{
        changeTheme(){
            this.time++;
            if(this.timer){
                clearTimeout(this.timer)
            }
            if(this.time === 5){
                let theme = this.isGreyTheme ? 'blue':'grey'
                this.CHANGETHEME(theme);
                this.isGreyTheme = !this.isGreyTheme;
                this.timer = null;
                this.time = 0;
                return
            } 
            this.timer = setTimeout(()=>{
                this.time = 0;
            },1000)
        },
        ...mapMutations(['CHANGETHEME'])
    }
}    
</script>
<style scoped lang="scss">
.theme-blue{
    .ggxx{
        border-top: 1px solid #1275a1; 
        overflow: hidden;
        .icon{
            height: 50%;
            text-align: center;
            display: table;
            // background: url(../assets/gonggao.png) no-repeat 25% center;
            // padding-left:50%;
            div{
                display: table-cell;
                vertical-align: middle;
                width:20%;
                h3{
                    color:#ffffff;
                    font-size: 16px;
                    font-weight: normal;
                    text-align: left
                }
                p{
                    text-align: left;
                    text-indent: 0;
                    color: #ffffff;
                }

            }
        }
        .msg{
            color: #ffffff;
            padding: 0 10px;
            text-indent: 25px;
        }
    }
}
.theme-grey{
    .ggxx{
        border-top: 1px solid $greyThemeBorderColor; 
        overflow: hidden;
        .icon{
            height: 50%;
            text-align: center;
            display: table;
            // background: url(../assets/grey_gonggao.png) no-repeat 25% center;
            // padding-left:50%;
            div{
                display: table-cell;
                vertical-align: middle;
                width:20%;
                h3{
                    color:#698ee9;
                    font-size: 16px;
                    font-weight: normal;
                    text-align: left
                }
                p{
                    text-align: left;
                    text-indent: 0;
                }

            }
        }
        .msg{
            color: $greyThemeFontColor;
            padding: 0 10px;
            text-indent: 25px;
        }
    }
}
</style>


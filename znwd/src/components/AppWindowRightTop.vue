<template>
    <div>
        <div :style="style">
            <window-title title="热点问题"/>
            <!-- tabs -->
            <!-- <div class="tabTitle">
                <span :class="{'active':isHotShow}" @click="isHotShow = true">热点问题</span>
                <span :class="{'active':!isHotShow}"  @click="isHotShow = false">相关问题</span>
            </div> -->
            <div class="content" id="hotQuestionContent" :style="{height:hotQuestionContentHeight}">
                <div v-show="isHotShow">
                    <ul>
                        <li v-for="(item,idx) in topTenQuestion" :key="idx">
                            <a href="javascript:void(0)" @click="askTopTenAnswer(item,$event)">
                                <span v-text="idx+1+'、'"></span><span v-text="item.question"></span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div v-show="!isHotShow">相关问题</div>
            </div>
        </div>
    </div>
</template>
<script>
import CssSplitLine from './common/CssSplitLine'
import windowTitle from './common/BaseWindowTitle'

import {mapActions,mapState,mapMutations} from 'vuex'
import {getAnswer} from '../api'

import {formatterElScrollBar} from '../utils/utils.js'

export default {
    components:{CssSplitLine, windowTitle},
    props:{
        'height':{
            required:true,
            type:Number
        }
    },
    data(){
        return {
            isHotShow:true
        }
    },
    computed:{
        style(){
            return {
                height:this.height-1+'px'
            }
        },
        hotQuestionContentHeight(){
            return this.height- 1 - 38 -1 + 'px';
        },
        ...mapState(['topTenQuestion'])
    },
    watch:{
        isHotShow(){
            this.$nextTick(()=>{
                $("#hotQuestionContent").getNiceScroll().resize();
            })
        }
    },
    methods:{
        askTopTenAnswer(q,e){
            $(e.target).parent('a').addClass('visited');
            this.askQuestion(q);
        },
        ...mapMutations(['ADDQUESTION']),
        ...mapActions(['addTopTenQuestion','askQuestion'])

    },
    mounted(){
        formatterElScrollBar('#hotQuestionContent');
        this.addTopTenQuestion();
    }
}    
</script>
<style scoped lang="scss">
.theme-blue{
    .tabTitle{
        background: #154285;
        height: 38px;
        line-height: 38px;
        font-size: 18px;
        color: #999;
    }
    .tabTitle span{
        display: inline-block;
        width:137px;
        text-align: center;
        border-right: 1px solid #1275a1;
        cursor: pointer;
        color:#1178ab;
        font-weight: bold
    }
    .tabTitle span:hover{
        color:#fdfdfd;
    }
    .tabTitle span.active{
        color:#fdfdfd;
    }
    .content{
        padding: 10px 10px;
        box-sizing: border-box;
        border-top: 1px solid #1275a1;
        border-bottom: 1px solid #1275a1;
    }
    .content li{
        margin:10px;
    }
    .content a{
        height: 30px;
        color: #ffff00;
        text-decoration: underline;
        transition: all .15s ease-in;
        &:hover{
            opacity: 0.5;
        }
        &.visited{
             opacity: 0.5;
        }
    }
    #hotQuestionContent{
        overflow: hidden;
        cursor: default !important;
    }
}
.theme-grey{
    .tabTitle{
        background: #154285;
        height: 38px;
        line-height: 38px;
        font-size: 18px;
        color: #999;
    }
    .tabTitle span{
        display: inline-block;
        width:137px;
        text-align: center;
        border-right: 1px solid #1275a1;
        cursor: pointer;
        color:#1178ab;
        font-weight: bold
    }
    .tabTitle span:hover{
        color:#fdfdfd;
    }
    .tabTitle span.active{
        color:#fdfdfd;
    }
    .content{
        padding: 10px 10px;
        box-sizing: border-box;
        border-top: 1px solid $greyThemeBorderColor;
        border-bottom: 1px solid $greyThemeBorderColor;
    }
    .content li{
        margin:10px;
    }
    .content a{
        height: 30px;
        color:$greyThemeFontColor;
        transition: all .15s ease-in;
        &:hover{
            opacity: 0.5;
        }
        &.visited{
             opacity: 0.5;
        }
    }
    
    #hotQuestionContent{
        overflow: hidden;
        cursor: default !important;
    }
}
</style>


<template>
    <div :style="style" @click.self="$refs.textarea.focus()">
        <suggest-list 
            v-if="isShowSuggest" 
            :suggestQuestions="suggestQuestions" 
            :suggestKeyword="suggestKeyword" 
            :positionBottom="height+10"
            :isInput="inputCounter"
            @selectSuggest ="handleSuggest" 
            @clickSuggest="handleClickSuggest"/>
        <app-functional-bar/>
        <textarea ref='textarea' v-focus placeholder="按Enter发送消息" v-model="inputMsg" @keyup.enter="askInputQuestion" id="questionInput" :style="{fontSize:fontSize+'px'}" @input="startSuggest" maxlength="499"></textarea>
        <button class="send" @click="askInputQuestion" >发送</button>
        <button class="closeChart" @click="clearMsg">清除对话</button>
    </div>
</template>
<script>
import AppFunctionalBar from './AppFunctionalBar'
import SuggestList from './common/SuggestList'
import {scrollToBottom,formatterElScrollBar} from '../utils/utils'
import { mapMutations,mapActions,mapState } from 'vuex'

import {getSuggest} from '../api/index.js'
export default {
    components:{AppFunctionalBar, SuggestList},

    data(){
        return {
            inputCounter:0,
            inputMsg:'',
            suggestQuestions:[],
            suggestKeyword:[],
            suggestQuestionId:'',
            isShowSuggest: false,
            timer:null
        }
    },

    props:{
        'height':{
            required:true,
            type:Number
        }
    },

    mounted(){
        //滚动条样式优化
        formatterElScrollBar('#questionInput');
        document.addEventListener('click', evt => {
            if(evt.target.tagName.toLowerCase() !== 'textarea'){
                this.isShowSuggest = false;
            }
        })
    },

    methods:{
        askInputQuestion(evt){
            this.isShowSuggest = false;
            // ctrl+enter 表示换行
            if(evt.ctrlKey){
                this.inputMsg += '\n'
                return;
            }
            let questionStr = this.inputMsg;
            if(this.suggestQuestionId){
                this.askQuestion({question:questionStr,id:this.suggestQuestionId});
            }else{
                this.askQuestion(questionStr);
            }
            this.suggestQuestionId = '';
            this.inputMsg = '';
        },
        handleSuggest(d){
            this.inputMsg = d.q;
            this.suggestQuestionId = d.qid;
        },
        handleClickSuggest(d){
            this.inputMsg = ''
            this.$refs.textarea.focus()
            this.askQuestion({question:d.q,id:d.qid})
        },
        startSuggest(){
            this.inputCounter++ ;
            let current = this.inputMsg;
            if(this.timer){
                clearTimeout(this.timer)
            }
            if(!this.inputMsg){
                return this.isShowSuggest = false;
            }

            this.timer = setTimeout(()=>{
                this.timer = null
                getSuggest(this.inputMsg).then(data => {
                    if(data.data.token === 1 && current === data.data.question){
                        this.isShowSuggest = true;
                        this.suggestQuestions = data.data.content;
                        this.suggestKeyword = data.data.match_word;
                        console.log(data.data)
                    }
                })
            },500)
        },
        ...mapMutations(['ADDQUESTION']),
        ...mapActions(['askQuestion','clearMsg'])
    },

    computed:{
        style(){
            return {
                height:this.height-1+'px',
                cursor:'text',
                position: 'relative'
            }
        },
        ...mapState(['fontSize'])
    },
}
</script>
<style scoped lang="scss">
.theme-blue{
    textarea{
        width: 100%;
        height:48%;
        background-color:transparent; 
        border: none;
        /* text-indent: 10px; */
        padding:10px;
        margin: 0;
        color: #fff;
        box-sizing: border-box;
        cursor: text !important;
    }
    button{
        width: 116px;
        height: 44px;
        border: 2px solid transparent;
        cursor: pointer;
        margin-right: 10px;
        float: right;
        border-radius: 5px;
        color: #fdfdfd;
        font-size: 18px;
    }
    .closeChart{
        border-color: #116e9e;
        background: #10376c;
        &:hover{
            background: #092852;
        }
    }
    .send{
        border-color: #fdfdfd;
        background: #3069f9;
        &:hover{
            background: #2c5dd6;
        }
    }
}
.theme-grey{
    textarea{
        width: 100%;
        height:48%;
        background-color:transparent; 
        border: none;
        /* text-indent: 10px; */
        padding:10px;
        margin: 0;
        color: $greyThemeFontColor;
        box-sizing: border-box;
        cursor: text !important;
    }
    button{
        width: 116px;
        height: 44px;
        border: 2px solid transparent;
        cursor: pointer;
        margin-right: 10px;
        float: right;
        border-radius: 5px;
        color: #fdfdfd;
        font-size: 18px;
    }
    .closeChart{
        color: #fff;
        border-color: #cccccc;
        background: #cccccc;
        &:hover{
            background: #91A3C2;
            border-color: #91A3C2;
        }
    }
    .send{
        border-color: #618df9;
        background: #618df9;
        &:hover{
            background: #265988;
            border-color: #265988;
        }
    }
}
</style>
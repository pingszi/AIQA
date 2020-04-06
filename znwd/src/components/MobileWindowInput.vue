<template>
	<footer :style="style"
	        @click.self="$refs.textarea.focus()">
		<i><img src="../assets/keyboard.png"
			     alt=""></i>
		<textarea ref='textarea'
		          v-model="inputMsg"
		          @keyup.enter="askInputQuestion"
		          id="questionInput"
                  @focus="handleFocus"
		          maxlength="499"></textarea>
		<button class="send"
		        @click="askInputQuestion">发送</button>
	</footer>
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
        handleFocus(e){
            setTimeout(() => {
                e.target.scrollIntoView();
            },400)
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
        textareaBlur(){
            this.$refs.textarea.blur()
        },
        ...mapMutations(['ADDQUESTION']),
        ...mapActions(['askQuestion','clearMsg'])
    },

    computed:{
        style(){
            return {
                height:this.height-1+'px',
                cursor:'text',
                position: 'relative',
                backgroundColor:'#f5f5f5',
                borderTop:'1px solid #dddddd'
            }
        },
        ...mapState(['fontSize'])
    },
}
</script>
<style scoped lang="scss">
i {
  width: 32px;
  height: 32px;
  margin-left: 5px;
  img {
    width: 32px;
    height: 32px;
  }
}
textarea {
  width: 68%;
  height: 90%;
  background-color: transparent;
  border: none;
  font-size: 16px;
  /* text-indent: 10px; */
  padding: 20px 5px 0px 5px;
  margin: 0;
  border-bottom: 1.5px solid #ddd;
  color: $greyThemeFontColor;
  box-sizing: border-box;
  cursor: text !important;
  &:focus {
    border-bottom: 1.5px solid #618df9;
  }
}
button {
  width: 60px;
  height: 34px;
  border: 2px solid transparent;
  cursor: pointer;
  margin-right: 10px;
  margin-top: 7px;
  float: right;
  border-radius: 5px;
  color: #fdfdfd;
  font-size: 14px;
}
.send {
  border-color: #618df9;
  background: #618df9;
  &:focus {
    background: #265988;
    border-color: #265988;
  }
}
</style>
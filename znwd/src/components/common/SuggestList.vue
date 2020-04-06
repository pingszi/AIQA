<template>
    <div class="suggestList" :style="{bottom:positionBottom+'px'}">
        <ul>
            <li v-for="(item,idx) in questionList" :key="idx" v-html="item.question" @click="askSuggestQusition({q:item.sd_question,qid:item.id})" :class="{'active':idx === activeIndex? true : false}"></li>
        </ul>
    </div>
</template>
<script>
import { mapActions } from 'vuex'

export default {
    props:{
        suggestQuestions:{
            type:Array,
            required:true
        },
        suggestKeyword:{
            type:Array,
            required:true
        },
        positionBottom:{
            type:Number,
            required:true
        },
        isInput:{
            
        }
    },

    data(){
        return {
            activeIndex:-1
        }
    },

    computed:{
        questionList(){
            return this.suggestQuestions
                .filter((item,idx) => idx<5)
                .map(item => {
                    let newItem = {}
                    newItem.id = item.id;
                    newItem.sd_question = item.sd_question;
                    newItem.question = this.suggestKeyword.reduce((start,word) => start.replace(new RegExp(word,'g'),'<span style="color:#fabd0b;">'+word+'</span>'),item.sd_question);
                    return newItem;
                })
        },
        findActiveIndex(){
            for(let i=0; i<this.questionList.length; i++){
                if(this.questionList[i].isActive){
                    return i;
                }
            }
            return -1
        }
    },

    mounted(){
        document.addEventListener('keyup',evt =>{
            let q = '',qid = '';
            if(evt.keyCode === 38){
                if(this.activeIndex === -1 || this.activeIndex === 0){
                    this.activeIndex = this.questionList.length-1
                }else{
                    this.activeIndex--
                }
                q = this.questionList[this.activeIndex].sd_question;
                qid = this.questionList[this.activeIndex].id
                this.$emit('selectSuggest',{q,qid});
            }
            if(evt.keyCode === 40){
                if(this.activeIndex === -1 || this.activeIndex === this.questionList.length-1){
                    this.activeIndex = 0;
                }else{
                    this.activeIndex++
                }
                q = this.questionList[this.activeIndex].sd_question;
                qid = this.questionList[this.activeIndex].id
                this.$emit('selectSuggest',{q,qid});
            }
        })
    },

    methods:{
        askSuggestQusition(q){
            this.$emit('clickSuggest',q)
        }
    },

    watch:{
        'isInput'(){
            this.activeIndex=-1
        }
    }

}
    
</script>
<style scoped lang="scss">
.suggestList{
    max-width: 90%;
    min-width:50%;
    // height: 150px;
    background: #124e62;
    // opacity: .9;
    position: absolute;
    border-radius: 8px;
    left: 10px;
    padding: 10px 0;
    li{
        color: #fff;
        // height: 30px;
        line-height: 30px;
        padding: 0 10px;
        cursor: pointer;
        &.active{
            background: #336CA1;
        }
        &:hover{
            background: #336CA1;
        }
    }
}
</style>

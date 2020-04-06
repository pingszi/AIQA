<template>
	<div>
		<p>
			以上答案是否解决了您的问题
			<a href="javascript:void(0)"
			   @click="questionResolve({question,uuid})">解决</a>
			<a href="javascript:void(0)"
			   @click="handleNotResolve(question)">未解决</a>
		</p>
	</div>
</template>
<script>
import { mapActions, mapState } from "vuex";

export default {
    props: {
        question: {
            type: String,
            required: true
        }
    },
    computed:{
        ...mapState(['isMobile', 'uuid'])
    },
    methods: {
        handleResolve(){

        },
        handleNotResolve(q){
            this.questionNotResolve({question:q,uuid:this.uuid});
            this.$modal.show('dialog', {
                text: '发送邮件人工咨询？',
                buttons: [
                    {
                        title: '取消',
                        handler: () => { 
                            this.renderQuestionNotResolveTips();
                            this.$modal.hide('dialog')
                        }
                    },
                    {
                        title: '确定',
                        handler: () => { 
                            this.$modal.show('send-email',{question:q})
                            this.$modal.hide('dialog')
                        }
                    },
                ]
            })
        },
        ...mapActions(["questionResolve", "questionNotResolve", "renderQuestionNotResolveTips"])
    }
};
</script>
<style scoped lang="scss">
.theme-blue {
  a {
    color: #fabd0b;
    text-decoration: underline;
  }
}
.theme-grey {
  p {
    color: $greyThemeColor;
    font-weight: bold;
    text-indent: 10px;
    a {
      color: $greyThemeFontColor;
      border-bottom: 1px solid #fabd0b;
    }
  }
}
</style>

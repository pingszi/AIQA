<template>
	<div>
		<p>
			<a href="javascript:void(0)"
			   @click="handleNotResolve(question)">发送邮件人工咨询？</a>
		</p>
	</div>
</template>
<script>
import { mapActions } from "vuex";

export default {
    props: {
        question: {
            type: String,
            required: true
        }
    },
    methods: {
        handleResolve(){

        },
        handleNotResolve(q){
            this.$modal.show('send-email',{question:q});
        },
        ...mapActions(["questionResolve", "questionNotResolve"])
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

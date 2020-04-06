<template>
	<modal name="send-email"
          :class="isMobile? 'mobile' : 'app'"
	       ref="popup"
	       @before-open="beforeOpen"
	       :width="width ? width: 600"
	       :height="height? height :300">
		<base-window-title title="发送邮件" />
		<div class="emailInfo">
			<p>
				<label for="user_email">您的邮箱：</label>
				<input type="email"
				       v-model="email"
				       id="user_email">
			</p>
			<p style="paddingLeft:70px;color:red;">
				<span v-show="!email.trim()">*邮箱必填</span>
				<span v-show="isValidateEmailShow">*请输入正确的邮箱地址</span>
				<span>&nbsp;</span>
			</p>
			<p class="user_qusetion">
				<label for="user_question">您的问题：</label>
				<textarea id="user_question"
				          v-model="question"></textarea>
			</p>
		</div>
		<div class="btns">

			<button class="btn"
			        @click="$modal.hide('send-email')">取消</button>
			<button class="btn" @click="handleClick">确定</button>
		</div>
	</modal>
</template>
<script>
import BaseWindowTitle from './BaseWindowTitle'
import { mapActions, mapState} from 'vuex';

import {sendEmail} from '@/api/index.js'

export default {
  name: 'ExampleModal',
  components:{BaseWindowTitle},
  props:{
    width:{

    },
    height:{

    }
  },
  data () {
    return {
      email:'',
      question:'',
      isValidateEmailShow:false
    }
  },
  computed:{
    ...mapState(['isMobile'])
  },
  methods: {
    beforeOpen (event) {
      this.question = event.params.question;
      this.isValidateEmailShow = false;
      this.email = '';
    },
    handleClick(){
      var email = this.email.trim();
      if(email){
        if(this.validateEmail(email)){
          this.sendEmail({email,question:this.question});
          this.$modal.hide('send-email');
        }else{
          this.isValidateEmailShow = true;
        }
      }else{
        return false;
      }
    },
    validateEmail(email){
      const reg = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
      if(reg.test(email)){
        return true
      }
      return false
    },
    ...mapActions(['sendEmail'])
  }
}
</script>
<style scoped lang='scss'>
.app{
  .emailInfo p {
    margin-bottom: 2px;
    text-align: left;
  }
  .user_qusetion label {
    position: relative;
    top: -32px;
  }
}
.mobile{
  .emailInfo p {
    text-indent: 5px;
    padding-left: 0 !important;
    label{
      display: block;
    }
    margin-bottom: 2px;
    text-align: left;
  }
  .user_qusetion label {
    position: relative;
  }
  #user_email,#user_question{
    width: 90%;
  }
}
.btn {
  outline: none;
  background: #fff;
  border: 0;
  padding: 7px 15px;
  cursor: pointer;
  color: #fff;
  box-shadow: 0 4px 8px rgba(32, 160, 255, 0.3);
  background: #618df9;
  font-weight: 600;
  border-radius: 3px;
  min-width: 90px;
  margin-bottom: 8px;
  margin-top: 8px;
  margin-right: 8px;
}
.btn:hover {
  background: #265988;
}
.emailInfo {
  border-top: 1px solid #c2cfdb;
}
.btns {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  border-top: 1px solid #c2cfdb;
  text-align: center;
}
.emailInfo {
  padding: 20px;
}

#user_email,
#user_question {
  font-family: inherit;
  display: table-cell;
  position: relative;
  z-index: 2;
  /* float: left; */
  width: 70%;
  margin-bottom: 0;
  height: 34px;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
  box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
  -webkit-transition: border-color ease-in-out 0.15s,
    -webkit-box-shadow ease-in-out 0.15s;
  -o-transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
  transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
}
#user_email:focus,
#user_question:focus {
  border-color: #66afe9;
  outline: 0;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075),
    0 0 8px rgba(102, 175, 233, 0.6);
  box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075),
    0 0 8px rgba(102, 175, 233, 0.6);
}
#user_question {
  height: 64px;
}
</style>

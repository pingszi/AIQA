import {
    getTopTenQuestion,
    getAnswer,
    isUnresolve,
    isResolve,
    getResultFromTuring,
    getPollingInfo,
    askQuestions,
    sendEmail
    
} from '../api'

import {
    scrollToBottom,
    getNowDate,
    getNowTime
} from '../utils/utils'

/**
 * @description 找出问题及问题id
 * @param {*} qItem:String|Object 传入第一个参数 
 * @param {*} getters vuex实例的 getters属性
 * @returns {q,qid}
 */
let getQuestionItem = (qItem,getters) => {
    let q,qid;

    if(typeof qItem == 'object'){
        q = qItem.question.trim();
        qid = qItem.id
    }
    
    if(typeof qItem == 'string'){
        q = qItem.trim();
        qid = ''
    }

    //数字
    if(/^\d+$/.test(q)){
        let qItemFromNumber = getters.getLatestRelativeQuestion(q);
        if(qItemFromNumber){
            q = qItemFromNumber[0]
            qid = qItemFromNumber[1]
        }
    }

    return {q,qid}
}

/**
 * @description 输出消息父类
 * @author fangyang
 * @class OutputMsg
 */
class OutputMsg {
    /**
     *Creates an instance of OutputMsg.
     * @author fangyang
     * @param {*} commit vuex实例的commit方法
     * @memberof OutputMsg
     */
    constructor(commit){
        this.commit = commit;
        this.msg = {
            host:'',
            content:{
                text:'',
                relativeFileList:null,
                relativeQuestionList:null,
                isSetResolve:false,
                isLaoshi:false,
                time:getNowTime(),
                question:''
            }
        }
    }

    /**
     * @description 提交消息到vuex实例上
     * @author fangyang
     * @memberof OutputMsg
     */
    renderMsg(){
        this.commit('ADDQUESTION',this.msg);
        scrollToBottom();
    }
}

/**
 * @description 用户输出文本消息类
 * @author fangyang
 * @class UserOutputMsg
 * @extends {OutputMsg}
 */
class UserOutputMsg extends OutputMsg {
    /**
     *Creates an instance of UserOutputMsg.
     * @author fangyang
     * @param {*} commit vuex实例的commit方法
     * @param {*} q 消息内容
     * @memberof UserOutputMsg
     */
    constructor(commit,q){
        super(commit);
        this.msg.host = 'user';
        this.msg.content.text = q;
        this.renderMsg();
    }
}

/**
 * @description 机器人输出消息类
 * @author fangyang
 * @class AIOutputMsg
 * @extends {OutputMsg}
 */
class AIOutputMsg extends OutputMsg {
    /**
     *Creates an instance of AIOutputMsg.
     * @author fangyang
     * @param {*} commit  vuex实例的commit方法
     * @param {*} q 消息内容
     * @memberof AIOutputMsg
     */
    constructor(commit,q){
        super(commit);
        this.msg.host = 'ai';
        this.msg.content.text = q;
        this.renderMsg();
    }
}

/**
 * @description 机器人输出消息类
 * @author fangyang
 * @class AIOutputMsg
 * @extends {OutputMsg}
 */
class AIOutputNoneMsg extends OutputMsg {
    /**
     *Creates an instance of AIOutputMsg.
     * @author fangyang
     * @param {*} commit  vuex实例的commit方法
     * @param {*} q 消息内容
     * @memberof AIOutputMsg
     */
    constructor(commit,q){
        super(commit);
        this.msg.host = 'ai';
        this.msg.content.text = '抱歉，您的提问对小穗来说，超纲啦！请在工作时间咨询老师。<br/>如有需要，请联系 QQ：4008861778，或致电源恒热线：400-8861-778。';
        this.msg.content.isShowSendEmail = true;
        this.msg.content.question = q;
        this.renderMsg();
    }
}

/**
 * @description 老师响应的答案类，给出老师标识
 * @author fangyang
 * @class LaoshiOutPut
 * @extends {AIOutputMsg}
 */
class LaoshiOutPut extends OutputMsg {
    /**
     *Creates an instance of LaoshiOutPut.
     * @author fangyang
     * @param {*} commit  vuex实例的commit方法
     * @param {*} q 消息内容
     * @memberof LaoshiOutPut
     */
    constructor(commit,q){
        super(commit,q);
        this.msg.content.isLaoshi = true;
        this.msg.host = 'ai';
        this.msg.content.text = q;
        this.renderMsg();
    }
}


/**
 * @description 渲染响应的内容，可能包括，相关政策，相关问题，问题的答案等内容
 * @author fangyang
 * @class AIResponceJsonOutputMsg
 * @extends {AIOutputMsg}
 */
class AIResponceJsonOutputMsg extends OutputMsg {
    constructor(commit,data){
        super(commit);
        this.msg.host = 'ai';
        data.ai_answer.length && (this.msg.content.text = data.ai_answer[0]);
        data.ai_policy_answer.length !== 0 && (this.msg.content.relativeFileList = data.ai_policy_answer);
        data.ai_relative_answer.length !== 0 && (this.msg.content.relativeQuestionList = data.ai_relative_answer);
        data.question && (this.msg.content.question = data.question)
        this.msg.content.isSetResolve = true;
        this.renderMsg();
    }
}

class TipsMsg extends OutputMsg{
    constructor(commit,role){
        super(commit)
        this.msg = {
            isTips:true,
            msg:role ? "您好，<b>源恒咨询老师</b>很高兴为您解答！":"您好，<b>源恒智能客服小穗</b>很高兴为您服务！"
        };
        this.renderMsg();
    }
}

export default {
    /**
     * @description 热点问题前十
     * @author fangyang
     * @param {*} {commit}
     */
    async addTopTenQuestion({commit}){
        let data = await getTopTenQuestion();
        commit('ADDTOPTENQUESTION',data.data);
    },

    /**
     * @description 问问题
     * @author fangyang
     * @param {*} {state,commit,getters,dispatch}
     * @param {*} qItem
     */
    async askQuestion({state,commit,getters,dispatch},qItem){
        //获取问题内容和问题id
        let {q,qid} = getQuestionItem(qItem,getters);
        //是否为空
        if(q===""){
            return new AIOutputMsg(commit,"不允许发送空消息。");
        }
        //**客服系统逻辑===========================================================/
        if(!state.uuid && state.isQuestionAsked){
            return new AIOutputMsg(commit,'输入问题过于频繁,请您休息一会重新输入！')
        }
        //**======================================================================/

        //显示用户的输入
        new UserOutputMsg(commit,q);

        
        //**之前的逻辑==============================================================/
        // let data = await getAnswer(q,qid).catch(err => {
        //     new AIOutputMsg(commit,"服务器出错了!")
        // });

        // if(data.data.token === 0){
        //     //请求图灵机器人
        //     let json = await getResultFromTuring(q)
        //     let msg = json.data.code === 100000 ? json.data.text : '看来我还需要学习来了解更多';
        //     new AIOutputMsg(commit,msg)
        // }else{
        //     new AIResponceJsonOutputMsg(commit,data.data)
        // }
        //**======================================================================/



        //**客服系统逻辑===========================================================/
        let data = await askQuestions({
            "uuid_key":state.uuid,
            "question":q,
            "knowledge_id":qid, 
        }).catch(err => {
            if (err.response) {
                err.response.status === 503 && new AIOutputMsg(commit,"输入问题过于频繁,请您休息一会重新输入！")
            }else{
                new AIOutputMsg(commit,"服务器出错了!")
            }
        });

        //第一次问问题
        if(!state.uuid){
            commit('SETUUID',data.data.uuid_key);
            // dispatch('beginPolling');
        }
        // else{
        //     await dispatch('switchRole',data.data.role);
        //     //是老师且不是第一次问问题就显示正在输入中
        //     if(data.data.role){
        //         // new LaoshiOutPut(commit,'正在输入中。。。')
        //     }
        // }
        
        //机器人回答
        if(!data.data.no_result || !data.data.no_policy_result || !data.data.no_relative_result){
            new AIResponceJsonOutputMsg(commit,data.data)
        }else{
            new AIOutputNoneMsg(commit,data.data.question)
        }

        //**======================================================================/

    },

    /**
     * @description 点击解决
     * @author fangyang
     * @param {*} {commit}
     * @param {*} qid
     */
    async questionResolve({commit},qid){
        let data = await isResolve(qid).catch(err => {
            new AIOutputMsg(commit,"服务器出错了!")
        }) 
        new AIOutputMsg(commit,data.data)
    },

    /**
     * @description 点击未解决
     * @author fangyang
     * @param {*} {commit}
     * @param {*} qid
     */
    async questionNotResolve({commit},qid){
        let data = await isUnresolve(qid).catch(err => {
            new AIOutputMsg(commit,"服务器出错了!")
        })
        commit('UNRESOLVETIPSCONTENT',data.data)
        // new AIOutputMsg(commit,data.data)
    },

    renderQuestionNotResolveTips({state, commit}){
        new AIOutputMsg(commit,state.unResolveTipsContent);
    },

    /**
     * @description 清屏
     * @author fangyang
     * @param {*} {commit}
     */
    clearMsg({commit}){
        commit('CLEARALLMSG');
        sessionStorage.removeItem('allMsg');
        scrollToBottom();
    },

    /**
     * @description 发送表情，请求tuning机器人，渲染结果到页面上
     * @author fangyang
     * @param {*} {commit,getters}
     * @param {*} emoji
     */
    async sendEmoji({commit,getters},emoji){
        new UserOutputMsg(commit,"<img src='"+emoji.src+"' />");
        let data = await getResultFromTuring(emoji.meanning);
        let msg = data.data.text;
        if(data.data.code !== 100000){
            msg = '看来我还需要学习来了解更多';
        }
        new AIOutputMsg(commit,msg)
    },

    /**
     * @description 轮询方法体
     * @author fangyang
     * @param {*} {commit,state}
     */
    async polling({commit,state,dispatch}){
        let data = await getPollingInfo(state.uuid);
        dispatch('switchRole',data.data.role)
        //老师回答
        if(data.data.answers.length && data.data.role){
            data.data.answers.forEach(a => new LaoshiOutPut(commit,a));
        }
    },

    /**
     * @description 开始轮询
     * @author fangyang
     * @param {*} {dispatch,commit,state}
     */
    async beginPolling({dispatch,commit,state}){
        let data = await getPollingInfo(state.uuid);
        commit('SETROLE',data.data.role);
        //进入页面时问问题后的问候语 执行1次
        if(data.data.role === 1){
            new LaoshiOutPut(commit,'源恒咨询老师 为您解答。');
            // new LaoshiOutPut(commit,'正在输入中。。。')
        }
        setInterval(() => dispatch('polling'),30000)
    },

    /**
     * @description 切换角色提醒
     * @author fangyang
     * @param {*} {state,commit}
     * @param {*} role 最新角色
     * @return \{{{Promise}}\} {{description}}{{}}
     */
    switchRole({state,commit},role){
        return new Promise(resolve => {
            if(role !== state.role){
                commit('SETROLE',role);
                if(role === 1){
                    new TipsMsg(commit,1)
                }else{
                    new TipsMsg(commit,0)
                }
            }
            resolve();
        })
    },

    async refreshPolling({dispatch}){
        setInterval(() => dispatch('polling'),30000)
    },

    sendEmail({state,commit},info){
        sendEmail({
            "uuid_key":state.uuid,
            "question":info.question,
            "email":info.email
        })
        .then(() => {
            new AIOutputMsg(commit,"发送成功，请等待老师的回复。")
        })
        .catch(err => {
            new AIOutputMsg(commit,"发送失败，请重新发送！")
        })
    }


}
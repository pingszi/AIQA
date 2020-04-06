import { getNowDate} from '../utils/utils'

import {
    GETDATAFROMLOCALSTORAGE,
    ADDQUESTION,
    ADDTOPTENQUESTION,
    ADDSESSIONITEM,
    CHANGEOUTPUTSCROLLPOSITON,
    CLEARALLMSG,
    CHANGEFONTSIZE,
    CHANGETHEME,
    SETROLE,
    SETUUID,
    SETISASKED ,
    SETISMOBILE,
    UNRESOLVETIPSCONTENT,
} from './mutation-types'

export default {

    [GETDATAFROMLOCALSTORAGE](state,json){
        state.allMsg = JSON.parse(json);
    },

    [ADDQUESTION](state,question){
        state.allMsg[state.allMsg.length-1].msg.push(question);
        if(state.isSetSessionStorage){
            window.sessionStorage.setItem('allMsg',JSON.stringify(state.allMsg));
        }
    },

    [ADDTOPTENQUESTION](state,data){
        state.topTenQuestion = data;
    },

    [ADDSESSIONITEM](state,data){
        state.allMsg.push(data);
    },

    [CHANGEOUTPUTSCROLLPOSITON](state,data){
        state.outputScrollPosition = data;
    },

    [CLEARALLMSG](state){
        let newDaySession = {
            date: getNowDate(),
            msg: []
        }
        state.allMsg = [newDaySession]
    },

    [CHANGEFONTSIZE](state,data){
        state.fontSize = data;
    },

    [CHANGETHEME](state,data){
        state.theme = data;
    },

    [SETROLE](state,data){
        state.role = data;
        if(state.isSetSessionStorage){
            window.sessionStorage.setItem('role',data);
        }
    },

    [SETUUID](state,data){
        state.uuid = data;
        if(state.isSetSessionStorage){
            window.sessionStorage.setItem('uuid',data);
        }
    },

    [SETISASKED](state,data){
        state.isQuestionAsked = data;
    },

    [SETISMOBILE](state,data){
        state.isMobile = data;
    },

    [UNRESOLVETIPSCONTENT](state,data){
        state.unResolveTipsContent = data;
    },
}
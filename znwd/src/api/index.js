require('es6-promise').polyfill();
import axios from 'axios';
import store from '../store/index'

export function getTopTenQuestion() {  
    return axios.get('/AIQA/v1/hot_question/');
}

export function getAnswer(q,qid) {  
    return axios.get('/AIQA/v1/search/?q='+ encodeURIComponent(q)+'&id='+qid);
}

export function isUnresolve(q) {  
    return axios.get('/AIQA/v1/question_unresolve/?question='+q.question+'&uuid_key='+q.uuid);
}

export function isResolve(q) {  
    return axios.get('/AIQA/v1/question_resolve/?question='+q.question+'&uuid_key='+q.uuid);
}

export function getResultFromTuring(q) {
    return axios({
        method: 'post',
        url:'http://www.tuling123.com/openapi/api',
        params: {
            'key': 'bfb9bad7b081450fb1fbfd06bfdb2619',
            'info':q,
            'userid':'253941'
        }
    })
}

export function getSuggest(q) {  
    return axios.get('/AIQA/v1/get_question/?question='+q);
}

export function askQuestions(params) {
    store.commit('SETISASKED',true)
    return axios.post(
        // '/AIQA/v1/ask_questions',
        '/AIQA/v1/search',
        {
            uuid_key:params.uuid_key,
            question:params.question,
            knowledge_id:params.knowledge_id,
            client_type:'PC'
        }
    );
}

export function getPollingInfo(uuid) {
    return axios.post('/AIQA/v1/find_answers',{
            uuid_key:uuid,
        });
}

export function sendEmail(params){
    return axios.post(
        '/AIQA/v1/unsolved_email',
        {
            uuid_key:params.uuid_key,
            question:params.question,
            email:params.email,
        }
    );
}
let Mock = require('mockjs');

let role = 0;

// setInterval(()=>{
//     role = role ? 0 : 1
// },10000);

Mock.mock('/AIQA/v1/find_answers','post',function (param) {
    let answers = [];
    let generateAnswers = () => {
        if(Math.random()<0.5){
            answers.push(Mock.Random.cparagraph(parseInt(Math.random()*9+1)))
        }
        if(Math.random()<0.5){
            generateAnswers();
        }
    }
    generateAnswers();
    return {
        role,
        answers,
        msg:'成功',
        status:1,
    }
})

Mock.mock('/AIQA/v1/ask_questions','post',function (param) {
    var params = JSON.parse(param.body);
    let uuid_key = params.uuid_key ? params.uuid_key : new Date().getTime()+'';
    let ai_answer = role ? [] : [Mock.Random.cparagraph(parseInt(Math.random()*9+1))];
    return {
        uuid_key,
        ai_answer,
        msg:'成功',
        status:1,
        role,
    }
})

//热点问题
Mock.mock('/AIQA/v1/hot_question/','get',function () {
    let list = [];
    for(let i=0; i<10; i++){
        let id = Mock.Random.natural(0,9999);

        // 去除重复id
        while(list.filter(it => it.id === id).length !== 0){
            id = Mock.Random.natural(0,9999);
        }
        let question = Mock.Random.cparagraph(1);
        list.push({
            id,
            question
        })
    }
    return list;
})
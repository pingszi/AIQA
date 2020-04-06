export default {
    
    getLatestRelativeQuestion:(state) =>(number) => {
        try {
            let q = state.allMsg.slice(-1)[0].msg.slice(-1)[0].content.relativeQuestionList[number-1].question;
            let qid = state.allMsg.slice(-1)[0].msg.slice(-1)[0].content.relativeQuestionList[number-1].id
            return [q,qid];
        } catch (error) {
            return false;
        }
    },
    
    getFilefromId:(state) => (id) => {
        let fileObj = {};
        state.allMsg.forEach(item => {
            item.msg.forEach(m => {
                if(m.content.relativeFileList){
                    m.content.relativeFileList.forEach(file => {
                        file.id == id && (fileObj = file);
                    })
                } 
            })
        })
        return fileObj;
    },

    getTheme: state => state.theme
}
<template>
    <div class="relativeQuestion">
        <h6>您可能关注以下相关问题【请输入序号查看】</h6>
        <ul name="list">
            <li v-for="(question,idx) in dataList.slice(0,3)" :key="idx">
                <a href="javascript:void(0)" @click="askQuestionHandle(question,$event)">
                    <span>{{idx+1}}、</span>
                    <span>{{question.question}}</span>
                </a>
            </li>
            <base-collapse v-for="(question,idx) in dataList.slice(3)" :key="idx">
                <li v-show="isSpread">
                    <a href="javascript:void(0)" @click="askQuestionHandle(question,$event)">
                        <span>{{idx+4}}、</span>
                        <span>{{question.question}}</span>
                    </a>
                </li>
            </base-collapse>
        </ul>
        <div v-show="dataList.length>3 && isShowSpreadBtn">
            <span class="moreFile" v-html="isSpread ? '合并':'更多'" @click="toggleSpread"></span>
        </div>
    </div>
</template>
<script>
import { mapActions, mapState } from "vuex";
import BaseCollapse from "./BaseCollapse";

export default {
    components: { BaseCollapse },

    data() {
        return {
            isSpread: !this.isHasSpread,
            isShowSpreadBtn: this.isHasSpread,
        };
    },

    computed:{
        dataList(){
            if(this.isMobile){
                return this.questionList.slice(0,5);
            }
            return this.questionList
        },
        ...mapState(['isMobile'])
    },

    props: {
        questionList: {
            type: Array
        },
        //是否可折叠
        isHasSpread: {
            type: Boolean
        }
    },

    methods: {
        askQuestionHandle(q,e) {
            $(e.target).parent('a').addClass('visited');
            this.askQuestion(q);
        },
        toggleSpread() {
            this.isSpread = !this.isSpread;
            //重置滚动条
            setTimeout(function() {
                $("#msgOutput")
                    .getNiceScroll()
                    .resize();
            }, 400);
        },
        ...mapActions(["askQuestion"])
    }
};
</script>

<style scoped lang="scss">
.theme-blue{
    .relativeQuestion {
        padding-left: 24px;
        padding-top: 5px;
        padding-bottom: 5px;
        h6 {
            color: #fabd0b;
        }
        a {
            color: inherit;
            &:hover {
                text-decoration: underline;
            }
            &.visited{
                opacity: 0.5;
            }
        }
        .moreFile {
            color: #fabd0b;
            cursor: pointer;
            text-decoration: underline;
        }
    }
}
.theme-grey{
    .relativeQuestion {
        padding-left: 24px;
        padding-top: 5px;
        padding-bottom: 5px;
        h6 {
            color: $greyThemeColor;
        }
        a {
            color: inherit;
            &:hover {
                text-decoration: underline;
            }
            &.visited{
                opacity: 0.5;
            }
        }
        .moreFile {
            cursor: pointer;
            border-bottom: 1px solid #fabd0b
        }
    }
}
</style>

<template>
    <div :style="{position:'relative',backgroundColor}">
        <div :style="style" id="msgOutput" ref="output" @click="handleOutputClick">
            <div v-for="(msg,idx) in allMsg" :key="idx">
                <p v-text="msg.date" class="nowTime"></p>
                <ul>
                    <li v-for="(item,idx1) in msg.msg" :key="idx1" :class="item.host === 'ai' ?'msgAI':'msgUser'">
                        <template v-if="item.isTips">
                            <app-window-left-output-tips :content="item.msg"/>
                        </template>
                        <template v-else>
                            <msg-time :time="item.content.time" :role="item.host" />
                            <app-window-left-output-user-icon :user="item.host" :isLaoshi="item.content.isLaoshi"/>
                            <div class="answer">
                                <div v-if="item.content.text.length!==0" v-html="item.content.text"></div>
                                <relative-file :fileList="item.content.relativeFileList" v-if="item.content.relativeFileList" :isHasSpread="true" />
                                <relative-question :questionList="item.content.relativeQuestionList" v-if="item.content.relativeQuestionList" :isHasSpread="false" />
                                <is-resolve v-if="item.content.isSetResolve" :question="item.content.question" />
                                <is-send-email v-if="item.content.isShowSendEmail" :question="item.content.question"/>
                                <i></i>
                            </div>
                        </template>
                        
                    </li>
                </ul>
            </div>
            <div class="padiingBottom"></div>
        </div>
        <i class="returnToTop" @click="scrollToTop" v-if="!isMobile"></i>
    </div>
</template>
<script>
import CssSplitLine from "./common/CssSplitLine";
import RelativeFile from "./common/RelativeFile";
import RelativeQuestion from "./common/RelativeQuestion";
import MsgTime from "./common/MsgTime";
import IsResolve from "./common/IsResolve";
import IsSendEmail from "./common/IsSendEmail";
import AppWindowLeftOutputUserIcon from "./AppWindowLeftOutputUserIcon";
import AppWindowLeftOutputTips from './AppWindowLeftOutputTips';

import { mapState } from "vuex";
import {
    scrollToBottom,
    scrollToHeight,
    getNowDate,
    getNowTime,
    formatterElScrollBar
} from "../utils/utils";

export default {
    components: {
        CssSplitLine,
        RelativeFile,
        RelativeQuestion,
        MsgTime,
        IsResolve,
        IsSendEmail,
        AppWindowLeftOutputUserIcon,
        AppWindowLeftOutputTips
    },

    props: {
        height: {
            required: true,
            type: Number
        },
        backgroundColor:{
            type: String
        },
        isMobile:{
            type: Boolean
        }
    },

    data() {
        return {
            nowTime: "",
            isMoreFileShow: false
        };
    },

    computed: {
        style() {
            return {
                height: this.height - 1 + "px",
                fontSize: this.fontSize + "px",
            };
        },
        ...mapState(["allMsg", "outputScrollPosition", "fontSize"])
    },

    mounted() {
        this.init();
        scrollToBottom();
    },

    methods: {
        init() {
            formatterElScrollBar("#msgOutput");
        },
        scrollToTop() {
            scrollToHeight(0,true);
        },
        handleOutputClick(){
            this.$emit('outputClick')
        }
    }
};
</script>
<style scoped lang="scss">
.theme-blue {
    .padiingBottom {
        height: 50px;
        width: 100%;
    }
    #msgOutput {
        background: url(../assets/background.png) no-repeat;
        background-size: 100% 100%;
        position: relative;
        line-height: 2em;
        cursor: default !important;
        .nowTime {
            text-align: center;
            color: #fdfdfd;
            font-weight: bold;
            margin-top: 20px;
            text-indent: 0;
        }
        .msgUser {
            overflow: hidden;
            padding-bottom: 20px;
            .answer {
                float: right;
                position: relative;
                top: 5px;
                max-width: 60%;
                min-width: 40px;
                margin-right: 7px;
                /* border: 1px solid #4a76c8; */
                border-radius: 10px;
                background: #fdfdfd;
                color: #244577;
                padding: 10px;
                position: relative;
                word-break:break-word;
                word-wrap:break-word; 
                // overflow:hidden;
                i {
                    width: 8px;
                    height: 7px;
                    background-image: url(../assets/aibubble.png);
                    position: absolute;
                    top: 18px;
                    right: -8px;
                }
            }
        }
        .msgAI {
            overflow: hidden;
            padding-bottom: 20px;
            .answer {
                float: left;
                max-width: 60%;
                min-width: 40px;
                word-break:break-word;
                word-wrap:break-word; 
                // overflow:hidden;
                margin-left: 7px;
                /* border: 1px solid #4a76c8; */
                border-radius: 10px;
                background: rgba(21, 82, 150, 0.4);
                color: #fff;
                position: relative;
                padding: 10px;
                i {
                    width: 8px;
                    height: 7px;
                    background-image: url(../assets/userbubble.png);
                    position: absolute;
                    top: 18px;
                    left: -7px;
                }
            }
        }
    }

    .msgAI >>> .icon {
        float: left;
        text-align: center;
        width: 60px;
        margin-left: 15px;
    }
    .msgUser >>> .icon {
        float: right;
        text-align: center;
        margin-right: 15px;
        width: 60px;
    }

    .returnToTop {
        position: absolute;
        bottom: 20px;
        right: 20px;
        height: 32px;
        width: 32px;
        background: url(../assets/return_to_top.png);
        cursor: pointer;
    }
}

.theme-grey {
    .padiingBottom {
        height: 50px;
        width: 100%;
    }
    #msgOutput {
        // background: url(../assets/background.png) no-repeat;
        background-size: 100% 100%;
        position: relative;
        line-height: 2em;
        cursor: default !important;
    }
    .nowTime {
        text-align: center;
        color: #cacaca;
        font-weight: bold;
        margin-top: 20px;
        margin-bottom: 20px;
        text-indent: 0;
    }
    .msgUser {
        overflow: hidden;
        padding-bottom: 20px;
        .answer {
            float: right;
            position: relative;
            top: 5px;
            max-width: 60%;
            min-width: 40px;
            margin-right: 7px;
            /* border: 1px solid #4a76c8; */
            border-radius: 10px;
            background: #abc1f7;
            color: #ffffff;
            padding: 10px;
            position: relative;
            word-break:break-word;
            word-wrap:break-word; 
            // overflow:hidden;
            i {
                width: 8px;
                height: 7px;
                background-image: url(../assets/grey_aibubble.png);
                position: absolute;
                top: 18px;
                right: -8px;
            }
        }
    }

    .msgAI {
        overflow: hidden;
        padding-bottom: 20px;
        .answer {
            float: left;
            position: relative;
            top:5px;
            max-width: 60%;
            min-width: 40px;
            margin-left: 7px;
            /* border: 1px solid #4a76c8; */
            border-radius: 10px;
            background: #ffffff;
            color:$greyThemeFontColor;
            position: relative;
            padding: 10px;
            word-break:break-word;
            word-wrap:break-word; 
            // overflow:hidden;
            i {
                width: 8px;
                height: 7px;
                background-image: url(../assets/grey_userbubble.png);
                position: absolute;
                top: 18px;
                left: -7px;
            }
        }
    }
    .msgAI >>> .icon {
        float: left;
        text-align: center;
        width: 60px;
        margin-left: 15px;
    }
    .msgUser >>> .icon {
        float: right;
        text-align: center;
        margin-right: 15px;
        width: 60px;
    }

    .returnToTop {
        position: absolute;
        bottom: 20px;
        right: 20px;
        height: 32px;
        width: 32px;
        background: url(../assets/grey_return_to_top.png);
        cursor: pointer;
    }
}
</style>

<template>
    <div class="relativeFile">
        <h6>您可能关注的相关税收政策文件</h6>
        <ul class="fileList" name="list">
            <li  v-for="(file,idx) in fileList.slice(0,3)" :key="idx">
                <a href="javascript:void(0)"  @click="openRelativeFilePage(file.id,$event)">
                    <span>{{idx+1}}、</span>
                    <span>{{file.articleTitle}}</span>
                </a>
            </li>
            <base-collapse v-for="(file,idx) in fileList.slice(3)" :key="idx">
                <li v-show="isSpread">
                    <a href="javascript:void(0)"  @click="openRelativeFilePage(file.id,$event)">
                        <span>{{idx+4}}、</span>
                        <span>{{file.articleTitle}}</span>
                    </a>
                </li>
            </base-collapse>
        </ul>
        <div v-show="fileList.length>3 && isShowSpreadBtn">
            <span class="moreFile" v-html="isSpread ? '合并':'更多'" @click="toggleSpread"></span>
        </div>
    </div>
</template>
<script>
import BaseCollapse from './BaseCollapse';
import {scrollToBottom} from '../../utils/utils'
import { mapMutations, mapState } from 'vuex'

export default {
    components:{BaseCollapse,},
    
    data(){
        return {
            isSpread:!this.isHasSpread,
            isShowSpreadBtn:this.isHasSpread,
        }
    },

    props:{
        //接收相关政策文件数据
        fileList:{
            type:Array
        },
        //是否可折叠
        isHasSpread:{
            type:Boolean
        }
    },

    computed:{
        ...mapState(['isMobile'])
    },

    methods: {
        toggleSpread(){
            this.isSpread = !this.isSpread;
            //重置滚动条
            setTimeout(function () {  
                $("#msgOutput").getNiceScroll().resize();
            },400)
        },
        openRelativeFilePage(id,e){
            $(e.target).parent('a').addClass('visited')
            this.CHANGEOUTPUTSCROLLPOSITON($('#msgOutput')[0].scrollTop);
            if(this.isMobile){
                this.$router.push('mFile/'+id);
            }else{
                this.$router.push('file/'+id);
            }
        },
        ...mapMutations(['CHANGEOUTPUTSCROLLPOSITON'])
    }
}
</script>
<style scoped lang="scss">
.theme-blue{
    .relativeFile{
        padding-left: 24px;
        h6{
            color:#fabd0b
        }
        a{
            color:inherit;
            &:hover{
                text-decoration: underline
            }
            &.visited{
                opacity: 0.5;
            }
        }
        .moreFile{
            color:#fabd0b;
            cursor: pointer;
            text-decoration: underline;
        }
    }
}
.theme-grey{
    .relativeFile{
        padding-left: 24px;
        h6{
            color:$greyThemeColor
        }
        a{
            color:inherit;
            &:hover{
                text-decoration: underline
            }
            &.visited{
                opacity: 0.5;
            }
        }
        .moreFile{
            cursor: pointer;
            border-bottom: 1px solid #fabd0b
        }
    }
}
</style>
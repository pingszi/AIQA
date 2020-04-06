<template>
    <div>
        <div id="content" class="content" :style="{height:windowHeight+'px'}">
            <h3 v-html="fileObj.articleTitle"></h3>
            <div v-html="fileObj.articleContent" class="fileContent"></div>
            <!-- <router-link class="returnIndex" to="/mIndex">返回</router-link> -->
        </div>
    </div>
</template>
<script>
import TheHeader from '../components/TheHeader'
import {mapGetters} from 'vuex'
import {scrollResize} from '../utils/utils'

export default {
    data() {
        return {
            headerHeight: 60,
            borderBottomWidth: 3,
            windowHeight:window.innerHeight
        }
    },
    computed:{
        appWindowHeight() {
            return this.windowHeight - this.headerHeight - this.borderBottomWidth
        },
        fileObj(){
            return this.getFilefromId(this.$route.params.id);
        },
        ...mapGetters(['getFilefromId'])
    },
    mounted(){
        $('#content').niceScroll({
                cursorcolor: "rgb(22, 120, 163)",
                cursorwidth: "5px",
                cursorborder: 'none'
            });

        window.onresize = this.resize
    },
    methods:{
        resize(){
            this.windowHeight = window.innerHeight
        }
    },
    components:{TheHeader, },
}
    
</script>
<style scoped lang="scss">
.theme-blue{
    .content{
        padding:15px;
        background: rgb(22, 61, 119);
        overflow: hidden;
        .fileContent{
            color:#fdfdfd;
            // width: 800px;
            margin: 0 auto;
            padding-bottom: 50px;
        }
        h3{
            // width: 800px;
            margin: 0 auto;
            text-align: center;
            font-size: 18px;
            color:#fdfdfd;
            height: 74xp;
            line-height: 74px;
        }
        .returnIndex{
            width: 116px;
            height: 44px;
            border: 2px solid transparent;
            text-align: center;
            line-height: 44px;
            cursor: pointer;
            margin-right: 10px;
            float: right;
            border-radius: 5px;
            color: #fdfdfd;
            font-size: 16px;
            border-color: #4a76c8;
            background: #65a1e7;
            position: fixed;
            bottom: 20px;
            right: 100px;
        }
    }
}

.theme-grey{
    .content{
        padding:15px;
        background:$greyThemeBgColor;
        overflow: hidden;
        .fileContent{
            color:$greyThemeFontColor;
            // width: 800px;
            margin: 0 auto;
            padding-bottom: 50px;
        }
        h3{
            // width: 800px;/
            margin: 0 auto;
            text-align: center;
            font-size: 18px;
            color:$greyThemeFontColor;
            height: 74xp;
            line-height: 74px;
        }
        .returnIndex{
            width: 116px;
            height: 44px;
            border: 2px solid transparent;
            text-align: center;
            line-height: 44px;
            cursor: pointer;
            margin-right: 10px;
            float: right;
            border-radius: 5px;
            color: #fdfdfd;
            font-size: 16px;
            border-color: #ffffff;
            background: #336CA1;
            position: fixed;
            bottom: 20px;
            right: 100px;
            &:hover{
                background: #265988;
            }
        }
    }
}


</style>

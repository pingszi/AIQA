<template>
    <div class="wrap" >
        <!-- <transition-group name="flip-list" tag="div"> -->
            <i @click="isFontSizeSelectShow = !isFontSizeSelectShow" key="1" class="fontSizeSelect"></i>
            <select 
                :value="fontSize" 
                :style="{width:isFontSizeSelectShow?'39px':'0px',opacity:isFontSizeSelectShow?1:0,borderWidth:isFontSizeSelectShow?'1px':0}" 
                @change="handleChange"
                key="2">
                <option value="12">12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
                <option value="19">19</option>
                <option value="20">20</option>
                <option value="21">21</option>
                <option value="22">22</option>
            </select>
            <!-- <i @click="isEmojiShow = !isEmojiShow"  key="3" class="smileFace"></i> -->
         <!-- </transition-group> -->
        <!-- <yh-emoji left="2px" bottom="42px" v-show="isEmojiShow" @clickEmoji="handleClickEmoji"/> -->
    </div>
</template>
<script>
import {mapState,mapMutations, mapActions} from 'vuex';
import YhEmoji from './emoji/index.vue';

export default {
    components:{YhEmoji,},

    data(){
        return {
            isFontSizeSelectShow:false,
            isEmojiShow:false,
        }
    },

    computed:{
        ...mapState(['fontSize'])
    },

    methods:{
        handleChange(evt){
            this.CHANGEFONTSIZE(evt.target.value)
        },
        handleClickEmoji(data){
            this.sendEmoji(data)
        },
        ...mapMutations(['CHANGEFONTSIZE']),
        ...mapActions(['sendEmoji'])
    },

    mounted(){
        let self = this;
        document.addEventListener('click',function (evt) { 
            if(evt.target.className !== 'smileFace'){
                self.isEmojiShow = false;
            }
        })
    }
}
</script>
<style scoped lang="scss">
.theme-blue {
    .wrap{
        height: 40px;
        background:#18518f;
        border-bottom: 1px solid #1678a3;
        border-top: 1px solid #1678a3;
        line-height: 40px;
        padding-left: 10px;
        position: relative;
        cursor: default;
        i{
            margin: 4px 0px;
            cursor: pointer;
            height: 32px;
            width: 32px;
            &.fontSizeSelect{
                background:url(../assets/font_size.png) no-repeat 
            }
            &.smileFace{
                background:url(../assets/smile_face.png) no-repeat 
            }
        }
        select{
            border-radius: 8px;
            height: 32px;
            position: relative;
            top: -16px;
            background: #d9e5fc;
            transition: all .3s;
        }
    }
}
.theme-grey {
    .wrap{
        height: 40px;
        border-bottom: 1px solid $greyThemeBorderColor;
        border-top: 1px solid $greyThemeBorderColor;
        line-height: 40px;
        padding-left: 10px;
        position: relative;
        cursor: default;
        i{
            margin: 4px 0px;
            cursor: pointer;
            height: 32px;
            width: 32px;
            &.fontSizeSelect{
                background:url(../assets/grey_font_size.png) no-repeat 
            }
            &.smileFace{
                background:url(../assets/grey_smile_face.png) no-repeat 
            }
        }
        select{
            border-radius: 8px;
            height: 32px;
            position: relative;
            top: -16px;
            background: #d9e5fc;
            transition: all .3s;
        }
    }
}
    /* .flip-list-move {
        transition: transform .3s;
    } */
</style>



<template>
    <div class="icon">
        <div v-if="user === 'ai'">
            <!-- <img src="../assets/ai.png" alt=""> -->
            <div class="aiIconImg">
                <div class="laoshi" v-if="isLaoshi"></div>
            </div>
            <p class="ainame"><span>{{isLaoshi ? '咨询老师':'小穗'}}</span></p>
        </div>
        <div v-else>
            <!-- <img src="../assets/user.png" alt=""> -->
            <div class="userIconImg"></div>
            <p class="username">我</p>
        </div>
    </div>
</template>
<script>

export default {
    props:{
        user:{
            required:true,
            type:String
        },
        isLaoshi:{
            default:false,
            type:Boolean
        }
    }
}
</script>
<style scoped lang="scss">
.theme-blue{
    .icon{
        font-size: 13px;
        .username{
            width: 52px;
            text-indent: 0;
            text-align: center;
            color: #a4b4f3;
        }
        .ainame{
            width: 52px;
            text-indent: 0;
            text-align: center;
            color: #a4b4f3;
        }
        .aiIconImg{
            width: 52px;
            height: 52px;
            background: url(../assets/ai.png) no-repeat;
            background-size:100% 100%; 
            .laoshi{
                width:100%;
                height: 100%;
                background: url(../assets/laoshi.png) no-repeat;
            }
        }
        .userIconImg{
            width: 52px;
            height: 52px;
            background-size:100% 100%; 
            background: url(../assets/user.png) no-repeat;
        }
    }
}
.theme-grey{
    .icon{
        font-size: 13px;
        .ainame{
            width: 52px;
            text-indent: 0;
            text-align: center;
            color: $greyThemeFontColor;
            position: relative;
        }
        .username{
           width: 52px;
            text-indent: 0;
            text-align: center;
            color: $greyThemeFontColor;
            position: relative;
            left: 8px; 
        }
        .aiIconImg{
            width: 52px;
            height: 52px;
            background-size:100% 100%; 
            background: url(../assets/grey_ai.png) no-repeat;
            .laoshi{
                width:100%;
                height: 100%;
                background: url(../assets/laoshi.png) no-repeat;
            }
        }
        .userIconImg{
            width: 52px;
            height: 52px;
            position: relative;
            left: 8px; 
            background-size:100% 100%; 
            background: url(../assets/grey_user.png) no-repeat right;
        }
    }
}
</style>


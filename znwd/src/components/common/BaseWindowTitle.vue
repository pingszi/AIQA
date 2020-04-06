<template>
    <div>
        <div class="title" v-text="title"></div>
    </div>
</template>
<script>
import CssSplitLine from './CssSplitLine'
export default {
    props:{
        "title":{
            required:true,
            type:String
        }
    },
    components:{CssSplitLine}
}
    
</script>
<style scoped lang="scss">
.theme-blue{
    .title{
        background: #154285;
        height: 38px;
        width: 147px;
        text-align: center;
        line-height: 38px;
        font-size: 18px;
        color: #fdfdfd;
        font-weight: bold;
    }
}
.theme-grey{
    .title{
        height: 38px;
        width: 147px;
        text-align: center;
        line-height: 38px;
        font-size: 18px;
        color: #608af6;
        font-weight: bold;
        border-bottom: 3px solid #608af6;
    }
}
</style>

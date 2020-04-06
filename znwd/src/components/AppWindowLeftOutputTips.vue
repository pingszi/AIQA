<template>
    <div class="wrap">
        <span class="tips">
            <img src="../assets/tips.png" alt="">
            <span v-html="content"></span>
        </span>
    </div>
</template>
<script>
export default {
    props:{
        content:{
            require:true,
            type:String
        }
    }
}
</script>
<style scoped lang="scss">
.wrap {
    text-align: center;
    padding: 5px;
    .tips{
        display: inline-block;
        background: #e7f1e5;
        border: 1px solid #ccc;
        padding: 2px 10px;
        border-radius: 10px;
        img{
            height: 16px;
            position: relative;
            top: 3px;
            padding-right: 5px;
        }
    }
}
</style>

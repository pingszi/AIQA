<template>
    <div class="msgTime">
        <span v-html="time"></span>
    </div>
</template>
<script>
export default {
    props:{
        time:{
            required:true,
            type:String
        },
        role:{
            type:String
        }
    }
}
</script>
<style scoped>
.msgTime{
    text-align: center;
    padding-top: 5px;
    margin-right: 2px;
    color: #cacaca;
}
</style>

<template>
    <div class="content" :style="style">
        <ul>
            <li v-for="(item,idx) in emojiList" :key="idx" @click="handleEmoji(item)">
                <img :src="item.src" :alt="item.meanning" :title="item.meanning" >
            </li>
        </ul>
    </div>
</template>
<script>
/**
 * @prop {string} top 距离定位父元素上边框距离
 * @prop {string} left 距离定位父元素左边框距离
 * @prop {string} right 距离定位父元素右边框距离
 * @prop {string} bottom 距离定位父元素下边框距离
 * @prop {boolean required} isEmojiShow 距离定位父元素下边框距离
 * @event clickEmoji 点击单个emoji表情事件
 */
export default {
    data() {
        return {
            emojiList: [
                { 'meanning': "微笑", 'src': require('./img/weixiao.gif') },
                { 'meanning': "撇嘴", 'src': require('./img/piezui.gif') },
                { 'meanning': "色", 'src': require('./img/se.gif') },
                { 'meanning': "吓", 'src': require('./img/xia.gif') },
                { 'meanning': "流泪", 'src': require('./img/liulei.gif') },
                { 'meanning': "害羞", 'src': require('./img/haixiu.gif') },
                { 'meanning': "闭嘴", 'src': require('./img/bizui.gif') },
                { 'meanning': "睡", 'src': require('./img/shui.gif') },
                { 'meanning': "大哭", 'src': require('./img/daku.gif') },
                { 'meanning': "尴尬", 'src': require('./img/ganga.gif') },
                { 'meanning': "发怒", 'src': require('./img/fanu.gif') },
                { 'meanning': "调皮", 'src': require('./img/tiaopi.gif') },
                { 'meanning': "呲牙", 'src': require('./img/ciya.gif') },
                { 'meanning': "惊讶", 'src': require('./img/jingya.gif') },
                { 'meanning': "难过", 'src': require('./img/nanguo.gif') },
                { 'meanning': "酷", 'src': require('./img/ku.gif') },
                { 'meanning': "冷汗", 'src': require('./img/lenghan.gif') },
                { 'meanning': "抓狂", 'src': require('./img/zhuakuang.gif') },
                { 'meanning': "吐", 'src': require('./img/tu.gif') },
                { 'meanning': "偷笑", 'src': require('./img/touxiao.gif') },
                { 'meanning': "可爱", 'src': require('./img/keai.gif') },
                { 'meanning': "白眼", 'src': require('./img/baiyan.gif') },
                { 'meanning': "傲慢", 'src': require('./img/aoman.gif') },
                { 'meanning': "饥饿", 'src': require('./img/jie.gif') },
                { 'meanning': "困", 'src': require('./img/kun.gif') },
                { 'meanning': "惊恐", 'src': require('./img/jingkong.gif') },
                { 'meanning': "流汗", 'src': require('./img/liuhan.gif') },
                { 'meanning': "憨笑", 'src': require('./img/hanxiao.gif') },
                { 'meanning': "大兵", 'src': require('./img/dabing.gif') },
                { 'meanning': "奋斗", 'src': require('./img/fendou.gif') },
                { 'meanning': "咒骂", 'src': require('./img/zhouma.gif') },
                { 'meanning': "疑问", 'src': require('./img/yiwen.gif') },
                { 'meanning': "嘘", 'src': require('./img/xu.gif') },
                { 'meanning': "晕", 'src': require('./img/yun.gif') },
                { 'meanning': "折磨", 'src': require('./img/zhemo.gif') },
                { 'meanning': "衰", 'src': require('./img/shuai.gif') },
                { 'meanning': "骷髅", 'src': require('./img/kulou.gif') },
                { 'meanning': "敲打", 'src': require('./img/qiaoda.gif') },
                { 'meanning': "再见", 'src': require('./img/zaijian.gif') },
                { 'meanning': "擦汗", 'src': require('./img/cahan.gif') },
                { 'meanning': "抠鼻", 'src': require('./img/koubi.gif') },
                { 'meanning': "鼓掌", 'src': require('./img/guzhang.gif') },
                { 'meanning': "糗大了", 'src': require('./img/qiudale.gif') },
                { 'meanning': "坏笑", 'src': require('./img/huaixiao.gif') },
                { 'meanning': "左哼哼", 'src': require('./img/zuohengheng.gif') },
                { 'meanning': "右哼哼", 'src': require('./img/youhengheng.gif') },
                { 'meanning': "哈欠", 'src': require('./img/haqian.gif') },
                { 'meanning': "鄙视", 'src': require('./img/bishi.gif') },
                { 'meanning': "委屈", 'src': require('./img/weiqu.gif') },
                { 'meanning': "快哭了", 'src': require('./img/kuaikule.gif') },
                { 'meanning': "阴险", 'src': require('./img/yinxian.gif') },
                { 'meanning': "亲亲", 'src': require('./img/qinqin.gif') },
                { 'meanning': "吓", 'src': require('./img/xia.gif') },
                { 'meanning': "可怜", 'src': require('./img/kelian.gif') },
                { 'meanning': "菜刀", 'src': require('./img/caidao.gif') },
                { 'meanning': "西瓜", 'src': require('./img/xigua.gif') },
                { 'meanning': "啤酒", 'src': require('./img/pijiu.gif') },
                { 'meanning': "篮球", 'src': require('./img/lanqiu.gif') },
                { 'meanning': "乒乓球", 'src': require('./img/pingpang.gif') },
                { 'meanning': "咖啡", 'src': require('./img/kafei.gif') },
                { 'meanning': "饭", 'src': require('./img/fan.gif') },
                { 'meanning': "猪头", 'src': require('./img/zhutou.gif') },
                { 'meanning': "玫瑰", 'src': require('./img/meigui.gif') },
                { 'meanning': "凋谢", 'src': require('./img/diaoxie.gif') },
                { 'meanning': "示爱", 'src': require('./img/shiai.gif') },
                { 'meanning': "爱心", 'src': require('./img/aixin.gif') },
                { 'meanning': "心碎", 'src': require('./img/xinsui.gif') },
                { 'meanning': "蛋糕", 'src': require('./img/dangao.gif') },
                { 'meanning': "闪电", 'src': require('./img/shandian.gif') },
                { 'meanning': "炸弹", 'src': require('./img/zhadan.gif') },
                { 'meanning': "刀", 'src': require('./img/dao.gif') },
                { 'meanning': "足球", 'src': require('./img/zuqiu.gif') },
                { 'meanning': "瓢虫", 'src': require('./img/piaochong.gif') },
                { 'meanning': "便便", 'src': require('./img/bianbian.gif') },
                { 'meanning': "月亮", 'src': require('./img/yueliang.gif') },
                { 'meanning': "太阳", 'src': require('./img/taiyang.gif') },
                { 'meanning': "礼物", 'src': require('./img/liwu.gif') },
                { 'meanning': "拥抱", 'src': require('./img/yongbao.gif') },
                { 'meanning': "强", 'src': require('./img/qiang.gif') },
                { 'meanning': "弱", 'src': require('./img/ruo.gif') },
                { 'meanning': "握手", 'src': require('./img/woshou.gif') },
                { 'meanning': "OK", 'src': require('./img/ok.gif') },
                { 'meanning': "NO", 'src': require('./img/no.gif') },
                { 'meanning': "抱拳", 'src': require('./img/baoquan.gif') },
            ]
        }
    },

    props: {
        top: {
            type: String,
        },
        left: {
            type: String,
        },
        bottom: {
            type: String,
        },
        right: {
            type: String,
        },
    },

    computed: {
        style() {
            let position = {};
            this.top && (position.top = this.top);
            this.left && (position.left = this.left);
            this.bottom && (position.bottom = this.bottom);
            this.right && (position.right = this.right);
            return position;
        }
    },

    methods:{
        handleEmoji(item){
            this.$emit('clickEmoji',item);
        }
    }
}
</script>
<style scoped>
.content {
  position: absolute;
  width: 420px;
  height: 168px;
  /* background: url(./img/bg.png) no-repeat; */
  background: #fdfdfd;
  padding-top: 2px;
  padding-bottom: 2px;
  cursor: default;
}
.content ul{
    overflow: hidden;
}
.content li {
  float: left;
  width: 30px;
  height: 28px;
  background: #fdfdfd;
  transition: all .2s
}
.content li:hover{
    background: #efefef;
    transform: translateY(-2px)
}
.content li img{
    display: block;
    cursor: pointer;
    margin: 2px auto;
}
</style>


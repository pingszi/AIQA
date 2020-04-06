import Vue from 'vue'
import 'jquery'
import 'jquery.nicescroll'

export function scrollToBottom () {
    Vue.nextTick(function() {
        $("#msgOutput").getNiceScroll().resize();
        $("#msgOutput").getNiceScroll(0).doScrollTop($('#msgOutput')[0].scrollHeight, 1000);
    })
}

export function scrollResize() {
    $("#msgOutput").getNiceScroll().resize();
}

export function scrollToHeight(height,isAnimate) {  
    Vue.nextTick(function() {
        if(isAnimate){
            $("#msgOutput").getNiceScroll().resize();
            $("#msgOutput").getNiceScroll(0).doScrollTop(height, 1000);
        }else{
            $("#msgOutput").scrollTop(height);
        }
    })
}


export function getNowTime() {  
    let now = new Date();
    let hour = now.getHours()<10 ? '0'+now.getHours() : now.getHours();
    let minute = now.getMinutes()<10 ? '0'+now.getMinutes() : now.getMinutes();
    let second = now.getSeconds()<10 ? '0'+now.getSeconds() : now.getSeconds();
    return hour+':'+minute+':'+second
}

export function getNowDate() {  
    let now = new Date();
    let year = now.getFullYear();
    let month= now.getMonth()<10 ? '0'+ (now.getMonth()+1) : (now.getMonth()+1);
    let day = now.getDate()<10 ? '0'+now.getDate() : now.getDate();
    return year+'-'+month+'-'+day
}

export function formatterElScrollBar(selector) {  
    $(selector).niceScroll({
        cursorcolor: "rgb(22, 120, 163)",
        cursorwidth: "5px",
        cursorborder: "none"
    });
}

export var mobile_bs = {
    versions: function() {
        var u = navigator.userAgent;
        return {
            trident: u.indexOf('Trident') > -1, //IE内核
            presto: u.indexOf('Presto') > -1,  //opera内核
            webKit: u.indexOf('AppleWebKit') > -1,  //苹果、谷歌内核
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,  //火狐内核
            mobile: !! u.match(/AppleWebKit.*Mobile.*/) || !! u.match(/AppleWebKit/) && u.indexOf('QIHU') && u.indexOf('QIHU') > -1 && u.indexOf('Chrome') < 0,  //是否为移动终端
            ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),  //ios终端
            android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1,  //android终端或者uc浏览器
            iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1,   //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1,     //是否iPad
            webApp: u.indexOf('Safari') == -1   //是否web应该程序，没有头部与底部
        }
    } ()
};
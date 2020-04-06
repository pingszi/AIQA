import Vue from 'vue'

Vue.filter('deleteEmptyLine', function (value) {
    if (!value) return ''
    value = value.toString().replace(/[\n\r]+/g,'\n');
    return value;
})
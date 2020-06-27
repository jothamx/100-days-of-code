import Vue from 'vue'
import App from './App.vue'

Vue.config.productionTip = false

new Vue({
    /*
    CLI生成的render: h => h(App) 等价于下面的表达式
    render:function(createElement){
        return createElement(App);
    },
    */
  render: h => h(App),
}).$mount('#app')

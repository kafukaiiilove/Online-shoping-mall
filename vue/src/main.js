import Vue from 'vue'
import axios from 'axios'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import '@/assets/css/global.css'
import '@/assets/css/theme/index.css'
import request from "@/utils/request";

// 全局事件总线
Vue.prototype.$eventBus = new Vue();

Vue.prototype.$eventBus.$on('addressUpdated', ({ address, phone, name }) => {
    console.log('接收到地址更新:', { address, phone, name });
    const user = JSON.parse(localStorage.getItem('xm-user') || '{}');
    user.address = address;
    user.phone = phone;
    user.name = name;
    localStorage.setItem('xm-user', JSON.stringify(user));
  });
  
  
  

// 配置 Axios 基础 URL
axios.defaults.baseURL = 'http://localhost:9090'; // 修改为实际 URL
Vue.prototype.$axios = axios; // 挂载 axios 到 Vue 实例

// 挂载自定义 request 工具和基础 URL
Vue.prototype.$request = request;
Vue.prototype.$baseUrl = process.env.VUE_APP_BASEURL;

// 配置 Vue
Vue.config.productionTip = false;

// 使用 ElementUI，设置默认尺寸
Vue.use(ElementUI, { size: "small" });

// 初始化 Vue 实例
new Vue({
  router,
  render: h => h(App),
}).$mount('#app');

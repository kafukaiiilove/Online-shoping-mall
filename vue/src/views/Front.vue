<template>
  <div>
    <!--头部-->
    <div class="front-header">
      <div class="front-header-left" @click="navTo('/front/home')" >
        <img src="@/assets/imgs/456.png" alt="">

        <div class="title-container" style="display: flex; align-items: center;">
  <!-- 购物商城使用title类的样式 -->
  <div class="title" style="margin-right: 20px;">购物商城</div>

  <!-- 亲，请登录使用普通的样式 -->
     <el-text v-if="!user.username" class="hover-text" style="cursor: pointer; color: red;" @click="handleClick">亲，请登录</el-text>
     <el-text v-if="!user.username" class="hover-text" style="cursor: pointer; margin-left: 10px;" @click="goToRegister">免费注册</el-text>

</div>
      </div>
      <div class="front-header-center" style="text-align: right; color:darkgray">
        <div user.username>
          <el-text class="hover-text" style="margin-right: 20px; cursor: pointer;" @click="handleClick">首页 </el-text>
          <el-text class="hover-text" style="margin-right: 20px;"   @click="navTo('/front/orders')">
            我的订单
            <span v-if="ordersData.length">{{ ordersData.length }}</span> <!-- 只有在 ordersData 有数据时才显示数量 -->
          </el-text>
          <el-text class="hover-text" style="margin-right: 20px;" @click="navTo('/front/cart')">
  <img src="@/assets/imgs/购物车.png" alt="购物车" style="height: 15px; width: 15px; position: relative; top: 2px; left: 2px;">
  购物车
  <span v-if="goodsData.length">{{ goodsData.length }}</span> <!-- 只有在 goodsData 有数据时才显示数量 -->
</el-text>

          <el-text class="hover-text" style="margin-right: 20px;"   @click="navTo('/front/collect')">
            收藏夹
            <span v-if="collectData.length">{{ collectData.length }}</span> <!-- 只有在 collectData 有数据时才显示数量 -->
          </el-text>
          <el-text class="hover-text" style="margin-right: 20px;"   @click="handleClick">商家支持</el-text>
          <el-text class="hover-text" style="margin-right: 20px;"   @click="handleClick">联系客服</el-text>
          <el-text class="hover-text" style="margin-right: 20px;"   @click="handleClick">帮助中心</el-text>
        </div>
        <div >
          <el-dropdown v-if="user && user.username">
            <div class="front-header-dropdown">
              <img @click="navTo('/front/person')" :src="user.avatar" alt="">
              <div style="margin-left: 10px">
               <i class="el-icon-arrow-down" style="margin-left: 5px"></i>
              </div>
            </div>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>
                <div style="text-decoration: none" @click="navTo('/front/cart')">我的购物车</div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div style="text-decoration: none" @click="navTo('/front/collect')">我的收藏</div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div style="text-decoration: none" @click="navTo('/front/address')">我的地址</div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div style="text-decoration: none" @click="navTo('/front/orders')">我的订单</div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div style="text-decoration: none" @click="logout">退出登录</div>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>
    <!--主体-->
    <div class="main-body">
      <router-view ref="child" @update:user="updateUser" />
    </div>
  </div>

</template>

<script>

import { MessageBox } from 'element-ui';

export default {
  name: "FrontLayout",

  data () {
    return {
      top: '',
      notice: [],
      ordersData: [],
      collectData: [],
      goodsData: [],
      user: JSON.parse(localStorage.getItem("xm-user") || '{}'),
      name: null
    }
  },

  mounted() {
     // 监听全局事件
    this.$eventBus.$on('updateCart', this.loadGoods);
    this.$eventBus.$on('updateCollect', this.loadCollect);
    this.$eventBus.$on('updateOrders', this.loadOrders);
    this.loadGoods(1);
    this.loadCollect(1);
    this.loadOrders(1);
    this.refreshData();
  },

  methods: {
    loadGoods(pageNum) {
    const user = JSON.parse(localStorage.getItem("xm-user") || '{}');
    if (!user || Object.keys(user).length === 0) {
      this.goodsData = [];
      return;
    }
    this.$request.get('/cart/selectPage', {
      params: { pageNum, pageSize: this.pageSize },
    }).then(res => {
      if (res.code === '200') {
        this.goodsData = res.data?.list;
      } else {
        this.$message.error(res.msg);
      }
    });
  },
  loadCollect(pageNum) {
    const user = JSON.parse(localStorage.getItem("xm-user") || '{}');
    if (!user || Object.keys(user).length === 0) {
      this.collectData = [];
      return;
    }
    this.$request.get('/collect/selectPage', {
      params: { pageNum, pageSize: this.pageSize },
    }).then(res => {
      if (res.code === '200') {
        this.collectData = res.data?.list;
      } else {
        this.$message.error(res.msg);
      }
    });
  },
  loadOrders(pageNum) {
    const user = JSON.parse(localStorage.getItem("xm-user") || '{}');
    if (!user || Object.keys(user).length === 0) {
      this.ordersData = [];
      return;
    }
    this.$request.get('/orders/selectPage', {
      params: { pageNum, pageSize: this.pageSize },
    }).then(res => {
      if (res.code === '200') {
        this.ordersData = res.data?.list;
      } else {
        this.$message.error(res.msg);
      }
    });
  },
    loadGoods(pageNum) {
  // 检查用户是否已登录
  const user = JSON.parse(localStorage.getItem("xm-user") || '{}');
  
  // 如果用户未登录，清空 goodsData，停止执行
  if (!user || Object.keys(user).length === 0) {
    this.goodsData = [];  // 清空 goodsData
    return;  // 停止继续执行加载操作
  }

  // 用户已登录，继续请求购物车数据
  if (pageNum) this.pageNum = pageNum;
  this.$request.get('/cart/selectPage', {
    params: {
      pageNum: this.pageNum,
      pageSize: this.pageSize,
    }
  }).then(res => {
    if (res.code === '200') {
      this.goodsData = res.data?.list;
      this.total = res.data?.total;
    } else {
      this.$message.error(res.msg);
    }
  });
},

    loadNotice() {
      this.$request.get('/notice/selectAll').then(res => {
        this.notice = res.data
        let i = 0
        if (this.notice && this.notice.length) {
          this.top = this.notice[0].content
          setInterval(() => {
            this.top = this.notice[i].content
            i++
            if (i === this.notice.length) {
              i = 0
            }
          }, 2500)
        }
      })
    },
    handleClick() {
  // 判断用户是否已经登录（通过 localStorage 中的 xm-user 判断）
  const user = localStorage.getItem("xm-user");

  if (user) {
    // 如果已登录，跳转到 /front/home 页面
    this.$router.push('/front/home');
  } else {
    // 如果未登录，跳转到登录页面
    this.$router.push('/login');
  }
},
    updateUser() {
      this.user = JSON.parse(localStorage.getItem('xm-user') || '{}')   // 重新获取下用户的最新信息
    },
    navTo(url) {
  // 判断用户是否登录
  const user = localStorage.getItem("xm-user");

  // 如果没有登录，跳转到登录页面
  if (!user) {
    this.$router.push('/login');
  } else {
    // 如果已登录，跳转到指定的 URL
    location.href = url;
  }
},
    // 退出登录
    logout() {
      MessageBox.confirm('你确认要退出吗？', '确认退出', {
        confirmButtonText: '确认',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 用户点击确认后，执行退出操作
        localStorage.removeItem("xm-user");
        this.$router.push("/login");
      }).catch(() => {
        // 用户点击取消时，什么都不做，返回
        console.log('取消退出');
      });
    },
    goToRegister() {
    // 如果是注册链接，直接跳转到注册页面
    this.$router.push('/register');
  },
    search() {
      let name = this.name ? this.name : ''
      location.href = '/front/search?name=' + name
    }
  }
}
</script>
<style scoped>
  @import "@/assets/css/front.css";
  .hover-text:hover {
  color: red;
}
</style>
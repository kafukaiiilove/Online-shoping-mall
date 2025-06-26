<template>
  <div class="main-content">
    <div style="height: 60px; background: linear-gradient(to right, #FFF8DC, #FFEFD5); display: flex; align-items: center; overflow: hidden; position: relative; border-radius: 15px;">
      <div class="announcement-container">
        <div class="announcement-content">
          <div class="announcement-wrapper">
            <span v-for="(item, index) in announcements" :key="index" class="announcement-item">
              {{ item }}
            </span>
          </div>
        </div>
      </div>
    </div>
    <div style="display: flex; justify-content: center;">
      <div class="left"></div>
      <div style="width: 86%; background-color: white; margin-bottom: 50px">

        
        <!-- 天猫Gif -->
        <div style="display: flex; flex: 0 1 auto; align-items: center; justify-content: space-between; margin-top: 5px;">
  <!-- 天猫Gif -->
  <div style="position: relative; height: 100px; overflow: hidden; width: 150px;margin-left: 40px;">
    <a href="/front/home">
      <img src="http://localhost:9090/files/1733909633270-456.png" alt="" style="width: 100%; height: 100%; object-fit: cover; border-radius: 50px;" @load="logImageLoad">
    </a>
  </div>

  <!-- 搜索框 -->
  <div style="display: flex; flex: auto; margin-left: 11%; margin-right: 24%; max-width: auto; align-items: center; height: 50px; border: 2px solid red; border-radius: 15px; padding: 5px;">
            <!-- 输入框 -->
            <input
              type="text"
              v-model="name"
              placeholder="请输入宝贝名称"
              style="flex-grow: 1; padding: 0 10px; font-size: 16px; border: none; outline: none; background: none; color: #333;">
            <!-- 搜索按钮 -->  
            <el-button
              type="danger"
              style="padding: 0 20px; height: 40px; font-size: 16px; border-radius: 10px;"
              @click="search">
              搜索
            </el-button>

</div>
</div>



          <!-- 中间大div -->
        <div style="display: flex; margin: 0 25px; height: 550px">
          <!-- 左侧分类内容 -->
          <div style="flex: 2; border-radius: 15px; margin-top: 10px">
            <div style="display: flex; color: #666666FF; margin: 14px 0" v-for="item in typeData" :key="item.id">
              <img :src="item.img" alt="" style="height: 20px; width: 20px;margin-left: 20px;">
              <div style="margin-left: 10px; font-size: 14px">
                <a href="#" @click="navTo('/front/type?id=' + item.id)">{{ item.name }}</a>
              </div>
            </div>
          </div>

          <!-- 中间轮播图 -->
          <div style="flex: 5; margin-top: 20px; border-radius: 10px;margin-left: 20px;margin-right: 20px;">
            <div>
              <el-carousel height="300px" style="border-radius: 10px">
                <el-carousel-item v-for="item in carousel_top" :key="item">
                  <img :src="item" alt="" style="width: 100%; height: 300px; border-radius: 15px">
                </el-carousel-item>
              </el-carousel>
            </div>

            <!-- 侧边轮播图 -->
            <div style="margin-top: 30px; display: flex">
              <div style="flex: 1">
                <el-carousel height="300px" style="border-radius: 10px">
                  <el-carousel-item v-for="item in carousel_left" :key="item">
                    <img :src="item" alt="" style="width: 100%; height: 200px; border-radius: 15px">
                  </el-carousel-item>
                </el-carousel>
              </div>
              <div style="flex: 1; margin-left: 5px">
                <el-carousel height="300px" style="border-radius: 10px">
                  <el-carousel-item v-for="item in carousel_right" :key="item">
                    <img :src="item" alt="" style="width: 100%; height: 200px; border-radius: 15px">
                  </el-carousel-item>
                </el-carousel>
              </div>
            </div>
          </div>

          <!-- 用户信息和推荐商品 -->
          <div style="flex: 2; background-image: linear-gradient(to bottom, rgb(255, 241, 232) 0%, rgb(255, 245, 240) 50%, rgb(252, 249, 247) 100%);
 margin-top: 20px; border-radius: 15px; ">
            <div style="text-align: center; margin-top: 30px">
              <!-- 如果用户未登录，头像不可点击 -->
              <img :src="user.username ? user.avatar : require('/src/assets/imgs/456.png')" alt="" style="width: 80px; height: 80px; border-radius: 50%"  
              @click="user.username ? navTo('/front/person') : null">
               <!-- 公告 -->
               <div style="margin-top: 10px">
  <span v-if="user.username">Hi，{{ user.name }}</span>
  <el-button 
    v-else
    type="danger" 
    style="padding: 0 20px; height: 40px; font-size: 16px; border-radius: 10px;" 
    @click="navTo('/login')">
    立即登录
  </el-button>
</div>       
            </div>
            <div style="margin-top: 20px; padding: 0 15px">
              <img src="@/assets/imgs/123.jpg" alt="" style="height: 150px; width: 100%; border-radius: 20px">
            </div>
            <div style="margin: 20px 10px 10px 10px; width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis">
              <i class="el-icon-bell"></i>
              <span style="font-weight: bold">公告</span>
              <span style="color: #666666;">：{{ top }}</span>
            </div>
            <div style="display: flex; margin-top: 50px">
              <div style="flex: 1; text-align: center">
                <a href="#" @click="navTo('/front/collect')">
                  <img src="@/assets/imgs/收藏.png" alt="" style="height: 25px; width: 25px">
                  <div>我的收藏</div>
                </a>
              </div>
              <div style="flex: 1; text-align: center">
                <a href="#" @click="navTo('/front/address')">
                  <img src="@/assets/imgs/店铺.png" alt="" style="height: 25px; width: 25px">
                  <div>我的地址</div>
                </a>
              </div>
              <div style="flex: 1; text-align: center">
                <a href="#" @click="navTo('/front/cart')">
                  <img src="@/assets/imgs/购物车.png" alt="" style="height: 25px; width: 25px">
                  <div>我的购物车</div>
                </a>
              </div>
              <div style="flex: 1; text-align: center">
                <a href="#" @click="navTo('/front/orders')">
                  <img src="@/assets/imgs/订单.png" alt="" style="height: 25px; width: 25px">
                  <div>我的订单</div>
                </a>
              </div>
            </div>
          </div>
        </div>

        <!-- 热卖商品 -->
        <div style="margin: 40px 0 0 15px; height: 40px; background-color: #04BF04FF; font-size: 20px; color: white; width: 130px; font-weight: bold; line-height: 40px; text-align: center; border-radius: 20px">热卖商品</div>
        <div style="margin: 10px 5px 0 5px">
          <el-row>
            <el-col :span="5" v-for="item in goodsData" :key="item.id">

  <img 
  @click="navTo('/front/detail?id=' + item.id)" 
  :src="item.img" 
  alt="" 
  style="width: 100%; height: 200px; border-radius: 10px; border: #cccccc 1px solid; object-fit: cover;">        
       <!-- 响应式调整图片大小         <img 
  @click="navTo('/front/detail?id=' + item.id)" 
  :src="item.img" 
  alt="" 
  style="max-width: 100%; max-height: 150px; border-radius: 10px; border: #cccccc 1px solid;"> -->

             
              <!--缩放图片版本  <img 
  @click="navTo('/front/detail?id=' + item.id)" 
  :src="item.img" 
  alt="" 
  style="width: 100%; height: 150px; border-radius: 10px; border: #cccccc 1px solid; object-fit: contain;"> -->
               <!--热卖商品-->
              <div style="margin-top: 10px; font-weight: 500; font-size: 16px; width: 180px; color: #000000FF; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">{{ item.name }}</div>
              <div style="margin-top: 5px; font-size: 18px; color: #FF5000FF"> ￥ {{ item.price }}&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#666666;">{{ item.count }}人购买</span></div>
            </el-col>
          </el-row>
        </div>

        <!-- 猜你喜欢 -->
        <div style="margin: 40px 0 0 15px; height: 40px; background-color: #04BF04FF; font-size: 20px; color: white; width: 130px; font-weight: bold; line-height: 40px; text-align: center; border-radius: 20px">猜你喜欢</div>
        <div style="margin: 10px 5px 0 5px">
          <el-row>
            <el-col :span="5" v-for="item in recommendData" :key="item.id">
              <img @click="navTo('/front/detail?id=' + item.id)" :src="item.img" alt="" style="width: 100%; height: 175px; border-radius: 10px; border: #cccccc 1px solid">
              <div style="margin-top: 10px; font-weight: 500; font-size: 16px; width: 180px; color: #000000FF; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">{{ item.name }}</div>
              <div style="margin-top: 5px; font-size: 18px; color: #FF5000FF">￥ {{ item.price }} / {{ item.unit }}&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#666666;">{{ item.count }}人购买</span></div>
            </el-col>
          </el-row>
        </div>
      </div>
      <div class="right"></div>
    </div>
  </div>
</template>

<script>

export default {

  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      typeData: [],
      top: null,
      notice: [],
      goodsData: [],
      recommendData: [],
      name:null,
      select: "天猫",
      carousel_top: [
        require('@/assets/imgs/carousel-1.png'),
        require('@/assets/imgs/carousel-2.png'),
        require('@/assets/imgs/carousel-9.png'),
      ],
      carousel_left: [
        require('@/assets/imgs/carousel-3.png'),
        require('@/assets/imgs/carousel-4.png'),
        require('@/assets/imgs/carousel-5.png'),
      ],
      carousel_right: [
        require('@/assets/imgs/carousel-6.png'),
        require('@/assets/imgs/carousel-7.png'),
        require('@/assets/imgs/carousel-8.png'),
      ],
      announcements: [
        "欢迎来到我们的商城！",
        "新品上市，限时特惠！",
        "全场满300减50，满500减100！",
        "会员专享折扣，立即加入！",
        "限时抢购，手慢无！",
        "新品首发，抢先体验！",
        "品质保证，假一赔十！",
        "全场包邮，无门槛！",
        "每日签到，积分奖励！",
        "关注店铺，领取优惠券！",
        "新品预售，提前锁定！",
        "限时折扣，错过等一年！",
        "品质生活，从这里开始！",
        "购物无忧，售后无忧！",
        "精选好物，等你来选！"
      ],
    }
  },
  mounted() {
    this.loadType()
    this.loadNotice()
    this.loadGoods()
    this.loadRecommend()
    // 添加动画持续时间检查
    console.log('公告数量:', this.announcements.length)
    console.log('动画持续时间:', `${this.announcements.length * 5}s`)
    
    // 检查DOM元素
    this.$nextTick(() => {
      const container = document.querySelector('.announcement-container')
      const content = document.querySelector('.announcement-content')
      console.log('容器宽度:', container?.offsetWidth)
      console.log('内容宽度:', content?.offsetWidth)
      console.log('内容样式:', content?.style.cssText)
    })
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    search() {
  let query = '';
  if (this.select === 0) {  // 如果选中的是天猫
    query = this.name ? this.name : '';
    location.href = '/front/search?name=' + query;
  } else if (this.select === 1) {  // 如果选中的是宝贝
    query = this.name ? this.name : '';
    location.href = '/front/search?name=' + query;
  } else if (this.select === 2) {  // 如果选中的是店铺
    query = this.business ? this.business : '';
    location.href = '/front/search?business=' + query;
  }
},
    loadRecommend() {
      this.$request.get('/goods/recommend').then(res => {
        if (res.code === '200') {
          this.recommendData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadType() {
      this.$request.get('/type/selectAll').then(res => {
        if (res.code === '200') {
          this.typeData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
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
    loadGoods() {
      this.$request.get('/goods/selectTop10').then(res => {
        if (res.code === '200') {
          this.goodsData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    navTo(url) {
    // 获取当前用户信息，检查是否登录
    const user = JSON.parse(localStorage.getItem('xm-user') || '{}');
    
    if (!user.id) {
      // 如果用户未登录，弹出提示并跳转到登录页面
      this.$message.warning('请先登录');
      location.href = '/login'; // 跳转到登录页面
      return; // 阻止继续跳转
    }

    // 如果已登录，则跳转到目标页面
    location.href = url;
  },
    search() {
      let name = this.name ? this.name : ''
      location.href = '/front/search?name=' + name
    },
    logImageLoad() {
      console.log('图片加载成功');
    },
    onAnimationStart(event) {
      console.log('动画开始:', event)
      console.log('当前动画持续时间:', event.target.style.animationDuration)
      console.log('动画元素样式:', event.target.style.cssText)
    },
    onAnimationIteration(event) {
      console.log('动画循环:', event)
      console.log('当前transform:', event.target.style.transform)
    },
    onAnimationEnd(event) {
      console.log('动画结束，重新开始:', event)
      // 强制重新开始动画
      event.target.style.animation = 'none'
      event.target.offsetHeight // 触发重排
      event.target.style.animation = `scroll-left ${this.announcements.length * 5}s linear infinite`
      console.log('重置后的动画样式:', event.target.style.cssText)
    },
    refreshData() {
      // 实现刷新数据的逻辑
      console.log('刷新数据')
      console.log('当前公告数量:', this.announcements.length)
      console.log('当前动画持续时间:', `${this.announcements.length * 5}s`)
    }
  }
}
</script>

<style scoped>
.main-content {
  min-height: 100vh;
  /*overflow: hidden;*/
  background-size: 100%;
  background-image: url('@/assets/imgs/img.png');
}
.left {
  width: 7%;
  background-repeat: no-repeat;
  background-color: white;
}
.right {
  width: 7%;
  background-repeat: no-repeat;
  background-color: white;
}
.el-col-5{
  width: 20%;
  max-width: 20%;
  padding: 10px 10px;
}
.el-select {
  width: 100%;
}
.input-with-select .el-input-group__prepend {
    background-color: #fff;
  }
.announcement-container {
  width: 100%;
  overflow: hidden;
  position: relative;
  height: 100%;
}

.announcement-content {
  position: absolute;
  white-space: nowrap;
  animation: scroll-left 30s linear infinite;
  left: 0;
}

.announcement-wrapper {
  display: inline-block;
  padding: 0 20px;
}

.announcement-item {
  display: inline-block;
  color: #666;
  margin-right: 50px;
  font-size: 16px;
  font-weight: bold;
  line-height: 60px;
}

@keyframes scroll-left {
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(-100%);
  }
}
</style>
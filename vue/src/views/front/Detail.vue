<template>
  <div class="main-content">
    <div style="width: 80%; background-color: white; min-height: 1000px; margin: 20px auto; margin-top: 60px; border-radius: 20px">
      <div style="padding: 15px 20px">
        <el-row :gutter="20">
          <el-col :span="12">
            <img :src="goodsData.img" alt="" style="width: 100%; height: 95%; border-radius: 20px">
          </el-col>
          <el-col :span="12">
            <div style="
  font-size: 23px; 
  font-weight: 900;
  height: 100px; 
  overflow: hidden;
  background-image: linear-gradient(to bottom, rgb(255, 241, 232) 0%, rgb(255, 245, 240) 50%, rgb(252, 249, 247) 100%);
  border-radius: 15px;
  text-overflow: ellipsis;
  display: flex;
  align-items: center;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;">
  {{goodsData.name}}
</div>

            <div style="color: #666666FF; margin-top: 5px;font-size: 20px; margin-top: 5px;" >销量：{{goodsData.count}}</div>
            <div style="color: red; margin-top: 15px;font-size: 15px; margin-top: 25px;">抢购价：<span style="font-size: 20px">{{goodsData.price}} / {{goodsData.unit}}</span></div>
            <div style="margin-top: 20px">
              <img src="@/assets/imgs/456.png" alt="" style="width: 30%; height: 90%; border-radius: 15px">
            </div>
            <div style="color: #666666FF; margin-top: 20px;font-size: 15px; margin-top: 20px;">商家：<a href="#" @click="navTo('/front/business?id=' + goodsData.businessId)">{{goodsData.businessName}}</a></div>
            <div style="color: #666666FF; margin-top: 20px;font-size: 15px; margin-top: 20px;">分类：<a href="#" @click="navTo('/front/type?id=' + goodsData.typeId)">{{goodsData.typeName}}</a></div>
           
            <template>
            <div style="color: #666666FF; margin-top: 20px;font-size: 15px;">数量：<el-input-number
            v-model="localNum"
            style="width: 100px"
            @change="handleChange"
            :min="1">
          </el-input-number>
          </div>
          </template>

            <div style="color: #666666FF; margin-top: 35px">
              <el-button type="warning" @click="addCart" style="font-size: 15px;">加入购物车</el-button>
              <el-button type="warning" @click="collect"style="font-size: 15px;">收藏</el-button>
              <el-button type="warning" @click="after"style="font-size: 15px;">立即购买</el-button>
              <el-button type="warning"  @click="navTo('/front/home')"style="font-size: 15px;">联系客服</el-button>
   

            </div>
          </el-col>
        </el-row>
      </div>
      <div style="padding: 15px 20px">
        <el-tabs v-model="activeName" @tab-click="handleClick">
          <el-tab-pane label="宝贝详情" name="first">
            <div style="padding: 10px 175px" v-html="goodsData.description"></div>
          </el-tab-pane>
          <el-tab-pane label="宝贝评价" name="second">
            <div style="margin-top: 10px">
              <div style="margin-top: 20px" v-for="item in commentData">
                <div style="display: flex">
                  <div style="width: 40px">
                    <img :src="item.userAvatar" alt="" style="height: 40px; width: 40px; border-radius: 50%">
                  </div>
                  <div style="width: 200px; margin-left: 10px">
                    <div style="font-weight: 700; font-size: 17px; color: #000000FF">{{item.userName}}</div>
                    <div style="color: #7A7A7AFF">{{item.time}}</div>
                  </div>
                </div>
                <div style="margin-top: 15px; font-size: 16px">{{item.content}}</div>
              </div>
            </div>
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>

<script>
import { MessageBox } from 'element-ui';

export default {
  props: {
    value: {
      type: Number,
      required: false, // value 是可选的
      default: 1, // 默认值为 1
    },
  },
  data() {
    let goodsId = this.$route.query.id
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      localNum: this.value,
      goodsId: goodsId,
      goodsData: {},
      totalPrice: 0,
      total: 0,
      activeName: 'first',
      commentData: [],
      selectedData: [],
      address: null,
      addressData: [],
      businessId:null
    }
  },
  mounted() {
    this.loadGoods()
    this.loadComments()
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    loadGoods() {
      this.$request.get('/goods/selectById?id=' + this.goodsId).then(res => {
        if (res.code === '200') {
          this.goodsData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleClick(tab, event) {
      this.activeName = tab.name
    },
    handleChange(row) {
      this.totalPrice = 0
      this.selectedData.forEach(item => {
        this.totalPrice += item.goodsPrice * item.num
      })
    },
    // 收藏商品
  collect() {
    let data = {
      userId: this.user.id,
      businessId: this.goodsData.businessId,
      goodsId: this.goodsId,
    };
    this.$request.post('/collect/add', data).then(res => {
      if (res.code === '200') {
        this.$message.success('收藏成功');
        this.$eventBus.$emit('updateCollect'); // 触发收藏夹更新事件
      } else {
        this.$message.error(res.msg);
      }
    });
  },
    // 加入购物车
  addCart() {
    let data = { num: this.localNum, userId: this.user.id, goodsId: this.goodsId, businessId: this.goodsData.businessId };
    this.$request.post('/cart/add', data).then(res => {
      if (res.code === '200') {
        this.$message.success('添加到购物车成功');
        this.$eventBus.$emit('updateCart'); // 触发购物车更新事件
      } else {
        this.$message.error(res.msg);
      }
    });
  },
   // 立即购买
   after() {
    const totalPrice = this.localNum * this.goodsData.price;
    MessageBox.confirm(
      `确认购买？<br>总价：<strong style="color: red;">¥${totalPrice.toFixed(2)}</strong>`,
      '购买',
      { confirmButtonText: '确认', cancelButtonText: '取消', type: 'warning', dangerouslyUseHTMLString: true }
    ).then(() => {
      this.pay();
    }).catch(() => {
      console.log('取消购买');
    });
  },
  pay() {
    if (this.user.address === null) {
      this.$message.warning('请设置收货地址');
      return;
    }
    let num = this.localNum;
    let totalPrice = num * this.goodsData.price;
    let data = {
      userId: this.user.id,
      addressId: this.user.address,
      status: '待发货',
      goodsId: this.goodsId,
      businessId: this.goodsData.businessId,
      num: num,
      price: totalPrice,
    };

    this.$request.post('/orders/detailPay', data).then(res => {
      if (res.code === '200') {
        this.$message.success('购买成功');
        this.$eventBus.$emit('updateOrders'); // 触发订单更新事件
      } else {
        this.$message.error(res.msg);
      }
    });
  },
    loadComments() {
      this.$request.get('/comment/selectByGoodsId?id=' + this.goodsId).then(res => {
        if (res.code === '200') {
          this.commentData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    navTo(url) {
      location.href = url
    }
  }
}
</script>

<template>
  <div class="main-content">
    <div style="width: 86%; background-color: white; margin: 30px auto; border-radius: 20px">
      <div style="padding-bottom: 10px">
        <div style="display: flex; font-size: 18px; color: #000000FF; line-height: 80px; border-bottom: #cccccc 1px solid;">
          <div style="margin-left: 20px; ">全部商品（{{ goodsData.length }}）</div>
          
        </div>
        <div style="margin: 20px 0; padding: 0 50px">
          <div class="table">

            
            <el-table :data="goodsData" strip @selection-change="handleSelectionChange">
  <el-table-column type="selection" width="100px" align="center"></el-table-column>

  <el-table-column label="商品主图" align="center"> <!-- 设置居中对齐 -->
    <template v-slot="scope">
      <el-image style="width: 80px; height: 60px; border-radius: 3px" v-if="scope.row.goodsImg"
                :src="scope.row.goodsImg" :preview-src-list="[scope.row.goodsImg]"></el-image>
    </template>
  </el-table-column>

  <el-table-column prop="goodsName" label="商品名称" width="240px" align="center"> <!-- 设置居中对齐 -->
    <template v-slot="scope">
      <a :href="'/front/detail?id=' + scope.row.goodsId">{{ scope.row.goodsName.slice(0, 8) }}</a>
    </template>
  </el-table-column>

  <el-table-column prop="businessName" label="店铺名称" align="center"> <!-- 设置居中对齐 -->
    <template v-slot="scope">
      <a :href="'/front/business?id=' + scope.row.businessId">{{scope.row.businessName}}</a>
    </template>
  </el-table-column>

  <el-table-column prop="goodsPrice" label="商品单价" align="center"></el-table-column> <!-- 设置居中对齐 -->

  <el-table-column prop="num" label="选择数量" align="center"> <!-- 设置居中对齐 -->
    <template v-slot="scope">
      <el-input-number v-model="scope.row.num" style="width: 100px" @change="handleChange(scope.row)" :min="1"></el-input-number>
    </template>
  </el-table-column>

  <el-table-column label="选项" align="center" width="180"> <!-- 设置居中对齐 -->
    <template v-slot="scope">
      <el-button size="mini" type="danger" plain @click="del(scope.row.id)">移除购物车</el-button>
    </template>
  </el-table-column>
</el-table>

            
            <div class="pagination" style="margin-top: 100px">
              <el-pagination
                  background
                  @current-change="handleCurrentChange"
                  :current-page="pageNum"
                  :page-sizes="[5, 10, 20]"
                  :page-size="pageSize"
                  layout="total, prev, pager, next"
                  :total="total">
              </el-pagination>
            </div>
          <div style="flex: 1; font-size: 16px; text-align: right; padding-right: 20px">
            已选商品 ￥ {{totalPrice}} <el-button type="danger" round @click="after">下单</el-button>
          </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { MessageBox } from 'element-ui';

export default {

  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      goodsData: [],
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      totalPrice: 0,
      total: 0,
      address: null,
      addressData: [],
      selectedData: [],
    }
  },
  mounted() {
    this.loadGoods(1)
    this.loadAddress()
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    loadAddress() {
      this.$request.get('/user/selectAll').then(res => {
        if (res.code === '200') {
          this.addressData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadGoods(pageNum) {
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/cart/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
        }
      }).then(res => {
        if (res.code === '200') {
          this.goodsData = res.data?.list
          this.total = res.data?.total
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    navTo(url) {
      location.href = url
    },
    del(id) {
      this.$request.delete('/cart/delete/' + id).then(res => {
        if (res.code === '200') {
          this.$message.success('移除成功')
          this.loadGoods(1)
          this.$eventBus.$emit('updateCart'); // 触发购物车更新事件
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleCurrentChange(pageNum) {
      this.loadGoods(pageNum)
    },
    handleSelectionChange(rows) {
      this.totalPrice = 0
      this.selectedData = rows
      // 计计算总价格
      this.selectedData.forEach(item => {
        this.totalPrice += (item.goodsPrice * item.num)
      })
    },
    handleChange(row) {
  this.$request.put('/cart/update', { id: row.id, num: row.num })
    .then(res => {
      if (res.code === '200') {
        //this.$message.success('数量已更新');
        // 重新计算总价
        this.totalPrice = 0;
        this.selectedData.forEach(item => {
          this.totalPrice += item.goodsPrice * item.num;
        });
      } else {
        this.$message.error(res.msg);
      }
    })
    .catch(error => {
      this.$message.error('更新过程中发生错误');
    });
},
 // 立即购买
 after() {
  if (!this.selectedData || this.selectedData.length === 0) {
    this.$message.warning('请选择商品');
    return;
  }
  if (this.user.address === null) {
    this.$message.warning('请选择收货地址');
    return;
  }

  // 计算总价
  let totalPrice = 0;
  this.selectedData.forEach(item => {
    totalPrice += item.goodsPrice * item.num; // 这里根据选中的商品数量计算总价
  });

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
     
    let data = {
        userId: this.user.id,
        phone:this.user.phone,
        addressId: this.user.address, // 使用 addressId 代替 address
        status: '待发货',
        cartData: this.selectedData
    
    };

   //这里是购物车的下单逻辑
    this.$request.post('/orders/add', data).then(res => {
        if (res.code === '200') {
            this.$message.success('操作成功');
            this.loadGoods(1);
            this.$eventBus.$emit('updateOrders'); // 触发订单更新事件
            this.$eventBus.$emit('updateCart'); // 触发购物车更新事件
        } else {
            this.$message.error(res.msg);
        }
    });
}
  }
}
</script>

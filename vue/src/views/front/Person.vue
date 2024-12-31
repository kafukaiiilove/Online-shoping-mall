<template>
  <div class="main-content">
    <el-card style="width: 50%; margin: 30px auto">
      <!-- 修改密码按钮 -->
      <div style="text-align: right; margin-bottom: 20px">
        <el-button type="primary" @click="updatePassword">修改密码</el-button>
      </div>

      <!-- 用户信息表单 -->
      <el-form :model="user" label-width="80px" style="padding-right: 20px">
        <div style="margin: 15px; text-align: center">
          <el-upload
            class="avatar-uploader"
            :action="$baseUrl + '/files/upload'"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
          >
            <img v-if="user.avatar" :src="user.avatar" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </div>

        <!-- 用户信息字段 -->
        <el-form-item label="用户名" prop="username">
          <el-input v-model="user.username" placeholder="用户名" disabled></el-input>
        </el-form-item>
        <el-form-item label="昵称" prop="name">
          <el-input v-model="user.name" placeholder="昵称"></el-input>
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="user.phone" placeholder="电话"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="user.email" placeholder="邮箱"></el-input>
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="user.address" placeholder="地址"></el-input>
        </el-form-item>

        <!-- 保存按钮 -->
        <div style="text-align: center; margin-bottom: 20px">
          <el-button type="primary" @click="update">保 存</el-button>
        </div>
      </el-form>
    </el-card>

    <!-- 修改密码弹窗 -->
    <el-dialog title="修改密码" :visible.sync="dialogVisible" width="30%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="user" label-width="80px" style="padding-right: 20px" :rules="rules" ref="formRef">
        <el-form-item label="原始密码" prop="password">
          <el-input show-password v-model="user.password" placeholder="原始密码"></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input show-password v-model="user.newPassword" placeholder="新密码"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input show-password v-model="user.confirmPassword" placeholder="确认密码"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    const validatePassword = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请确认密码'));
      } else if (value !== this.user.newPassword) {
        callback(new Error('确认密码错误'));
      } else {
        callback();
      }
    };

    return {
      // 用户信息从本地存储获取
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),

      // 控制修改密码弹窗的显示与否
      dialogVisible: false,

      // 密码修改表单的验证规则
      rules: {
        password: [
          { required: true, message: '请输入原始密码', trigger: 'blur' },
        ],
        newPassword: [
          { required: true, message: '请输入新密码', trigger: 'blur' },
        ],
        confirmPassword: [
          { validator: validatePassword, required: true, trigger: 'blur' },
        ],
      },
    };
  },

  watch: {
    // 监听路由变化，当进入 "Person" 页面时加载用户数据
    $route(to) {
      if (to.name === 'Person') {
        this.loadUserData();
      }
    },

    // 监听 user 数据变化，确保及时更新视图
    'user': {
      handler() {
        localStorage.setItem('xm-user', JSON.stringify(this.user)); // 更新本地存储
      },
      deep: true
    }
  },

  methods: {
    // 更新用户信息
    update() {
      this.$request.put('/user/update', this.user).then((res) => {
        if (res.code === '200') {
          this.$message.success('保存成功');
          console.log('Updated user:', this.user); // 检查更新后的用户数据
          this.loadUserData(); // 重新加载用户数据
        } else {
          this.$message.error(res.msg);
        }
      });
    },

    // 头像上传成功后的回调
    handleAvatarSuccess(response) {
      this.$set(this.user, 'avatar', response.data); // 更新用户头像
    },

    // 显示修改密码弹窗
    updatePassword() {
      this.dialogVisible = true;
    },

    // 保存修改密码
    save() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request.put('/updatePassword', this.user).then((res) => {
            if (res.code === '200') {
              this.$message.success('修改密码成功');
              this.$router.push('/login'); // 跳转到登录页面
            } else {
              this.$message.error(res.msg);
            }
          });
        }
      });
    },

    // 加载用户数据
    loadUserData() {
      this.user = JSON.parse(localStorage.getItem('xm-user') || '{}');
    },

    // 监听 'addressUpdated' 事件来更新本地存储中的用户数据
    initEventBus() {
      this.$eventBus.$on('addressUpdated', ({ address, phone, name }) => {
        console.log('接收到地址更新:', { address, phone, name });
        const user = JSON.parse(localStorage.getItem('xm-user') || '{}');
        user.address = address;
        user.phone = phone;
        user.name = name;
        localStorage.setItem('xm-user', JSON.stringify(user));
      });
    }
  },

  created() {
    // 初始化事件总线监听
    this.initEventBus();
  }
};
</script>

<style scoped>
.el-form-item__label {
  font-weight: bold;
}
.el-upload {
  border-radius: 50%;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  border-radius: 50%;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 120px;
  height: 120px;
  line-height: 120px;
  text-align: center;
  border-radius: 50%;
}
.avatar {
  width: 120px;
  height: 120px;
  display: block;
  border-radius: 50%;
}
</style>

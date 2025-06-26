![local](https://github.com/user-attachments/assets/c1c056b4-200f-4e9b-b81c-4f3d9fa59001)

# Online Shopping Mall 网上购物商城

这是一个全栈的网上购物商城项目，包含前端Vue.js应用和后端Spring Boot应用。

## 项目结构

```
Online-shoping-mall/
├── vue/                    # 前端Vue.js项目
│   ├── src/               # 源代码
│   ├── public/            # 公共资源
│   ├── package.json       # 前端依赖配置
│   └── ...
├── springboot/            # 后端Spring Boot项目
│   └── ...
├── xm_shopping_manager.sql # 数据库脚本
└── README.md
```

## 快速开始

### 前端项目（Vue.js）

1. 进入前端项目目录：
   ```bash
   cd vue
   ```

2. 安装依赖：
   ```bash
   npm install
   # 或者使用 yarn
   yarn install
   ```

3. 启动开发服务器：
   ```bash
   npm run serve
   # 或者
   yarn serve
   ```

4. 构建生产版本：
   ```bash
   npm run build
   # 或者
   yarn build
   ```

### 后端项目（Spring Boot）

1. 进入后端项目目录：
   ```bash
   cd springboot
   ```

2. 使用Maven或Gradle构建项目（根据具体配置）

### 数据库设置

1. 导入数据库脚本：
   ```sql
   source xm_shopping_manager.sql
   ```

## 注意事项

- 本项目的 `node_modules` 目录已被添加到 `.gitignore` 中，不会被版本控制
- 克隆项目后，需要手动安装前端依赖
- 确保本地已安装 Node.js 和 npm/yarn

## 开发环境要求

根据项目实际使用的版本：

### 前端开发环境
- **Node.js**: v16.20.2 (推荐 >= 16.x)
- **npm**: 8.19.4 (推荐 >= 8.x)
- **Vue CLI**: ~5.0.0

### 后端开发环境  
- **Java**: OpenJDK 17.0.13 LTS (项目配置要求 Java 17)
- **Maven**: 3.9.9 (推荐 >= 3.6.x)
- **Spring Boot**: 2.5.9

### 数据库
- **MySQL**: 8.0.40 (推荐 >= 8.0.x)

## 贡献指南

1. Fork 本仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

## 许可证

本项目使用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

# 基于Springboot+vue的推荐算法网上商城项目 

本地数据库名：root 密码：123456 表名：xm_shopping_manager 
后端端口9090 前台端口8080

node版本v16.20.2
jdk版本：java17

![商城首页](springboot/files/商城首页.png)
![商户后台](springboot/files/商户后台.png)
![管理员后台](springboot/files/管理员后台.png)

部署联系方式：qq1321955902 

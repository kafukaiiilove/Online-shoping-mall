package com.example.service;

import ch.qos.logback.core.util.COWArrayList;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.ObjectUtil;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.mapper.*;
import com.example.utils.TokenUtils;
import com.example.utils.UserCF;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

/**
 * 商品信息表业务处理
 **/
@Service
public class GoodsService {

    @Resource
    private GoodsMapper goodsMapper;
    @Resource
    private UserMapper userMapper;
    @Resource
    private CollectMapper collectMapper;
    @Resource
    private CommentMapper commentMapper;
    @Resource
    private CartMapper cartMapper;
    @Resource
    private OrdersMapper ordersMapper;

    /**
     * 新增
     */
    public void add(Goods goods) {
        Account currentUser = TokenUtils.getCurrentUser();
        Integer maxId = goodsMapper.getMaxId();
        if (maxId == null) {
            goodsMapper.updateAutoIncrement(1);
        } else {
            goodsMapper.updateAutoIncrement(maxId + 1);
        }
        if (RoleEnum.BUSINESS.name().equals(currentUser.getRole())) {
            goods.setBusinessId(currentUser.getId());
        }
        goodsMapper.insert(goods);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        goodsMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            goodsMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Goods goods) {
        goodsMapper.updateById(goods);
    }

    /**
     * 根据ID查询
     */
    public Goods selectById(Integer id) {
        return goodsMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Goods> selectAll(Goods goods) {
        return goodsMapper.selectAll(goods);
    }

    /**
     * 分页查询
     */
    public PageInfo<Goods> selectPage(Goods goods, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.BUSINESS.name().equals(currentUser.getRole())) {
            goods.setBusinessId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Goods> list = goodsMapper.selectAll(goods);
        return PageInfo.of(list);
    }

    public List<Goods> selectTop10() {
        return goodsMapper.selectTop10();
    }

    public List<Goods> selectByTypeId(Integer id) {
        return goodsMapper.selectByTypeId(id);
    }

    public List<Goods> selectByBusinessId(Integer id) {
        return goodsMapper.selectByBusinessId(id);
    }

    public List<Goods> selectByName(String name) {
        return goodsMapper.selectByName(name);
    }

    public List<Goods> recommend() {
        Account currentUser = TokenUtils.getCurrentUser();
        List<Goods> recommendResult;

        if (currentUser == null ||
                ObjectUtil.isEmpty(currentUser) ||
                currentUser.getUsername() == null ||
                currentUser.getRole() == null) {
            // 未登录逻辑：按count字段从高到低排序，返回前10个商品
            // 在数据库层执行过滤、排序和限制操作
            recommendResult = goodsMapper.selectGoodsWithCountGreaterThanZeroLimit(5);
        }else{
        // 登录用户的推荐逻辑（保持不变）
        // 收藏、加入购物车、下单、评论

        // 1. 获取所有的收藏信息
        List<Collect> allCollects = collectMapper.selectAll(null);
        // 2. 获取所有的购物车信息
        List<Cart> allCarts = cartMapper.selectAll(null);
        // 3. 获取所有的订单信息
        List<Orders> allOrders = ordersMapper.selectAllOKOrders();
   //     System.out.println("订单数据大小: " + allOrders.size()); // 打印订单数据大小
        // 4. 获取所有的评论信息
        List<Comment> allComments = commentMapper.selectAll(null);
        // 5. 获取所有的用户信息
        List<User> allUsers = userMapper.selectAll(null);
        // 6. 获取所有的商品信息
        List<Goods> allGoods = goodsMapper.selectAll(null);

        // 定义存储每个商品和每个用户关系的List
        List<RelateDTO> data = new ArrayList<>();
        // 定义一个存储最后返回给前端的商品List

        // 创建一个栅栏，等待所有的异步处理都结束后，再往下走
        CountDownLatch countDownLatch = new CountDownLatch(allGoods.size() * allUsers.size());
        // 创建一个线程池
        ExecutorService threadPool = Executors.newCachedThreadPool();

        // 开始计算每个商品和每个用户之间的关系数据
        for (Goods goods : allGoods) {
            Integer goodsId = goods.getId();
            for (User user : allUsers) {
                threadPool.execute(() -> {
                    Integer userId = user.getId();
                    int index = 1;

                    // 收藏的权重 1
                    Optional<Collect> collectOptional = allCollects.stream().filter(x -> x.getGoodsId().equals(goodsId) && x.getUserId().equals(userId)).findFirst();
                    if (collectOptional.isPresent()) {
                        index += 1;
                    }
                    // 2. 加入购物车的权重 2
                    Optional<Cart> cartOptional = allCarts.stream().filter(x -> x.getGoodsId().equals(goodsId) && x.getUserId().equals(userId)).findFirst();
                    if (cartOptional.isPresent()) {
                        index += 2;
                    }
                    // 3. 订单的权重 3
                    Optional<Orders> ordersOptional = allOrders.stream().filter(x -> x.getGoodsId().equals(goodsId) && x.getUserId().equals(userId)).findFirst();
//                    System.out.println("检查订单数据： " + ordersOptional.isPresent() + " for goodsId: " + goodsId + " and userId: " + userId);
                    if (ordersOptional.isPresent()) {
                        index += 3;
//                        System.out.println("商品 " + goodsId + " 对用户 " + userId + " 的订单权重为: " + index);
                    }
                    // 4. 评论2
                    Optional<Comment> commentOptional = allComments.stream().filter(x -> x.getGoodsId().equals(goodsId) && x.getUserId().equals(userId)).findFirst();
                    if (commentOptional.isPresent()) {
                        index += 2;
                    }
                    if (index > 1) {
                        RelateDTO relateDTO = new RelateDTO(userId, goodsId, index);
                        data.add(relateDTO);
//                        System.out.println("添加商品 " + goodsId + " 和用户 " + userId + " 的关系数据，权重为: " + index);
                    }
                    countDownLatch.countDown();
                });
            }
        }
        try {
            countDownLatch.await();
            threadPool.shutdown();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {

            // 数据准备结束后，就把这些数据一起喂给这个推荐算法
            // 使用协同过滤推荐算法获取推荐商品
            List<Integer> goodsIds = UserCF.recommend(currentUser.getId(), data);

            // 把商品id转换成商品
            System.out.println("推荐的商品ID列表: " + goodsIds);
            // 打印每个商品的全称（name）
            goodsIds.forEach(goodsId -> {
                Goods matchedGoods = allGoods.stream()
                        .filter(goods -> goods.getId().equals(goodsId))
                        .findFirst()
                        .orElse(null);
                if (matchedGoods != null) {
                    System.out.println("商品名称: " + matchedGoods.getName());
                }
            });

            recommendResult = goodsIds.stream()
                    .map(goodsId -> allGoods.stream()
                    .filter(x -> x.getId().equals(goodsId)).findFirst().orElse(null))
                    .limit(10).collect(Collectors.toList());
        }
    }
        if (recommendResult.size() < 10) {
            // 计算需要补充的商品数量
            int needToAdd = 10 - recommendResult.size();
            List<Goods> additionalGoods = getRandomGoods(needToAdd);  // 从商品列表中随机挑选

            // 获取推荐商品中已有商品的ID
            Set<Integer> existingIds = recommendResult.stream()
                    .map(Goods::getId)
                    .collect(Collectors.toSet());

            // 过滤掉已存在的商品，确保没有重复
            additionalGoods = additionalGoods.stream()
                    .filter(goods -> !existingIds.contains(goods.getId()))
                    .collect(Collectors.toList());

            // 将补充的商品添加到推荐结果中
            recommendResult.addAll(additionalGoods);


            // 输出相关信息用于调试
            System.out.println("推荐结果初始大小: " + recommendResult.size());
            System.out.println("需要补充商品数量: " + needToAdd);
            System.out.println("补充商品数量: " + additionalGoods.size());
        }

        System.out.println("推荐商品的数量：" + recommendResult.size());
        return recommendResult;

        // 在推荐逻辑结束前，打印推荐商品的数量
    }

    private List<Goods> getRandomGoods(int num) {
        List<Goods> goods = goodsMapper.selectAll(null);
        if (goods.size() <= num) {
            return new ArrayList<>(goods); // 商品数量少于 num，直接返回全部商品
        }

        List<Goods> randomGoods = new ArrayList<>(num);
        Set<Integer> selectedIndices = new HashSet<>(); // 用于记录已经选择的索引
        Random random = new Random();

        while (randomGoods.size() < num) {
            int index = random.nextInt(goods.size());
            if (!selectedIndices.contains(index)) {
                randomGoods.add(goods.get(index)); // 添加商品到结果列表
                selectedIndices.add(index); // 记录已选择的索引
            }
        }

        return randomGoods;
    }

}
package com.example.service;

import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Cart;
import com.example.entity.Goods;
import com.example.entity.Orders;
import com.example.mapper.CartMapper;
import com.example.mapper.GoodsMapper;
import com.example.mapper.OrdersMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

/**
 * 收藏业务处理
 **/
@Service
public class OrdersService {

    @Resource
    private OrdersMapper ordersMapper;
    @Resource
    private CartMapper cartMapper;
    @Resource
    private GoodsMapper goodsMapper;

    /**
     * 购物车下单新增
     */
    @Transactional
    public void add(Orders orders) {
        // 设置订单号
        // orders.setOrderId(DateUtil.format(new Date(), "yyyyMMddHHmmss"));
        String orderId = UUID.randomUUID().toString().replace("-", "").toUpperCase();
        orders.setOrderId(orderId);

        for (Cart cart : orders.getCartData()) {
                Orders dbOrders = new Orders();
                // 复制基础属性
                BeanUtils.copyProperties(orders, dbOrders);
                // 设置商品相关信息
                dbOrders.setGoodsId(cart.getGoodsId());
                dbOrders.setBusinessId(cart.getBusinessId());
                dbOrders.setNum(cart.getNum());
                dbOrders.setPrice(cart.getNum() * cart.getGoodsPrice());
                // 获取最大 ID 并更新自增
                Integer maxId = ordersMapper.getMaxId();
                if (maxId == null) {
                    ordersMapper.updateAutoIncrement(1);
                } else {
                    ordersMapper.updateAutoIncrement(maxId + 1);
                }
                // 插入订单记录
                ordersMapper.insert(dbOrders);
                // 删除购物车中对应的商品
                cartMapper.deleteById(cart.getId());
                // 更新商品销量
                Goods goods = goodsMapper.selectById(cart.getGoodsId());
                goods.setCount(goods.getCount() + cart.getNum());
                goodsMapper.updateById(goods);
            }
        }
    /**
     * 商品详情下单逻辑
     */
    @Transactional
    public void detailPay(Orders orders) {
        // 设置订单号
        String orderId = UUID.randomUUID().toString().replace("-", "").toUpperCase();
        orders.setOrderId(orderId);

        // 创建数据库订单对象
        Orders dbOrders = new Orders();
        BeanUtils.copyProperties(orders, dbOrders);

        // 打印日志（调试）
        System.out.println("插入订单信息: " + dbOrders);

        // 插入订单记录
        ordersMapper.insert(dbOrders);

        Goods goods = goodsMapper.selectById(orders.getGoodsId());

        goods.setCount(goods.getCount() + orders.getNum());


        goodsMapper.updateById(goods);
    }
    /**
     * 删除
     */
    public void deleteById(Integer id) {
        ordersMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            ordersMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Orders orders) {
        ordersMapper.updateById(orders);
    }

    /**
     * 根据ID查询
     */
    public Orders selectById(Integer id) {
        return ordersMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Orders> selectAll(Orders orders) {
        return ordersMapper.selectAll(orders);
    }

    /**
     * 分页查询
     */
    public PageInfo<Orders> selectPage(Orders orders, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            orders.setUserId(currentUser.getId());
        }
        if (RoleEnum.BUSINESS.name().equals(currentUser.getRole())) {
            orders.setBusinessId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Orders> list = ordersMapper.selectAll(orders);
        return PageInfo.of(list);
    }
}
package com.example.mapper;

import com.example.entity.Type;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 操作type相关数据接口
*/
public interface TypeMapper {

    /**
      * 新增
    */
    int insert(Type type);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Type type);

    /**
      * 根据ID查询
    */
    Type selectById(Integer id);

    /**
      * 查询所有
    */
    List<Type> selectAll(Type type);
    /**
     * 获取主键最大值
     */
    Integer getMaxId();
    /**
     * 更新主键设置值方法
     */
    void updateAutoIncrement(@Param("value") int value);

}
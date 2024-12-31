package com.example.mapper;

import com.example.entity.Goods;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 操作goods相关数据接口
*/
public interface GoodsMapper {

    /**
      * 新增
    */
    int insert(Goods goods);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Goods goods);

    /**
      * 根据ID查询
    */
    Goods selectById(Integer id);

    /**
      * 查询所有
    */
    List<Goods> selectAll(Goods goods);
    /**
     * 获取主键最大值
     */
    Integer getMaxId();
    /**
     * 更新主键设置值方法
     */
    void updateAutoIncrement(@Param("value") int value);


    @Select("select * from goods order by count desc limit 10")
    List<Goods> selectTop10();

    @Select("select * from goods where type_id = #{id}")
    List<Goods> selectByTypeId(Integer id);

    @Select("select * from goods where business_id = #{id}")
    List<Goods> selectByBusinessId(Integer id);

    @Select("select * from goods where name like concat('%', #{name}, '%')")
    List<Goods> selectByName(String name);

    @Select("SELECT * FROM goods WHERE count > 0 ORDER BY count DESC LIMIT 5")
    List<Goods> selectGoodsWithCountGreaterThanZeroLimit(int limit);
}
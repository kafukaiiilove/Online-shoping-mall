package com.example.mapper;

import com.example.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 操作user相关数据接口
*/
public interface UserMapper {

    /**
      * 新增
    */
    int insert(User user);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(User user);

    /**
      * 根据ID查询
    */
    User selectById(Integer id);

    /**
      * 查询所有
    */
    List<User> selectAll(User user);

    @Select("select * from user where username = #{username}")
    User selectByUsername(String username);
    /**
     * 获取主键最大值
     */
    Integer getMaxId();
    /**
     * 更新主键设置值方法
     */
    void updateAutoIncrement(@Param("value") int value);


    @Update("UPDATE user SET address = #{address}, phone = #{phone}, name = #{name} WHERE id = #{userId}")
    int updateUserAddressPhoneAndName(@Param("userId") Long userId,
                                      @Param("address") String address,
                                      @Param("phone") String phone,
                                      @Param("name") String name);




}
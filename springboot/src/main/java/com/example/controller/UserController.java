package com.example.controller;

import com.example.common.Result;
import com.example.common.enums.ResultCodeEnum;
import com.example.entity.Account;
import com.example.entity.User;
import com.example.service.UserService;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageInfo;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 商家前端操作接口
 **/
@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody User user) {
        userService.add(user);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        userService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        userService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody User user) {
        userService.updateById(user);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        User user = userService.selectById(id);
        return Result.success(user);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(User user ) {
        List<User> list = userService.selectAll(user);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(User user,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<User> page = userService.selectPage(user, pageNum, pageSize);
        return Result.success(page);
    }
    @PostMapping("/updateAddress")
    public ResponseEntity<String> updateUserAddress(@RequestBody Map<String, String> request) {
        System.out.println("接收到的请求数据: " + request);

        String address = request.get("address");
        String phone = request.get("phone");
        String name = request.get("name");  // 接收 name 字段
        String userIdStr = request.get("userId");

        // 校验字段是否为空
        if (address == null || address.trim().isEmpty()) {
            System.out.println("地址为空，无法更新。");
            return ResponseEntity.badRequest().body("地址不能为空");
        }

        if (phone == null || phone.trim().isEmpty()) {
            System.out.println("电话为空，无法更新。");
            return ResponseEntity.badRequest().body("电话不能为空");
        }

        if (name == null || name.trim().isEmpty()) {
            System.out.println("姓名为空，无法更新。");
            return ResponseEntity.badRequest().body("姓名不能为空");
        }

        if (userIdStr == null || userIdStr.trim().isEmpty()) {
            System.out.println("用户 ID 为空，无法更新。");
            return ResponseEntity.badRequest().body("用户 ID 不能为空");
        }

        Long userId;
        try {
            userId = Long.parseLong(userIdStr);
        } catch (NumberFormatException e) {
            System.out.println("无效的用户 ID: " + userIdStr);
            return ResponseEntity.badRequest().body("无效的用户 ID");
        }

        System.out.println("接收到的地址: " + address + ", 电话: " + phone + ", 姓名: " + name + ", 用户 ID: " + userId);

        try {
            // 调用服务层更新地址、电话和姓名
            userService.updateUserAddressPhoneAndName(userId, address, phone, name);
            System.out.println("用户 " + userId + " 的地址、电话和姓名已更新为: " + address + ", " + phone + ", " + name);
            return ResponseEntity.ok("默认地址、电话和姓名更新成功");
        } catch (Exception e) {
            System.out.println("更新地址、电话和姓名失败: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("更新失败: " + e.getMessage());
        }
    }


}
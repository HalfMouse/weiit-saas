package com.weiit.web.admin.task;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.web.admin.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Created by 罗鸿强 on 2018/6/14.
 *
 *
 * 任务Handler示例（Bean模式）
 *
 * 开发步骤：
 * 1、继承"IJobHandler"：“com.weiit.task.core.handler.Task”；
 * 2、注册到Spring容器：添加“@Component”注解，被Spring容器扫描为Bean实例；
 * 3、注册到执行器工厂：添加“@TaskHandler(value="自定义jobhandler名称")”注解，注解value值对应的是调度中心新建任务的JobHandler属性的值。
 */
@TaskHandler("testTask")
@Component
public class TestTask extends Task {

    @Autowired
    UserService userService;

    @Override
    public ReturnT<String> execute(String s) throws Exception {
        System.out.println("task success");
        FormMap formMap = new FormMap();
        formMap.put("user_id",8501058);
        E user = userService.selectById(formMap);
        System.out.println(user.toString());

        return ReturnT.SUCCESS;
    }
}

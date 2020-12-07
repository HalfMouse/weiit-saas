package com.weiit.web.admin.task.executor;

import com.weiit.core.entity.E;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.task.service.HelloWorldService;

import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;


/**
 * 任务Handler示例（Bean模式）
 * 
 * 开发步骤：
 * 1、继承"IJobHandler"：“com.weiit.task.handler.IJobHandler”；
 * 2、注册到Spring容器：添加“@Component”注解，被Spring容器扫描为Bean实例；
 * 3、注册到执行器工厂：添加“@JobHandler(value="自定义jobhandler名称")”注解，注解value值对应的是调度中心新建任务的JobHandler属性的值。
 * 4、执行日志：需要通过 "XxlJobLogger.log" 打印执行日志；
 * 
 * @author xuxueli 2015-12-19 19:43:36
 */
@TaskHandler(value="helloWorldTask")
@Component
public class HelloWordTask extends Task {

	@Resource
	private HelloWorldService helloWorldService;
	@Override
	public ReturnT<String> execute(String param) throws Exception {
		TaskLogger.log("XXL-JOB, Hello World.");
		System.out.println("-----------------------------------------------------hzy");
		for (int i = 0; i < 5; i++) {
			TaskLogger.log("beat at:" + i);
			System.out.println(11111);
			TimeUnit.SECONDS.sleep(2);
		}
		
		//查询数据
		List<E> list=helloWorldService.selectList(null);
		for (E e : list) {
			System.out.println(e.getStr("user_name"));
		}
		
		return SUCCESS;
	}


	public static void main(String[] args) {
		TaskLogger.log("\nXXL-JOB, Hello World.{0}{1}",new Date(),"xx");
	}
	
}

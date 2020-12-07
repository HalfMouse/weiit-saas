package com.weiit.web.admin.task.executor;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.weiit.core.entity.FormMap;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.web.admin.task.service.UserCouponService;

/**
 * Created by 罗鸿强 on 2018/7/10.
 * 
 * 用户优惠券超时未使用，失效
 */

@TaskHandler(value = "userCouponEndTask")
@Component
public class UserCouponEndTask extends Task {
	
    @Resource
    UserCouponService userCouponService;
    
    @Override
    public ReturnT<String> execute(String s) throws Exception {
    	System.out.println("-----------------------------------------------------UserCouponEndTask");
        FormMap formMap = new FormMap();
        formMap.put("state",0);
        formMap.put("end_time",new Date());
        formMap.put("update_state",-1);
    	userCouponService.edit(formMap);
    	
        return SUCCESS;
    }
}

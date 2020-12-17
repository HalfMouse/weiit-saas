package com.weiit.web.admin.task.executor;

import com.weiit.core.entity.FormMap;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.web.admin.task.service.UserCouponService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by 罗鸿强 on 2018/7/10.
 * 用户领取的优惠券生效
 */

@TaskHandler(value="userCouponStartTask")
@Component
public class UserCouponStartTask  extends Task{

    @Resource
    UserCouponService userCouponService;
    
    @Override
    public ReturnT<String> execute(String s) throws Exception {
    	System.out.println("-----------------------------------------------------UserCouponStartTask");
        FormMap formMap = new FormMap();
        formMap.put("state",-2);
        formMap.put("start_time",new Date());
        formMap.put("update_state",0);
    	userCouponService.edit(formMap);
    	
        return SUCCESS;
    }
}

package com.weiit.web.admin.task.executor;


import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.weiit.core.entity.FormMap;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.task.service.BargainService;

/**
 * Created by 罗鸿强 on 2018/7/10.
 *
 * 发起的砍价  到期未支付
 */
@TaskHandler("bargainOrderEndTask")
@Component
public class BargainOrderEndTask extends Task {
	@Resource
    BargainService bargainService;
    
    @Override
    public ReturnT<String> execute(String s) throws Exception {
        TaskLogger.log("用户发起的砍价到期未支付失效");

        FormMap selectMap = new FormMap();
        selectMap.put("state",0);
        selectMap.put("end_time",new Date());
        selectMap.put("update_state",-1);
        bargainService.editBargainOrder(selectMap);

        return SUCCESS;
    }
}

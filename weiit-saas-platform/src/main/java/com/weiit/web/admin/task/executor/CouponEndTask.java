package com.weiit.web.admin.task.executor;

import com.weiit.core.entity.FormMap;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.task.service.CouponService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by 罗鸿强 on 2018/7/10.
 */

@TaskHandler("couponEndTask")
@Component
public class CouponEndTask extends Task {

    @Resource
    CouponService couponService;
    @Override
    public ReturnT<String> execute(String s) throws Exception {
        TaskLogger.log("查询已生效的优惠券");

        FormMap selectMap = new FormMap();
        selectMap.put("state",0);
        selectMap.put("end_time",new Date());
        selectMap.put("updateState",-1);
        couponService.updateCouponState(selectMap);



        //用户手里没使用的也过期

        return SUCCESS;
    }
}

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
 * Created by 罗鸿强 on 2018/7/9.
 *
 * 优惠券活动生效
 */
@TaskHandler("couponStartTask")
@Component
public class CouponStartTask extends Task{
    @Resource
    CouponService couponService;

    @Override
    public ReturnT<String> execute(String s) throws Exception {
        TaskLogger.log("查询未生效的优惠券");

        FormMap selectMap = new FormMap();
        selectMap.put("state",-2);
        selectMap.put("start_time",new Date());
        selectMap.put("updateState",0);
        couponService.updateCouponState(selectMap);


//        List<E> list = couponService.selectCouponList(selectMap);





        return SUCCESS;
    }
}

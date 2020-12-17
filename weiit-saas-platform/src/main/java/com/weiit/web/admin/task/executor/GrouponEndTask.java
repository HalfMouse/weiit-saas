package com.weiit.web.admin.task.executor;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.init.service.OrderService;
import com.weiit.web.admin.task.service.GrouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

/**
 * Created by luo on 2018/7/7.
 * <p>
 * 拼团订单结束
 */
@TaskHandler(value = "grouponEndTask")
@Component
public class GrouponEndTask extends Task {
    @Autowired
    GrouponService grouponService;

    @Autowired
    RedisUtil redisUtil;

    @Autowired
    OrderService orderService;

    @Override
    public ReturnT<String> execute(String s) throws Exception {
        TaskLogger.log("XXL-JOB, grouponStartTask.拼团结束任务");
        //查询开始的拼团活动
        FormMap formMap = new FormMap();
        formMap.put("state", 0);
        formMap.put("end_time", new Date());
        List<E> grouponList = grouponService.selectGrouponList(formMap);
        if (grouponList != null && grouponList.size() > 0) {
            for (E groupon : grouponList) {
                TaskLogger.log("拼团结束grouponStartTask groupon_id:" + groupon.get("groupon_id"));
                FormMap updateFormMap = new FormMap();
                updateFormMap.put("state", -1);
                updateFormMap.put("groupon_id", groupon.get("groupon_id"));
                //更新活动  失效状态
                grouponService.updateGrouponState(updateFormMap);

                //查询活动下的进行中拼团订单
//                List<E> grouponOrderList = grouponService.selectGrouponOrderList(updateFormMap);

//                grouponService.processEndGroupon(groupon,grouponOrderList);
            }
        }
        return SUCCESS;
    }
}

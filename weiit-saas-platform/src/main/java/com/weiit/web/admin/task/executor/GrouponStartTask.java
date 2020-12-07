package com.weiit.web.admin.task.executor;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.task.service.GrouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

/**
 * Created by luo on 2018/7/7.
 *
 * 拼团活动生效
 */
@TaskHandler(value="grouponStartTask")
@Component
public class GrouponStartTask extends Task{

    @Autowired
    GrouponService grouponService;

    @Override
    public ReturnT<String> execute(String s) throws Exception {
        TaskLogger.log("XXL-JOB, grouponStartTask.拼团开始生效任务");
        //查询未开始的拼团活动
        FormMap formMap = new FormMap();
        formMap.put("state",-2);
        formMap.put("create_time",new Date());
        List<E> grouponList = grouponService.selectGrouponList(formMap);

        formMap.put("update_state",0);

        grouponService.updateGrouponOrderState(formMap);

        if (grouponList!=null && grouponList.size()>0){
            for (E groupon: grouponList){
                TaskLogger.log("拼团生效grouponStartTask groupon_id:" +groupon.get("groupon_id") );
//                formMap.clear();
//                formMap.put("state",0);
//                formMap.put("groupon_id",groupon.get("groupon_id"));
//                //更新为开始状态
//                grouponService.updateGrouponState(formMap);
            }
        }
        return SUCCESS;
    }
}

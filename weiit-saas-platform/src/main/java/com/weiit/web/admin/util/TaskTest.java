package com.weiit.web.admin.util;
 
import com.weiit.task.core.biz.ExecutorBiz;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.biz.model.TriggerParam;
import com.weiit.task.core.enums.ExecutorBlockStrategyEnum;
import com.weiit.task.core.glue.GlueTypeEnum;
import com.weiit.task.core.rpc.netcom.NetComClientProxy;

/**
 *  测试定时任务 
 */
public class TaskTest {

    public static void main(String[] args) throws Exception {

        // param
        String jobHandler = "merchantExpireTask";
        String params = "";

        // trigger data
        TriggerParam triggerParam = new TriggerParam();
        triggerParam.setJobId(1);
        triggerParam.setExecutorHandler(jobHandler);
        triggerParam.setExecutorParams(params);
        triggerParam.setExecutorBlockStrategy(ExecutorBlockStrategyEnum.COVER_EARLY.name());
        triggerParam.setGlueType(GlueTypeEnum.BEAN.name());
        triggerParam.setGlueSource(null);
        triggerParam.setGlueUpdatetime(System.currentTimeMillis());
        triggerParam.setLogId(1);
        triggerParam.setLogDateTim(System.currentTimeMillis());

        // do remote trigger
        String accessToken = "Weiit18565660736";
        ExecutorBiz executorBiz = (ExecutorBiz) new NetComClientProxy(ExecutorBiz.class, "127.0.0.1:9998", accessToken).getObject();
        ReturnT<String> runResult = executorBiz.run(triggerParam);
    }

}

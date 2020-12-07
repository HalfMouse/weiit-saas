package com.weiit.web.admin.task.executor;

import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import org.springframework.stereotype.Component;

/**
 * Created by 罗鸿强 on 2018/8/9.
 */
@TaskHandler("autoPublishMiniProgram")
@Component
public class AutoPublishMiniProgram extends Task {



    @Override
    public ReturnT<String> execute(String s) throws Exception {
        //查询新版本



        return null;
    }
}

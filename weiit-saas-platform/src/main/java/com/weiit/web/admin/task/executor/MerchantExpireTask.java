package com.weiit.web.admin.task.executor;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.web.admin.task.service.MerchantService;
import com.weiit.web.admin.util.DateUtil;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/11.
 *
 *
 * 商户到期
 */

@TaskHandler(value="merchantExpireTask")
@Component
public class MerchantExpireTask extends Task {
	@Resource
	MerchantService merchantService;
    
    @Override
    public ReturnT<String> execute(String s) throws Exception {
    	System.out.println("-----------------------------------------------------merchantExpireTask");

    	//商户还有三天到期的发送一条短信通知（后期改动  有店铺的商户才发送短信）
        FormMap merchMap = new FormMap();
        merchMap.set("expireDate",DateUtil.format(DateUtil.addDate(5,new Date(),3),"yyyy-MM-dd"));
        List<E> merchList = merchantService.selectList(merchMap);

        for (E merchInfo :merchList){
            //发送短信
            String [] msg ={merchInfo.getStr("account")};
            WeiitUtil.sendMobileMessage(merchInfo.getStr("account"),"175809",msg);
        }


        //商户到期
    	FormMap formMap = new FormMap();
        formMap.put("state",0);
        formMap.put("end_time",new Date());
        formMap.put("update_state",-1);
        merchantService.edit(formMap);
        
        //商户购买的服务项目到期
        FormMap serviceMap = new FormMap();
        serviceMap.put("state",1);
        serviceMap.put("end_time",new Date());
        serviceMap.put("update_state",2);
        merchantService.editMerchantService(serviceMap);
    	
        return SUCCESS;
    }


    public static void main(String[] args) {

        System.out.println(DateUtil.format(DateUtil.addDate(5,new Date(),3),"yyyy-MM-dd"));
    }
}

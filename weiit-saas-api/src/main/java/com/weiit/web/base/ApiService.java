package com.weiit.web.base;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.weiit.core.entity.E;
import com.weiit.core.service.BaseService;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.common.ApiResponseCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;


/**
 * Created by 罗鸿强 on 2018/9/19.
 */
public abstract class ApiService extends AbstractService implements BaseService {
    public final Logger logger = LoggerFactory.getLogger(this.getClass());
    /**
     * 直接返回json对象
     *
     * @param object
     * @return
     */
    public String toJson(Object object) {

        String result = JSON.toJSONString(object, SerializerFeature.WriteMapNullValue,
                SerializerFeature.DisableCircularReferenceDetect);
        logger.info("返回参数:{}",result);
        return result;
    }

    /**
     * 直接返回api接口，默认方法返回成功状态
     *
     * @param object
     * @return
     */
    public String toJsonAPI(Object object) {
        E e = new E();
        e.set("code", "0");
        e.set("message", "success");
        e.set("data", object);
        return toJson(e);
    }

    /**
     * 直接返回api接口，可自定义返回message,code
     *
     * @param object
     * @param message
     * @param code
     * @return
     */
    public String toJsonAPI(Object object, String message, String code) {
        E e = new E();
        e.set("code", code);
        e.set("message", message);
        e.set("data", object);
        return toJson(e);
    }

    public String toJsonAPI(ApiResponseCode apiResponseCode){
        E result = new E();
        result.set("code", apiResponseCode.getCode());
        result.set("message", apiResponseCode.getMessage());
        return toJson(result);
    }


    public  <T> T getObject(String json,Class clazz){
        return (T) JSON.parseObject(json,clazz);
    }

    /**
     * 四舍五入
     *
     * */
    public double getDoubleValue(BigDecimal bigDecimal){
        return bigDecimal.setScale(2,BigDecimal.ROUND_HALF_DOWN).doubleValue();
    }

    /**
     * 四舍五入支付精度缺失会少一分钱
     *
     * */
    public int getInterValue(BigDecimal bigDecimal){
        return bigDecimal.setScale(0,BigDecimal.ROUND_HALF_DOWN).intValue();
    }
}

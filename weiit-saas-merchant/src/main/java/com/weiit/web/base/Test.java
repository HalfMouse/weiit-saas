package com.weiit.web.base;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.weiit.core.entity.E;


public class Test {
	public static void main(String[] args) {
		String[] validate_id={"zhangsan","lisi","wangwu"};
		//System.out.println(WeiitUtil.getLogistics("ZTO", "880387829909"));
		E e =new E();
		e.put("shop_domain_prex", false);
		System.out.println(JSON.toJSONString(e, SerializerFeature.WriteMapNullValue,
				SerializerFeature.DisableCircularReferenceDetect));
	}
}

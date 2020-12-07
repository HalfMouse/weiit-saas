package com.weiit.web.util;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang.SystemUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.util.StringUtils;

import com.weiit.core.entity.E;

public class Test {
	
	
	
	public static void main(String[] args) throws Exception {

		String area ="110937,110938";
		String city= "1111";

		System.out.println(SystemUtils.getJavaVersion());
		System.out.println(SystemUtils.FILE_ENCODING);
		System.out.println(SystemUtils.FILE_SEPARATOR);
		System.out.println(SystemUtils.IS_OS_MAC);
		System.out.println(SystemUtils.IS_OS_WINDOWS_7);


		//String [] content={"123456","5分钟"};
		//WeiyunMobileMsgUtil.SendTemplateSMS("18306668080", "119614", content);
		
		//String [] content={"18306668080","5分钟"};
		//WeiyunMobileMsgUtil.SendTemplateSMS("18306668080", "129478", content);
		
//		/*boolean f=StringUtils.isEmpty(null);
//		System.out.println(f);
//
//		System.out.println(RandomUtils.nextInt(1000000));
//
//		WeiitCache.put(EhcacheTime.MIN, "key", "123456");
//		System.out.println(WeiitCache.get(EhcacheTime.MIN, "key"));
//
//		E u = JWTUtil.unsign("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.ejJleHAiOjE1MjQyOTUzNDQwMzYsInBheWxvYWQiOiJ7XCJpZFwiOjEsXCJ1c2VybmFtZVwiOlwiYWRtaW5cIn0ifQ.fw4lgiKW1WgxEkNLvTRQWV4WxvwGksQegjKFruUztgM", E.class);
//    	System.out.println(u);
//
//    	String [] msg={"123456","5分钟"};*/
		//boolean sendState=WeiitMobileMsgUtil.SendMobileMessageByYLY("18565660736", "119614", msg);
    	//String s="中午";
    	//String k=new String(s.getBytes("utf-8"),"utf-8");
    	//=new String(s.getBytes("ISO8859-1"), "UTF-8");
    	//=
    	//System.out.println(k);
//		for (int i = 0; i < 10; i++) {
//			E e =new E();
//			e.set("user_id", "16");
//			e.set("user_name", "半个鼠标");
//			e.set("user_name2", "半个鼠标");
//			e.set("user_name3", "半个鼠标");
//			e.set("user_name4", "半个鼠标");
//			e.set("user_name5", "半个鼠标");
//			e.set("user_name6", "半个鼠标");
//			e.set("user_name7", "半个鼠标");
//			e.set("user_name8", "半个鼠标");
//			e.set("user_name9", "半个鼠标");
//			e.set("user_name99", "半个鼠标");
//			e.set("user_name55", "半个鼠标");
//			e.set("user_name65", "半个鼠标");
//			e.set("user_name75", "半个鼠标");
//			e.set("user_name85", "半个鼠标");
//			e.set("user_name95", "半个鼠标");
//			e.set("user_name995", "半个鼠标");
//
//			String token2=JWTUtil.sign(e, 30L * 24L * 3600L * 1000L);
//			long t3=System.currentTimeMillis();
//			System.out.println(System.currentTimeMillis()+"t3");
//			E eresult = JWTUtil.unsign(token2, E.class);
//			long t4=System.currentTimeMillis();
//			System.out.println(System.currentTimeMillis()+"t4");
//			System.out.println(t4-t3);
//
//
//			E u =new E();
//			u.set("user_id", "16");
//			u.set("user_name", "半个鼠标");
//			String token1=JWTUtil.sign(u, 30L * 24L * 3600L * 1000L);
//			long t1=System.currentTimeMillis();
//			System.out.println(System.currentTimeMillis()+"t1");
//			E uresult = JWTUtil.unsign(token1, E.class);
//			long t2=System.currentTimeMillis();
//			System.out.println(System.currentTimeMillis()+"t2");
//
//			System.out.println(t2-t1);
//
//		}
		
	}
}

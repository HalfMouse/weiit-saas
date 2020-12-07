package com.weiit.web.util;

import com.weiit.resource.common.enums.EhcacheTime;
import com.weiit.resource.common.utils.EhcacheUtil;



public class WeiitCache {

	private static EhcacheUtil manager=EhcacheUtil.getInstance();
	
	/**
	 * 默认缓存读取方法，缓存机制是长久缓存
	 * @param key
	 * @return
	 */
	public static Object get(String key){
		return manager.get("alwaysCache", key);
	}
	
	
	/**
	 * 缓存读取方法，缓存机制支持，按照分钟、小时、天、长久四种策略
	 * 
	 * @param time
	 * @param key
	 * @param value
	 * @return
	 */
	public static Object get(EhcacheTime time, String key) {
		Object value=null;
		switch (time.getIndex()) {
		case 1:
			value=manager.get("minCache", key);
			break;
		case 2:
			value=manager.get("hourCache", key);
			break;
		case 3:
			value=manager.get("dayCache", key);
			break;
		case 4:
			value=manager.get("alwaysCache", key);
			break;
		default:
			value=manager.get("alwaysCache", key);
			break;

		}
		return value;
	}
	
	/**
	 * 默认缓存方法，缓存机制是长久缓存
	 * @param key
	 * @param value
	 * @return
	 */
	public static void put(String key,Object value){
		manager.put("alwaysCache", key, value);
	}
	
	/**
	 * 缓存存储方法
	 * 
	 * @param time
	 * @param key
	 * @param value
	 * @return
	 */
	public static void put(EhcacheTime time, String key,Object value) {
		
		switch (time.getIndex()) {
		case 1:
			manager.put("minCache", key, value);
			break;
		case 2:
			manager.put("hourCache", key, value);
			break;
		case 3:
			manager.put("dayCache", key, value);
			break;
		case 4:
			manager.put("alwaysCache", key, value);
			break;
		default:
			manager.put("alwaysCache", key, value);
			break;

		}
	}
	
	//使用测试
	public static void main(String[] args) {
		
		System.out.println("************缓存存储默认支持**************");
		//缓存长久存放
		WeiitCache.put("username:123", "zhangsan");
		//缓存获取
		System.out.println(WeiitCache.get("username:123"));
		
//		System.out.println("************缓存存储于获取1**************");
//		//缓存长久存放
//		WeiitCache.put(EhcacheTime.MIN, "username", "zhangsan");
//		//缓存获取
//		System.out.println(WeiitCache.get(EhcacheTime.MIN, "username"));
//
//		System.out.println("************缓存存储于获取2**************");
//		//缓存长久存放
//		WeiitCache.put(EhcacheTime.HOUR, "username", "zhangsan");
//		//缓存获取
//		System.out.println(WeiitCache.get(EhcacheTime.HOUR, "username"));
//
//		System.out.println("************缓存存储于获取3**************");
//		//缓存长久存放
//		WeiitCache.put(EhcacheTime.DAY, "username", "zhangsan");
//		//缓存获取
//		System.out.println(WeiitCache.get(EhcacheTime.DAY, "username"));
//
//		System.out.println("************缓存存储于获取4**************");
//		//缓存长久存放
//		WeiitCache.put(EhcacheTime.ALWAYS, "username", "zhangsan");
//		//缓存获取
//		System.out.println(WeiitCache.get(EhcacheTime.ALWAYS, "username"));
	}
}

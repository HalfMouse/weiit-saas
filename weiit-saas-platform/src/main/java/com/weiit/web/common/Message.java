package com.weiit.web.common;

import org.springframework.web.servlet.ModelAndView;


/**
 * @author 半个鼠标
 * @Email：137075251@qq.com
 * @date：2017年2月20日 上午2:48:07
 * @version 1.0
 */
public class Message {
	public static final boolean REDIRECT=true;
	public static final int ALERT=0;
	public static final int INFO=1;
	public static final int WARNNING=2;
	public static final int DANGER=3;
	public static final String NOTIFYMESSAGE="notifyMessage";
	public static final String DEFAULTMESSAGE="操作成功，一条记录被生效！";
	public ModelAndView showView(UIview view,int level){
		if(level==INFO){
			view.addFlashAttribute(NOTIFYMESSAGE,info(DEFAULTMESSAGE));
		}else if(level==WARNNING){
			view.addFlashAttribute(NOTIFYMESSAGE,warnning(DEFAULTMESSAGE));
		}else if(level==DANGER){
			view.addFlashAttribute(NOTIFYMESSAGE,danger(DEFAULTMESSAGE));
		}
		return view;
	}
	public ModelAndView showView(UIview view,String message,int level){
		if(level==INFO){
			view.addFlashAttribute(NOTIFYMESSAGE,info(message));
		}else if(level==WARNNING){
			view.addFlashAttribute(NOTIFYMESSAGE,warnning(message));
		}else if(level==DANGER){
			view.addFlashAttribute(NOTIFYMESSAGE,danger(message));
		}
		return view;
	}
	public String info(String message){
		String notify="<script>$(function(){"+
	        	"new PNotify({"+
	        	    "title: '提示操作',"+
	        	    "text: '"+message+"',"+
	        	    "addclass: 'bg-info'"+
	        	"});"+
	        "});</script>";
		return notify;
	}
	public String warnning(String message){
		String notify="<script>$(function(){"+
	        	"new PNotify({"+
	        	    "title: '提示操作',"+
	        	    "text: '"+message+"',"+
	        	    "addclass: 'bg-warning'"+
	        	"});"+
	        "});</script>";
		return notify;
	}
	public String danger(String message){
		String notify="<script>$(function(){"+
	        	"new PNotify({"+
	        	    "title: '提示操作',"+
	        	    "text: '"+message+"',"+
	        	    "addclass: 'bg-danger'"+
	        	"});"+
	        "});</script>";
		return notify;
	}
}

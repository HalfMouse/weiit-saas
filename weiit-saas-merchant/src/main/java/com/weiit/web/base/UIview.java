package com.weiit.web.base;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public class UIview extends ModelAndView{
	
	private RedirectAttributes attr;
	
	public UIview(){
		
	}
	
	public UIview(RedirectAttributes attr){
		this.attr=attr;
	}
	
	public RedirectAttributes addFlashAttribute(String attributeName,Object attributeValue){
		return this.attr.addFlashAttribute(attributeName, attributeValue);
	}
	
	public void addPNotifyMessage(String message){
		this.attr.addFlashAttribute("isPNotify", true);
		this.attr.addFlashAttribute("text", message);
	}
	public void addErrorMessage(String message){
		this.attr.addFlashAttribute("isError", true);
		this.attr.addFlashAttribute("text", message);
	}
	
}

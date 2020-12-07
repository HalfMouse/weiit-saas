package com.weiit.web.admin.setting.controller;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.publics.service.PublicsService;
import com.weiit.web.admin.setting.service.ExpressService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 设置》物流配送
 * @author：半个鼠标
 * @date：2018年6月5日 下午2:58:33
 * @version 2.0
 * @company http://www.wei-it.com 微邦互联
 */
@Controller
@RequestMapping("/setting")
public class ExpressController  extends AdminController {


	@Resource
	private ExpressService expressService;
	@Resource
	private PublicsService publicsService;


    /**
     *  物流公司管理-页面加载
     */
	@RequestMapping("/expressList")
	public UIview list() throws Exception { 
		//获取请求参数
    	FormMap formMap=getFormMap();
    	//查询商户常用快递
    	List<E> myExpressList=expressService.selectList(formMap);
		UIview result = UIView("/center/setting/expressList",false);
    	
		//查询所有快递公司
		List<E> allExpressList=expressService.selectAllExpressList(formMap);
		
        //绑定
        result.addObject("myExpressList", myExpressList);
        result.addObject("allExpressList", allExpressList);
		return result;
	}


	
    /**
     *  快递公司  》》  快递公司新增 
     */
	@ResponseBody
	@RequestMapping("/expressAdd")
	public String add() throws Exception {
		try { 
			FormMap formMap = getFormMap();
			
			if(StringUtils.isEmpty(formMap.getStr("express_id"))){
				return toJsonAPI("","添加常用快递时参数有误","1000");
			}else{
				//获得物流公司id，查询物流公司表信息
				E expressAli=expressService.selectExpressAliByExpressId(formMap);
				
				if(expressAli!=null){
					//将物流公司信息插入到商户的物流基本信息表去
					FormMap param=new FormMap();
					param.put("express_name", expressAli.getStr("express_name"));
					param.put("express_logo", expressAli.getStr("express_logo"));
					param.put("type", 0);
					param.put("shop_id", formMap.getStr("shop_id"));
					param.put("express_id", expressAli.getStr("express_id"));
					E myExpress=expressService.selectOne(param);
					if(myExpress!=null){
						return toJsonAPI(myExpress,"已经加入到常用快递","1000");
					}else{
						expressService.insert(param);
						E info=expressService.selectOne(param);
						return toJsonAPI(info,"添加成功","0");
					}
				}else{
					return toJsonAPI("","该物流公司已被下架","1000");
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace(); 
			return toJsonAPI("","添加常用快递失败","1000");
		}
	}

	/**
     *  快递公司  》》  快递公司 删除 
     */
	@ResponseBody
	@RequestMapping("/expressRemove")
	public String remove() throws Exception {
		try {
			FormMap formMap=getFormMap();
			E myExpress=expressService.selectOne(formMap);
			if(myExpress!=null){
				expressService.remove(formMap);
				return toJsonAPI(myExpress,"删除成功","0");
			}else{
				return toJsonAPI("","不能重复删除","1000");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return toJsonAPI("","删除失败","0");
		}
		
	}
 
}

package com.weiit.web.admin.product.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.product.service.ProductGroupService;
import com.weiit.web.admin.util.DesUtil;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

//import com.weiit.web.admin.ump.service.BargainService;
//import com.weiit.web.admin.ump.service.GrouponService;

/**
 * 商品分组
 * @author hzy 
 * @date 2017年7月7日
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/productGroup")
public class ProductGroupController extends AdminController {
	
	public static Logger logger= Logger.getLogger(ProductGroupController.class);
	
	@Resource
	private ProductGroupService productGroupService;

    /**
     * 商品分组列表
     */
    @RequestMapping("/list")
    public ModelAndView list() {
    	logger.info("进入ProductGroupController-list,商品分组列表"); 
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	List<E> list=productGroupService.selectList(formMap);
    	
    	UIview result = UIView("/center/product/groupList",false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap); 
    	return result;
    }

 
    /**
     *  新增 
     */
	@RequestMapping("/add")
	public String add()  {
		return "/center/product/groupEdit";
	}
	
    /**
     * 编辑 
     */
	@RequestMapping("/edit")
	public UIview edit() {
		UIview result=UIView("/center/product/groupEdit",false);
		try {
			FormMap formMap=getFormMap();
			E infoMap=productGroupService.selectOne(formMap);
	    	result.addObject("infoMap", infoMap); 
		} catch (Exception e) {
			e.printStackTrace();
			result.addErrorMessage("编辑失败，稍后重试");
		}
		return result;
	}
	
    /**
     *  新增，编辑保存 
     */
    @RequestMapping("/save")
    public UIview save() {
    	UIview result=UIView("list",true);
    	logger.info("进入ProductGroupController-save,商品分组保存"); 
    	try { 
	        FormMap formMap=getFormMap();
			if(formMap.get("validate_id")==null || formMap.get("validate_id").equals("")){
				productGroupService.insert(formMap);
			}else{
				productGroupService.edit(formMap);
			}    
    	} catch (Exception e) {
			e.printStackTrace();
			result.addErrorMessage("保存失败，稍后重试");
		}
		result.addPNotifyMessage("商品分组保存成功！");
        return result;
    }
    
    /**
     * 删除 
     */
    @RequestMapping("/remove")
    public UIview remove() {
    	UIview result=UIView("list",true);
    	logger.info("进入ProductGroupController-remove,商品分组删除");
    	try { 
    		FormMap formMap=getFormMap();
			//删除此分类
            productGroupService.remove(formMap);
    	} catch (Exception e) {
			e.printStackTrace();
			result.addErrorMessage("删除失败，稍后重试");
		}
		result.addPNotifyMessage("商品分组删除成功！");
        return result;
    }
    
	/**
	 * 查询商品分组列表--弹出选择框modal
	 */
	@ResponseBody
	@RequestMapping("/groupList.json")
	public String groupList() throws Exception {
		logger.info("进入ProductGroupController-GroupList,查询商品分组列表");
		try {
			FormMap formMap=getFormMap();
			formMap.set("group_name", new String(formMap.getStr("group_name").getBytes("ISO-8859-1")));//中文乱码
			List<E> productList=productGroupService.selectList(formMap);
			List<E> productJson=new ArrayList<E>();
			for (E e : productList) {
				E productInfo=new E();
				productInfo.set("group_name", e.getStr("group_name"));
				productInfo.set("create_time", e.getStr("create_time")); 
				
				productInfo.set("option", "<a href='javascript:;'   title='选取' class='btn bg-green m-r-5 m-b-5 able_group_"+e.getStr("validate_id")+"' style='height: 22px;padding-top: 0px;' onclick='selectProduct("+e.getStr("validate_id")+",\""+e.getStr("group_name")+"\")' >选取</a>");
				
				productJson.add(productInfo);
			}
			return toJsonAPI(productJson);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
	}



	/**
	 * 微页面装修   商品分组查询
	 */
	@RequestMapping(value = "/productGroupList",method = RequestMethod.GET)
	@ResponseBody
	public E productGroupList(String product_name, @RequestParam String token, String is_on_sale, String stock,Integer page,Integer rows) {
		logger.info("进入ProductGroupController-productGroupList,商品分组列表");
		FormMap formMap=new FormMap();
		E result = new E();
		try {
			formMap.put("shop_id", DesUtil.decrypt(token));
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("token 解密失败");
			result.put("desc","不要瞎搞");
			return result;
		}
		formMap.put("product_name", product_name);
		formMap.put("is_on_sale", is_on_sale);
		formMap.put("stock", stock);
		formMap.put("page", page);
		formMap.put("rows", rows);
		//开启分页
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> list=productGroupService.selectList(formMap);
		result.put("productGroupList",new PageInfo<E>(list));
		return result;
	}

	@RequestMapping(value = "/productGroupListNotoken",method = RequestMethod.GET)
	@ResponseBody
	public E productGroupListNotoken(String product_name, String is_on_sale, String stock,Integer page,Integer rows) {
		logger.info("进入ProductGroupController-productGroupList,商品分组列表");
		FormMap formMap=getFormMap();
		E result = new E();
		formMap.put("product_name", product_name);
		formMap.put("is_on_sale", is_on_sale);
		formMap.put("stock", stock);
		formMap.put("page", page);
		formMap.put("rows", rows);
		//开启分页
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> list=productGroupService.selectList(formMap);
		result.put("productGroupList",new PageInfo<E>(list));
		return result;
	}


	/**
	 *
	 * 微页面商品分组基本信息  根据group_ids 获取商品
	 * @author lhq
	 * @date 2018年5月9日
	 *
	 * request_param group_id
	 * */
	@RequestMapping(value = "/getProductByGroupIds",method = RequestMethod.GET)
	@ResponseBody
	public String getProductByGroupIds(@RequestParam String token,String group_ids) {
		logger.info("进入ProductGroupController-getProductByGroupIds,微页面  商品分组获取商品基本信息");
		FormMap formMap=new FormMap();
		try {
			formMap.put("shop_id", DesUtil.decrypt(token));
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("token 解密失败");
			return toJsonAPI("","解密失败","404");
		}

		if (StringUtils.isEmpty(group_ids)){
			//可定义一个异常Code类,,,或可跳转返回一个官方认可商店
			return toJsonAPI("","参数为空","404");
		}else {
			List<String> groupidList;
			if (group_ids.contains("[")){
				groupidList=Arrays.asList(StringUtils.strip(group_ids,"[]").split(","));
			}else {
				groupidList=Arrays.asList(group_ids.split(","));
			}
			List<E> result = new ArrayList();
			for (String group_id:groupidList){
				//根据group_id 返回分组下的商品
				formMap.put("group_id",group_id);
				List<E> list =productGroupService.getProductByGroupId(formMap);
				E groupInfo = new E();
				//返回前端所需数据格式
				if (list!=null && list.size()>0){
					groupInfo.put("productInfo",list);
					groupInfo.put("group_name",list.get(0).getStr("group_name"));
					groupInfo.put("group_id",group_id);
					result.add(groupInfo);
				}
			}
			return toJsonAPI(result);
		}
	}


}
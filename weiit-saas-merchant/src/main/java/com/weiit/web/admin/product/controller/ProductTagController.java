package com.weiit.web.admin.product.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.product.service.ProductTagService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

/**
 * 商品标签
 * @author hzy 
 * @date 2017年7月7日
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/productTag")
public class ProductTagController extends AdminController {
	
	public static Logger logger= Logger.getLogger(ProductTagController.class);
	
	@Resource
	private ProductTagService productTagService;
 
    /**
     * 商品标签查询 
     */
    @RequestMapping("/list")
    public ModelAndView list() {
			logger.info("进入ProductTagController-list,商品标签列表");
			FormMap formMap=getFormMap();
			//开启分页
			PageHelper.startPage(formMap.getPage(), formMap.getRows());
			List<E> list=productTagService.selectList(formMap);

			UIview result = UIView("/center/product/tagList",false);
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
			return "/center/product/tagEdit";
	}
	
    /**
     * 编辑 
     */
	@RequestMapping("/edit")
	public UIview edit()  {
			FormMap formMap=getFormMap();
			logger.info("进入ProductTagController-edit,商品标签编辑");
			UIview result=UIView("/center/product/tagEdit",false);

			E infoMap=productTagService.selectOne(formMap);
			result.addObject("infoMap", infoMap);
			return result;
	}
	
    /**
     *  新增，编辑保存 
     */
    @RequestMapping("/save")
    public UIview save() {
			UIview result=UIView("list",true);
			logger.info("进入ProductTagController-save,商品标签保存");
				FormMap formMap=getFormMap();
				if(formMap.get("validate_id")==null || formMap.get("validate_id").equals("")){
					productTagService.insert(formMap);
				}else{
					productTagService.edit(formMap);
				}

			result.addPNotifyMessage("商品标签保存成功！");
			return result;
    }
    
    /**
     * 删除 
     */
    @RequestMapping("/remove")
    public UIview remove() {
			UIview result=UIView("list",true);
			logger.info("进入ProductTagController-remove,商品标签删除");
			FormMap formMap=getFormMap();
			//删除此分类
			productTagService.remove(formMap);
			result.addPNotifyMessage("商品标签删除成功！");
			return result;
    }
    
	/**
	 * 查询商品标签列表--弹出选择框modal
	 */
	@ResponseBody
	@RequestMapping("/tagList.json")
	public String tagList() throws Exception {
			logger.info("进入ProductTagController-tagList,查询商品标签列表");
			FormMap formMap=getFormMap();
			//防止中文乱码
			try {
				formMap.set("tag_name", new String(formMap.getStr("tag_name").getBytes("ISO-8859-1")));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				throw new Exception("中文乱码");
			}
			List<E> productList=productTagService.selectList(formMap);
			List<E> productJson=new ArrayList<E>();
			for (E e : productList) {
				E productInfo=new E();
				productInfo.set("tag_name", e.getStr("tag_name"));
				productInfo.set("create_time", e.getStr("create_time")); 
				
				productInfo.set("option", "<a href='javascript:;'   title='选取' class='btn bg-green m-r-5 m-b-5 able_tag_"+e.getStr("validate_id")+"' style='height: 22px;padding-top: 0px;' onclick='selectProduct("+e.getStr("validate_id")+",\""+e.getStr("tag_name")+"\")' >选取</a>");
				
				productJson.add(productInfo);
			}
			return toJsonAPI(productJson);
	}
	
	/**
	 * 商品发布修改    上架，下架，删除状态
	 * @author hzy 
	 */
	@RequestMapping("/editProductTag")
	public UIview editProductTag(){
			logger.info("进入ProductController-editProductTag,商品分组修改");
			UIview result = UIView("/center/product/productTagModal",false);
			FormMap formMap=getFormMap();

			List<E> tagList=productTagService.selectList(formMap);
			this.getRequest().setAttribute("tagList", tagList);
			if(formMap.getStr("validate_id").equals("")){
				formMap.set("product_id", -1);
			}else{
				formMap.set("product_id", formMap.get("validate_id"));
			}
			List<E> tagDetailList=productTagService.selectDetailList(formMap);
			this.getRequest().setAttribute("tagDetailList", tagDetailList);

			result.addObject("queryParam", formMap);
			return result;
	}
	
	/**
	 * 商品发布修改    上架，下架，删除状态
	 * @author hzy 
	 */
	@RequestMapping("/editProductTagSave")
	public UIview editProductTagSave()  {
			logger.info("进入ProductController-editProductTag,商品分组修改");
			String retUrl="../product/onSaleList";
			FormMap map=getFormMap();
			String saleOld=map.getStr("saleOld");
			if(saleOld.equals("2")){
				retUrl="../product/soldOutList";
			}else if(saleOld.equals("3")){
				retUrl="../product/forSaleList";
			}
			productTagService.editProductTagSave(map);

			UIview result = UIView(retUrl,true);
			return result;
	}
    
}
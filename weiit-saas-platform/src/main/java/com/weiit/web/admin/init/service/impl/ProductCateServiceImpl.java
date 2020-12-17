package com.weiit.web.admin.init.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.ProductCateMapper;
import com.weiit.web.admin.init.service.ProductCateService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 商品分类Mapper
 * @author hezhiying
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("productCateService")
public class ProductCateServiceImpl extends AbstractService implements ProductCateService {

    @Resource
    private ProductCateMapper productCateMapper;

    @Override
	public BaseMapper setMapper() {
		return productCateMapper;
	}
    
    @Override
    public List<E> selectList(FormMap param){
    	List retList=new ArrayList();
    	List list =productCateMapper.selectList(param);
		if(null != list){
			for(int i = 0;i < list.size(); i++)
			{
				Map firstdaram = (Map)list.get(i);
				if(firstdaram.get("parent_id")!=null && firstdaram.get("parent_id").toString().equals("-1")){
					List secondList=new ArrayList();
					for(int j = 0 ; j < list.size() ; j++)
					{
						Map secondaram = (Map)list.get(j);
						if(secondaram.get("parent_id")!=null && 
								secondaram.get("parent_id").toString().equals( firstdaram.get("cate_id").toString()) ){
							List thirdList = new ArrayList();
							for(int m = 0 ; m < list.size() ; m++)
							{
								Map thirdaram = (Map)list.get(m);
								if(thirdaram.get("parent_id")!=null && 
										thirdaram.get("parent_id").toString().equals( secondaram.get("cate_id").toString()) ){
									thirdList.add(thirdaram);
								}
							} 
							secondaram.put("thirdList", thirdList);
							secondList.add(secondaram);
						}
					}
					firstdaram.put("secondList", secondList);
					retList.add(firstdaram);
				} 
			}
		}
		return retList;
    }
    
    @Override
    public int remove(FormMap param){   	
    	productCateMapper.remove(param);//删除分类
		param.put("parent_id", param.get("validate_id"));//如果是一级分类删除
		List secondList =productCateMapper.selectList(param);//二级分类
		if(null != secondList && secondList.size() > 0){
			for(int i = 0;i < secondList.size(); i++)
			{
				Map firstdaram = (Map)secondList.get(i);
				param.put("cate_id", firstdaram.get("cate_id"));
				productCateMapper.remove(param);//删除二级分类
				param.put("parent_id", firstdaram.get("cate_id"));
				//二级分类
				List thirdList =  productCateMapper.selectList(param);
				if(null != thirdList && thirdList.size() > 0)
				{
					for(int j = 0 ; j < thirdList.size() ; j++)
					{
						Map secondaram = (Map)thirdList.get(j);
                        param.put("cate_id", secondaram.get("cate_id"));
                        productCateMapper.remove(param);//删除三级分类
					}
				}
			}
		}
	    return 0;
    }
}

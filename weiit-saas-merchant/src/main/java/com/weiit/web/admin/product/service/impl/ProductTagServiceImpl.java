package com.weiit.web.admin.product.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.product.mapper.ProductTagMapper;
import com.weiit.web.admin.product.service.ProductTagService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 商品标签Mapper
 * @author hezhiying
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("productTagService")
public class ProductTagServiceImpl extends AbstractService implements ProductTagService {

    @Resource
    private ProductTagMapper productTagMapper;

    @Override
	public BaseMapper setMapper() {
		return productTagMapper;
	}
      
    @Override
    public int remove(FormMap param){
    	productTagMapper.removeDetail(param);
    	productTagMapper.remove(param); 
	    return 0;
    }
    
    @Override
    public  List<E> selectDetailList(FormMap param){
    	return productTagMapper.selectDetailList(param);
    }
	
	/**
	 * 插入 
	 */
    @Override
    public void insertDetail(FormMap param){
    	productTagMapper.insertDetail(param);
    }
	
	/**
	 * 删除 
	 */ 
    @Override
    public void removeDetail(FormMap param){
    	productTagMapper.removeDetail(param);
    }
    
	/**
	 * 修改商品标签
	 */
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public int editProductTagSave(FormMap map) {
		String[] validate_id =null ;
		if(map.get("ids")!=null && !map.getStr("ids").equals("")){
			validate_id =map.getStr("ids").split("\\|") ;
		}else{
			validate_id = new String[1];
			validate_id[0] = map.getStr("validate_id");
		}
		for (int i = 0; i < validate_id.length; i++) {
			FormMap tagDel=new FormMap();
			tagDel.put("product_id", validate_id[i]);
			productTagMapper.removeDetail(tagDel);
			
			String[] tag_id_str =null ;
			if(map.get("tag_id_str")!=null){
				if(map.get("tag_id_str") instanceof String[]){
					tag_id_str = (String[]) map.get("tag_id_str");
				}else{
					tag_id_str = new String[1];
					tag_id_str[0] = map.getStr("tag_id_str");
				}
	//			循环插入多个标签
				for (int j = 0; j < tag_id_str.length; j++) {
					if(tag_id_str[j]!=null && !tag_id_str[j].equals("")){
						FormMap tagMap=new FormMap();
						tagMap.put("tag_id", tag_id_str[j]);
						tagMap.put("product_id", validate_id[i]);
						tagMap.put("shop_id", map.get("shop_id")); 
						productTagMapper.insertDetail(tagMap);
					}
				}
			}
		}
		return 1;
	}
}

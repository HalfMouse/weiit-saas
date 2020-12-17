package com.weiit.web.admin.login.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.login.mapper.LoginMapper;
import com.weiit.web.admin.login.service.LoginService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
 * @author 半个鼠标
 * @date：2017-8-20 下午6:46:40
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service
public class LoginServiceImpl extends AbstractService implements LoginService {

	@Resource
	private LoginMapper loginMapper;
	
	@Override
	public BaseMapper setMapper() {
		return loginMapper;
	}
	
	@Override
	public E getManagerShopIdAndAppId(FormMap formMap) {
		E result=new E();
		getParentManager(formMap, result);
		return result;
	}
	
	/**
	 * 递归方法获取管理员所属的shop_id和app_id
	 * @param formMap
	 * @param result
	 */
	private void getParentManager(FormMap formMap,E result){
		//查询管理员信息
		E manager=loginMapper.selectOne(formMap);
		result.set("role_sign", manager.getStr("role_sign"));
//		//判断管理员是否为平台管理员，否  将管理员父id设置为管理员id 进行下次递归
//		if(manager.getInt("type")!=Constant.MANAGER_TYPE_ADMIN){
//			formMap.set("manager_id", manager.getInt("parent_id"));
//			getParentManager(formMap,result);
//		}else{
//			//是 则 查询管理员所属的app_id
//			FormMap pamas=new FormMap();
//			pamas.set("manager_id", manager.getInt("manager_id"));
//			E developerManager=loginMapper.selectDeveloperManagerByManagerId(pamas);
//			result.set("app_id", developerManager.getStr("app_id"));
//		}
//		//判断管理员的父id是否是1  1是平台管理员id 是 则查询出shop_id
//		//这块代码如果要在其他项目中使用，需将超管id更换
//		if(manager.getInt("parent_id")==1){
//			FormMap pamas=new FormMap();
//			pamas.set("manager_id", manager.getInt("manager_id"));
//			E shop=loginMapper.selectShopByManagerId(pamas);
//			result.set("shop_id", shop.getStr("shop_id"));
//		}
		
	}

	@Override
	public E selectShopInfo(FormMap formMap) {
		return loginMapper.selectShopInfo(formMap);
	}

	@Override
	public List<E> selectSystemManagerBalanceList(FormMap formMap) {
		// TODO Auto-generated method stub
		return loginMapper.selectSystemManagerBalanceList(formMap);
	}

	@Override
	public E selectSystemManagerLastBalance(FormMap formMap) {
		// TODO Auto-generated method stub
		return loginMapper.selectSystemManagerLastBalance(formMap);
	}

	@Override
	public void insertManagerBalance(FormMap formMap) {
		// TODO Auto-generated method stub
		loginMapper.insertManagerBalance(formMap);
	}

	@Override
	public E selectSystemManagerLastBalanceByValidateId(FormMap formMap) {
		// TODO Auto-generated method stub
		return loginMapper.selectSystemManagerLastBalanceByValidateId(formMap);
	}

}

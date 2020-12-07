package com.weiit.web.admin.file.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.file.mapper.PictureMapper;
import com.weiit.web.admin.file.service.PictureService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/**
 * 图片空间实现类
 * @author 半个鼠标
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("PictureService")
public class PictureServiceImpl  extends AbstractService  implements  PictureService{

	@Resource
	private PictureMapper pictureMapper;
	
	@Override
	public BaseMapper setMapper() {
		return pictureMapper;
	}

	@Override
	public int uploadFile(E param) {
		return pictureMapper.uploadFile(param);
	}

	@Override
	public List<E> getFileForPage(FormMap formMap) {
		return pictureMapper.getFileForPage(formMap);
	}

	@Override
	public List<E> getVideoList(FormMap formMap) {
		return pictureMapper.getVideoList(formMap);
	}

	@Override
	public void insertExpress(FormMap formMap) {
		pictureMapper.insertExpress(formMap);
	}


}



package com.weiit.web.admin.init.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

public interface AgreementMapper extends BaseMapper {

    List<E> selectAgreementList(FormMap formMap);
}
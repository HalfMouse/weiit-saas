package com.weiit.web.admin.miniprogram.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/19.
 */
public interface WxMiniProgramMapper extends BaseMapper {

    List<E> selectTestUserList(FormMap formMap);


    void addTestUser(FormMap formMap);

    void delTestUser(FormMap formMap);

    E selectMiniVersionInfo(FormMap formMap);

    E selectMiniCurrentAuthInfo(FormMap formMap);

    void addMiniAuth(FormMap formMap);

    void updateMiniAuth(FormMap formMap);


}

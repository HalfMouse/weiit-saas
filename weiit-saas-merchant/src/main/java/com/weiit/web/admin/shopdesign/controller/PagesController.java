package com.weiit.web.admin.shopdesign.controller;

import com.weiit.web.base.AdminController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 罗鸿强 on 2018/7/10.
 */
@Controller
@RequestMapping("/")
public class PagesController extends AdminController {
    @RequestMapping("pageAddOrEdit")
    public String pageAddOrEdit(){
        return "/center/design/page/pageAddOrEdit";
    }
}

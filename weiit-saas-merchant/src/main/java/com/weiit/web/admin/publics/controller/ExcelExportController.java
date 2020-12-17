package com.weiit.web.admin.publics.controller;


import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.CSVUtil;
import com.weiit.resource.common.utils.DateUtil;
import com.weiit.resource.common.utils.SpringUtil;
import com.weiit.resource.common.utils.XlsExcelUtil;
import com.weiit.web.admin.publics.service.ExcelExportService;
import com.weiit.web.base.AdminController;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.List;
 
/**
 * Excel公共服务
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/publics/excel")
public class ExcelExportController  extends AdminController {

	public static Logger logger=Logger.getLogger(PublicsController.class);
	
	@Resource
	private ExcelExportService excelExportService;
	
	/**
	 *  excel导出
	 */
	@RequestMapping("/export")
	public void export() throws Exception{
		logger.info("进入 ExcelExportController-export, excel导出 ");
		
		try {
			FormMap formMap=getFormMap();
			String exportClassName=formMap.getStr("exportClassName");
			String methodName=formMap.getStr("exportMethodName");
			String exportExcelName=formMap.getStr("exportExcelName");
			String exportTitles=formMap.getStr("exportTitles");
			String exportFields=formMap.getStr("exportFields");
			String fileType=formMap.getStr("fileType");
			
			Class<?> action=Class.forName(exportClassName);
			Object bean=SpringUtil.getBean(action); 
 
			Method method =  action.getMethod(methodName, FormMap.class);
			List<?> resultsList=(List<?>)method.invoke(bean, formMap);
 
			Date date=new Date(); 
			if(StringUtils.isNotBlank(exportExcelName)){
				exportExcelName=exportExcelName+DateUtil.dateToString(date, DateUtil.patternF);
			}else{
				exportExcelName=DateUtil.dateToString(date, DateUtil.patternF);
			} 
			exportExcelName=exportExcelName+(int)((Math.random()+1)*10000);
			String outPutPath= File.separator+"www"+File.separator+"files"+File.separator+"excel"+File.separator+""+DateUtil.dateToString(date, DateUtil.patternB)  ;
			
			File file=null;
			if(fileType.toUpperCase().equals("XLS") || fileType.toUpperCase().equals("XLSX")){
				fileType="xls";
				file=XlsExcelUtil.createXls(resultsList, exportTitles, exportFields, outPutPath+""+File.separator, exportExcelName);
			}else{
				fileType="csv";
				file=CSVUtil.createListCSV(resultsList, exportTitles, exportFields, outPutPath+""+File.separator, exportExcelName);
			}
			
			/*将生成的excel记录文件表记录，方便二次下载
			formMap.set("file_name", exportExcelName+"."+fileType);
			formMap.set("file_url", "");
			formMap.set("parent_id", "-1");
			formMap.set("type", 1);
			formMap.set("is_icon", 0);
			excelExportService.insert(formMap);
	 		*/
			this.getResponse().setCharacterEncoding("GBK");
			this.getResponse().setContentType("application/x-xls;charset=GBK");
			this.getResponse().setHeader("Content-Disposition", "attachment;filename=" + new String(exportExcelName.getBytes("GBK"), "ISO-8859-1") +  "."+fileType);
			FileInputStream in = new FileInputStream(file);
			ServletOutputStream out = this.getResponse().getOutputStream();
			byte b[] = new byte[1024*20];
			int i = 0;
			while((i=in.read(b))!=	-1){
				out.write(b, 0, i);
			}
			out.flush();
			out.close();
		    in.close();
		    this.getRequest().setAttribute("info","导出文件:"+file.getName());
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("导出文件异常..."+e.getMessage());
		}
	}
	
 
}

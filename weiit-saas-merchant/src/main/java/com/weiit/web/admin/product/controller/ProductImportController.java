package com.weiit.web.admin.product.controller;

import com.csvreader.CsvReader;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.product.service.ProductGroupService;
import com.weiit.web.admin.product.service.ProductImportService;
import com.weiit.web.admin.product.service.ProductService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.*;


/**
 * 
 * Title: ProductController.java
 * Description: 店铺 商品管理
 * Company: 微云时代
 * @author hzy
 * @date 2017年3月3日
 */
@Controller
@RequestMapping("/productImport")
public class ProductImportController  extends AdminController {
	@Resource
	private ProductImportService productImportService;
	@Resource
	private ProductService productService;
	@Resource
	private ProductGroupService productGroupService;
	
	/**
	 * 导入商品查询  
	 * @author hzy
	 * @return 
	 */
	@RequestMapping("/list")
	public UIview list() {
		//获取请求参数
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	//查询展示数量
    	List<E> list=productImportService.selectList(formMap);
    	//返回到list页面
    	UIview result = UIView("/center/product/importList",false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
		return result;
	}

	
	/**
	 * 商品发布第一页
	 * @author hzy 
	 */
	@RequestMapping("/releaseOne")
	public String releaseOne() throws Exception
	{
		FormMap requestMap=getFormMap();
		if(requestMap.get("oneflag")==null || "".equals(requestMap.get("oneflag").toString()) ){
			this.getSession().removeAttribute("productSession");
			return "/center/product/importReleaseOne";
		}
		List idslist=new ArrayList();
		for (Iterator iterator = requestMap.keySet().iterator(); iterator.hasNext();) {
 			String name = (String) iterator.next();
 			if(name.indexOf("mattvalids")!=-1){
 				idslist.add(requestMap.get(name));
 			}
		} 
		requestMap.put("idslist", idslist);
		
		if(requestMap.get("spec_config")!=null && requestMap.get("spec_config").toString().equals("1"))
		{
			int rowCount= Integer.parseInt( requestMap.get("rowCount").toString() );
			List skulist=new ArrayList();
			for (int i = 0; i < rowCount ; i++) {
				Map sukMap=new HashMap();
				sukMap.put("item_num", requestMap.get("itemNumlist"+i) );
				sukMap.put("supply_price", requestMap.get("supplyPricelist"+i) );
				sukMap.put("smarket_price", requestMap.get("smarketPricelist"+i));
				sukMap.put("sale_price", requestMap.get("salePricelist"+i));
				sukMap.put("stock", requestMap.get("stocklist"+i));
				skulist.add(sukMap);
			}
			requestMap.put("skulist", skulist);
		} 
		
		if(requestMap.get("mitems")!=null){ 
			if( requestMap.get("mitems").getClass().getName().equals("java.lang.String")){
				requestMap.put("mitemsCount", 1);
			}else if( requestMap.get("mitems").getClass().isArray() ){
				requestMap.put("mitemsCount", 2);
			}
		}
		if(requestMap.get("tag_id_str")!=null){ 
			if( requestMap.get("tag_id_str").getClass().getName().equals("java.lang.String")){
				requestMap.put("tag_id_count", 1);
			}else if( requestMap.get("tag_id_str").getClass().isArray() ){
				requestMap.put("tag_id_count", 2);
			}
		}
		getProductSession(requestMap);
		return "/center/product/importReleaseOne";
	}
	 
	/**
	 * 商品发布三个页面跳转 缓存数据
	 * @author hzy 
	 */
	public FormMap getProductSession(FormMap map) throws Exception
	{
		if(this.getSession().getAttribute("productSession")!=null){
			FormMap productSession=(FormMap)this.getSession().getAttribute("productSession");
			productSession.putAll( map );
			this.getSession().setAttribute("productSession", productSession );
			return productSession;
		}else{
			this.getSession().setAttribute("productSession", map);
			return map;
		}
	}
	
	/**
	 * 商品发布第二页
	 * @author hzy 
	 */
	@RequestMapping("/releaseTwo")
	public String releaseTwo() throws Exception
	{ 
		FormMap requestMap=getFormMap();
		
		if(requestMap.get("oneflag")==null || "".equals(requestMap.get("oneflag").toString()) ){
			this.getSession().removeAttribute("productSession");
		}
		
		if(requestMap.get("product_id")!=null && !requestMap.get("product_id").toString().equals("")){
			this.getSession().removeAttribute("productSession");
			Map product=productImportService.selectOne(requestMap);
			requestMap.putAll(product);
			
			List imagesList=new ArrayList();
			if(product.get("images")!=null && !product.get("images").equals("")){
				String images=product.get("images").toString();
				String [] imagesarr=images.split(";");
				List arrlist = Arrays.asList(imagesarr);
	        	imagesList= new ArrayList(arrlist);
			}
			requestMap.put("imagesList", imagesList);
		}

		requestMap=getProductSession(requestMap);
 
		String cateId="0";
		if(requestMap.get("thirdCateId")!=null && !requestMap.get("thirdCateId").toString().equals("") ){
			cateId=requestMap.get("thirdCateId").toString();
		}else if(requestMap.get("secondCateId")!=null  && !requestMap.get("secondCateId").toString().equals("")){
			cateId=requestMap.get("secondCateId").toString();
		}else if(requestMap.get("firstCateId")!=null  && !requestMap.get("firstCateId").toString().equals("")){
			cateId=requestMap.get("firstCateId").toString();
		}
		requestMap.put("cate_id", cateId );	

		List attrList=productService.selectAttrList(requestMap);  
		this.getRequest().setAttribute("attrList", attrList); 
		
		FormMap shipMap=new FormMap();
		shipMap.put("app_id", requestMap.get("app_id"));
//		List shipList=shippingService.selectList(shipMap);
//		this.getRequest().setAttribute("shipList", shipList);
		
		List tagList=productGroupService.selectList(requestMap);
		this.getRequest().setAttribute("tagList", tagList);
		
		return "/center/product/importReleaseTwo";
	}
	
	/**
	 * 商品发布第三页
	 * @author hzy 
	 */
	@RequestMapping("/releaseThree")
	public String releaseThree() throws Exception
	{
		FormMap requestMap=this.getFormMap();
		try {
			// 转型为MultipartHttpRequest：   
	        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();
	        // 获得文件：   
	        List imagesList=new ArrayList();
	        String [] imgArr= this.getRequest().getParameterValues("imagesList");
	        if(imgArr!=null ){
	        	List arrlist = Arrays.asList(imgArr);
	        	imagesList= new ArrayList(arrlist);
	        }
	        Map<String, MultipartFile> fileMap=multipartRequest.getFileMap();
	        if(fileMap!=null && !fileMap.isEmpty()){
		        for (Iterator iterator = fileMap.keySet().iterator(); iterator.hasNext();) {
		        	String key = iterator.next().toString();
		        	MultipartFile mFile=fileMap.get(key);
		        	if( !mFile.isEmpty()){
				        String pictureName=WeiitUtil.uploadFile(mFile);
				        imagesList.add(pictureName);
			        }
				}
	        }
	        requestMap.put("imagesList", imagesList);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
 
		List idslist=new ArrayList();
		for (Iterator iterator = requestMap.keySet().iterator(); iterator.hasNext();) {
 			String name = (String) iterator.next();
 			if(name.indexOf("mattvalids")!=-1){
 				idslist.add(requestMap.get(name));
 			}
		} 
		requestMap.put("idslist", idslist);
		
		if(requestMap.get("specConfig")!=null && requestMap.get("specConfig").toString().equals("1"))
		{
			int rowCount= Integer.parseInt( requestMap.get("rowCount").toString() );
			List skulist=new ArrayList();
			for (int i = 0; i < rowCount ; i++) {
				Map sukMap=new HashMap();
				sukMap.put("itemNum", requestMap.get("itemNumlist"+i) );
				sukMap.put("barCode", requestMap.get("barCodelist"+i) );
				sukMap.put("smarketPrice", requestMap.get("smarketPricelist"+i));
				sukMap.put("salePrice", requestMap.get("salePricelist"+i));
				sukMap.put("stock", requestMap.get("stocklist"+i));
				skulist.add(sukMap);
			}
			requestMap.put("skulist", skulist);
		}
		if(requestMap.get("mitems")!=null){ 
			if( requestMap.get("mitems").getClass().getName().equals("java.lang.String")){
				requestMap.put("mitemsCount", 1);
			}else if( requestMap.get("mitems").getClass().isArray() ){
				requestMap.put("mitemsCount", 2);
			}
		}
		if(requestMap.get("tag_id_str")!=null){ 
			if( requestMap.get("tag_id_str").getClass().getName().equals("java.lang.String")){
				requestMap.put("tag_id_count", 1);
			}else if( requestMap.get("tag_id_str").getClass().isArray() ){
				requestMap.put("tag_id_count", 2);
			}
		}
		
		if(this.getSession().getAttribute("productSession")!=null){
			FormMap productSession=(FormMap)this.getSession().getAttribute("productSession");
			if(requestMap.get("tag_id_str")==null){
				productSession.remove("tag_id_str");
			}
			productSession.putAll( requestMap );
			this.getSession().setAttribute("productSession", productSession ); 
		}
		return "/center/product/importReleaseThree";
	}
 
	/**
	 *  导入商品 保存 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/importSave")
	public UIview saveProductImport() throws Exception{
		UIview result=UIView("list",true);
		String title="商品导入成功！";
		List<FormMap> csvList=new ArrayList<FormMap>();
		try {
			// 转型为MultipartHttpRequest：   
	        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();
	        // 获得文件：   
	        MultipartFile mFile = multipartRequest.getFile("mfile");
 
			//生成CsvReader对象，以，为分隔符，utf-16编码方式
	        CsvReader r = new CsvReader(mFile.getInputStream(), '\t',Charset.forName("utf-16"));
	        //读取表头
	        r.readHeaders();
	        System.out.println(r.getRawRecord()); 
	        r.readRecord();
	        r.readRecord();
	        
	        FormMap requestMap=this.getFormMap();
	        //逐条读取记录，直至读完
	        while (r.readRecord()) {
	            //读取一条记录
//	            System.out.println(r.getRawRecord()); 
	            // 读取这条记录的值 
	            String []arr=r.getValues();
                String  cell = arr[28]; //取得第row行第0列的数据
                String orgImg="";
                String images="";
                if(cell!=null && cell.lastIndexOf("|")!=-1 ){
                	String [] img=cell.split(";");
                	for (int i = 0; i < img.length & i<5 ; i++) {
                		if(!images.equals("")){
                			images=images+";";
                		}
                		images= images + img[i].substring(img[i].lastIndexOf("|")+1 , img[i].length() );
                		if(orgImg.equals("")){
                			orgImg= images;
                		}
                	}
                }
                FormMap map=new FormMap();
                map.put("product_name", arr[0]);
                map.put("original_img", images);
                map.put("images", images);
                map.put("item_num", arr[33]);
                map.put("bar_code", arr[54]);
                map.put("sale_price", arr[7]);
                map.put("stock", arr[9]);
                map.put("product_desc", arr[20]);
                map.put("shop_id", requestMap.get("shopId"));
	            csvList.add(map);
	        }
	        r.close(); 
            System.out.println("当前存在的行数 "+csvList.size());
            if(csvList.size()==0){
            	title="文件格式错误，请使用淘宝最新csv文件！";
            }
            
            for (FormMap csvMap : csvList) {
            	String orgImg="";
            	String images="";
            	if(csvMap.get("originalImg")!=null){
            		String originalImg = csvMap.get("originalImg").toString();
            		String [] imgarr = originalImg.split(";");
            		for (int j = 0; j < imgarr.length; j++) {
            			String img = imgarr[j];
            			try {
            				URL url = new URL(img);  
                            HttpURLConnection conn = (HttpURLConnection)url.openConnection();  
                            conn.setRequestMethod("GET");
                            conn.setDoOutput(true);
                            conn.setConnectTimeout(5 * 1000);
                            InputStream inStream = conn.getInputStream();  
                            ByteArrayOutputStream outStream = new ByteArrayOutputStream();  
                            byte[] buffer = new byte[1024*200];  
                            int len = 0;  
                            while( (len=inStream.read(buffer)) != -1 ){  
                                outStream.write(buffer, 0, len);  
                            }  
                            byte [] bytes = outStream.toByteArray(); 
                	        String pictureName=WeiitUtil.uploadFile(bytes,"jpg");
                	        if(images.equals("")){
                	        	images= pictureName ;
                    			orgImg= pictureName ;
                    		}else{
                    			images=images+";"+pictureName;
                    		}
						} catch (Exception e) {
							logger.info("一个图片上传失败！");
						}
                    	
					}
            	}
            	csvMap.put("originalImg", orgImg);
    	        csvMap.put("images", images);
			}
            productImportService.insertProductImport(csvList); 
		} catch (Exception e) {
			e.printStackTrace();
			title="导入失败，请使用最新版的淘宝助手导出CSV文件！";
		}
		result.addPNotifyMessage(title);
		return result;
	}
	
	/**
	 * 导入商品 发布 保存 
	 */
	@RequestMapping("/save")
	public UIview saveProductImportToProduct() throws Exception{
		UIview result=UIView("list",true);
		try {
			FormMap requestMap=this.getFormMap();
			requestMap=getProductSession(requestMap);
			requestMap.put("importProductId", requestMap.get("product_id"));
			requestMap.remove("product_id");
			requestMap.put("state", 0);
			requestMap.put("officialState", "0");
			productService.insert(requestMap);
			
			this.getSession().removeAttribute("productSession");
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("导入商品发布成功！");
		return result;
	} 
	
	/**
	 * 删除导入商品
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/remove")
	public UIview deleteProductImport() throws Exception {
		UIview result=UIView("list",true);
		try {
			FormMap param=this.getFormMap();
			productImportService.remove(param);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("导入商品删除成功！");
		return result;
	}
	
	
}

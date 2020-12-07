package com.weiit.web.admin.util;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.weiit.core.entity.E;

public class Test {
	
	public static void main(String[] args) {
		Test test=new Test();
		//test.addCate();
		List<HashMap> list=test.addProduct();
		System.out.println(list.size());
	}

	/*线上saas数据库链接*/
	public Connection getConn() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://121.40.223.175:3306/weiyun_shop_f2b",
				"root", "Weiit890D");
		return conn;
	}
	

	//释放连接
	private void releaseResources(Connection conn, PreparedStatement ps,
			ResultSet rs) {
		try {
			if (null != rs)
				rs.close();
			if (null != ps)
				ps.close();
			if (null != conn)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	public  void addCate() {
		String sql = "select * from weiit_open_product_cate where create_time>'2018-04-30'";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<HashMap> cateList=new ArrayList<HashMap>();
		try {
			conn =getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				HashMap<String, String> cate = new HashMap<String, String>();
				cate.put("cate_id", rs.getString(1));
				cate.put("cate_name", rs.getString(2));
				cate.put("cate_img", rs.getString(3));
				cate.put("cate_icon_img", rs.getString(4));
				cate.put("parent_id", rs.getString(5));
				cate.put("sort_num", rs.getString(6));
				cate.put("is_official", rs.getString(7));
				cate.put("is_show", rs.getString(8));
				cate.put("is_disabled", rs.getString(9));
				cate.put("is_deleted", rs.getString(10));
				cate.put("create_time", rs.getString(11));
				cate.put("update_time", rs.getString(12));
				
				cateList.add(cate);
			}
			for (int i = 23; i < 32; i++) {
				for (HashMap cate : cateList) {
					
					String cate_sql = "insert into weiit_open_product_cate(cate_name, cate_img, cate_icon_img, parent_id,sort_num,is_official, is_show,is_disabled,is_deleted,create_time,update_time,shop_id,app_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
					try {
						Connection conn2 =getConn();
						PreparedStatement ps2=conn2.prepareStatement(cate_sql);
						ps2.setString(1, cate.get("cate_name").toString());
						ps2.setString(2, cate.get("cate_img").toString());
						ps2.setString(3, cate.get("cate_icon_img").toString());
						ps2.setString(4, cate.get("parent_id").toString());
						ps2.setString(5, cate.get("sort_num").toString());
						ps2.setString(6, cate.get("is_official").toString());
						ps2.setString(7, cate.get("is_show").toString());
						ps2.setString(8, cate.get("is_disabled").toString());
						ps2.setString(9, cate.get("is_deleted").toString());
						ps2.setString(10, cate.get("create_time").toString());
						ps2.setString(11, cate.get("update_time").toString());
						ps2.setString(12, i+"");
						ps2.setString(13, "10086");
						ps2.execute();
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
				
				
			
			System.out.println(111);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 释放资源
			releaseResources(conn, ps, rs);
		}
	}
	
	public  List<HashMap> addProduct() {
		String sql = "select product_id,product_num,product_name,supply_price,smarket_price,sale_price,stock,product_img,sale_count,purchase,express_config,is_on_sale,create_time,update_time from weiit_open_product where create_time>'2018-04-30'";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<HashMap> cateList=new ArrayList<HashMap>();
		try {
			conn =getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				HashMap<String, Object> cate = new HashMap<String, Object>();
				cate.put("product_id", rs.getString(1));
				cate.put("product_num", rs.getString(2));
				cate.put("product_name", rs.getString(3));
				cate.put("supply_price", rs.getString(4));
				cate.put("smarket_price", rs.getString(5));
				cate.put("sale_price", rs.getString(6));
				cate.put("stock", rs.getString(7));
				cate.put("product_img", rs.getString(8));
				cate.put("sale_count", rs.getString(9));
				cate.put("purchase", rs.getString(10));
				cate.put("express_config", rs.getString(11));
				cate.put("is_on_sale", rs.getString(12));
				cate.put("create_time", rs.getString(13));
				cate.put("update_time", rs.getString(14));
				
				//根据商品id查询商品的图片信息
				String image_sql="select product_id,product_img,type,is_deleted from weiit_open_product_images where product_id="+rs.getString(1);
				Connection conn2 =getConn();
				PreparedStatement ps2=conn2.prepareStatement(image_sql);
				ResultSet rs2=ps2.executeQuery();
				List<HashMap> imageList=new ArrayList<HashMap>();
				while(rs2.next()){
					HashMap<String, String> images = new HashMap<String, String>();
					images.put("product_id", rs2.getString(1));
					images.put("product_img", rs2.getString(2));
					images.put("type", rs2.getString(3));
					images.put("is_deleted", rs2.getString(4));
					imageList.add(images);
				}
				cate.put("imageList", imageList);
				
				//查询描述
				String desc_sql="select product_id,product_desc,is_deleted from weiit_open_product_desc where product_id="+rs.getString(1);
				Connection conn3 =getConn();
				PreparedStatement ps3=conn3.prepareStatement(desc_sql);
				ResultSet rs3=ps3.executeQuery();
				
				rs3.next();
				HashMap<String, String> desc = new HashMap<String, String>();
				desc.put("product_id", rs3.getString(1));
				desc.put("product_desc", rs3.getString(2));
				desc.put("is_deleted", rs3.getString(3));
				
				cate.put("desc", desc);
				cateList.add(cate);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 释放资源
			releaseResources(conn, ps, rs);
		}
		return cateList;
	}
}

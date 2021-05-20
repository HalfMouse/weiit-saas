ALTER TABLE weiit_page ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_page_global ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_page_bottom_menu ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_page_bottom_menu ADD state INT NULL COMMENT '状态';
ALTER TABLE weiit_page_bottom_menu ADD create_time TIMESTAMP NULL;
ALTER TABLE weiit_page_bottom_menu ADD update_time TIMESTAMP NULL;
ALTER TABLE weiit_product ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_shop_express ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_product_custom_key ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_product_desc ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_product_images ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_product_item ADD shop_id INT NULL COMMENT '店铺ID';
 
UPDATE weiit_page SET shop_id=350;
UPDATE weiit_page_global  SET shop_id=350;
UPDATE weiit_page_bottom_menu SET shop_id=350;
UPDATE weiit_product SET shop_id=350;
UPDATE weiit_shop_express SET shop_id=350;
UPDATE weiit_product_custom_key SET shop_id=350;
UPDATE weiit_product_desc SET shop_id=350;
UPDATE weiit_product_images SET shop_id=350;
UPDATE weiit_product_item SET shop_id=350;







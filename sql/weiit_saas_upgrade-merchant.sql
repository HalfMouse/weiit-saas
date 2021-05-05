ALTER TABLE weiit_page ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_page_global ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_page_bottom_menu ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_page_bottom_menu ADD state INT NULL COMMENT '状态';
ALTER TABLE weiit_page_bottom_menu ADD create_time TIMESTAMP NULL;
ALTER TABLE weiit_page_bottom_menu ADD update_time TIMESTAMP NULL;
ALTER TABLE weiit_product ADD shop_id INT NULL COMMENT '店铺ID';
ALTER TABLE weiit_shop_express ADD shop_id INT NULL COMMENT '店铺ID';



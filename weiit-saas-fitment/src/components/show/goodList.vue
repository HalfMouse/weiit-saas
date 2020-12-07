<template>
    <div class="showBox">
        <div class="good_list blankShow">
            <!-- 大图显示 -->
            <div class="list_box" v-if="listStyle == 'big'">
                <ul class="big_list fn-clear" v-if="showGoods.length == 0">
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="/static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'/static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="/static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'/static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="/static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'/static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="/static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'/static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                </ul>
                <ul class="big_list fn-clear" v-else>
                    <li v-for="item in showGoods">
                         <div class="good_pic">
                            <img class="goodsPic" :src="imageDomaia + item.product_img" alt="" draggable="false">
                            <!-- <img class="goodsPic" src="../../../static/images/goods.png" alt=""> -->
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 小图显示 -->
            <div class="list_box" v-if="listStyle == 'small'">
                <ul class="small_list fn-clear" v-if="showGoods.length == 0">
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                </ul>
                <ul class="small_list fn-clear" v-else >
                    <li v-for="item in showGoods">
                        <div class="good_pic">
                            <img class="goodsPic" :src="imageDomaia + item.product_img" alt="" draggable="false">
                            <!-- <img class="goodsPic" src="../../../static/images/goods.png" alt=""> -->
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 一大两小图显示 -->
            <div class="list_box" v-if="listStyle == 'zigzag'">
                <ul class="zigzag_list fn-clear" v-if="showGoods.length == 0">
                    <li class="big">
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                    <li class="small">
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                    <li class="small">
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                </ul>
                <ul class="zigzag_list fn-clear" v-else>
                    <li class="big" v-for="item in showbigGoods">
                        <div class="good_pic">
                            <img class="goodsPic" :src="imageDomaia + item.product_img" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'/static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                    <li class="small" v-for="item in showSmallGoods">
                        <div class="good_pic">
                            <img class="goodsPic" :src="imageDomaia + item.product_img" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'/static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 详细列表图显示 -->
            <div class="list_box" v-if="listStyle == 'detailed'">
                <ul class="detailed_list" v-if="showGoods.length == 0">
                    <li class="fn-clear">
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <p class="des">此处是描述部分</p>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                    <li class="fn-clear">
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <p class="des">此处是描述部分</p>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                    <li class="fn-clear">
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <p class="des">此处是描述部分</p>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                    <li class="fn-clear">
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <p class="des">此处是描述部分</p>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                </ul>
                <ul class="detailed_list" v-else>
                    <li v-for="item in showGoods" class="fn-clear">
                        <div class="good_pic">
                            <img class="goodsPic" :src="imageDomaia + item.product_img" alt="" draggable="false">
                            <!-- <img class="goodsPic" src="../../../static/images/goods.png" alt=""> -->
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <p class="des">{{item.firstCateName}}{{item.secondCateName}}{{item.thirdCateName}}</p>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn1'">
                            <i class="icon iconfont icon-gouwuche"></i>
                        </div>
                        <div class="shop" v-if="buyBtn && btnStyle == 'btn2'">
                            <i class="icon iconfont icon-jia"></i>
                        </div>
                        <div class="shop1" v-if="buyBtn && btnStyle == 'btn3'">
                            {{btnTxt3}}
                        </div>
                        <div class="shop2" v-if="buyBtn && btnStyle == 'btn4'">
                            {{btnTxt4}}
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 一行三个图显示 -->
            <div class="list_box" v-if="listStyle == 'more'">
                <ul class="small_list more_list fn-clear" v-if="showGoods.length == 0">
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                    <li>
                        <div class="good_pic">
                            <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">此处显示商品名称</h5>
                            <span v-if="goodPrice">￥999.00</span>
                        </div>
                    </li>
                </ul>
                <ul class="small_list more_list fn-clear" v-else>
                    <li v-for="item in showGoods">
                        <div class="good_pic">
                            <img class="goodsPic" :src="imageDomaia + item.product_img" alt="" draggable="false">
                            <!-- <img class="goodsPic" src="../../../static/images/goods.png" alt=""> -->
                            <div class="cornerMark" v-show="cornerMark">
                                <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                            </div>
                        </div>
                        <div class="good_txt">
                            <h5 v-if="goodName">{{item.product_name}}</h5>
                            <span v-if="goodPrice">￥{{item.sale_price}}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 横向滚动图显示 -->
            <div class="list_box" v-if="listStyle == 'scroll'">
                <div class="scroll_box">
                    <ul class="small_list more_list fn-clear scroll_lsit" v-if="showGoods.length == 0">
                        <li>
                            <div class="good_pic">
                                <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                                <div class="cornerMark" v-show="cornerMark">
                                    <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                                </div>
                            </div>
                            <div class="good_txt">
                                <h5 v-if="goodName">此处显示商品名称</h5>
                                <span v-if="goodPrice">￥999.00</span>
                            </div>
                        </li>
                        <li>
                            <div class="good_pic">
                                <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                                <div class="cornerMark" v-show="cornerMark">
                                    <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                                </div>
                            </div>
                            <div class="good_txt">
                                <h5 v-if="goodName">此处显示商品名称</h5>
                                <span v-if="goodPrice">￥999.00</span>
                            </div>
                        </li>
                        <li>
                            <div class="good_pic">
                                <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                                <div class="cornerMark" v-show="cornerMark">
                                    <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                                </div>
                            </div>
                            <div class="good_txt">
                                <h5 v-if="goodName">此处显示商品名称</h5>
                                <span v-if="goodPrice">￥999.00</span>
                            </div>
                        </li>
                        <li>
                            <div class="good_pic">
                                <img class="goodsPic" src="static/images/goods.png" alt="" draggable="false">
                                <div class="cornerMark" v-show="cornerMark">
                                    <img :src="'static/images/' + corner + '.png'" alt="" draggable="false">
                                </div>
                            </div>
                            <div class="good_txt">
                                <h5 v-if="goodName">此处显示商品名称</h5>
                                <span v-if="goodPrice">￥999.00</span>
                            </div>
                        </li>
                    </ul>
                    <ul class="small_list more_list fn-clear scroll_lsit" v-else>
                        <li v-for="item in showGoods">
                            <div class="good_pic">
                                <img class="goodsPic" :src="imageDomaia + item.product_img" alt="" draggable="false">
                            <!-- <img class="goodsPic" src="../../../static/images/goods.png" alt=""> -->
                                <div class="cornerMark" v-show="cornerMark">
                                    <img :src="'static/images/' + corner + '.png'" alt=""  draggable="false">
                                </div>
                            </div>
                            <div class="good_txt">
                                <h5 v-if="goodName">{{item.product_name}}</h5>
                                <span v-if="goodPrice">￥{{item.sale_price}}</span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    <!-- 设置列表 -->
        <div class="modify_box head_modify">
            <head-modify :keyText="keyText"></head-modify>
            <set-list @event="getData" :pageParam="pageParam"></set-list>
        </div> 
    </div>
</template>

<script>
    // 设置列表
    import setList from '@/components/set/setList'
    // 设置头部
    import headModify from '@/components/common/headModify'
    import List from '../../../static/js/List'
    import {mapActions} from 'vuex'
    export default {
        props:{
            keyText:String,
            tempId:Number,
            keyWords:String,
            pageParam:{
                type:Object,
                default:() => {
                    return {
                        addFun: 'manual',
                        showNum:4,
                        listStyle:'big',
                        goodName:true,
                        goodDes:'des',
                        goodPrice:true,
                        buyBtn:true,
                        btnStyle:'btn1',
                        cornerMark:true,
                        corner:'new',
                        btnTxt3:'马上抢',
                        btnTxt4:'购买',
                        showGoods:[],
                        showbigGoods:[],
                        showSmallGoods:[],
                        productIds:[]
                    }
                }
            }
        },
        data() {
            return {
                addFun: 'manual',
                showNum:6,
                listStyle:'big',
                goodName:true,
                goodDes:'des',
                goodPrice:true,
                buyBtn:true,
                btnStyle:'btn1',
                cornerMark:true,
                corner:'new',
                btnTxt3:'马上抢',
                btnTxt4:'购买',
                showGoods:[],
                showbigGoods:[],
                showSmallGoods:[],
                // 图片前缀名
                imageDomaia:'http://wstore-1255653546.image.myqcloud.com',
                productIds:[]
            }
        },
        components:{
            setList,
            headModify
        },
        methods:{
            ...mapActions(['addData','changeData']),
            // 样式参数
            getData(list){
                this.addFun = list.addFun;
                this.showNum = list.showNum ? list.showNum : 6;
                this.listStyle = list.listStyle;
                this.goodName = list.goodName;
                this.goodDes = list.goodDes;
                this.goodPrice = list.goodPrice;
                this.buyBtn = list.buyBtn;
                this.btnStyle = list.btnStyle;
                this.cornerMark = list.cornerMark;
                this.corner = list.corner;
                this.btnTxt3 = list.btnTxt3;
                this.btnTxt4 = list.btnTxt4;
                this.productIds = list.productIds;
            	if(list.addFun == 'manual'){
                    if(this.productIds.length == 0){
                        this.showGoods = [];
	                    this.showbigGoods = [];
	                    this.showSmallGoods = [];
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/product/getProductListByIds',
                            params:{
                                productIds:JSON.stringify(this.productIds),
                                productGetType:0
                            }
                        }).then(res => {
                            this.showGoods = res.data.productInfo;
                            this.showbigGoods = this.showGoods.slice(0,1);
                            this.showSmallGoods = this.showGoods.slice(1,3);
                        }).catch(err => {
                            (err);
                        })
                    }
	                
            	}else if(list.addFun == 'automatic'){
                    this.$ajax({
                        methods:'get',
                        url:'/center/product/getProductListByIds',
                        params:{
                            productGetType:1
                        }
                    }).then(res => {
                        this.showGoods = res.data.productInfo.splice(0, this.showNum);
                        this.showbigGoods = this.showGoods.slice(0,1);
                        this.showSmallGoods = this.showGoods.slice(1,3);
                    }).catch(err => {
                        (err);
                    })
            	}
                this.changeData({id:this.tempId,op:list})
            },
            // 存储数据
            saveData(){
                let list = new List();
                list.pageParam.addFun = this.addFun;
                list.pageParam.showNum = this.showNum;
                list.pageParam.btnStyle = this.btnStyle;
                list.pageParam.btnTxt3 = this.btnTxt3;
                list.pageParam.buyBtn = this.buyBtn;
                list.pageParam.corner = this.corner;
                list.pageParam.cornerMark = this.cornerMark;
                list.pageParam.goodDes = this.goodDes;
                list.pageParam.goodName = this.goodName;
                list.pageParam.goodPrice = this.goodPrice;
                list.pageParam.listStyle = this.listStyle;
                list.pageParam.productIds = this.productIds;
                
                list.id =this.tempId;
                list.name = this.keyText;
                list.type = this.keyWords;
                
                this.addData(list);
            },
            // 检测格式
            listTest(){
                if(this.showGoods == []){
                    this.$message.error('请选择任意一个列表设置');
                }
            },
            // 初始化数据
            initData(){
                this.addFun = this.pageParam.addFun;
                this.showNum = this.pageParam.showNum ? this.pageParam.showNum : 6;
                this.btnStyle = this.pageParam.btnStyle;
                this.btnTxt3 = this.pageParam.btnTxt3;
                this.buyBtn = this.pageParam.buyBtn;
                this.corner = this.pageParam.corner;
                this.cornerMark = this.pageParam.cornerMark;
                this.goodDes = this.pageParam.goodDes;
                this.goodName = this.pageParam.goodName;
                this.goodPrice = this.pageParam.goodPrice;
                this.listStyle = this.pageParam.listStyle;
                if(this.pageParam.productIds.length > 0 && this.pageParam.productIds){
                	this.productIds = this.pageParam.productIds;
                }else{
                	this.productIds = [];
                }
                if(this.pageParam.addFun == 'manual'){
                    if(this.productIds.length == 0){
                        this.showGoods = [];
	                    this.showbigGoods = [];
	                    this.showSmallGoods = [];
                    }else{
                        this.$ajax({
                            methods:'get',
                            url:'/center/product/getProductListByIds',
                            params:{
                                productIds:JSON.stringify(this.productIds),
                                productGetType:0
                            }
                        }).then(res => {
                            this.showGoods = res.data.productInfo;
                            this.showbigGoods = this.showGoods.slice(0,1);
                            this.showSmallGoods = this.showGoods.slice(1,3);
                        }).catch(err => {
                            (err);
                        })
                    }
                }else if(this.pageParam.addFun == 'automatic'){
                    this.$ajax({
                        methods:'get',
                        url:'/center/product/getProductListByIds',
                        params:{
                            productGetType:1
                        }
                    }).then(res => {
                        this.showGoods = res.data.productInfo.splice(0, this.showNum);
	                    this.showbigGoods = this.showGoods.slice(0, 1);
	                    this.showSmallGoods = this.showGoods.slice(1, 3);
                    }).catch(err => {
                        (err);
                    })
                }
            }
        },
        mounted(){
            this.saveData();
            this.initData();
        }
    }
</script>

<style scoped>
    .list_box{
        padding: 0 10px;
    }
    .list_box ul li{
        position: relative;
        margin-bottom: 10px;
    }
    .buy_icon{
        position: absolute;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        border: 1px solid #f44;
        text-align: center;
        line-height: 24px;
        right: 4px;
        bottom: 4px;
    }
    .buy_icon .icon{
        font-size: 20px;
        color: #f44;
    }
    .good_pic{
        position: relative;
    }
    .good_pic .cornerMark{
        position: absolute;
        left: 0;
        top: 0;
        width: 40px;
    }
    .good_pic .cornerMark img{
        width: 100%;
    }
    .good_pic img.goodsPic{
        width: 100%;
        height: 100%;
    }
    .scroll_box{
        width: 100%;
        overflow-x: hidden;
    }
    .good_txt{
        min-height: 30px;
    }
    /* 大图排列 */
    .zigzag_list .good_pic,
    .big_list .good_pic{
        width: 100%;
    }
    .big_list .good_txt{
        margin-top: 6px;
    }
    .detailed_list .good_txt h5,
    .zigzag_list .good_txt h5,
    .small_list .good_txt h5,
    .big_list .good_txt h5{
        font-size: 16px;
        color: #333;
        margin-bottom: 6px;
    }   
    .detailed_list .good_txt span,
    .zigzag_list .good_txt span,
    .small_list .good_txt span,
    .big_list .good_txt span{
        display: block;
        font-size: 16px;
        color: #f44;
    }
    /* 小图排列 */
    .zigzag_list li.small .good_pic,
    .small_list .good_pic{
        width: 142px;
        height: 142px;
    }
    .zigzag_list li,
    .small_list li{
        float: left;
        margin-right: 7px;
    }
    .small_list li{
        width: 142px;
    }
    .zigzag_list li.small .good_txt h5, 
    .small_list li .good_txt h5{
        text-overflow:ellipsis; 
        white-space:nowrap; 
        overflow:hidden; 
    }
    .small_list li:nth-child(event){
        margin-right: 0;
    }
    .zigzag_list li.small .good_txt h5,
    .zigzag_list li.small .good_txt span,
    .small_list .good_txt h5,
    .small_list .good_txt span{
        font-size: 14px;
        
    }
    /* 一行三个 */
    .more_list{
        margin-right: -13px;
    }
    .more_list li{
        width: 90px;
        margin-right: 13px;
    }
    .more_list li .good_pic{
        width: 90px;
        height: 90px;
    }
    .more_list .good_txt{
        width: 85px;
    }
    .more_list .good_txt h5,
    .small_list .good_txt span{
        font-size: 12px;
    }
    .scroll_lsit{
        width: 800px;
    }
    /* 一大两小 */
    .zigzag_list li.small{
        width: 142px;
    }
    /* 详细列表 */
    .detailed_list .good_pic{
        width: 100px;
        height: 100px;
        float: left;
        margin-right: 10px;
    }
    .detailed_list li{
        padding: 10px 0;
    }
    .detailed_list .good_txt{
        float: left;
        padding-top: 6px;
        width: 175px
    }
    .detailed_list .good_txt h5{
        text-overflow:ellipsis; 
        white-space:nowrap; 
        overflow:hidden; 
        font-size: 16px;
        color: #333;
        margin-bottom: 10px;
    }
    .detailed_list .good_txt span{
        margin-top: 10px;
    }
    .detailed_list .buy_icon{
        right: 11px;
        bottom: 13px;
    }
    .shop{
        position: absolute;
        border: 1px solid #f44;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        text-align: center;
        line-height: 24px;
        right: 12px;
        bottom: 7px;
    }
    .shop .icon{
        font-size: 16px;
        color: #f44;
    }
    .shop1,.shop2{
        position:absolute;
        right: 6px;
        bottom: 6px;
        font-size: 12px;
        line-height: 20px;
        padding: 0 5px;
        cursor: pointer;
        background-color: #f44;
        color: #fff;
        border-radius: 10px;
    }
    .shop2{
        background-color: #fff;
        line-height: 20px;
        border-radius: 0;
        border: 1px solid #f44;
        color: #f44;
    }
    .small_list .shop1,
    .small_list .shop2{
        bottom: 0;
        right: 4px;
    }
    .detailed_list .shop1,
    .detailed_list .shop2{
        bottom: 12px;
    }
    /* 右侧设置 */
    .modify_box {
        position: absolute;
        right: -450px;
        top:0;
        padding: 12px 10px;
        min-height: 28px;
        background: #f8f8f8;
        border-radius: 5px;
        border: 1px solid #e5e5e5;
        width: 420px;
        margin-left: 20px;
        font-size: 12px;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        z-index: 100;
    }
    .modify_box:after, 
    .modify_box:before {
        right: 100%;
        top: 20px;
        border: solid transparent;
        content: " ";
        height: 0;
        width: 0;
        position: absolute;
        pointer-events: none;
    }
    .modify_box:before {
        border-color: transparent;
        border-right-color: #e5e5e5;
        border-width: 7px;
        margin-top: -7px;
    }
</style>
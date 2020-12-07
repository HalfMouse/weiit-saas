/*
* jQuery pager plugin
* Version 1.0 (12/22/2008)
* @requires jQuery v1.2.6 or later 
* The included Pager.CSS file is a dependancy but can obviously tweaked to your wishes
* Tested in IE6 IE7 Firefox & Safari. Any browser strangeness, please report.
*/
(function($) {

    $.fn.pager = function(options) {

        var opts = $.extend({}, $.fn.pager.defaults, options);

        return this.each(function() {
			$(this).append(
				renderpager(
					parseInt(options.pagenumber), 
					parseInt(options.pagecount), 
            		parseInt(options.pagesize),
            		parseInt(options.pagerecordSize), 
            		options.buttonClickCallback
            	)
            );
        });
    };
 
    function renderpager(pagenumber, pagecount,pagesize,pagerecordSize, buttonClickCallback) {
        // setup $pager to hold render
        var $pager = $('<div class="text-right"></div>');
		$pager.append('<div style="float:left;margin-top:8px;"><input type="hidden" name="page" id="page" value="'+pagenumber
				+'" />共<span class="text-primary"> '+pagerecordSize+' </span>条记录，第 '+pagenumber+'/'+pagecount+' 页</div>');
 
		var $pagerUl = $('<ul class="pagination pagination-separated pagination-rounded"></ul>');
 
        var $Button = $('<li><a href="javascript:;" >首页</a></li>');
        pagenumber <= 1 ? $Button.addClass('disabled') : $Button.click(function() { buttonClickCallback(1); });
        $Button.appendTo($pagerUl);
        
        var $ButtonShang = $('<li><a href="javascript:;" >上一页</a></li>');
        pagenumber <= 1 ? $ButtonShang.addClass('disabled') : $ButtonShang.click(function() { buttonClickCallback(pagenumber- 1); });
        $ButtonShang.appendTo($pagerUl);
        
        var startPoint = 1;
        var endPoint = 8;

        if (pagenumber > 4) {
            startPoint = pagenumber - 4;
            endPoint = pagenumber + 3;
        }

        if (endPoint > pagecount) {
            startPoint = pagecount - 8;
            endPoint = pagecount;
        }

        if (startPoint < 1) {
            startPoint = 1;
        }
 
        for (var page = startPoint; page <= endPoint; page++) {
        	var currUl = $('<li ></li>');
        		page == pagenumber ? currUl.addClass('active'):"";
            var currentButton = $('<a href="javascript:;" >' + (page) + '</a>');
            	currentButton.click(function() { buttonClickCallback(this.firstChild.data); });
            currentButton.appendTo(currUl);
            currUl.appendTo($pagerUl);
        }
 
        var $ButtonXia = $('<li><a href="javascript:;" >下一页</a></li>');
        pagenumber >= pagecount ? $ButtonXia.addClass('disabled') : $ButtonXia.click(function() { buttonClickCallback(pagenumber+1); });
        $ButtonXia.appendTo($pagerUl);
        
        var $ButtonMo = $('<li><a href="javascript:;" >末页</a></li>');
        pagenumber >= pagecount ? $ButtonMo.addClass('disabled') : $ButtonMo.click(function() { buttonClickCallback(pagecount); });
        $ButtonMo.appendTo($pagerUl);
        
        $pager.append($pagerUl);
        
        
        var $ButtonGo = $('<input type="button" value="跳转" class="bg-blue" style="width:38px;height:36px;border:1px solid #ddd;"/>');
        $ButtonGo.click(function(){
        	var goInput = $('#pageGo').val();
        	if(goInput == ''||isNaN(goInput))
        	{
        		MAlert('页码输入错误!');
        		return;
        	}
        	if(goInput > pagecount )
        	{
        		goInput=pagecount;
        	}
        	if(goInput <1)
        	{
        		goInput=1;
        	}
        	buttonClickCallback(goInput);
        });
        var $ButtonGoDiv = $('<div style="float:right;"></div>');
        
        $ButtonGoDiv.append('<input type="text" id="pageGo" name="pageGo" class="input-sm" value="'+pagenumber
					+'" style="width:38px;height:36px;border:1px solid #ddd;"/>').append($ButtonGo);
		 
		$pager.append($ButtonGoDiv);
 
        return $pager;
    }

    $.fn.pager.defaults = {
        pagenumber: 1,
        pagecount: 1,
    };

})(jQuery);






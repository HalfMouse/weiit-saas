/* ------------------------------------------------------------------------------
*
*  # Date and time pickers
*
*  Specific JS code additions for picker_date.html page
*
*  Version: 1.0
*  Latest update: Aug 1, 2015
*
* ---------------------------------------------------------------------------- */

$(function() {

    //根据范围的日期控件
    $('.daterange-datemenu').daterangepicker({
        showDropdowns: true
    });	
	
	//单日期控件
   $('.pickadate-translated').pickadate({
		format: 'yyyy-mm-dd',
        monthsFull: ['01月', '02月', '03月', '04月', '05月', '06月', '07月', '08月', '09月', '10月', '11月', '12月'],
        weekdaysShort: ['日', '一', '二', '三', '四', '五', '六'],
        today: '今天',
        clear: '清除',
		close:'关闭',
		labelMonthSelect: '选择月份',
        labelYearSelect: '选择年份',
		labelMonthNext: '下一月',
        labelMonthPrev: '上个月',
        formatSubmit: 'yyyy/mm/dd',
		selectYears: true,
        selectMonths: true,
			
    });
    
});

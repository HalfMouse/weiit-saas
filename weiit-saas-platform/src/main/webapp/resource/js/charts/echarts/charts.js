 
require.config({
    paths: {
    	 echarts: basePath+'/resource/js/plugins/visualization/echarts'
    }
});

// Step:4 require echarts and use it in the callback.
// Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
 
function user_chart_bar(id,title,lineTitle,times,datas){
	require(
	    [
	        'echarts',
	        'echarts/chart/bar',
	        'echarts/chart/line'
	    ],
	    function (ec) {
	        //--- 折柱 --- 
	       var myChart = ec.init(document.getElementById(id));
	       myChart.setOption({
	           tooltip : {
	               trigger: 'axis'
	           },
	           legend: {
	               data:[''+title+'']
	           },
	           toolbox: {
	               show : true,
	               feature : {
	                   mark : {show: false},
	                   dataView : {show: false, readOnly: false},
	                   magicType : {show: true, type: ['line', 'bar']},
	                   restore : {show: true},
	                   saveAsImage : {show: true}
	               }
	           },
	           calculable : true,
	           xAxis : [
	               {
	                   type : 'category',
	                   data : times
	               }
	           ],
	           yAxis : [
	               {
	                   type : 'value',
	                   splitArea : {show : true}
	               }
	           ],
	           series : [
	               {
	                   name:lineTitle,
	                   type:'bar',
	                   data:datas
	               }
	           ]
	       });
	       
	    }
	);
 
	
}
function user_chart_line(id,title,lineTitle,times,datas){
	require(
	    [
	        'echarts',
	        'echarts/chart/bar',
	        'echarts/chart/line'
	    ],
		function (ec) {
			var myChart = ec.init(document.getElementById(id));
		 	myChart.setOption({
		       tooltip : {
		           trigger: 'axis'
		       },
		       legend: {
		           data:[''+title+'']
		       },
		       toolbox: {
		           show : true,
		           feature : {
		               mark : {show: false},
		               dataView : {show: false, readOnly: false},
		               magicType : {show: true, type: ['line', 'bar']},
		               restore : {show: true},
		               saveAsImage : {show: true}
		           }
		       },
		       calculable : true,
		       xAxis : [
		           {
		               type : 'category',
		               data : times
		           }
		       ],
		       yAxis : [
		           {
		               type : 'value',
		               splitArea : {show : true}
		           }
		       ],
		       series : [         
		           {
		               name:lineTitle,
		               type:'line',
		               data:datas
		           }
		       ]
		   });
   
	});
 
}

function stack_chart(id,result){
    require(
        [
            'echarts',
            'echarts/theme/limitless',
            'echarts/chart/line',
            'echarts/chart/bar'
        ],

        function (ec, limitless) {

            var stack = ec.init(document.getElementById(id), limitless);
           
            stack_options = {
                grid: {
                    x: 35,
                    x2: 15,
                    y: 35,
                    y2: 25
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {
                    data:['平台用户数据', '平台订单数', '平台交易额']
                },
                calculable: true,
                xAxis: [{
                    type: 'value'
                }],
                yAxis: [{
                    type: 'category',
                    axisTick: {
                        show: false
                    },
                    data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月']
                }],
                series: [
                    {
                        name: '平台用户数据',
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                label: {
                                    show: true,
                                    position: 'inside'
                                }
                            }
                        },
                        data: [200, 170, 240, 244, 200, 220, 210]
                    },
                    {
                        name: '平台订单数',
                        type: 'bar',
                        stack: 'Total',
                        barWidth: 5,
                        itemStyle: {
                            normal: {
                                label: {
                                    show: true
                                }
                            }
                        },
                        data: [320, 302, 341, 374, 390, 450, 420]
                    },
                    {
                        name: '平台交易额',
                        type: 'bar',
                        stack: 'Total',
                        itemStyle: {
                            normal: {
                                label: {
                                    show: true,
                                    position: 'left'
                                }
                            }
                        },
                        data: [-120, -132, -101, -134, -190, -230, -210]
                    }
                ]
            };

            //
            // Apply options
            //

            stack.setOption(stack_options);


           
        }
    );

 
	
}



function line_bar_chart(id,title,lineTitle,times,datas){
	// Configuration
    require(
        [
            'echarts',
            'echarts/theme/limitless',
            'echarts/chart/line',   
            'echarts/chart/bar'
        ],

        function (ec, limitless) {

        	 var line_bar = ec.init(document.getElementById('line_bar'), limitless);
        	 // Line and bar combination
             //

             line_bar_options = {

                 // Setup grid
                 grid: {
                     x: 55,
                     x2: 45,
                     y: 35,
                     y2: 25
                 },

                 // Add tooltip
                 tooltip: {
                     trigger: 'axis'
                 },

                 // Enable drag recalculate
                 calculable: true,

                 // Add legend
                 legend: {
                     data: ['Evaporation','Precipitation','Temperature']
                 },

                 // Horizontal axis
                 xAxis: [{
                     type: 'category',
                     data: ['January','February','March','April','May','June','July','August','September','October','November','December']
                 }],

                 // Vertical axis
                 yAxis: [
                     {
                         type: 'value',
                         name: 'Water',
                         axisLabel: {
                             formatter: '{value} ml'
                         }
                     },
                     {
                         type: 'value',
                         name: 'Temp',
                         axisLabel: {
                             formatter: '{value} °C'
                         }
                     }
                 ],

                 // Add series
                 series: [
                     {
                         name: 'Evaporation',
                         type: 'bar',
                         data: [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
                     },
                     {
                         name: 'Precipitation',
                         type: 'bar',
                         data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
                     },
                     {
                         name: 'Temperature',
                         type: 'line',
                         yAxisIndex: 1,
                         data: [2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2]
                     }
                 ]
             };
             
             line_bar.setOption(line_bar_options);
        	
        }
    );

	
}
function basic_columns_chart(result){
	// Configuration
    require(
        [
            'echarts',
            'echarts/theme/limitless',
            'echarts/chart/line',   
            'echarts/chart/bar'
        ],

        function (ec, limitless) {

        	var basic_columns = ec.init(document.getElementById(result.div_id), limitless);
        	
        	basic_columns_options = {

                    // Setup grid
                    grid: {
                        x: 40,
                        x2: 40,
                        y: 35,
                        y2: 25
                    },

                    // Add tooltip
                    tooltip: {
                        trigger: 'axis'
                    },

                    // Add legend
                    legend: {
                       // data: ['Evaporation', 'Precipitation']
                    	data:result.label
                    },

                    // Enable drag recalculate
                    calculable: true,

                    // Horizontal axis
                    xAxis: [{
                        type: 'category',
                        //data:['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                        data: result.xAxis
                    }],

                    // Vertical axis
                    yAxis: [{
                        type: 'value'
                    }],

                    // Add series
                    series: result.data
                    /*series: [
                        {
                            name: 'Evaporation',
                            type: 'bar',
                            data: [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3],
                            itemStyle: {
                                normal: {
                                    label: {
                                        show: true,
                                        textStyle: {
                                            fontWeight: 500
                                        }
                                    }
                                }
                            },
                            markLine: {
                                data: [{type: 'average', name: 'Average'}]
                            }
                        },
                        {
                            name: 'Precipitation',
                            type: 'bar',
                            data: [2.6, 5.9, 9.0, 26.4, 58.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3],
                            itemStyle: {
                                normal: {
                                    label: {
                                        show: true,
                                        textStyle: {
                                            fontWeight: 500
                                        }
                                    }
                                }
                            },
                            markLine: {
                                data: [{type: 'average', name: 'Average'}]
                            }
                        }
                    ]*/
                };
        	
        	 basic_columns.setOption(basic_columns_options);

        }
    );

	
}

function combination_connection_chart(result){
	// Configuration
    require(
        [
            'echarts',
            'echarts/theme/limitless',
            'echarts/chart/line',   
            'echarts/chart/bar',
            'echarts/chart/pie'
        ],

        function (ec, limitless) {
        	 
            var connect_column = ec.init(document.getElementById(result.column.div_id), limitless);
           
            // Column options
            connect_column_options = {

                // Setup grid
                grid: {
                    x: 40,
                    x2: 47,
                    y: 35,
                    y2: 25
                },

                // Add tooltip
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },

                // Add legend
                legend: {
                    data: result.column.label
                },

                // Add toolbox
                toolbox: {
                    show: true,
                    orient: 'vertical',
                    x: 'right', 
                    y: 35,
                    feature: {
                        mark: {
                            show: true,
                            title: {
                                mark: 'Markline switch',
                                markUndo: 'Undo markline',
                                markClear: 'Clear markline'
                            }
                        },
                        magicType: {
                            show: true,
                            title: {
                                line: 'Switch to line chart',
                                bar: 'Switch to bar chart',
                                stack: 'Switch to stack',
                                tiled: 'Switch to tiled'
                            },
                            type: ['line', 'bar', 'stack', 'tiled']
                        },
                        restore: {
                            show: true,
                            title: 'Restore'
                        },
                        saveAsImage: {
                            show: true,
                            title: 'Same as image',
                            lang: ['Save']
                        }
                    }
                },

                // Enable drag recalculate
                calculable: true,

                // Horizontal axis
                xAxis: [{
                    type: 'category',
                    data: result.column.xAxis
                }],

                // Vertical axis
                yAxis: [{
                    type: 'value',
                    splitArea: {show: true}
                }],

                // Add series
                series: result.column.data
            };

            // Connect charts 
            connect_column.connect(connect_column); 
            connect_column.setOption(connect_column_options);
        	
        }
    );

	
}
function funnel_chart(result){
	// Configuration
    require(
        [
            'echarts',
            'echarts/theme/limitless',
            'echarts/chart/funnel',
            'echarts/chart/pie'
        ],

        function (ec, limitless) {

        	 var funnel_desc = ec.init(document.getElementById(result.div_id), limitless);
        	 
        	 funnel_desc_options = {

                     // Add title
                     title: {
                         //text: 'Browser popularity',
                         //subtext: 'Open source information',
                    	 text:result.text,
                    	 subtext:result.subtext,
                         x: 'center'
                     },

                     // Add legend
                     legend: {
                         x: 'left',
                         y: 75,
                         orient: 'vertical',
                         //data: ['Internet Explorer','Opera','Safari','Firefox','Chrome']
                         data:result.label
                     },
                     // Add tooltip
                     tooltip: {
                         trigger: 'item',
                         formatter: "{a} <br/>{b}: {c}笔"
                     },
                     // Enable drag recalculate
                     calculable: true,

                     // Add series
                     series:result.data
                    /* series: [
                         {
                             name: 'Statistics',
                             type: 'funnel',
                             x: '25%',
                             x2: '25%',
                             y: '17.5%',
                             height: '80%',
                             itemStyle: {
                                 normal: {
                                     label: {
                                         position: 'left'
                                     }
                                 }
                             },
                             data: [
                                 {value: 60, name: 'Safari'},
                                 {value: 40, name: 'Firefox'},
                                 {value: 20, name: 'Chrome'},
                                 {value: 80, name: 'Opera'},
                                 {value: 100, name: 'Internet Explorer'}
                             ]
                         }
                     ]*/
                 };

        	  funnel_desc.setOption(funnel_desc_options);
        }
    );

	
}
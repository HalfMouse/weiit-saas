/* ------------------------------------------------------------------------------
*
*  # User profile
*
*  Specific JS code additions for User profile pages set
*
*  Version: 1.0
*  Latest update: Aug 1, 2015
*
* ---------------------------------------------------------------------------- */

$(function() {


    // Charts
    // ------------------------------

    // Set paths
    require.config({
        paths: {
            echarts: basePath+'/resource/js/plugins/visualization/echarts'
        }
    });


    // Configuration
    require(
        [
            'echarts',
            'echarts/theme/limitless',
            'echarts/chart/line',   // load-on-demand, don't forget the Magic switch type.
            'echarts/chart/bar'
        ],


        // Charts setup
        function (ec, limitless) {

            // Init
            var sales = ec.init(document.getElementById('sales'), limitless);


            //
            // Sales chart options
            //

            sales_options = {

                // Setup grid
                grid: {
                    x: 35,
                    x2: 15,
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
                    data:['平台用户数据', '平台订单数', '平台交易额']
                },

                // Enable drag recalculate
                calculable: true,

                // Horizontal axis
                xAxis: [{
                    type: 'value'
                }],

                // Vertical axis
                yAxis: [{
                    type: 'category',
                    axisTick: {
                        show: false
                    },
                    data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月']
                }],

                // Add series
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

            sales.setOption(sales_options);


           
        }
    );





    
    
});

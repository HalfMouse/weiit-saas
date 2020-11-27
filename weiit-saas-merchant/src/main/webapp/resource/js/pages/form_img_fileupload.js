/* ------------------------------------------------------------------------------
*
*  # Table elements
*
*  Specific JS code additions for table_elements.html page
*
*  Version: 1.0
*  Latest update: Aug 1, 2015
*
* ---------------------------------------------------------------------------- */

$(function() {


    // Selects
    // ------------------------------

    // Multiselect
    //$('.multiselect').multiselect({
  //      buttonWidth: '100%'
   // });


    

   

    // Multiple files uploader
    $('.bootstrap-uploader').fileinput({
        browseLabel: '本地上传',
        browseClass: 'btn bg-grey',
        removeLabel: '取消',
        uploadLabel: '',
        browseIcon: '<i class="icon-image2"></i>',
        uploadIcon: '<i class="icon-image2"></i> ',
        removeClass: 'btn btn-danger btn-icon',
        uploadClass: 'btn bg-grey btn-icon',
        removeIcon: '<i class="icon-trash"></i> ',
        layoutTemplates: {
            caption: '<div tabindex="-1" class="form-control file-caption {class}">'+ '</div>'
        },
        msgLoading: "加载...",
        maxFileSize: 6200, // 文件限制大小KB
        msgSizeTooLarge: '文件大小不能超过6M',
        msgInvalidFileExtension: '无效的文件类型，不支持此文件格式上传.',
        allowedFileExtensions: ["jpg", "gif", "png"],
        msgProgress: "加载完成",
        msgSelected: "",
        initialCaption: "主图"
    });

 
    
});

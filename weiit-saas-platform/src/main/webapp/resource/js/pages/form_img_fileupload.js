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
        initialCaption: "主图"
    });


 
    
});

/* ------------------------------------------------------------------------------
*
*  # PNotify notifications
*
*  Specific JS code additions for components_notifications_pnotify.html page
*
*  Version: 1.0
*  Latest update: Aug 1, 2015
*
* ---------------------------------------------------------------------------- */

$(function() {


   
    // Solid primary
    $('#pnotify-solid-primary').on('click', function () {
        new PNotify({
            title: 'Primary notice',
            text: 'Check me out! I\'m a notice.',
            addclass: 'bg-primary'
        });
    });

   
});

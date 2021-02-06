$(function() {
    $('.nav-tabs a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        // save the latest tab; use cookies if you like 'em better:
        localStorage.setItem('lastTab', $(this).attr('href'));
    });
    // go to the latest tab, if it exists:
    var lastTab = localStorage.getItem('lastTab');
    if (lastTab && $('a[href="' + lastTab + '"]').length) {
        $('.nav-tabs a[href="' + lastTab + '"]').tab('show');
    } else {
        $('.nav-tabs a[data-toggle="tab"]:first').tab('show');
    }
});

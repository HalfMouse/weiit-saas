/* ------------------------------------------------------------------------------
*
*  # Select2 selects
*
*  Specific JS code additions for form_select2.html page
*
*  Version: 1.0
*  Latest update: Aug 1, 2015
*
* ---------------------------------------------------------------------------- */

$(function() {


    // Basic examples
    // ------------------------------

    // Default initialization
    $('.select').select2({
        minimumResultsForSearch: "-1"
    });


    // Select with search
    $('.select-search').select2();


    // Fixed width
    $('.select-fixed').select2({
        minimumResultsForSearch: "-1",
        width: 250
    });


    // Minimum input length
    $(".select-minimum").select2({
        minimumInputLength: 2,
        minimumResultsForSearch: "-1"
    });


    // Allow clear selection
    $('.select-clear').select2({
        placeholder: "Select a State",
        allowClear: true
    });



    // Styling options
    // ------------------------------

    // Custom menu color
    $('.select-menu-color').select2({
        dropdownCssClass: 'bg-teal'
    });


    // Combine custom colors
    $('.select-menu2-color').select2({
        dropdownCssClass: 'bg-indigo-400'
    });


    // Multiselect item colors
    $('.select-items-color').select2({
        formatSelectionCssClass: function (data, container) { return "bg-danger"; }
    });


    // Menu border color
    $('.select-border-color').select2({
        dropdownCssClass: 'border-warning'
    });


    // Tagging support
    $(".select-multiple-tags").select2({
        width: '100%',
        tags:['red', 'green', 'blue', 'cyan', 'brown', 'pink']
    });


    // Maximum input length
    $(".select-multiple-maximum-length").select2({
        width: '100%',
        tags:['red', 'green', 'blue', 'cyan', 'brown', 'pink'],
        maximumInputLength: 4
    });


    // Tokenization
    $(".select-multiple-tokenization").select2({
        width: '100%',
        tags:['red', 'green', 'blue', 'cyan', 'brown', 'pink'],
        tokenSeparators: [",", " "]
    });



    // Advanced examples
    // ------------------------------

    // Infinite scroll
    $(".select-remote-data-infinite").select2({
        placeholder: "Search for a movie",
        minimumInputLength: 3,
        ajax: {
            url: "http://api.rottentomatoes.com/api/public/v1.0/movies.json",
            dataType: 'jsonp',
            quietMillis: 100,
            data: function (term, page) { // page is the one-based page number tracked by Select2
                return {
                    q: term, //search term
                    page_limit: 10, // page size
                    page: page, // page number
                    apikey: "ju6z9mjyajq2djue3gbvv26t" // please do not use so this example keeps working
                };
            },
            results: function (data, page) {
                var more = (page * 10) < data.total; // whether or not there are more results available
     
                // notice we return the value of more so Select2 knows if more results can be loaded
                return {results: data.movies, more: more};
            }
        },
        formatResult: movieFormatResult, // omitted for brevity, see the source of this page
        formatSelection: movieFormatSelection, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
        escapeMarkup: function (m) { return m; } // we do not want to escape markup since we are displaying html in results
    });


    // Sort results
    $('.select-sorting-results').select2({
        width: '100%',
        sortResults: function(results, container, query) {
            if (query.term) {
                // use the built in javascript sort function
                return results.sort(function(a, b) {
                    if (a.text.length > b.text.length) {
                        return 1;
                    } else if (a.text.length < b.text.length) {
                        return -1;
                    } else {
                        return 0;
                    }
                });
            }
            return results;
        }
    });


    // Maximum selections allowed
    $('.select-multiple-maximum').select2({
        width: '100%',
        maximumSelectionSize: 3
    });


    //
    // Single select with icons
    //

    // Format icon
    function iconFormat(state) {
        var originalOption = state.element;
        return "<i class='icon-" + $(originalOption).data('icon') + "'></i>" + state.text;
    }

    // Initialize with options
    $(".select-icons").select2({
        formatResult: iconFormat,
        minimumResultsForSearch: "-1",
        width: '100%',
        formatSelection: iconFormat,
        escapeMarkup: function(m) { return m; }
    });


    //
    // Loading result data
    //

    // Initialize with options
    $(".select-loading-data").select2({
        minimumInputLength: 1,
        minimumResultsForSearch: "-1",
        placeholder: "Select a State",
        query: function (query) {
            var data = {results: []}, i, j, s;
            for (i = 1; i < 5; i++) {
                s = "";
                for (j = 0; j < i; j++) {s = s + query.term;}
                data.results.push({id: query.term + i, text: s});
            }
            query.callback(data);
        }
    });

    // Text key
    $(".select-text-key").select2({
        placeholder: "Click fto load data",
        minimumResultsForSearch: "-1",
        data:[{id:0,text:'enhancement'},{id:1,text:'bug'},{id:2,text:'duplicate'},{id:3,text:'invalid'},{id:4,text:'wontfix'}]
    });

    // Data
    var data = [
        {id: 0, tag: 'enhancement'},
        {id: 1, tag: 'bug'},
        {id: 2, tag: 'duplicate'},
        {id: 3, tag: 'invalid'},
        {id: 4, tag: 'wontfix'}
    ];

    // Format
    function format(item) { 
        return item.tag; 
    }

    // String alternative key
    $(".select-string").select2({
        placeholder: "Click fto load data",
        minimumResultsForSearch: "-1",
        data: { results: data, text: 'tag' },
        formatSelection: format,
        formatResult: format
    });

    // As a function
    $(".select-function").select2({
        placeholder: "Click fto load data",
        minimumResultsForSearch: "-1",
        data:{ results: data, text: function(item) { return item.tag; } },
        formatSelection: format,
        formatResult: format
    });

    // Return a results object
    $(".select-data-function").select2({
        placeholder: "Click fto load data",
        minimumResultsForSearch: "-1",
        data:function() { return { text:'tag', results: data }; },
        formatSelection: format,
        formatResult: format
    });


    //
    // Loading remote data
    //

    // Format result
    function movieFormatResult(movie) {
        var markup = "<table class='movie-result'><tr>";
        if (movie.posters !== undefined && movie.posters.thumbnail !== undefined) {
            markup += "<td class='movie-image'><img src='" + movie.posters.thumbnail + "'/></td>";
        }
        markup += "<td class='movie-info'><div class='movie-title'>" + movie.title + "</div>";
        if (movie.critics_consensus !== undefined) {
            markup += "<div class='movie-synopsis'>" + movie.critics_consensus + "</div>";
        }
        else if (movie.synopsis !== undefined) {
            markup += "<div class='movie-synopsis'>" + movie.synopsis + "</div>";
        }
        markup += "</td></tr></table>";
        return markup;
    }

    // Format selection
    function movieFormatSelection(movie) {
        return movie.title;
    }

    // Initialize plugin with options
    $(".select-remote-data").select2({
        placeholder: "Search for a movie",
        minimumInputLength: 1,
        ajax: { // Instead of writing the function to execute the request we use Select2's convenient helper
            url: "http://api.rottentomatoes.com/api/public/v1.0/movies.json",
            dataType: 'jsonp',
            data: function (term, page) {
                return {
                    q: term, // search term
                    page_limit: 10,
                    apikey: "ju6z9mjyajq2djue3gbvv26t" // please do not use so this example keeps working
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.

                // Since we are using custom formatting functions we do not need to alter remote JSON data
                return {results: data.movies};
            }
        },
        initSelection: function(element, callback) {

            // The input tag has a value attribute preloaded that points to a preselected movie's id
            // this function resolves that id attribute to an object that select2 can render
            // using its formatResult renderer - that way the movie name is shown preselected
            var id=$(element).val();
            if (id!=="") {
                $.ajax("http://api.rottentomatoes.com/api/public/v1.0/movies/"+id+".json", {
                    data: {
                        apikey: "ju6z9mjyajq2djue3gbvv26t"
                    },
                    dataType: "jsonp"
                }).done(function(data) { callback(data); });
            }
        },
        formatResult: movieFormatResult, // omitted for brevity, see the source of this page
        formatSelection: movieFormatSelection,  // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
        escapeMarkup: function (m) { return m; } // we do not want to escape markup since we are displaying html in results
    });


    //
    // Programmatic access (single)
    //

    // Initialize plugin
    $('.select-access').select2({
        minimumResultsForSearch: "-1",
        placeholder: "Select State..."
    });

    // Methods
    $(".access-get").click(function () { alert("Selected value is: "+$(".select-access").select2("val"));});
    $(".access-set").click(function () { $(".select-access").select2("val", "CA"); });
    $(".access-get2").click(function () { var data = $(".select-access").select2("data"); delete data.element; alert("Selected data is: "+JSON.stringify(data));});
    $(".access-set2").click(function () { $(".select-access").select2("data", {id: "CA", text: "California"}); });
    $(".access-open").click(function () { $(".select-access").select2("open"); });
    $(".access-close").click(function () { $(".select-access").select2("close"); });


    //
    // Programmatic access (multiple)
    //

    // Initialize
    $(".select-access-multiple").select2({
        width: '100%',
        placeholder: "Select a state"
    });

    // Methods
    $(".access-multiple-get").click(function () { alert("Selected value is: "+$(".select-access-multiple").select2("val"));});
    $(".access-multiple-set").click(function () { $(".select-access-multiple").select2("val", ["ID","NV"]); });
    $(".access-multiple-get2").click(function () { alert("Selected value is: "+JSON.stringify($(".select-access-multiple").select2("data")));});
    $(".access-multiple-set2").click(function () { $(".select-access-multiple").select2("data", [{id: "ID", text: "Idaho"},{id:"NV", text: "Nevada"}]); });
    $(".access-multiple-open").click(function () { $(".select-access-multiple").select2("open"); });
    $(".access-multiple-close").click(function () { $(".select-access-multiple").select2("close"); });


    //
    // Reacting to external value changes
    //

    // Initialize
    $(".select-multiple-value-changes").select2({
        width: '100%'
    });

    // Change values
    $(".change-to-ca").click(function() { $(".select-multiple-value-changes").val("CA").trigger("change"); });
    $(".change-to-ak-co").click(function() { $(".select-multiple-value-changes").val(["AK","CO"]).trigger("change"); });


    //
    // Select lifecycle
    //

    // Initialize with selected options
    $(".select-multiple-lifecycle").val(["AL","AZ"]).select2({
        width: '100%'
    });

    // Init on click
    $(".lifecycle-init").click(function() { $(".select-multiple-lifecycle").select2(); });

    // Destroy on click
    $(".lifecycle-destroy").click(function() { $(".select-multiple-lifecycle").select2("destroy"); });


    //
    // Drag and drop selected items
    //

    // Initialize with tags
    $(".select-multiple-drag").select2({
        width: '100%',
        tags: ['red', 'green', 'blue', 'orange', 'white', 'black', 'purple', 'cyan', 'teal']
    });

    // Add jQuery UI Sortable support
    $(".select-multiple-drag").select2("container").find("ul.select2-choices").sortable({
        containment: 'parent',
        start: function() { $(".select-multiple-drag").select2("onSortStart"); },
        update: function() { $(".select-multiple-drag").select2("onSortEnd"); }
    });


    //
    // Disabled mode
    //

    // Initialize
    $(".select-multiple-disabled").select2({
        width: '100%'
    });

    // Methods
    $(".select-multiple-enable").click(function() { $(".select-multiple-disabled").select2("enable", true); });
    $(".select-multiple-disable").click(function() { $(".select-multiple-disabled").select2("enable", false); });
    $(".select-multiple-readonly").click(function() { $(".select-multiple-disabled").select2("readonly", true); });
    $(".select-multiple-writable").click(function() { $(".select-multiple-disabled").select2("readonly", false); });


    //
    // Locked selections
    //

    // Data
    var preload_data = [
        {id: 'user0', text: 'Disabled User', locked: true},
        {id: 'user1', text: 'Jane Doe'},
        {id: 'user2', text: 'John Doe', locked: true},
        {id: 'user3', text: 'Robert Paulson', locked: true},
        {id: 'user6', text: 'Planet Bob'}
    ];
 
    // Initialize
    $('.select-multiple-locked').select2({
        multiple: true,
        width: '100%',
        query: function (query) {
            var data = {results: []};
            $.each(preload_data, function() {
                if(query.term.length == 0 || this.text.toUpperCase().indexOf(query.term.toUpperCase()) >= 0) {
                    data.results.push({id: this.id, text: this.text });
                }
            });
            query.callback(data);
        }
    });

    // Bind data
    $('.select-multiple-locked').select2('data', preload_data);
    
});

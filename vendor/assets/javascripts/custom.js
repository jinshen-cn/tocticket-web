/***************************************************
SuperFish Menu
***************************************************/

// initialise plugins
$(function () {
    jQuery('ul.nav').superfish();
});

$(function ($) {
    if ($.browser.msie && $.browser.version.substr(0, 1) < 7) {
        $('li').has('ul').mouseover(function () {
            $(this).children('ul').css('visibility', 'visible');
        }).mouseout(function () {
            $(this).children('ul').css('visibility', 'hidden');
        })
    }
});

$(function () {
    
    try {
        //home page slider
        $('#da-slider').cslider({
            autoplay: true,
            bgincrement: 450
        });

        //Home page over services section
        $('.marketing .span3').hover(function () { $(this).find('.Icon i').addClass('hover'); }, function () { $(this).find('.Icon i').removeClass('hover'); });

    }
    catch (e)
    { }
    //Portfolio filter
    try {
        var $container = $('#portfolio');
        // items filter
        $('#work-filter a').click(function () {
            var selector = $(this).attr('data-filter');
            $container.isotope({
                filter: selector,
                itemSelector: '.work-item',
                layoutMode: 'fitRows'
            });

            $('#work-filter').find('a.btn-success').removeClass('btn-success');
            $(this).addClass('btn-success');
            return false;
        });
    }
    catch (e)
    { }

    //Image overlay
    try {
        $('.work-item-image-container').mouseover(function () {
            //adjust work item ovelay button and text to center
            var w = parseFloat($('.work-item-image-container:eq(0) > img:eq(0)').width());
            var h = parseFloat($('.work-item-image-container:eq(0) > img:eq(0)').height());
            $('.work-item-overlay').css({ width: w, height: h });
            var iw = $('.work-item-overlay:eq(0) .inner:eq(0)').outerWidth();
            var ih = $('.work-item-overlay:eq(0) .inner:eq(0)').outerHeight();
            $('.work-item-overlay .inner').css({ marginLeft: -iw / 2.0,
                marginTop: -ih / 2.0
            });

        });
        var w = parseFloat($('.carousel-inner .thumbnail').outerWidth());
        var h = parseFloat($('.carousel-inner .thumbnail').outerHeight());

        var iw = $('.work-item-overlay:eq(0) .inner:eq(0)').outerWidth();
        var ih = $('.work-item-overlay:eq(0) .inner:eq(0)').outerHeight();

        $('.carousel-inner .thumbnail').mouseover(function () {
            //adjust work item ovelay button and text to center
            var w1 = parseFloat($('.thumbnail:eq(0)').outerWidth());
            var h1 = parseFloat($('.thumbnail:eq(0)').outerHeight());
            w = Math.max(w, w1);
            h = Math.max(h, h1);
            $('.work-item-overlay').css({ width: w, height: h });

            var iw1 = $('.work-item-overlay:eq(0) .inner:eq(0)').outerWidth();
            var ih1 = $('.work-item-overlay:eq(0) .inner:eq(0)').outerHeight();

            iw = Math.max(iw, iw1);
            ih = Math.max(ih, ih1);
            $('.work-item-overlay .inner').css({ marginLeft: -iw / 2.0,
                marginTop: -ih / 2.0
            });

        });

    }
    catch (e)
    { }
    //Pretty photo gallery
    try {
        //Initialize PrettyPhoto here
        $("a[rel^='prettyPhoto']").prettyPhoto({ animation_speed: 'normal', theme: 'facebook', slideshow: 3000, autoplay_slideshow: false, social_tools: false });
    }
    catch (e)
    { }

    //Work detail page slider
    try {
        $('.portfolio_showcase').cycle({
            fx: 'fade',
            speed: 'slow',
            timeout: 4000,
            pager: '#number',
            pause: 1
        });
    }
    catch (e)
    { }

});
//Dynamically adds drop down for smaller screens.
$(function ($) {
	if ($("#main-nav ul").children().length) {
	    $("#main-nav").append("<select/>");
	    $("<option />", {
	        "selected": "selected",
	        "value": "",
	        "text": "Please choose page"
	    }).appendTo("#main-nav select");
	    
	    //new dropdown menu
	    $("#main-nav a").each(function () {
	        var el = $(this);
	        var perfix = '';
	        switch (el.parents().length) {
	            case (11):
	                perfix = '-';
	                break;
	            case (13):
	                perfix = '--';
	                break;
	            default:
	                perfix = '';
	                break;
	
	        }
	        $("<option />", {
	            "value": el.attr("href"),
	            "text": perfix + el.text()
	        }).appendTo("#main-nav select");
	    });
	
	    $('#main-nav select').change(function () {
	
	        window.location.href = this.value;
	
	    });
    }
});

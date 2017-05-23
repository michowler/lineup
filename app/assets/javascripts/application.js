// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery_nested_form
//= require bootstrap-sprockets
//= require turbolinks
//= require moment 
//= require fullcalendar
//= require_tree .

$(document).ready(function(){
document.addEventListener("turbolinks:load",function(){

    $('#calendar').fullCalendar({
    	selectable: true,
        theme: true,

    	select: function(start, end, jsEvent, view) {
	         // start contains the date you have selected
	         // end contains the end date. 
	         // Caution: the end date is exclusive (new since v2).

	         start_date = moment(start).format()
	         end_date = yesterday(moment(end).format())
	         $('#datepicker1').val(start_date)
	         $('#datepicker2').val(end_date)
	    },
	    googleCalendarApiKey: 'AIzaSyD8IQsRnniDJRYp6wEl-TEoxrOymYN1_rs',
	    events: {
            googleCalendarId: 'en.malaysia#holiday@group.v.calendar.google.com'
        }
    });

    $('.glyphicon-remove').click(function(){
    	url = $(this).attr("id")
    	$('form').attr("action",url)
    });

    $('.glyphicon-ok').click(function(){
        url = $(this).attr("id")
        $('#approveModal a').attr("href",url)
    });


    $(document).delegate('.open', 'click', function(event){
        $(this).addClass('oppenned');
        event.stopPropagation();
    })
    $(document).delegate('body', 'click', function(event) {
        $('.open').removeClass('oppenned');
    })
    $(document).delegate('.cls', 'click', function(event){
        $('.open').removeClass('oppenned');
        event.stopPropagation();
    });

    $(window).scroll(function () {
        if ($(window).scrollTop() >= 50) {
        $('.navbar').css('background','rgba(255,255,255,0.5)');
        } 
        else {
        $('.navbar').css('background','transparent');
        }
    });

    $(window).scroll(
        {
            previousTop: 0
        }, 
        function () {
        var currentTop = $(window).scrollTop();
        if (currentTop < this.previousTop) {
            
            $(".navbar").fadeIn('fast');
        } else {
            
            $(".navbar").hide();
        }
        this.previousTop = currentTop;
    });
    
    window.onload = function() {
      Particles.init({
        selector: '.background'
      });
    };
    
})


});

function yesterday(date){
    $date = new Date(date);
    $date.setDate($date.getDate() - 1);
    var $dd = $date.getDate();
    var $mm = $date.getMonth()+1; //January is 0!

    var $yyyy = $date.getFullYear();
    if($dd<10){$dd='0'+$dd} if($mm<10){$mm='0'+$mm} 
    return $yyyy+'-'+$mm+'-'+$dd;
}


/*
publish control partial for publishable models
----------------------------------------------------*/
;(function($){
	$.fn.publishControl = function(){
		var dates = $(this).find('.publish_dates');
		var check = $(this).find('input.js_date_toggle');
		var end_toggle = $(this).find('input.js_end_date_toggle');
		end_toggle.show();
		var end_inputs = $(this).find('.js_end_date select');
		var end_span = $(this).find('.js_end_date');
		var hidden_end = $(this).find('input.js_hidden_end')
		check.change(function(){
			if($(this).attr('checked'))
				dates.show('fast')
			else
				dates.hide('fast')
		});
		end_toggle.change(function(){
		  if($(this).attr('checked')){
				end_inputs.attr('disabled',false);
				hidden_end.attr('disabled',true);
				end_span.show('fast');
			}
			else{
				end_inputs.attr('disabled',true);
				hidden_end.attr('disabled',false);
				end_span.hide('fast');
			}
		});
		check.change();
		end_toggle.change();
		
		// $(this).find('input.js_hidden').attr('disabled',true);
		//    $(this).find('.js_hide select').attr('disabled',true);
	}
})(jQuery);


$(function(){
  $('.js_publish_control').publishControl();
});
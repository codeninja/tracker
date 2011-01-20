$(document).ready(function(){
	$('.click_demo').click(function(e){
		// alert("You clicked me, I'm reporting you.")
		
		console.log($(this).attr("id"))
		// url = '/report/api_key/ad_id/session_key/event/'
		ad_id =$(this).attr("id").replace("x_", "") 
		uri = "/report/"+_TRACKER_API_KEY+"/"+ad_id+"/"+_TRACKER_SESSION+"/click"
		console.log(_TRACKER_API_KEY, ad_id, _TRACKER_SESSION)
		$.ajax({url : uri})
		
		
		e.preventDefault();
	})
})



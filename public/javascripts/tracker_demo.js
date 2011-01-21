$(document).ready(function(){
	$('.click_demo').click(function(e){
		// url = '/report/api_key/ad_id/session_key/event/'
		ad_id =$(this).attr("id").replace("x_", "") 
		
		
		uri = "/report/"+_TRACKER_API_KEY+"/"+ad_id+"/"+_TRACKER_SESSION+"/click"

		$.ajax({url : uri})
		e.preventDefault();
	})
	
	$(".heatmap_demo").mousemove(function(e){
		ad_id = $(this).attr('id').replace("x_", "")	
		
		// url = '/report/api_key/ad_id/session_key/event/'
		uri = "/report/"+_TRACKER_API_KEY+"/"+ad_id+"/"+_TRACKER_SESSION+"/hotspot"
		payload = {"payload": {'x': e.clientX, 'y': e.clientY}}
		
		$.ajax({url : uri, data: payload})
	})
})



$(function(){
	$("#container").hide();
	window.onload = (e) => {
		console.log("Website geladen");
		window.addEventListener('message', (event) => {
			var item = event.data;
			if (item !== undefined && item.type === "ui") {
				if (item.display === true) {
                    $("#container").show();
				} else{
                    $("#container").hide();
                }
			}
		});	
	};
});
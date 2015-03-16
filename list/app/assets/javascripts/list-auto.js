jQuery(
	function() {
		var array =  $("#debug")[0].value.split("\n");
		$("#content").autocomplete({source:array});
	}
);

// function image_autocomplete(li_array) {
// 	console.log(li_array);
// 	for (var i = 0; i < li_array.length; i++) {
// 		li = li_array[i];
// 		var img = $("<img>", {class: "autocomplete_img", src: li.text});
// 		li.appendChild(img);
// 	}
// }

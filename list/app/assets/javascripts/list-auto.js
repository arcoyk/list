jQuery(
	function() {
		var array =  $("#debug")[0].value.split("\n");
		$("#content").autocomplete({source:array});
		console.log(array);
	}
);

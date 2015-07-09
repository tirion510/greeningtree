function buttonSubmit(obj){
	$(obj).attr("disabled",true);
	$(obj).val(obj.dataset.disableWith);
	return true;
}

function buttonDisabled(){
	$("input[type='submit']").each(function(){
		$(this).attr("disabled",true);
	});
}

function buttonAbled(){
	$("input[type='submit']").each(function(){
		$(this).attr("disabled",false);
	});
}
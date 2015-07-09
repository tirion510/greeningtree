<#macro tab uTab>
	<#if uTab?exists>
		<#local tab_menu_class_c = "xxk">
		<#local div_class = "xxk_content">
		<#if uTab.type?? && uTab.type==1>
			<#local tab_menu_class_c = "xxk2">
			<#local div_class = "xxk2_content">
		</#if>
		<#if uTab.tabMenuClass??>
			<#local uTab=uTab+{"tabMenuClass":(tab_menu_class_c+" "+uTab.tabMenuClass)}>
		<#else>
			<#local uTab=uTab+{"tabMenuClass":tab_menu_class_c}>
		</#if>
		<#local li_html="">
		<#local div_html="">
		<#list uTab.tabList as jTab>
			<#local class_html = "">
			<#if jTab.tabIsActive>
				<#local class_html = "active">
			</#if>
			<#local li_html=li_html+"\lli class=\"${class_html}\" ${jTab.event} ${jTab.attrs}\g${jTab.title}\l/li\g">
			<#local style_html="style='display: none;'">
			<#if jTab.tabIsActive>
				<#local style_html="style='display: block;'">
			</#if>
			<#local div_html=div_html+"\ldiv ${style_html}\g${jTab.content}\l/div\g">
		</#list>
		<ul class="tab_menu no_list_style fixfloat ${uTab.tabMenuClass}">
			${li_html}
		</ul>
		<div class="tab_box ${div_class}">
			${div_html}
		</div>
		<script type="text/javascript">
		$(document).ready(function(){
		  $(".tab_menu").each(function(){
		  	var div_li = $(this).find("li");
		  	div_li.click(function(){
	     		$(this).addClass("active").siblings().removeClass("active");
			    var div_index = div_li.index(this);
			    $(this).parent().next().children("div").eq(div_index).show().siblings().hide();
			    if($(this).attr('callback'))
			    {
			    	eval($(this).attr('callback'));
			    }
			    $(".scrol,.tab_menu").trigger("slidetab");
			    ${uTab.bindClick}
			  }).hover(function(){
	        $(this).addClass("hover");
	   		},function(){
	 		    $(this).removeClass("hover");
	 			});
		  });
		}); 
		</script>
	</#if>
</#macro>
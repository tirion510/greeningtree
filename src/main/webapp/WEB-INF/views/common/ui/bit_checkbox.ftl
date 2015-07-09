<#--
Example:
	<#assign bitcheckboxmap=[{"value":1,"text":"c4"},{"value":2,"text":"c2","is_checked":true},{"value":3,"text":"c3","is_checked":false,"event_html":"","attrs_html":""},{"value":4,"text":"c6","is_checked":true},{"value":5,"text":"c7","is_checked":false},{"value":6,"text":"c1","is_checked":false,"event_html":""}]>
    <@form_ui.bit_checkbox map=bitcheckboxmap value="21" name="testcheckboxgroup" show_all=true disable_auto_sort=false>
    </@form_ui.bit_checkbox>
-->
<#macro bit_checkbox name value map show_all disable_auto_sort>
	<#if map?exists>
		<#local sortmap=map>
		<#if (map?size>5 && !disable_auto_sort)>
			<#local sortmap=map?sort_by("text")>
		</#if>
		<#local event_html="onclick='change_bit_${name}(this)'">
		<#local all_c_value=0>
		<div class="clearfix">
			<#list sortmap as checkbox>
				<#local all_c_value=all_c_value+checkbox.value>
			</#list>
			<#if show_all>
				<#local is_checked=false>
				<#if all_c_value==value>
					<#local is_checked=true>
				</#if>
				<#local all_checkbox=[{"value":0,"text":"All","is_checked":is_checked,"event_html":event_html}]>
				<#local sortmap=all_checkbox+sortmap>
			</#if>
			<#list sortmap as checkbox>
				<#local ch_checked="" is_checked=false ch_value=(checkbox.value!0) ch_text=(checkbox.text!"") ch_attrs_html=(checkbox.attrs_html!"")>
				<#if checkbox.is_checked>
					<#local is_checked=true>
				</#if>
				<#if (value & ch_value)>
					<#local is_checked=true>
				<#elseif ch_value==1>
					<#local is_checked=false>
				</#if>
				<#if is_checked>
					<#local ch_checked="checked='checked'">
				</#if>
				<div class="floatL ckcheck">
					<input type="checkbox" ${ch_checked} name="chk_${name}" value="${ch_value}" ${event_html} ${ch_attrs_html}>
					<span class="spaceR15">${ch_text}</span>
				</div>							
			</#list>
		</div>
    <script type="text/javascript">
			function change_bit_${name}(obj)
			{
				if($(obj).val() == 0)
				{
					$("input[name='chk_${name}']").prop("checked",$(obj).prop("checked"));
				}
				var count = 0;
				$("input[name='chk_${name}']:checked").each(function(){
					count	+= parseInt($(this).val());
				});
				var all_count = 0;
				$("input[name='chk_${name}']").each(function(){
					all_count	+= parseInt($(this).val());
				});				
				if($(obj).val() != 0 )
				{
					if(count == all_count)
					{
						$("input[name='chk_${name}']").eq(0).prop("checked",true);
					}
					else
					{
						$("input[name='chk_${name}']").eq(0).prop("checked",false);
					}
				}
				$("input[name='${name}']").val(count);
			}
			</script>
	</#if>
</#macro>
<#macro form form_elements form_index title_width form_style method action onsubmit hidden_html no_form id name language>
	<#if !method??>
		<#local method="post">
	</#if>
	<#if !name?? && id??>
		<#local name=id>
	</#if>
	<#local html="">
	<#list form_elements as form_element>
		<#if form_element.content?? && form_element.content!="">
			<#local title=form_element.title>
			<#if language=="en">
				<#local title=title?trim>
				<#if title!="&nbsp;" && !title?ends_with(":") && !title?ends_with("$")>
					<#local title="\""+title+"\"">
				</#if>
			</#if>
			<#local required=form_element.required>
			<#local required_html="">
			<#if required>
				<#local required_html=required_html+"\lspan class=\"n_red\"\g*\l/span\g">
			</#if>
			<#if form_index==1>
				<#local width_attr="">
				<#if title_width?? && title_width!="">
					<#local width_attr="width=\"${title_width}\"">
				</#if>
				<#local separator_style="">
				<#if form_element.separator??>
					<#local separator_style=" style=\"border-top:1px solid #cccccc\"">
				</#if>
				<#local html=html+"\ltr${separator_style}\g
					\lth${width_attr}\g${required_html} ${title}\l/th\g
					\ltd\g${form_element.content}\l/td\g
					\l/tr\g">
			<#elseif form_index==2>
				<#local title_div="">
				<#if required_html?? || title??>
					<#local title_div="\ldiv\g${required_html} ${title}\l/div\g">
				</#if>
				<#local html=html+"\ldiv class=\"n_sale_bot\"\g	
										${title_div}
										\ldiv\g${form_element.content}\l/div\g
									\l/div\g">
			<#elseif form_index==3>
				<#local title_html="">
				<#if title??>
					<#local title_html="\lspan class=\"spaceR10 floatL\"\g${required_html} ${title}\l/span\g">
				</#if>
				<#local html=html+"\ldiv class=\"floatL marbot spaceR10\" style=\"min-height:25px;\"\g
										${title_html}
										\ldiv class=\"floatL\"\g
											${form_element.content}
										\l/div\g
									\l/div\g">
			<#elseif form_index==4>
				<#local html=html+"\ldiv\g
										${form_element.content}
									\l/div\g">
			</#if>
		</#if>
	</#list>
	<#if form_index == 1>
		<#local html="\ltable cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style=\"border-collapse:collapse;\"\g
						\ltbody\g
							${html}
						\l/tbody\g
					\l/table\g">
	<#elseif form_index==3>
		<#local html="\ldiv class=\"clearfix\"\g
							${html}
						\l/div\g">
	<#elseif form_index==4>
		<#local html="\ldiv\g
							${html}
						\l/div\g">
	</#if>
	<#local html=html+hidden_html>
	<#if no_form>
		<#local html="\ldiv class=\"form${form_index}\" id=\"${id}\" ${form_style}\g
							${html}
						\l/div\g">
	<#else>
		<#local html="\lform class=\"form${form_index}\" method=\"${method}\" action=\"${action}\" onsubmit=\"${onsubmit}\" id=\"${id}\" name=\"${name}\" ${form_style}\g
							${html}
						\l/form\g">
	</#if>
	${html}
</#macro>
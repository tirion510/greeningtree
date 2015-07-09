<#macro panel head_title content panel_index foot_title foot_custom>
	<#local panel_index=panel_index/>
	<#if panel_index?exists>
		<#local panel=panel_index/>
	<#else>
		<#local panel=1/>
	</#if>
	<#local p_class=""/>
	<#if panel_idnex==1>
		<#local p_class="sPanelOrange"/>
	<#elseif panel_index==2>
		<#local p_class="sPanelBlue"/>
	<#elseif panel_index==3>
		<#local p_class="spanelGray"/>
	<#elseif panel_index==4>
		<#local p_class="sPanelWhite"/>
	</#if>
	<#local head_title=head_title/>
	<#local head_custom=head_custom/>
	<#local foot_title=foot_title/>
	<#local foot_custom=foot_custom/>
	<#local content=content/>
	
	<div class="${p_class}">
		 <#if head_title?exists||head_custom?exists>
		 	<#if head_custom?exists>
				<div class="custom">${head_custom}</div>
		 	</#if>
		 	<#if head_title?exists>
				<h3 class="sPanelTitle">${head_title}</h3>
			</#if>
		 	<div class="heading">
		    	<div class="custom">${head_custom}</div>
		    	<h3 class="sPanelTitle">${head_title}</h3>
		 	</div>
	     </#if>
		 <div class="sPanelBody">
		 	${content}
		 </div>
		 	<#if foot_title?exists||foot_custom?exists>
				<#if foot_custom?exists>
					<div class="custom">${foot_custom}</div>
				</#if>
				<#if foot_title?exists>
					<h3 class="sPanelTitle">${foot_title}</h3>
				</#if>
				<div class="heading">
					<div class="custom">${foot_custom}</div>
					<h3 class="sPanelTitle">${foot_title}</h3>
				</div>
			</#if>
	</div>
</#macro>
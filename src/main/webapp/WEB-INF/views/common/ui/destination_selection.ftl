<#macro destination_selection destinationSelection>
	<#if destinationSelection??>
		<#local options=[]>
		<#local destination_expressions=[]>
		<#if destinationSelection.showInUse>
			<#local destination_expressions = destination_expressions + ["self.tier < 15"]>
		</#if>
		<#if destinationSelection.listStationCity>
			<#local destination_expressions = destination_expressions + ["self.list_station_city == true"]>
		</#if>
		<#if destinationSelection.hideRegion>
			<#local destination_expressions = destination_expressions + ["self.d_type != 3"]>
		</#if>
		<#local destination_expression_string = "">
		<#if (destination_expressions?size>0)>
			<#list destination_expressions as destination_expression>
				<#local destination_expression_string = destination_expression_string + destination_expression>
				<#if destination_expression_has_next>
					<#local destination_expression_string = destination_expression_string + " && ">
				</#if>
			</#list>
		</#if>
		<#local destination_ancestors_string = "">
		<#if destinationSelection.vendorSelectedDestinations?? && (destinationSelection.vendorSelectedDestinations?size>0)>
			<#list destinationSelection.vendorSelectedDestinations as vendorSelectedDestination>
				<#local destination_ancestors_string = destination_ancestors_string + vendorSelectedDestination>
				<#if vendorSelectedDestination_has_next>
					<#local destination_ancestors_string = destination_ancestors_string + ",">
				</#if>
			</#list>
		</#if>
		<#local options=options + ["type:0"]>
		<#if destination_expression_string != "">
			<#local options=options + ["destination_expression: \"${destination_expression_string}\""]>
		</#if>
		<#if destination_ancestors_string != "">
			<#local options=options + ["destination_ancestors: \"${destination_ancestors_string}\""]>
		</#if>
		<#if !destinationSelection.userIsSupport>
			<#local options=options + ["is_support: false"]>
		</#if>
		<#local options_string = "">
		<#list options as option>
			<#local options_string = options_string + option>
			<#if option_has_next>
				<#local options_string = options_string + ",">
			</#if>
		</#list>
		<#local container_style_attr = "">
		<#if destinationSelection.width != 0>
			<#local container_style_attr = "style=\"width:${destinationSelection.width}px;\"">
		</#if>
		<div ${container_style_attr} vendor_id="${destinationSelection.vendorId}">
			<input type="hidden" id="${destinationSelection.id}" name="${destinationSelection.name}" value="${destinationSelection.value}" destination_selection="destination_selection"/>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#${destinationSelection.id}").not(".hasDestinationSelection").destination_selection({
					${options_string}
				});
			});
		</script>
	</#if>
</#macro>
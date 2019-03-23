
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:if test="#attr.searchMenu != null">

	<style>
#searchMenu div.dropdown.bootstrap-select, #searchMenu div.dropdown.bootstrap-select>button
	{
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}

#searchMenu div.input-group {
	
}

#searchMenu div.input-group input {
	margin-left: 0.5em;
	display: inline-block;
	width: auto;
}

#searchMenu div.dropdown.bootstrap-select>.dropdown-menu {
	width: 100%;
}
</style>
	<form id='searchMenu' class="rounded alert-info pt-2 pl-2">
		<div class="row">
			<s:iterator value="#attr.searchMenu.elements" var="element" status="status">
				<div class="col-sm-6 col-md-4 input-group">
					<s:property value="#element.html" escape="false" />
				</div>
			</s:iterator>
		</div>
		<div class="row">
			<div class="col-auto ml-auto">
				<a class="nav-link" href="<s:property value="#attr.actionName" />.action?" id="searchMenuQuery"> <i class="fas fa-search" style="font-size: 24px;"></i> <span
					class="nav-link-text"></span>
				</a>
			</div>
		</div>
	</form>
</s:if>
<script type="text/javascript">
	$(document).ready(function() {
		
		$('#searchMenuQuery').on('click', function(e) {
			e.preventDefault()
			var href = "";
			$('#searchMenu input').each(function(idx, el){
				href += $(el).attr('name') + "=" + encodeURI($(el).val()) + "&";
			})
			window.location.assign($(this).attr('href') + href);
		})
	})
</script>
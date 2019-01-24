
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:if test="#attr.searchMenu != null">

	<style>
#searchMenu div.dropdown.bootstrap-select, #searchMenu div.dropdown.bootstrap-select>button {
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}

#searchMenu div.input-group {
	height: 40px;
}

#searchMenu div.dropdown.bootstrap-select>.dropdown-menu {
	width: 100%;
}
</style>
	<form id='searchMenu' class="rounded alert-info pt-2 pl-2">
		<div class="row">
			<s:iterator value="#attr.searchMenu.elements" var="elements" status="status">
				<s:iterator value="#elements.element" var="element" status="status">
					<s:if test="{#element.Type == 'INPUT'}" >
</s:if>
				</s:iterator>
			</s:iterator>
			<div class="col-auto mb-2">
				<div class="input-group">
					<div class="input-group-prepend">
						<div class="input-group-text">as</div>
					</div>
					<div class="input-group-append">
						<input width="200px" type="text" class="form-control" placeholder="Username2">
					</div>
				</div>
			</div>
			<div class="col-auto mb-2">
				<div class="input-group">
					<div class="input-group-prepend">
						<div class="input-group-text">4564654456456456654</div>
					</div>
					<div class="input-group-append">
						<select class="form-control selectpicker " data-width="auto">
							<option value="">中文</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-auto mb-2">
				<div class="input-group">
					<div class="input-group-prepend">
						<div class="input-group-text">as</div>
					</div>
					<div class="input-group-append">
						<input width="200px" type="text" class="form-control" placeholder="Username2">
					</div>
				</div>
			</div>
			<div class="col-auto mb-2">
				<div class="input-group">
					<div class="input-group-prepend">
						<div class="input-group-text">4564654456456456654</div>
					</div>
					<div class="input-group-append">
						<select class="form-control selectpicker " data-width="auto">
							<option value="">中文</option>
						</select>
					</div>
				</div>
			</div>

			<div class="col-auto ml-auto">
				<a class="nav-link" href="#" onclick="onQuery();"> <i class="fas fa-search" style="font-size: 24px;"></i> <span
					class="nav-link-text"></span>
				</a>
			</div>
		</div>
	</form>
</s:if>
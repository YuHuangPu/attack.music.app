<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav"> <a class="navbar-brand" href=""><s:property value="userInfo.Account" /></a>
	<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarResponsive">
		<ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
			<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard"><a class="nav-link" href="ownerPage.action"> <i class="fas fa-tachometer-alt fa-lg"></i>
					<span class="nav-link-text"><s:property value="lgView.getId('001')" /></span>
			</a></li>
			<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Factory"><a class="nav-link" href="factoryPage.action"> <i class="far fa-handshake fa-lg"></i>
					<span class="nav-link-text"><s:property value="lgView.getId('002')" /></span>
			</a></li>
			<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Consumer"><a class="nav-link" href="consumerPage.action"> <i class="fas fa-balance-scale fa-lg"></i>
					<span class="nav-link-text"><s:property value="lgView.getId('036')" /></span>
			</a></li>
			<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Reserve"><a class="nav-link" href="reservePage.action"> <i class="fas fa-dolly-flatbed fa-lg"></i>
					<span class="nav-link-text"><s:property value="lgView.getId('013')" /></span>
			</a></li>
			<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Transaction"><a class="nav-link" href="transactionPage.action"> <i
					class="fas fa-hand-holding-usd fa-lg"></i> <span class="nav-link-text"><s:property value="lgView.getId('019')" /></span>
			</a></li>
		</ul>
		<ul class="navbar-nav sidenav-toggler">
			<li class="nav-item"><a class="nav-link text-center" id="sidenavToggler"> <i class="fa fa-fw fa-angle-left"></i>
			</a></li>
		</ul>
		<ul class="navbar-nav ml-auto">
			<li class="nav-item"><a class="nav-link" data-toggle="modal" data-target="#exampleModal"> <s:property value="lgView.getId('025')" /> <i class="fas fa-sign-out-alt"></i>
			</a></li>
		</ul>
	</div>
	</nav>
	<!-- Logout Modal-->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						<s:property value="lgView.getId('026')" />
					</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<s:property value="lgView.getId('027')" />
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">
						<s:property value="lgView.getId('028')" />
					</button>
					<a class="btn btn-primary" href="logout"><s:property value="lgView.getId('025')" /></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
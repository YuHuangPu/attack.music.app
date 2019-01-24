<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<style type="text/css">
</style>
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
	<div class="content-wrapper">
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="ownerPage.action"><s:property value="lgView.getId('001')" /></a></li>
				<li class="breadcrumb-item active"><s:property value="lgView.getId('052')" /></li>
			</ol>
			<s:include value="/jsp/head/searchMenu.jsp"></s:include>
		</div>

	</div>
</body>

<script type="text/javascript">
	$(document).ready(function() {
	});
</script>

</html>
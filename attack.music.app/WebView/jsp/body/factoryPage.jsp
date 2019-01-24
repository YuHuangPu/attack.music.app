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
<!-- 	<s:iterator value="#attr.fInfo" var="f" status="status">
		<s:property value='#f.get("Name")' />
	</s:iterator> -->

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
  <!-- Navigation-->
 <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="ownerPage.action"><s:property value="lgView.getId('001')" /></a>
        </li>
        <li class="breadcrumb-item active"><s:property value="lgView.getId('002')" /></li>
      </ol>
      <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-header">
          <i class="far fa-handshake fa-lg"></i> <s:property value="lgView.getId('002')+lgView.getId('003')" />
            <a class="mr-3 btn btn-primary text-white" data-toggle="modal"
				data-target="#addModal">
                  <i class="fas fa-user-plus"></i>
            </a>          
        </div>
        
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                <th><s:property value="lgView.getId('004')" /></th>
                  <th><s:property value="lgView.getId('005')" /></th>
                  <th><s:property value="lgView.getId('006')" /></th>
                  <th><s:property value="lgView.getId('007')" /></th>
                  <th><s:property value="lgView.getId('008')" /></th>
                  <th><s:property value="lgView.getId('009')" /></th>
                  <th><s:property value="lgView.getId('010')" /></th>
                  <th><s:property value="lgView.getId('011')" /></th>
                  <th><s:property value="lgView.getId('012')" /></th>
                </tr>
              </thead>
              <tbody>
                <s:iterator value="#attr.fInfo" var="f" status="status">
					<tr>
					<td>
						<div class="btn-toolbar mb-3" id=<s:property value='#f.get("Id")' />>
						  <div class="btn-group mr-2">
						    <button type="button" class="btn btn-success editFactory" data-toggle="modal" data-target="#editModal">
								<i class="fas fa-user-edit"></i>
							</button>
						    <button type="button" class="btn btn-danger delFactory" >
						    	<i class="fas fa-user-minus"></i>
							</button>
						  </div>
						</div>
					</td>
	                  <td><s:property value='#f.get("Id")' /></td>
	                  <td><s:property value='#f.get("Name")' /></td>
	                  <td><s:property value='#f.get("Contact")' /></td>
	                  <td><s:property value='#f.get("Address")' /></td>
	                  <td><s:property value='#f.get("Mobile")' /></td>
	                  <td><s:property value='#f.get("Remark")' /></td>
	                  <td><s:property value='#f.get("UpdateWho")' /></td>
	                  <td><s:property value='#f.get("UpdateDate")' /></td>
	                </tr>
				</s:iterator>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer small text-muted"><s:property value='#attr.MaxUpdate' /></div>
      </div>
    </div>
    <!-- /.container-fluid-->
    <!-- /.content-wrapper-->
    
  </div>
<!-- add page -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="ModalLabel"><s:property value="lgView.getId('029') + lgView.getId('002')" /></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<form id="addFactoryForm">
				<div class="modal-body">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">
								<label ><s:property value="lgView.getId('002') + lgView.getId('005')" /></label>
								<input class="form-control" id="FactoryId" type="text" placeholder="0">
							</div>
							<div class="col-md-8">
								<label><s:property value="lgView.getId('002') + lgView.getId('006')" /></label>
								<input class="form-control" id="FactoryName" type="text" 
									placeholder="<s:property value="lgView.getId('032') + lgView.getId('002') + lgView.getId('006')" />" required>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label ><s:property value="lgView.getId('007') + lgView.getId('006')" /></label>
								<input class="form-control" id="FactoryContact" type="text" 
									placeholder="<s:property value="lgView.getId('032') + lgView.getId('007') + lgView.getId('006')" />" >
							</div>
							<div class="col-md-6">
								<label ><s:property value="lgView.getId('007') + lgView.getId('009')" /></label>
								<input class="form-control" id="FactoryMobile" type="text" 
									placeholder="<s:property value="lgView.getId('032') + lgView.getId('007') + lgView.getId('009')" />" >
							</div>
						</div>
					</div>
					<div class="form-group">
						<label><s:property value="lgView.getId('002') + lgView.getId('008')" /></label>
						<input class="form-control" id="FactoryAddress" type="text" 
							placeholder="<s:property value="lgView.getId('032') + lgView.getId('002') + lgView.getId('008')" />" >
					</div>
					<div class="form-group">
						<label><s:property value="lgView.getId('010')" /></label>
						<textarea class="form-control" id="FactoryRemark" type="text" placeholder=""></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal"><s:property value="lgView.getId('028')" /></button>
					<button class="btn btn-primary text-white"><s:property value="lgView.getId('031')" /></button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- edit page -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="ModalLabel">Edit Factory</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<form id="editFactoryForm">
				<div class="modal-body">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">
								<label >Factory ID</label>
								<input class="form-control" id="FactoryId" type="text" placeholder="0" disabled>
							</div>
							<div class="col-md-8">
								<label>Factory Name</label>
								<input class="form-control" id="FactoryName" type="text" placeholder="Enter Factory Name" required autofocus>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label >Contact Name</label>
								<input class="form-control" id="FactoryContact" type="text" placeholder="Enter Contact Name" required>
							</div>
							<div class="col-md-6">
								<label >Contact Mobile</label>
								<input class="form-control" id="FactoryMobile" type="text" placeholder="Enter Contact Mobile" required>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label>Factory Address</label>
						<input class="form-control" id="FactoryAddress" type="text" placeholder="Enter Factory Address" required>
					</div>
					<div class="form-group">
						<label>Remark</label>
						<textarea class="form-control" id="FactoryRemark" type="text" placeholder="Remark"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
					<button class="btn btn-primary text-white">Submit</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	$("#addFactoryForm").on('submit', function(e) {
		e.preventDefault();
		$("#addFactoryForm button").prop('disabled', true);
		var data = {};
		$('#addModal .form-control').each(function(n,v){
			data[$(this).attr('id')] = $(v).val();
		});
		$.ajax({
			type: "post",
		    url: "addFactory",
		    contentType: 'application/json; charset=utf-8',
		    data: JSON.stringify(data), 
		    dataType: "json",
			cache: false,
			beforeSend:function(){}
			,success: function(response){
				if(!response.status){
					showError(response.message);
				}else{
					window.location.reload();
				}
			}
			,complete:function(){
				$("#addFactoryForm button").prop('disabled', false);
			}
			,error: function(xhr, ajaxOptions, thrownError){
		    	showError('?????')
		    }
		});
	});
	
	$(".delFactory").on('click', function(e) {
		e.preventDefault();
		$(this).prop('disabled', true);
		var data = {};
		data['FactoryID'] = $(this).parents('div.btn-toolbar').attr('id');
		$.ajax({
			type: "post",
		    url: "editFactory",
		    contentType: 'application/json; charset=utf-8',
		    data: JSON.stringify(data), 
		    dataType: "json",
			cache: false,
			beforeSend:function(){}
			,success: function(response){
				if(!response.status){
					showError(response.message);
				}else{
					window.location.reload();
				}
			}
			,complete:function(){
				$(this).prop('disabled', false);
			}
			,error: function(xhr, ajaxOptions, thrownError){
		    	showError('?????')
		    }
		});
	});
	$(".editFactory").on('click', function(e) {
		e.preventDefault();
		var $editF = $(this);
		$('#editModal').unbind('show.bs.modal').on('show.bs.modal', function(e){
			var title = ["FactoryId", "FactoryName", "FactoryContact", "FactoryMobile", "FactoryAddress", "FactoryRemark"]
			$editF.parents('tr[role="row"]').children('td').each(function(n,v){
				if(n>0&&n<=6){
					$('#editModal #editFactoryForm .form-control[id='+title[n-1]+']').val($(v).html())
				}
			});
		});
	});
	$("#editFactoryForm").on('submit', function(e) {
		e.preventDefault();
		$(this).prop('disabled', true);
		var data = {};
		$('#editModal .form-control').each(function(n,v){
			data[$(this).attr('id')] = $(v).val();
		});
		console.log(data);
		$.ajax({
			type: "post",
		    url: "editFactory",
		    contentType: 'application/json; charset=utf-8',
		    data: JSON.stringify(data), 
		    dataType: "json",
			cache: false,
			beforeSend:function(){}
			,success: function(response){
				if(!response.status){
					showError(response.message);
				}else{
					window.location.reload();
				}
			}
			,complete:function(){
				$(this).prop('disabled', false);
			}
			,error: function(xhr, ajaxOptions, thrownError){
		    	showError('?????')
		    }
		});
	});
});
</script>

</html>
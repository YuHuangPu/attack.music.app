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
        <li class="breadcrumb-item active"><s:property value="lgView.getId('036')" /></li>
      </ol>
      <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-header">
          <i class="fas fa-balance-scale fa-lg"></i> <s:property value="lgView.getId('036')+lgView.getId('003')" />
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
                  <th><s:property value="lgView.getId('009')" /></th>
                  <th><s:property value="lgView.getId('010')" /></th>
                  <th><s:property value="lgView.getId('017')" /></th>
                  <th><s:property value="lgView.getId('018')" /></th>
                  <th><s:property value="lgView.getId('011')" /></th>
                  <th><s:property value="lgView.getId('012')" /></th>
                </tr>
              </thead>
              <tbody>
                <s:iterator value="#attr.consumers" var="f" status="status">
					<tr>
					<td>
						<div class="btn-toolbar mb-3" id=<s:property value='#f.get("Id")' />>
						  <div class="btn-group mr-2">
						    <button type="button" class="btn btn-success editConsumer" data-toggle="modal" data-target="#editModal">
								<i class="fas fa-user-edit"></i>
							</button>
						    <button type="button" class="btn btn-danger delConsumer" >
						    	<i class="fas fa-user-minus"></i>
							</button>
						  </div>
						</div>
					</td>
	                  <td><s:property value='#f.get("Id")' /></td>
	                  <td><s:property value='#f.get("Name")' /></td>
	                  <td><s:property value='#f.get("Mobile")' /></td>
	                  <td><s:property value='#f.get("Remark")' /></td>
	                  <td><s:property value='#f.get("CreateWho")' /></td>
	                  <td><s:property value='#f.get("CreateDate")' /></td>
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
				<h5 class="modal-title" id="ModalLabel"><s:property value="lgView.getId('029')+ lgView.getId('036')" /></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body ">
				<form id="addConsumerForm">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label"><s:property value="lgView.getId('005')" /></label>
						<div class="col-sm-9">
							<input class="form-control" id="ConsumerId" type="text" placeholder="0">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label"><s:property value="lgView.getId('006')" /></label>
						<div class="col-sm-9">
							<input class="form-control" id="ConsumerName" type="text"
								placeholder="<s:property value="lgView.getId('032') + lgView.getId('036') + lgView.getId('006')" />" required>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label"><s:property value="lgView.getId('009')" /></label>
						<div class="col-sm-9">
							<input class="form-control" id="ConsumerMobile" type="text" 
								placeholder="<s:property value="lgView.getId('032') + lgView.getId('036') + lgView.getId('009')" />" required>
						</div>
					</div>
					<div class="form-group">
						<label><s:property value="lgView.getId('010')" /></label>
						<textarea class="form-control" type="text" placeholder=""></textarea>
					</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button" data-dismiss="modal"><s:property value="lgView.getId('028')" /></button>
						<button class="btn btn-primary text-white"><s:property value="lgView.getId('031')" /></button>
					</div>
				</form>
			</div>
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
			<div class="modal-body ">
				<form id="editConsumerForm">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label"><s:property value="lgView.getId('005')" /></label>
						<div class="col-sm-9">
							<input class="form-control" id="ConsumerId" type="text" placeholder="0" disabled>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label"><s:property value="lgView.getId('006')" /></label>
						<div class="col-sm-9">
							<input class="form-control" id="ConsumerName" type="text"
								placeholder="<s:property value="lgView.getId('032') + lgView.getId('036') + lgView.getId('006')" />" required>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label"><s:property value="lgView.getId('009')" /></label>
						<div class="col-sm-9">
							<input class="form-control" id="ConsumerMobile" type="text" 
								placeholder="<s:property value="lgView.getId('032') + lgView.getId('036') + lgView.getId('009')" />" required>
						</div>
					</div>
					<div class="form-group">
						<label><s:property value="lgView.getId('010')" /></label>
						<textarea id="ConsumerRemark" class="form-control" type="text" placeholder=""></textarea>
					</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button" data-dismiss="modal"><s:property value="lgView.getId('028')" /></button>
						<button class="btn btn-primary text-white"><s:property value="lgView.getId('031')" /></button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	
	$('#addConsumerForm').on('submit', function(e){
		e.preventDefault();
		data = {};
		$btn = $(this).find('button');
		$btn.prop('disabled', true);
		dataTil = ["ConsumerId", "ConsumerName", "ConsumerMobile", "ConsumerRemark"];
		$(this).find('.form-control').each(function(n, v){
			data[dataTil[n]] = $(v).val();
		})
		data = {"addConsumer":data};
		$.ajax({
			type: "post",
		    url: "maintainConsumer",
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
				$btn.prop('disabled', false);
			}
			,error: function(xhr, ajaxOptions, thrownError){
		    	showError('?????')
		    }
		});
	});
	$(".delConsumer").on('click', function(e) {
		e.preventDefault();
		data = {};
		$btn = $(this).find('button');
		$btn.prop('disabled', true);
		data['ConsumerId'] = $(this).parents('div.btn-toolbar').attr('id');
		data = {"delConsumer":data};
		$.ajax({
			type: "post",
		    url: "maintainConsumer",
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
				$btn.prop('disabled', false);
			}
			,error: function(xhr, ajaxOptions, thrownError){
		    	showError('?????')
		    }
		});
	});
	$(".editConsumer").on('click', function(e) {
		e.preventDefault();
		var $editF = $(this);
		$('#editModal').unbind('show.bs.modal').on('show.bs.modal', function(e){
			var title = ["ConsumerId", "ConsumerName", "ConsumerMobile", "ConsumerRemark"]
			$editF.parents('tr[role="row"]').children('td').each(function(n,v){
				if(n>0&&n<=4){
					$('#editModal #editConsumerForm .form-control[id='+title[n-1]+']').val($(v).html())
				}
			});
		});
	});
	$("#editConsumerForm").on('submit', function(e) {
		e.preventDefault();
		data = {};
		$btn = $(this).find('button');
		$btn.prop('disabled', true);
		dataTil = ["ConsumerId", "ConsumerName", "ConsumerMobile", "ConsumerRemark"];
		$(this).find('.form-control').each(function(n, v){
			data[dataTil[n]] = $(v).val();
		})
		data = {"editConsumer":data};
		$.ajax({
			type: "post",
		    url: "maintainConsumer",
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
				$btn.prop('disabled', false);
			}
			,error: function(xhr, ajaxOptions, thrownError){
		    	showError('?????')
		    }
		});
	});
});
</script>

</html>
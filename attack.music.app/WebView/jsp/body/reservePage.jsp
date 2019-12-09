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
				<li class="breadcrumb-item"><a href="ownerPage.action"><s:property value="lgView.getId('001')" /></a></li>
				<li class="breadcrumb-item active"><s:property value="lgView.getId('013')" /></li>

			</ol>
			<!-- Example DataTables Card-->
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-dolly-flatbed fa-lg"></i>
					<s:property value="lgView.getId('013') + lgView.getId('003')" />
					<a class="mr-3 btn btn-primary text-white" data-toggle="modal" data-target="#listModal"> <i class="fas fa-user-plus"></i>
					</a>
				</div>
				<div class="card-body">
					<jsp:include page="/jsp/head/searchMenu.jsp"></jsp:include>
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th><s:property value="lgView.getId('005')" /></th>
									<th><s:property value="lgView.getId('006')" /></th>
									<th><s:property value="lgView.getId('013')" /></th>
									<th><s:property value="lgView.getId('044')" /></th>
									<th><s:property value="lgView.getId('015')" /></th>
									<th><s:property value="lgView.getId('016')" /></th>
									<th><s:property value="lgView.getId('002')" /></th>
									<th><s:property value="lgView.getId('010')" /></th>
									<th><s:property value="lgView.getId('017')" /></th>
									<th><s:property value="lgView.getId('012')" /></th>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="#attr.gInfo" var="f" status="status">
									<tr>
										<td><a class="editGoods" href="" data-toggle="modal" data-target="#editModal"><s:property value='#f.get("Id")' /></a></td>
										<td><s:property value='#f.get("Name")' /></td>
										<td><s:property value='#f.get("Reserve")' /></td>
										<td><s:property value='#f.get("Purchase") + " / " + #f.get("Sell")' /></td>
										<td><s:property value='#f.get("Cost")' /></td>
										<td><s:property value='#f.get("Price")' /></td>
										<td factoryId=<s:property value='#f.get("Factory")' />><s:property value='#f.get("FactoryName")' /></td>
										<td><s:property value='#f.get("Remark")' /></td>
										<td><s:property value='#f.get("CreateWho")' /></td>
										<td><s:property value='#f.get("UpdateDate")' /></td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
					</div>
				</div>
				<div class="card-footer small text-muted">
					<s:property value='#attr.MaxUpdate' />
				</div>
			</div>
		</div>
		<!-- /.container-fluid-->
		<!-- /.content-wrapper-->


	</div>

	<div class="modal fade" id="listModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel">
						<s:property value="lgView.getId('035')" />
					</h5>
					<button class="btn btn-outline-primary" type="button" id="addList">
						<s:property value="lgView.getId('029')" />
					</button>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form id="reserveListForm">
					<div class="modal-body">
						<div class="form-group row">
							<div class="col-md-7">
								<label class="col-form-label"><s:property value="lgView.getId('002')" /></label> <select class="form-control selectpicker show-tick" data-live-search="true" data-size="5"
									required>
									<s:iterator value="#attr.factorys" var="f" status="status">
										<option value="<s:property value='#f.get("Value")' />"><s:property value='#f.get("Text")' /></option>
									</s:iterator>
								</select>
							</div>
							<div class="col-md-5">
								<div class=" rounded border border-info">
									<div class="col-md-12 row">
										<label class="col-form-label"><s:property value="lgView.getId('024') + ' :'" /></label>
										<p class="col-form-label">9999999</p>
									</div>
									<div class="col-md-12 row">
										<label class="col-form-label"><s:property value="lgView.getId('043') + ' :'" /></label>
										<p class="col-form-label">9999999</p>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-2">
								<label class="col-form-label"><s:property value="lgView.getId('005')" /></label> <input class="form-control" type="text" placeholder="0">
							</div>
							<div class="col-md-2">
								<label class="col-form-label"><s:property value="lgView.getId('006')" /></label> <input class="form-control" type="text"
									placeholder="<s:property value="lgView.getId('032') + lgView.getId('006')" />" required>
							</div>
							<div class="col-md-2">
								<label class="col-form-label"><s:property value="lgView.getId('013')" /></label> <input class="form-control" type="text"
									placeholder="<s:property value="lgView.getId('032') + lgView.getId('013')" />">
							</div>
							<div class="col-md-2">
								<label class="col-form-label"><s:property value="lgView.getId('015')" /></label> <input class="form-control" type="text"
									placeholder="<s:property value="lgView.getId('032') + lgView.getId('015')" />">
							</div>
							<div class="col-md-2">
								<label class="col-form-label"><s:property value="lgView.getId('016')" /></label> <input class="form-control" type="text"
									placeholder="<s:property value="lgView.getId('032') + lgView.getId('016')" />">
							</div>
							<div class="col-md-2">
								<label class="col-form-label"><s:property value="lgView.getId('010')" /></label>
								<textarea class="form-control" type="text" placeholder="<s:property value="lgView.getId('010')" />" rows="1"></textarea>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button" data-dismiss="modal">
							<s:property value="lgView.getId('028')" />
						</button>
						<button class="btn btn-primary text-white">
							<s:property value="lgView.getId('031')" />
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel">aa</h5>
					<button class="btn btn-outline-danger ">
						<s:property value="lgView.getId('045')" />
					</button>
				</div>
				<form id="editGoodsForm">
					<div class="modal-body ">
						<div class="form-group row">
							<label class="col-sm-3 col-form-label"><s:property value="lgView.getId('006')" /></label>
							<div class="col-sm-9">
								<input class="form-control" type="text" placeholder="<s:property value="lgView.getId('032') + lgView.getId('035') + lgView.getId('006')" />" required>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label"><s:property value="lgView.getId('002')" /></label>
							<div class="col-sm-9">
								<select class="form-control selectpicker show-tick" data-live-search="true" data-size="5">
									<s:iterator value="#attr.factorys" var="f" status="status">
										<option value="<s:property value='#f.get("Value")' />"><s:property value='#f.get("Text")' /></option>
									</s:iterator>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								<div class="col-md-4">
									<label class="col-form-label"><s:property value="lgView.getId('013')" /></label>
									<div>
										<input class="form-control" type="text" placeholder="<s:property value="lgView.getId('032') + lgView.getId('013')" />" required>
									</div>
								</div>
								<div class="col-md-4">
									<label class="col-form-label"><s:property value="lgView.getId('015')" /></label>
									<div>
										<input class="form-control" type="text" placeholder="<s:property value="lgView.getId('032') + lgView.getId('038')" />" required>
									</div>
								</div>
								<div class="col-md-4">
									<label class="col-form-label"><s:property value="lgView.getId('016')" /></label>
									<div>
										<input class="form-control" type="text" placeholder="<s:property value="lgView.getId('032') + lgView.getId('039')" />" required>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label><s:property value="lgView.getId('010')" /></label>
							<textarea class="form-control" placeholder=""></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-secondary " type="button" data-dismiss="modal">
							<s:property value="lgView.getId('028')" />
						</button>
						<button class="btn btn-primary text-white ">
							<s:property value="lgView.getId('031')" />
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">

$(document).ready(function(){
	
	
	
	$('#searchMenuQuery').on('click', function(){
		console.log("a");
	})
	
	$('#editModal .modal-header button:eq(0)').on('click', function(e){
		data = {};
		data['GoodsId'] = $('#editModal').find('#ModalLabel').text();
		data = {"delGoods":data};
		$.ajax({
			type: "post",
		    url: "maintainGoods",
		    contentType: 'application/json; charset=utf-8',
		    data: JSON.stringify(data), 
		    dataType: "json",
			cache: false,
			beforeSend:function(){}
			,success: function(response){
				if(!response.status){
					showError(response.message);
				}else{
					$('#searchMenuQuery').click();
// 					window.location.reload();
				}
			}
			,complete:function(){
				$btn.prop('disabled', false);
			}
			,error: function(xhr, ajaxOptions, thrownError){
		    	showError('?????')
		    }
		});
	})
	
	$('form#editGoodsForm').on('submit', function(e){
		e.preventDefault();
		data = {};
		$btn = $(this).find('.modal-footer button');
		$btn.prop('disabled', true);
		dataTil = ["GoodsName", "FactoryId", "GoodsReserve", "GoodsCost", "GoodsPrice", "GoodsRemark"];
		$(this).find('.form-group input.form-control[placeholder], .form-group select.form-control, .form-group textarea.form-control').each(function(n, v){
			data[dataTil[n]] = $(v).val();
		});
		data['GoodsId'] = $('#editModal').find('#ModalLabel').text();
		data = {"editGoods":data};
		$.ajax({
			type: "post",
		    url: "maintainGoods",
		    contentType: 'application/json; charset=utf-8',
		    data: JSON.stringify(data), 
		    dataType: "json",
			cache: false,
			beforeSend:function(){}
			,success: function(response){
				if(!response.status){
					showError(response.message);
				}else{
					$('#searchMenuQuery').click();
// 					window.location.reload();
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
	
	$('.editGoods').on('click', function(e){
		var $t = $(this);
		var $tr = $t.parents('tr');
		var data = {GoodsId : $t.text()
				, GoodsName:$tr.find('td:eq(1)').text()
				, GoodsReserve:$tr.find('td:eq(2)').text()
				, GoodsCost:$tr.find('td:eq(4)').text()
				, GoodsPrice:$tr.find('td:eq(5)').text()
				, FactoryId:$tr.find('td:eq(6)').attr('factoryId')
				, GoodsRemark:$tr.find('td:eq(7)').text()}
		$('#editModal').unbind('show.bs.modal').on('show.bs.modal', function(e){
			var $modal = $(this);
			$modal.find('#ModalLabel').text(data['GoodsId']);
			var $form = $modal.find('#editGoodsForm')
			$form.find('.form-group:eq(0) input').val(data['GoodsName']);
			
			$form.find('.form-group:eq(1) select').selectpicker('val', data['FactoryId']);
			
			$form.find('.form-group:eq(2) input:eq(0)').val(data['GoodsReserve']);
			$form.find('.form-group:eq(2) input:eq(1)').val(data['GoodsCost']);
			$form.find('.form-group:eq(2) input:eq(2)').val(data['GoodsPrice']);

			$form.find('.form-group:eq(3) textarea').val(data['GoodsRemark']);
		})
	});
	
	
	
	
	
	$('form#reserveListForm').on('submit', function(e){
		e.preventDefault();
		data = {};
		$btn = $(this).find('button');
		$btn.prop('disabled', true);
		dataTil = ["FactoryId", "GoodsList"];
		$(this).find('.form-group.row:eq(0) select.form-control').each(function(n, v){
			data[dataTil[n]] = $(v).val();
		});
		data[dataTil[1]] = [];
		dataListTil = ["GoodsId", "GoodsName", "GoodsReserve", "GoodsCost", "GoodsPrice", "GoodsRemark"];
		$(this).find('.form-group.row').each(function(n, v){
			if(n > 0){
				d = {};
				$(this).find('.form-control').each(function(En, Ev){
					d[dataListTil[En]] = $(Ev).val();
				})
				data[dataTil[1]][n-1]= d;
			}
		});
		data = {"addGoods":data};
		console.log(data);
		$.ajax({
			type: "post",
		    url: "maintainGoods",
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
	$('#addList').on('click', function(e){
		var $reserveListForm = $(this).parents('.modal-content').find('#reserveListForm .modal-body');
		var newGoodsItem = $('<div></div>').addClass('form-group row');
		
		newGoodsItem.append($('<div />', {'class':'col-md-2'}).append(
			$('<input />', {'class':'form-control', type:'text', placeholder:'0'})
		));
		newGoodsItem.append($('<div />', {'class':'col-md-2'}).append(
			$('<input />', {'class':'form-control', type:'text', placeholder:'${sessionScope.lgView.getId("032")}${sessionScope.lgView.getId("006")}', required:true})
		));
		newGoodsItem.append($('<div />', {'class':'col-md-2'}).append(
			$('<input />', {'class':'form-control', type:'text', placeholder:'${sessionScope.lgView.getId("032")}${sessionScope.lgView.getId("013")}'})
		));
		newGoodsItem.append($('<div />', {'class':'col-md-2'}).append(
			$('<input />', {'class':'form-control', type:'text', placeholder:'${sessionScope.lgView.getId("032")}${sessionScope.lgView.getId("015")}'})
		));
		newGoodsItem.append($('<div />', {'class':'col-md-2'}).append(
			$('<input />', {'class':'form-control', type:'text', placeholder:'${sessionScope.lgView.getId("032")}${sessionScope.lgView.getId("016")}'})
		));
		newGoodsItem.append($('<div />', {'class':'col-md-2'}).append(
			$('<textarea />', {'class':'form-control', type:'text', placeholder:'${sessionScope.lgView.getId("010")}', rows:'1'})
		));
		
		$reserveListForm.append(newGoodsItem);
		$setAutoTotal();
	});
	var getAmount = function(type){
		var sumAmount = 0, total = 0;
		$('form#reserveListForm .form-group.row').each(function(n, v){
			if(n > 0){
				$amount = $(this).find('div.col-md-2:eq(2) input.form-control');
				goodsAmount = parseInt($amount.val()==''?0:$amount.val());
				sumAmount = parseInt(sumAmount) + goodsAmount;
				$t = $(this).find('div.col-md-2:eq(3) input.form-control');
				gooodsPrice = parseFloat($t.val()==''?0:$t.val()) * goodsAmount;
				total = (parseFloat(total) + gooodsPrice).toFixed(2);
			}
		});
		return type==0?sumAmount:total;
	};
	$setAutoTotal = function(){
	
		$('form#reserveListForm .form-group.row').each(function(n, v){
			if(n > 0){
				$thisE = $(this).find('div.col-md-2:eq(2) input.form-control');
				$thisE.unbind('keyup').on('keyup', function(e){
					$('#reserveListForm p.col-form-label:eq(0)').text(getAmount(0));
					$('#reserveListForm p.col-form-label:eq(1)').text(getAmount(1));
				})
			}
		})
		$('form#reserveListForm .form-group.row').each(function(n, v){
			if(n > 0){
				$thisE = $(this).find('div.col-md-2:eq(3) input.form-control');
				$thisE.unbind('keyup').on('keyup', function(e){
					$('#reserveListForm p.col-form-label:eq(0)').text(getAmount(0));
					$('#reserveListForm p.col-form-label:eq(1)').text(getAmount(1));
				})
			}
		})
		
	};
	$setAutoTotal();
	
	

});
</script>

</html>
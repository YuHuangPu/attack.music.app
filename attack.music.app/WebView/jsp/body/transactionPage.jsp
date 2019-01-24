<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<style type="text/css">
.card-body-icon {
	top: 15px;
	right: 8px;
}
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
				<li class="breadcrumb-item"><a href="ownerPage.action"> <s:property value="lgView.getId('001')" />
				</a></li>
				<li class="breadcrumb-item active"><s:property value="lgView.getId('019')" /></li>
			</ol>
			<!-- Icon Cards-->
			<div class="row">
				<div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-primary o-hidden h-100">
						<div class="card-body">
							<div class="card-body-icon">
								<i class="fas fa-shopping-cart "></i>
							</div>
							<div class="mr-5">
								<s:property value="lgView.getId('020')" />
								!
							</div>
						</div>
						<a class="card-footer text-white clearfix small z-1 btn" data-toggle="modal" data-target="#maintainModal"> <span
							class="float-left"> <s:property value="lgView.getId('021')" />
						</span>
						</a>
					</div>
				</div>
				<div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-success o-hidden h-100">
						<div class="card-body">
							<div class="card-body-icon">
								<i class="fas fa-truck"></i>
							</div>
							<div class="mr-5">
								<s:property value="lgView.getId('014')" />
								!
							</div>
						</div>
						<a class="card-footer text-white clearfix small z-1 btn" data-toggle="modal" data-target="#sellModal"> <span
							class="float-left"> <s:property value="lgView.getId('021')" />
						</span>
						</a>
					</div>
				</div>
				<div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-info o-hidden h-100">
						<div class="card-body">
							<div class="card-body-icon">
								<i class="fas fa-clipboard-list"></i>
							</div>
							<div class="mr-5">
								<s:property value="lgView.getId('040')" />
								!
							</div>
						</div>
						<a class="card-footer text-white clearfix small z-1 btn" data-toggle="modal" data-target="#dayModal"> <span
							class="float-left"> <s:property value="lgView.getId('021')" />
						</span>
						</a>
					</div>
				</div>
			</div>

			<!-- Example DataTables Card-->
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-hand-holding-usd fa-lg"></i>
					<s:property value="lgView.getId('019')+lgView.getId('022')" />
				</div>
				<s:iterator value="#attr.gdInfoKey" var="key" status="status">
					<div class="accordion" id="accordionExample">
						<div class="card">
							<div class="card-header" id="<s:property value="#key+'-'+#status.index" />">
								<h5 class="mb-0">
									<button class="btn btn-link" type="button" data-toggle="collapse"
										data-target="#<s:property value="#key+'-'+#status.index+'collapse'" />" aria-expanded="true"
										aria-controls="<s:property value="#key+'-'+#status.index+'collapse'" />">
										<s:iterator value="#attr.gdInfoMap.get(#key).get('description')" var="desc" status="status">
											<s:property value="#desc.get('SellDate')" />, <s:property value="#desc.get('Status')" />,  <s:property
												value="#desc.get('text')" />
										</s:iterator>
									</button>
								</h5>
							</div>

							<div id="<s:property value="#key+'-'+#status.index+'collapse'" />" class="collapse" aria-labelledby="headingOne"
								data-parent="#accordionExample">
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-bordered" width="100%" cellspacing="0">
											<thead>
												<tr>
													<th><s:property value="lgView.getId('004')" /></th>
													<th><s:property value="lgView.getId('005')" /></th>
													<th><s:property value="lgView.getId('006')" /></th>
													<th><s:property value="lgView.getId('023')" /></th>
													<!-- <th><s:property value="lgView.getId('037')" /></th> -->
													<th><s:property value="lgView.getId('024')" /></th>
													<th><s:property value="lgView.getId('042')" /></th>
													<th><s:property value="lgView.getId('010')" /></th>
													<!-- <th><s:property value="lgView.getId('017')" /></th> -->
													<th><s:property value="lgView.getId('018')" /></th>
												</tr>
											</thead>
											<tbody>
												<s:iterator value="#attr.gdInfoMap.get(#key).get('detail')" var="f" status="status">
													<tr>
														<td>
															<div class="btn-toolbar mb-3" id=<s:property value='#f.get("Item")' />>
																<div class="btn-group mr-2">
																	<button type="button" class="btn btn-danger delGoodsDetail">
																		<i class="fas fa-user-minus"></i>
																	</button>
																</div>
															</div>
														</td>
														<td><s:property value='#f.get("GoodsId")' /></td>
														<td><s:property value='#f.get("GoodsName")' /></td>
														<td><s:property value='#f.get("StatusText")' /></td>
														<!-- <td><s:property value='#f.get("SellDate")' /></td> -->
														<td><s:property value='#f.get("Amount")' /></td>
														<td><s:property value='#f.get("Price")' /></td>
														<td><s:property value='#f.get("Remark")' /></td>
														<!-- <td><s:property value='#f.get("CreateWho")' /></td> -->
														<td><s:property value='#f.get("CreateDate")' /></td>
													</tr>
												</s:iterator>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</s:iterator>
				<div class="card-footer small text-muted">
					<s:property value='#attr.MaxUpdate' />
				</div>
			</div>
		</div>
	</div>
	<!-- /.container-fluid-->
	<!-- /.content-wrapper-->
	<!-- PurchasePage -->
	<div class="modal fade" id="maintainModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<div class="btn-toolbar  btn-block" role="toolbar" aria-label="Toolbar with button groups">
						<button type="button" class="btn btn-outline-primary btn-block" id="GoodsType" Use-type="New">
							<s:property value="lgView.getId('033')" />
						</button>
					</div>
				</div>
				<div class=" collapse show " id="collapseNewGoods">
					<form id="FormNewGoods">
						<div class="modal-body ">
							<div class="form-group row">
								<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('037')" />
								</label>
								<div class="col-sm-9">
									<input class="form-control" type="text" required placeholder=""
										value=<%=com.util.DatesUtil.DateFormat.format(new java.util.Date())%>>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('002')" />
								</label>
								<div class="col-sm-9">
									<select class="form-control selectpicker show-tick" data-live-search="true" data-size="5">
										<s:iterator value="#attr.factorys" var="f" status="status">
											<option value="<s:property value='#f.get("Value")' />"><s:property value='#f.get("Text")' /></option>
										</s:iterator>
									</select>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('005')" />
								</label>
								<div class="col-sm-9">
									<input class="form-control" type="text"
										placeholder="<s:property value="lgView.getId('032') + lgView.getId('035') + lgView.getId('005')" />" required>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('006')" />
								</label>
								<div class="col-sm-9">
									<input class="form-control" type="text"
										placeholder="<s:property value="lgView.getId('032') + lgView.getId('035') + lgView.getId('006')" />" required>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('024')" />
								</label>
								<div class="col-sm-9">
									<input class="form-control" type="text"
										placeholder="<s:property value="lgView.getId('032') + lgView.getId('035') + lgView.getId('024')" />" required>
								</div>
							</div>
							<div class="form-group">
								<div class="form-row">
									<div class="col-md-6">
										<label class="col-form-label"> <s:property value="lgView.getId('015')" />
										</label>
										<div>
											<input class="form-control" type="text"
												placeholder="<s:property value="lgView.getId('032') + lgView.getId('038')" />" required>
										</div>
									</div>
									<div class="col-md-6">
										<label class="col-form-label"> <s:property value="lgView.getId('016')" />
										</label>
										<div>
											<input class="form-control" type="text"
												placeholder="<s:property value="lgView.getId('032') + lgView.getId('039')" />" required>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label> <s:property value="lgView.getId('010')" />
								</label>
								<textarea class="form-control" placeholder=""></textarea>
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
				<div class=" collapse" id="collapseOldGoods">
					<form id="FormOldGoods">
						<div class="modal-body">
							<div class="form-group row">
								<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('037')" />
								</label>
								<div class="col-sm-9">
									<input class="form-control" type="text" required placeholder=""
										value=<%=com.util.DatesUtil.DateFormat.format(new java.util.Date())%>>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('035')" />
								</label>
								<div class="col-sm-9">
									<select class="form-control selectpicker show-tick" data-live-search="true" data-size="5" required>
										<s:iterator value="#attr.RGs" var="f" status="status">
											<option value="<s:property value='#f.get("Value")' />"><s:property value='#f.get("Text")' /></option>
										</s:iterator>
									</select>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('024')" />
								</label>
								<div class="col-sm-9">
									<input class="form-control" type="text"
										placeholder="<s:property value="lgView.getId('032') + lgView.getId('035') + lgView.getId('024')" />" required>
								</div>
							</div>
							<div class="form-group">
								<div class="form-row">
									<div class="col-md-6">
										<label class="col-form-label"> <s:property value="lgView.getId('015')" />
										</label>
										<div>
											<input class="form-control" type="text"
												placeholder="<s:property value="lgView.getId('032') + lgView.getId('038')" />" required>
										</div>
									</div>
									<div class="col-md-6">
										<label class="col-form-label"> <s:property value="lgView.getId('016')" />
										</label>
										<div>
											<input class="form-control" type="text"
												placeholder="<s:property value="lgView.getId('032') + lgView.getId('039')" />" required>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label> <s:property value="lgView.getId('010')" />
								</label>
								<textarea class="form-control" type="text" placeholder=""></textarea>
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
	</div>

	<!-- 	SellPage -->
	<div class="modal fade" id="sellModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel">
						<s:property value="lgView.getId('014')" />
					</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form id="sellGoodsForm">
					<div class="modal-body">
						<div class="form-group row">
							<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('037')" />
							</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" placeholder="" required
									value=<%=com.util.DatesUtil.DateFormat.format(new java.util.Date())%>>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('035')" />
							</label>
							<div class="col-sm-9">
								<select class="form-control selectpicker show-tick" data-live-search="true" data-size="5" required>
									<s:iterator value="#attr.hasReserveGoods" var="f" status="status">
										<option value="<s:property value='#f.get("Value")' />"><s:property value='#f.get("Text")' /></option>
									</s:iterator>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label"> <s:property value="lgView.getId('036')" />
							</label>
							<div class="col-sm-9">
								<select class="form-control  selectpicker show-tick" data-live-search="true" data-size="5" required>
									<s:iterator value="#attr.consumers" var="f" status="status">
										<option value="<s:property value='#f.get("Value")' />"><s:property value='#f.get("Text")' /></option>
									</s:iterator>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								<div class="col-md-6">
									<label class="col-form-label"> <s:property value="lgView.getId('024')" />
									</label>
									<div>
										<input class="form-control" type="text"
											placeholder="<s:property value="lgView.getId('032') + lgView.getId('038') " />" required>
									</div>
								</div>
								<div class="col-md-6">
									<label class="col-form-label"> <s:property value="lgView.getId('016')" />
									</label>
									<div>
										<input class="form-control" type="text"
											placeholder="<s:property value="lgView.getId('032') + lgView.getId('039')" />" required>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label> <s:property value="lgView.getId('010')" />
							</label>
							<textarea class="form-control" type="text" placeholder="Remark"></textarea>
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
	<!-- DayListPage -->
	<div class="modal fade" id="dayModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel">
						<s:property value="lgView.getId('040')" />
					</h5>
					<button class="btn btn-outline-primary" type="button" id="daySellAdd">
						<s:property value="lgView.getId('029')" />
					</button>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form id="dayListForm">
					<div class="modal-body">
						<div class="form-group row">
							<div class="col-md-4">
								<label class="col-form-label"> <s:property value="lgView.getId('036')" />
								</label> <select class="form-control  selectpicker show-tick" data-live-search="true" data-size="5" required>
									<s:iterator value="#attr.DayListConsumers" var="f" status="status">
										<option value="<s:property value='#f.get("Value")' />"><s:property value='#f.get("Text")' /></option>
									</s:iterator>
								</select>
							</div>
							<div class="col-md-3">
								<label class="col-form-label"> <s:property value="lgView.getId('037')" />
								</label> <input class="form-control" type="text" required placeholder=""
									value=<%=com.util.DatesUtil.DateFormat.format(new java.util.Date())%>>
							</div>
							<div class="col-md-5">
								<div class=" rounded border border-info">
									<div class="col-md-12 row">
										<label class="col-form-label"> <s:property value="lgView.getId('024') + ' :'" />
										</label>
										<p class="col-form-label" name=totalQty>9999999</p>
									</div>
									<div class="col-md-12 row">
										<label class="col-form-label"> <s:property value="lgView.getId('041') + ' :'" />
										</label>
										<p class="col-form-label" name=totalPrice>9999999</p>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group row" style="margin-bottom: 0px;">
							<div class="col-md-1"></div>
							<div class="col-md-5">
								<label class="col-form-label"> <s:property value="lgView.getId('035')" />
								</label>
							</div>
							<div class="col-md-2">
								<label class="col-form-label"> <s:property value="lgView.getId('024')" />
								</label>
							</div>
							<div class="col-md-2">
								<label class="col-form-label"> <s:property value="lgView.getId('016')" />
								</label>
							</div>
							<div class="col-md-2">
								<label class="col-form-label"> <s:property value="lgView.getId('010')" />
								</label>
							</div>
						</div>
						<div class="form-group row" name="goodsList">
							<div class="col-md-1 align-self-end">
								<button class="btn btn-outline-danger" type="button" name="daySellDel">
									<s:property value="lgView.getId('045')" />
								</button>
							</div>
							<div class="col-md-5">
								<select class="form-control selectpicker show-tick" data-live-search="true" data-size="5" required>
									<s:iterator value="#attr.RGs" var="f" status="status">
										<option value="<s:property value='#f.get("Value")' />"><s:property value='#f.get("Text")' /></option>
									</s:iterator>
								</select>
							</div>
							<div class="col-md-2">
								<input class="form-control" type="text" name="qty"
									placeholder="<s:property value="lgView.getId('032') + lgView.getId('024')" />" required>
							</div>
							<div class="col-md-2">
								<input class="form-control" type="text" name="price" placeholder="<s:property value="lgView.getId('039')" />"
									required>
							</div>
							<div class="col-md-2">
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
</body>

<script type="text/javascript">
	$(document).ready(function() {
		// One day Sell
		$('form#dayListForm').on('submit', function(e) {
			e.preventDefault();
			data = {};
			$btn = $(this).find('button');
			$btn.prop('disabled', true);
			dataTil = [ "DayConsumerId", "DayIDate", "DayList" ];
			$(this).find('.form-group.row:eq(0) input.form-control[placeholder],.form-group.row:eq(0) select.form-control').each(function(n, v) {
				data[dataTil[n]] = $(v).val();
			});
			data[dataTil[2]] = [];
			dataListTil = [ "GoodsId", "GoodsAmount", "GoodsPrice", "GoodsRemark" ];
			$(this).find('.form-group.row[name=goodsList]').each(function(n, v) {
				
					d = {};
					$(this).find('input.form-control[placeholder], select.form-control, textarea.form-control').each(function(En, Ev) {
						d[dataListTil[En]] = $(Ev).val();
					})
					data[dataTil[2]][n] = d;
				
			});
			data = {
				"DayList" : data
			};
			console.log(data);
			$.ajax({
				type : "post",
				url : "transactionGoods",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(data),
				dataType : "json",
				cache : false,
				beforeSend : function() {
				},
				success : function(response) {
					if (!response.status) {
						showError(response.message);
					} else {
						window.location.reload();
					}
				},
				complete : function() {
					$btn.prop('disabled', false);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					showError('?????')
				}
			});
		});
		$('#daySellAdd').on('click', function(e) {
			var $sellForm = $(this).parents('.modal-content').find('#dayListForm .modal-body');
			var newSellItem = $('<div></div>', {name:'goodsList'}).addClass('form-group row');

			newSellItem.append($('<div />', {
				class : 'col-md-1 align-self-end'
			}).append($('<button />', {
				class : 'btn btn-outline-danger',
				'type' : 'button',
				'name' : 'daySellDel'
			}).text('${sessionScope.lgView.getId("045")}')));

			var selectGoods = $('<select />', {
				'class' : 'form-control selectpicker show-tick',
				'data-live-search' : true,
				'data-size' : 5,
				'required' : true
			})
			var itr = '${RGsStr}';
			itr = JSON.parse(itr);
			$(itr).each(function(n, v) {
				selectGoods.append($('<option />', {
					value : v.Value,
					text : v.Text
				}));
			});
			newSellItem.append($('<div />', {
				class : 'col-md-5'
			}).append(selectGoods));
			newSellItem.append($('<div />', {
				class : 'col-md-2'
			}).append($('<input />', {
				class : 'form-control',
				type : 'text',
				name : 'qty', 
				placeholder : '${sessionScope.lgView.getId("032")}${sessionScope.lgView.getId("024")}',
				required : true
			})));

			newSellItem.append($('<div />', {
				class : 'col-md-2'
			}).append($('<input />', {
				class : 'form-control',
				type : 'text',
				name : 'price', 
				placeholder : '${sessionScope.lgView.getId("039")}',
				required : true
			})));

			newSellItem.append($('<div />', {
				class : 'col-md-2'
			}).append($('<textarea />', {
				class : 'form-control',
				type : 'text',
				placeholder : '${sessionScope.lgView.getId("010")}',
				rows : '1'
			})));

			$sellForm.append(newSellItem);
			$setAutoTotal();
		});
		$setAutoTotal = function() {
			if ($('form#dayListForm .form-group.row button[name=daySellDel]').length == 1) {
				$('form#dayListForm .form-group.row button[name=daySellDel]').attr('disabled', true);
			} else {
				$('form#dayListForm .form-group.row button[name=daySellDel]').unbind('click').on('click', function(e) {
					$(this).parents('div.form-group.row').remove();
					$setAutoTotal();
				}).removeAttr('disabled');
			}
			
			$('form#dayListForm .form-group.row input[name=qty], form#dayListForm .form-group.row input[name=price]').unbind('keyup').on('keyup', function(e){
				var tmp = 0;
				$('form#dayListForm .form-group.row input[name=qty]').each(function(n, v){
					tmp = tmp + (isNaN(parseInt($(v).val())) ? 0 : parseInt($(v).val()));
				})
				$('form#dayListForm p[name=totalQty]').text(tmp);
				tmp = 0;
				$('form#dayListForm .form-group.row input[name=price]').each(function(n, v){
					var $qty = $(v).parents('div.form-group.row').find('input[name=qty]');
					$qty = (isNaN(parseFloat($qty.val())) ? 0 : parseFloat($qty.val()));
					tmp = tmp + (isNaN(parseFloat($(v).val())) ? 0 : ($qty * parseFloat($(v).val())));
				})
				$('form#dayListForm p[name=totalPrice]').text(tmp);
			})
			
// 			$('form#dayListForm .form-group.row input[name=price]').unbind('keyup').on('keyup', function(e){
// 				var tmp = 0;
// 				$('form#dayListForm .form-group.row input[name=price]').each(function(n, v){
// 					var $qty = $(v).parents('div.form-group.row').find('input[name=qty]');
// 					$qty = (isNaN(parseFloat($qty.val())) ? 0 : parseFloat($qty.val()));
// 					tmp = tmp + (isNaN(parseFloat($(v).val())) ? 0 : ($qty * parseFloat($(v).val())));
// 				})
// 				$('form#dayListForm p[name=totalPrice]').text(tmp);
// 			})

			$('.selectpicker').selectpicker();
		};
		$setAutoTotal();

		//P
		$('#collapseNewGoods').on('hidden.bs.collapse', function(e) {
			$('#collapseOldGoods').collapse('show');
		});
		$('#collapseOldGoods').on('hidden.bs.collapse', function(e) {
			$('#collapseNewGoods').collapse('show');
		});
		$('.modal-content .collapse').on('shown.bs.collapse', function(e) {
			$('#GoodsType').prop('disabled', false);
		});
		$('#GoodsType').on('click', function(e) {
			e.preventDefault();
			var $thisBtn = $(this);
			$thisBtn.prop('disabled', true);
			if ($thisBtn.attr('Use-type') == 'New') {
				$thisBtn.attr('Use-type', 'Old');
				$thisBtn.html("${sessionScope.lgView.getId('034')}");
				$thisBtn.removeClass('btn-outline-primary');
				$thisBtn.addClass('btn-outline-success');
				$('#collapseNewGoods').collapse('hide');
			} else {
				$thisBtn.attr('Use-type', 'New');
				$thisBtn.html("${sessionScope.lgView.getId('033')}");
				$thisBtn.removeClass('btn-outline-success');
				$thisBtn.addClass('btn-outline-primary');
				$('#collapseOldGoods').collapse('hide');
			}
		});

		$('form#FormNewGoods').on('submit', function(e) {
			e.preventDefault();
			data = {};
			$btn = $(this).find('button');
			$btn.prop('disabled', true);
			dataTil = [ "IDate", "FactoryId", "GoodsId", "GoodsName", "GoodsAmount", "GoodsCost", "GoodsPrice", "GoodsRemark" ];
			$(this).find('input.form-control[placeholder], select.form-control, textarea.form-control').each(function(n, v) {
				data[dataTil[n]] = $(v).val();
			})
			data = {
				"NewGoods" : data
			};
			$.ajax({
				type : "post",
				url : "transactionGoods",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(data),
				dataType : "json",
				cache : false,
				beforeSend : function() {
				},
				success : function(response) {
					if (!response.status) {
						showError(response.message);
					} else {
						window.location.reload();
					}
				},
				complete : function() {
					$btn.prop('disabled', false);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					showError('?????')
				}
			});
		});

		$('form#FormOldGoods').on('submit', function(e) {
			e.preventDefault();
			data = {};
			$btn = $(this).find('button');
			$btn.prop('disabled', true);
			dataTil = [ "IDate", "GoodsId", "GoodsAmount", "GoodsCost", "GoodsPrice", "GoodsRemark" ];
			$(this).find('input.form-control[placeholder], select.form-control, textarea.form-control').each(function(n, v) {
				data[dataTil[n]] = $(v).val();
			})
			data = {
				"OldGoods" : data
			};
			$.ajax({
				type : "post",
				url : "transactionGoods",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(data),
				dataType : "json",
				cache : false,
				beforeSend : function() {
				},
				success : function(response) {
					if (!response.status) {
						showError(response.message);
					} else {
						window.location.reload();
					}
				},
				complete : function() {
					$btn.prop('disabled', false);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					showError('?????')
				}
			});
		});

		$('form#sellGoodsForm').on('submit', function(e) {
			e.preventDefault();
			data = {};
			$btn = $(this).find('button');
			$btn.prop('disabled', true);
			dataTil = [ "IDate", "GoodsId", "ConsumerId", "GoodsAmount", "GoodsPrice", "GoodsRemark" ];
			$(this).find('input.form-control[placeholder], select.form-control, textarea.form-control').each(function(n, v) {
				data[dataTil[n]] = $(v).val();
			})
			data = {
				"SellGoods" : data
			};
			$.ajax({
				type : "post",
				url : "transactionGoods",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(data),
				dataType : "json",
				cache : false,
				beforeSend : function() {
				},
				success : function(response) {
					if (!response.status) {
						showError(response.message);
					} else {
						window.location.reload();
					}
				},
				complete : function() {
					$btn.prop('disabled', false);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					showError('?????')
				}
			});
		});

		$(".delGoodsDetail").on('click', function(e) {
			e.preventDefault();
			data = {};
			$btn = $(this).find('button');
			$btn.prop('disabled', true);
			data['GoodsDetailId'] = $(this).parents('div.btn-toolbar').attr('id');
			data = {
				"DelGoodsDetail" : data
			};
			$.ajax({
				type : "post",
				url : "transactionGoods",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(data),
				dataType : "json",
				cache : false,
				beforeSend : function() {
				},
				success : function(response) {
					if (!response.status) {
						showError(response.message);
					} else {
						window.location.reload();
					}
				},
				complete : function() {
					$btn.prop('disabled', false);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					showError('?????')
				}
			});
		});
	})
</script>
</html>
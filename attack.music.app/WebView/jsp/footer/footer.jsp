<%@ page contentType="text/html; charset=UTF-8"%>


<footer class="sticky-footer">
	<div class="container">
		<div class="text-center">
			<small>Ziv.Huang V1.0</small>
		</div>
	</div>
</footer>
<a class="scroll-to-top rounded" href="#page-top">
	<i class="fa fa-angle-up"></i>
</a>


 <!-- Bootstrap core JavaScript-->
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Page level plugin JavaScript-->
<script src="vendor/chart.js/Chart.min.js"></script>
<script src="vendor/datatables/jquery.dataTables.js"></script>
<script src="vendor/datatables/dataTables.bootstrap4.js"></script>
<!-- Custom scripts for all pages-->
<script src="js/sb-admin.min.js"></script>
<!-- Custom scripts for this page-->
<script src="js/sb-admin-datatables.min.js"></script>


<!-- Bootstrap Select -->
<script src="bootstrap-select/js/bootstrap-select.min.js"></script>
<script src="bootstrap-select/js/i18n/defaults-zh_TW.min.js"></script>


<script type="text/javascript" src="Bootstrap-Timepicker/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="Bootstrap-Timepicker/js/locales/bootstrap-datetimepicker.zh-TW.js" charset="UTF-8"></script>
<script type="text/javascript">
jQuery(document).ready(function($){
	
	$('.form_date').datetimepicker({
	    language:  'zh-TW',
	    weekStart: 1,
	    todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
		
	});
});
	
</script>
<script src="toastr/toastr.js"></script>

<script type="text/javascript">
	function showmes(){
		if($("#SessionMes").attr("Smes")!=""){
			showSuccess($("#SessionMes").attr("Smes"));
		}else if($("#SessionMes").attr("Fmes")!=""){
			showError($("#SessionMes").attr("Fmes"));
		}
	}
	function showSuccess(msg) {
		toastr.clear();
		toastr.options = {
			"closeButton" : true,
			"debug" : false,
			"positionClass" : "toast-top-center",
			"onclick" : null,
			"showDuration" : "300",
			"hideDuration" : "1000",
			"timeOut" : "10000",
			"extendedTimeOut" : "1000",
			"showEasing" : "swing",
			"hideEasing" : "linear",
			"showMethod" : "fadeIn",
			"hideMethod" : "fadeOut"
		}
		var notify = toastr.success(msg);
		centerMsg(notify);
	}

	function showError(msg) {
		toastr.clear();
		toastr.options = {
			"closeButton" : true,
			"debug" : false,
			"positionClass" : "toast-top-center",
			"onclick" : null,
			"showDuration" : "300",
			"hideDuration" : "1000",
			"timeOut" : "0",
			"extendedTimeOut" : "0",
			"showEasing" : "swing",
			"hideEasing" : "linear",
			"showMethod" : "fadeIn",
			"hideMethod" : "fadeOut"
		}
		var notify = toastr.error(msg);
		centerMsg(notify);
	}

	function showWarning(msg) {
		toastr.clear();
		toastr.options = {
			"closeButton" : true,
			"debug" : false,
			"positionClass" : "toast-top-center",
			"onclick" : null,
			"showDuration" : "300",
			"hideDuration" : "1000",
			"timeOut" : "0",
			"extendedTimeOut" : "0",
			"showEasing" : "swing",
			"hideEasing" : "linear",
			"showMethod" : "fadeIn",
			"hideMethod" : "fadeOut"
		}
		var notify = toastr.warning(msg);
		centerMsg(notify);
	}

	function showSuccessChangeOpt(msg, params) {
		toastr.clear();
		var notify = toastr.success(msg, '', params);
		centerMsg(notify);
	}

	function showErrorChangeOpt(msg, params) {
		toastr.clear();
		var notify = toastr.error(msg, '', params);
		centerMsg(notify);
	}

	function centerMsg(notify) {
		var $notifyContainer = jQuery(notify).closest('.toast-top-center');
		if ($notifyContainer) {
			// align center
			var containerWidth = jQuery(notify).width() + 20;
			$notifyContainer.css("margin-left", -containerWidth / 2);
		}
	}
</script>
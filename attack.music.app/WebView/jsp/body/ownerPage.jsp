<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

</head>
<body class="fixed-nav sticky-footer bg-dark" id="page-top">
	<div class="content-wrapper">
	    <div class="container-fluid">
	      <!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="#"><s:property value="lgView.getId('001')" /></a>
				</li>
			</ol>
	      <!-- Area Chart Example-->
			<div class="row">
				<div class="col-lg-12">
		          <!-- Example Bar Chart Card-->
					<div class="card mb-3">
			            <div class="card-header">
			         		<i class="fas fa-chart-line"></i>
			         		<s:property value="lgView.getId('046')" />
			            </div>
			            <div class="card-body">
				        	<div class="row">
				       			<div class="col-sm-9 my-auto">
				               		<canvas id="myBarChart" width="100" height="50"></canvas>
				                </div>
				                <div class="col-sm-3 text-center my-auto">
				               		<div class="h4 mb-0 text-primary"><s:property value="'$'+#attr.AmountCost" /></div>
				                  	<div class="small text-muted"><s:property value="lgView.getId('047') + ' NTD' " /></div>
				                  	<hr>
				                  	<div class="h4 mb-0 text-danger"><s:property value="'$'+#attr.DataMap.get('I')" /></div>
				                  	<div class="small text-muted"><s:property value="lgView.getId('050') + ' NTD' " /></div>
				                  	<hr>
				                  	<div class="h4 mb-0 text-success"><s:property value="'$'+#attr.DataMap.get('O')" /></div>
				                  	<div class="small text-muted"><s:property value="lgView.getId('048') + ' NTD' " /></div>
				                </div>
				        	</div>
			            </div>
		            	<div class="card-footer small text-muted"></div>
		          	</div>
		        </div>
			</div>
			<div class="row">
				<div class="col-lg-6">
					<div class="card">
					  <div class="card-header">
					   	 <i class="fas fa-grin-stars fa-5x fa-spin" ></i>更新資訊 V20190324
					  </div>
					  <div class="card-body">
					    <blockquote class="blockquote mb-0">
					      <p>..........</p>
					      <footer class="blockquote-footer">黃子育 <cite title="Source Title">2019-03-24</cite></footer>
					    </blockquote>
					  </div>
					</div>
				</div>
			</div>
			<br/>
		</div>
    <!-- /.container-fluid-->
	</div>
</body>
</html>

<script type="text/javascript">
$(document).ready(function(){
	
	// Chart.js scripts
	// -- Set new default font family and font color to mimic Bootstrap's default styling
	//Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	//Chart.defaults.global.defaultFontColor = '#292b2c';
	// -- Area Chart Example
	var ctx = document.getElementById("myBarChart");
	var title=  ${DataMap.get('chartData').get('title')};
	var value = ${DataMap.get('chartData').get('value')};
	var max = ${DataMap.get('chartData').get('max')};
	var myLineChart = new Chart(ctx, {
	  type: 'bar',
	  data: {
	    labels: title,
	    datasets: [{
	      label: "${sessionScope.lgView.getId('049')}",
	      backgroundColor: "rgba(2,117,216,1)",
	      borderColor: "rgba(2,117,216,1)",
	      data: value,
	    }],
	  },
	  options: {
	    scales: {
	      xAxes: [{
	        time: {
	          unit: 'month'
	        },
	        gridLines: {
	          display: false
	        },
	        ticks: {
	          maxTicksLimit: 6
	        }
	      }],
	      yAxes: [{
	        ticks: {
	          min: 0,
	          max: max,
	          maxTicksLimit: 5
	        },
	        gridLines: {
	          display: true
	        }
	      }],
	    },
	    legend: {
	      display: false
	    }
	  }
	});
	
});
</script>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom:10px;margin-top:10px;background-color:grey;padding:15px">
	<div class="panel-footer clearfix">
		<div id="accordion" class="panel-group">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title ">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"> Menu - Navigate </a>
						<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="glyphicon glyphicon-chevron-down pull-right"></a>
					</h4>
				</div>
				<div id="collapseOne" class="panel-collapse collapse in">
					<div class="panel-body">
						<div class="list-group">
							<a style="text-weight:bold;" class="list-group-item" href="studenthome.asp?lstemaill=<%=emailID%>&lregNot=<%=regNom%>&check=admissionstatus" >
								<span class="glyphicon glyphicon-file"></span> Check Admission Status <span class="glyphicon glyphicon-circle-arrow-right pull-right"></span>
							</a>
							<a style="color:black;text-weight:bold;" class="list-group-item" target="_blank" href="upload_details_print.asp?lstemaill=<%=emailID%>&lregNot=<%=regNom%> ">
								<span class="glyphicon glyphicon-print"></span> Print Application Slip <span class="glyphicon glyphicon-circle-arrow-right pull-right"></span>
							</a>
							<a style="color:black;text-weight:bold;" class="list-group-item" href="studentlogout.asp">
								<span class="glyphicon glyphicon-lock"></span> Log Out <span class="glyphicon glyphicon-circle-arrow-right pull-right"></span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="accordion" class="panel-group">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title ">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"> Menu - Payment </a>
						<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="glyphicon glyphicon-chevron-down pull-right"></a>
					</h4>
				</div>
				<div id="collapseTwo" class="panel-collapse collapse out">
					<div class="panel-body">
						<div class="list-group">
							<a style="text-weight:bold;" class="list-group-item" href="paymentstepa.asp?lstemaill=<%=emailID%>&lregNot=<%=regNom%>" >
								<span class="glyphicon glyphicon-edit"></span> Make Payment <span class="glyphicon glyphicon-circle-arrow-right pull-right"></span>
							</a>
							<a style="color:black;text-weight:bold;" class="list-group-item"  href="receipt.asp?lstemaill=<%=emailID%>&lregNot=<%=regNom%> ">
								<span class="glyphicon glyphicon-print"></span> Print Payment Receipt <span class="glyphicon glyphicon-circle-arrow-right pull-right"></span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


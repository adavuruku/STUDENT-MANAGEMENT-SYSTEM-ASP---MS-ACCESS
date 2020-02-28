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
							<a style="text-weight:bold;" class="list-group-item" href="adminhome.asp?ausername=<%=ausername%>&last_login=<%=last_login%>" >
								<span class="glyphicon glyphicon-file"></span> Account Home <span class="glyphicon glyphicon-circle-arrow-right pull-right"></span>
							</a>
							<a style="text-weight:bold;" class="list-group-item" href="admissionlist.asp?ausername=<%=ausername%>&last_login=<%=last_login%>&check=admissionlist" >
								<span class="glyphicon glyphicon-file"></span> View Admitted Student <span class="glyphicon glyphicon-circle-arrow-right pull-right"></span>
							</a>
							<a style="color:black;text-weight:bold;" class="list-group-item" href="notadmissionlist.asp?ausername=<%=ausername%>&last_login=<%=last_login%>&check=notadmissionlist" >
								<span class="glyphicon glyphicon-print"></span> View Non Admitted Student <span class="glyphicon glyphicon-circle-arrow-right pull-right"></span>
							</a>
							<a style="color:black;text-weight:bold;" class="list-group-item" href="adminlogout.asp">
								<span class="glyphicon glyphicon-lock"></span> Log Out <span class="glyphicon glyphicon-circle-arrow-right pull-right"></span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


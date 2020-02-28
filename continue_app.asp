<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<%
	'set timeout for sessions
	Session.Timeout=30 
	Dim regNom, emailID, queryS, errorS, appID ,appIDA, dataList(5),txtAppid,status
	'rs.Fields.Item("Name")
	if Request.Form("proceed") = "Continue App" then
		'get values
		regNom = Request.Form("txtUsername")
		txtAppid = Request.Form("txtAppid") 
		'check if empty field entered
		if regNom <> "" AND txtAppid <> "" then
			set rs = Server.CreateObject("ADODB.recordset")
			queryS = "Select * from student_record where regNo='" & regNom & "' AND appID='" & txtAppid & "'" 
			rs.Open queryS, conn
			'Response.Write(rs.RecordCount)
			if Not rs.EOF then
				rs.MoveFirst
					errorS=""
					status = rs.Fields.Item("reg_status")
					Session("stemail")=rs.Fields.Item("studEmail")
					Session("stregNo")=regNom
					Session("stappid")= txtAppid
					emailID = rs.Fields.Item("studEmail")
					if status ="1" then
						'take to home page
						Response.Redirect ("studenthome.asp?lstemaill=" & emailID & "&lregNot=" & regNom )
					end if
					if status ="0" Or status ="" then
						'take to upload details
						Response.Redirect ("upload_details.asp?lstemaill=" & emailID & "&lregNot=" & regNom & "&edit=yess" )
					end if
			else
				'reg no and email is used by another student
				errorS ="Error: The Registration No Or Application ID is Not Correct.. Verify !!"
			end if
		end if
		'conn.Close
		'Set conn = Nothing
	end if
%>
			<!-- MIDDLE -->
			<div class="row" style="margin-top:5px;">
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" style="background-color: white">
					<!--#include file ="settings/navigate.asp"-->
				</div>
				<div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" style="background-color: white">
					
				</div>
				<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6" style="background-color: grey;padding:10px">
					<div class="col-xs-12 col-sm-6 col-md-12 col-lg-12" style="background-color:white;">
						<form role="form"  name="reg_form"  id="form" class="form-vertical" action="continue_app.asp" method="POST">
							<h4 style="margin-bottom:20px;background-color:#CCFF33;padding:10px">Continue Application </h4>
						<hr/>
							<div class="form-group">
								<label for="txtPasswordC2">Matriculation / Registration N<u>o</u> : </label>
								<div class="input-group">
									<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
									<input type="text" class="form-control" onkeypress="wipeboxeror('4')" id="txtUsername" name="txtUsername" value="<%=regNom%>" required="true" placeholder="Enter Matriculation / Registration No" />
								</div>
							</div>
							<div class="form-group">
								<label for="txtPasswordC2">Application ID : </label>
								<div class="input-group">
									<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span> 
									<input type="password" class="form-control" id="txtAppid" name="txtAppid" required="true" value="<%=txtAppid%>" placeholder="Enter Your Application ID" />
								</div>
								<span class="help-block" id="result4" style="color:brown;text-weight:bold;text-align:center;"><%=errorS%></span>
							</div>
							<div class="form-group">
								<div class="input-group">
									<input type="submit" name="proceed" style="margin-bottom:10px;padding:5px 20px 5px 20px" value="Continue App" class="btn btn-primary btn-md"></input>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- FOOTER -->
			<!--#include file ="settings/footer.asp"-->
		</body>
</html>
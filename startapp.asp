<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<%
	'set timeout for sessions
	Session.Timeout=30
	Dim regNom, emailID, queryS, errorS, appID ,appIDA, dataList(5)
	'rs.Fields.Item("Name")
	if Request.Form("proceed") = "Generate APPID" then
		'get values
		regNom = Request.Form("txtUsername")
		emailID = Request.Form("txtEmail")
		'check if empty field entered
		if regNom <> "" AND emailID <> "" then
			set rs = Server.CreateObject("ADODB.recordset")
			queryS = "Select * from student_record where regNo='" & regNom & "' OR studEmail='" & emailID & "'" 
			rs.Open queryS, conn
			'Response.Write(rs.RecordCount)
			if rs.EOF then
				errorS=""
				'Generate Application 
				dataList(0) = "XL"
				dataList(1) = "TV"
				dataList(2) = "AX"
				dataList(3) = "WZ"
				dataList(4) = "ZW"
				dataList(5) = "VA"
				Randomize
				min = 1000000000
				max = 9999999999
				min_a = 0
				max_a = 5
				appIDA = Int((max_a-min_a +1) *Rnd + min_a)
				appID = "APP" & Int((max-min +1) *Rnd + min) & dataList(appIDA)
				'Put record in new session to insert at next page
				Session("stemail")=emailID
				Session("stregNo")=regNom
				Session("stappid")=appID
				Response.Redirect ("application_print.asp?lstemaill=" & emailID & "&lregNot=" & regNom )
			else
				'reg no and email is used by another student
				errorS ="Error: The Registration No Or Email Has Already Been Used !!"
			end if
		else
			'Empty Record
			errorS ="Error: Invalid Datas Provided !!"
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
						<form role="form"  id="form" class="form-vertical" action="startapp.asp"  method="post">
							<h4 style="margin-bottom:20px;background-color:#CCFF33;padding:10px">Generate Application ID </h4>
						<hr/>
							<div class="form-group">
								<label for="txtPasswordC2">Matriculation / Registration N<u>o</u> : </label>
								<div class="input-group">
									<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
									<input type="text" class="form-control" onkeypress="wipeboxeror('4')" id="txtUsername" name="txtUsername" value="<%=regNom%>" required="true" placeholder="Enter Matriculation / Registration No" />
								</div>
							</div>
							<div class="form-group">
								<label for="txtPasswordC2">Email Address : </label>
								<div class="input-group">
									<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span> 
									<input type="email" onkeypress="wipeboxeror('4')" class="form-control" id="txtEmail" name="txtEmail" required="true" value="<%=emailID%>" placeholder="Enter Email Address" />
								</div>
								<span class="help-block" id="result4" style="color:brown;text-weight:bold;text-align:center;"><%=errorS%></span>
							</div>
							<div class="form-group">
								<div class="input-group">
									<input type="submit" name="proceed" style="margin-bottom:10px;padding:5px 20px 5px 20px" value="Generate APPID" class="btn btn-primary btn-md"></input>
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
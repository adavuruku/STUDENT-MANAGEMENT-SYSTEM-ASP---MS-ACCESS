<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<%
	'set timeout for sessions
	Session.Timeout=30 
	Dim txtUsername, queryS, errorS, admin_name,txtPassword,lastlogin
	'rs.Fields.Item("Name")
	if Request.Form("proceed") = "Login" then
		'get values
		txtUsername = Request.Form("txtUsername")
		txtPassword = Request.Form("txtPassword") 
		'check if empty field entered
		if txtUsername <> "" AND txtPassword <> "" then
			set rs = Server.CreateObject("ADODB.recordset")
			queryS = "Select * from adminrecord where ausername='" & txtUsername & "' AND apassword='" & txtPassword & "'" 
			rs.Open queryS, conn
			'Response.Write(rs.RecordCount)
			if Not rs.EOF then
				rs.MoveFirst
					errorS=""
					admin_name = rs.Fields.Item("aname")
					lastlogin = rs.Fields.Item("lastlogin")
					Session("admin_name")= admin_name
					Session("ausername")= txtUsername
					Session("last_login")=lastlogin
					Response.Redirect ("adminhome.asp?ausername=" & txtUsername & "&last_login=" & lastlogin )
			else
				'reg no and email is used by another student
				errorS ="Error: The UserName Or Password is Not Correct.. Verify !!"
			end if
		else
			'Empty Record
			errorS ="Error: Invalid Datas Provided !!"
		end if
		conn.Close
		Set conn = Nothing
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
						<form role="form"  name="reg_form"  id="form" class="form-vertical" action="adminlogin.asp" method="POST">
							<h4 style="margin-bottom:20px;background-color:#CCFF33;padding:10px">Admin Login </h4>
						<hr/>
							<div class="form-group">
								<label for="txtPasswordC2">User Name : </label>
								<div class="input-group">
									<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
									<input type="text" class="form-control" onkeypress="wipeboxeror('4')" id="txtUsername" name="txtUsername" value="<%=txtUsername%>" required="true" placeholder="Enter Your User Name" />
								</div>
							</div>
							<div class="form-group">
								<label for="txtPasswordC2">Password : </label>
								<div class="input-group">
									<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span> 
									<input type="password" class="form-control" id="txtAppid" name="txtPassword" required="true" value="<%=txtPassword%>" placeholder="Enter Your Password" />
								</div>
								<span class="help-block" id="result4" style="color:brown;text-weight:bold;text-align:center;"><%=errorS%></span>
							</div>
							<div class="form-group">
								<div class="input-group">
									<input type="submit" name="proceed" style="margin-bottom:10px;padding:5px 20px 5px 20px" value="Login" class="btn btn-primary btn-md"></input>
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
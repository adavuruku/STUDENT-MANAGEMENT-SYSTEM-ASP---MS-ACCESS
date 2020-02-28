<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<%
	Dim regNom, emailID, queryS, er_msg, appID, txttitle, txtfname, txtoname, txtAPhone, txtgender,txtstate, txtdob, txtlgov,  txtPermadd, txtentrance, txtfaculty, txtdept, filename
'***********************************************************
	if Request.Form("submit") = "Submit Details" OR Request.Form("edit_details") = "Edit Details" then
		regNom = Request.Form("regNoH")
		emailID = Request.Form("emailIDH")
	else
		if Request.QueryString("lregNot") <> "" AND Request.QueryString("lstemaill") <> "" then
			regNom = Request.QueryString("lregNot")
			emailID = Request.QueryString("lstemaill")
		end if
	end if
	
	if Session("stemail") ="" OR Session("stregNo")="" OR Session("stappid")="" then
		Response.Redirect ("studentlogout.asp")
	end if

	if Session("stemail") <> emailID OR Session("stregNo") <> regNom then
		Response.Redirect ("studentlogout.asp")
	end if

	appID = Session("stappid")
'********************************************************************
	'check admission status
	if Request.QueryString("check") <> "" AND Request.QueryString("check") = "admissionstatus" then
		Dim Status_C, msg1,studFaculty,studCourse,progyear
		Status_C = "1"
		set rs = Server.CreateObject("ADODB.recordset")
		queryS = "Select * from student_record where regNo='" & regNom & "' AND appID='" & appID & "' AND admissionStatus='" & Status_C & "'"  
		rs.Open queryS, conn
		'Response.Write(rs.RecordCount) 
		if Not rs.EOF then
			'admission is given
			rs.MoveFirst
				studFaculty=rs.Fields.Item("studFaculty")
				studCourse=rs.Fields.Item("studCourse")
				progyear = "A Five (5) Years"
				if rs.Fields.Item("studMode") ="Direct Entry" then
					progyear = "A Four (4) Years"
				end if
				
				msg1 = "<p> Congratulations ! </p>"
				msg1 = msg1 & "<p> You Have Been Offered " & progyear &" Provisional Admission In The Faculty Of "
				msg1 = msg1 & studFaculty & " To Study " & studCourse & " . </p>"
				er_msg="<div class='alert alert-success alert-dismissable'>"
				er_msg= er_msg & "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'> &times;"
				er_msg= er_msg & "</button>" & msg1 & " </div>"
		else
			'admission not given
			msg1 = "<p> Sorry ! </p>"
			msg1 = msg1 & "<p> You Have Not Been Offered Admission Yet.. ! </p>"
			er_msg="<div class='alert alert-danger alert-dismissable'>"
			er_msg= er_msg & "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'> &times;"
			er_msg= er_msg & "</button>" & msg1 & " </div>"
		end if
		
		
	end if
'********************************************************************
	'retrieve details
	set rs = Server.CreateObject("ADODB.recordset")
	queryS = "Select * from student_record where regNo='" & regNom & "' AND appID='" & appID & "'" 
	rs.Open queryS, conn
	'Response.Write(rs.RecordCount) 
	if Not rs.EOF then
		rs.MoveFirst 
			txttitle=rs.Fields.Item("studTitle") & " " & rs.Fields.Item("studFName") & " " & rs.Fields.Item("studLname")
			txtAPhone=rs.Fields.Item("studPhone") & " / " & rs.Fields.Item("studEmail")
			txtstate=rs.Fields.Item("studState") & " / " & rs.Fields.Item("studLg")
			txtentrance=rs.Fields.Item("studMode")
			txtfaculty=rs.Fields.Item("studFaculty")
			txtdept=rs.Fields.Item("studCourse")
			filename = "Uploads/" & appID & "." & rs.Fields.Item("fileext")
			'txtgender=rs.Fields.Item("studGender")
			'txtdob=rs.Fields.Item("studDob")
			'txtPermadd=rs.Fields.Item("studAdd")
			 
	Else
		Response.Redirect ("studentlogout.asp")
	End If
%>
			<!-- MIDDLE -->
			<div class="row" style="margin-top:5px;">
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" style="background-color: white">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="background-color: white">
						<img src="<%=filename%>" width="170" height="170" class="img-thumbnail" alt="Thumbnail Image">
					</div>
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="background-color: white">
						<!--#include file ="settings/navigate_student.asp"-->
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-8 col-lg-8" style="background-color: grey;padding:10px;margin-bottom:10px">
					<%=er_msg%>
					<div class="col-xs-12 col-sm-6 col-md-12 col-lg-12" style="background-color:white;">
						<table class="table table-hover">
								<thead>
									<tr>
										<th colspan="3" style="text-align:center"><h4>WELSH UNIVERSITY AJAOKUTA - ACCOUNT DETAILS | - <a class="hidden-print" href="index.asp">Sign Out</a> -</h4></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td align="right"><h4>Student Name : </h4></td>
										<td></td>
										<td><h4><%=txttitle%></h4></td>
									</tr>
									<tr>
										<td width="350px" align="right"><h4>Registration N<u>o</u> :</h4></td>
										<td></td>
										<td><h4><%=regNom%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Application ID :</h4></td>
										<td></td>
										<td><h4><b><%=appID%></b></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Phone No / Email Address : </h4></td>
										<td></td>
										<td><h4><%=txtAPhone%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>State / Local Govt : </h4></td>
										<td></td>
										<td><h4><%=txtstate%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Mode Of Application : </h4></td>
										<td></td>
										<td><h4><%=txtentrance%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4> Faculty : </h4></td>
										<td></td>
										<td><h4><%=txtfaculty  %></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Choice Department : </h4></td>
										<td></td>
										<td><h4><%=txtdept%></h4></td>
									</tr>
								</tbody>
							</table>
					</div>	
				</div>
			</div>
			<!-- FOOTER -->
			<!--#include file ="settings/footer.asp"-->
		</body>
</html>
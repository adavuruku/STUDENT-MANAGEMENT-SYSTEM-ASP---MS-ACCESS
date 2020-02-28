<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<%
	Dim regNom, emailID, queryS, errorS, appID, txttitle, txtfname, txtoname, txtAPhone, txtgender,txtstate, txtdob, txtlgov,  txtPermadd, txtentrance, txtfaculty, txtdept, filename
'***********************************************************
	
	if Request.QueryString("lregNot") <> "" AND Request.QueryString("lstemaill") <> "" then
		regNom = Request.QueryString("lregNot")
		emailID = Request.QueryString("lstemaill")
	end if
	
	if Session("stemail") ="" OR Session("stregNo")="" OR Session("stappid")="" then
		Response.Redirect ("studentlogout.asp")
	end if
	
	if Session("stemail") <> emailID OR Session("stregNo") <> regNom then
		Response.Redirect ("studentlogout.asp")
	end if

	appID = Session("stappid")
'********************************************************************

	'retrieve details
	set rs = Server.CreateObject("ADODB.recordset")
	queryS = "Select * from student_record where regNo='" & regNom & "' AND appID='" & appID & "'" 
	rs.Open queryS, conn
	'Response.Write(rs.RecordCount) 
	if Not rs.EOF then
		rs.MoveFirst
			txttitle=rs.Fields.Item("studTitle") & " " & rs.Fields.Item("studFName") & " " & rs.Fields.Item("studLname")
			txtAPhone=rs.Fields.Item("studPhone")
			txtgender=rs.Fields.Item("studGender")
			txtstate=rs.Fields.Item("studState")
			txtdob=rs.Fields.Item("studDob")
			txtlgov=rs.Fields.Item("studLg")
			txtPermadd=rs.Fields.Item("studAdd")
			txtentrance=rs.Fields.Item("studMode")
			txtfaculty=rs.Fields.Item("studFaculty")
			txtdept=rs.Fields.Item("studCourse")
			filename = "Uploads/" & appID & "." & rs.Fields.Item("fileext")
	Else
		Response.Redirect ("studentlogout.asp")
	End If
%>
			<!-- MIDDLE -->
			<div class="row" style="margin-top:5px;">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="background-color: grey;padding:10px;margin-bottom:5px;">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="background-color:white;">
						<form role="form"  name="reg_form"  id="form" class="form-vertical" action="upload_details_preview.asp" method="POST">
							<input type="hidden" name="regNoH" value="<%=regNom%>" />
							<input type="hidden" name="emailIDH" value="<%=emailID %>" />
							<table class="table table-hover">
								<thead>
									<tr>
										<th colspan="3" style="text-align:center"><h4>WELSH UNIVERSITY AJAOKUTA - APPLICATION SLIP | - <a class="hidden-print" href="studentlogout.asp">Sign Out</a> -</h4></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan="2" >
										</td>
										<td >
											<img src="<%=filename%>" width="150" height="150" class="img-thumbnail" alt="Thumbnail Image">
										</td>
									</tr>
									<tr>
										<td width="350px" align="right"><h4>Registration N<u>o</u> :</h4></td>
										<td></td>
										<td><h4><%=regNom%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Email Address : </h4></td>
										<td></td>
										<td><h4><%= emailID%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Application ID :</h4></td>
										<td></td>
										<td><h4><b><%=appID%></b></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Student Name : </h4></td>
										<td></td>
										<td><h4><%=txttitle%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Phone No : </h4></td>
										<td></td>
										<td><h4><%=txtAPhone%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Gender : </h4></td>
										<td></td>
										<td><h4><%=txtgender%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Date Of Birth : </h4></td>
										<td></td>
										<td><h4><%=txtdob%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>State Of Origin : </h4></td>
										<td></td>
										<td><h4><%=txtstate%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Local Government : </h4></td>
										<td></td>
										<td><h4><%=txtlgov%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Contact Address : </h4></td>
										<td></td>
										<td><h4><%=txtPermadd%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Mode Of Application : </h4></td>
										<td></td>
										<td><h4><%=txtentrance%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Choice Faculty : </h4></td>
										<td></td>
										<td><h4><%=txtfaculty%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Choice Department : </h4></td>
										<td></td>
										<td><h4><%=txtdept%></h4></td>
									</tr>
									
									<tr>
										<td colspan="2"></td>
										<td>
											<p><span onClick="window.print();" class="btn btn-primary hidden-print">Print Slip</span><p>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
			<!-- FOOTER -->
			<!--#include file ="settings/footer.asp"-->
		</body>
</html>
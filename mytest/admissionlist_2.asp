<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<%
	Dim regNom, emailID, queryS, er_msg, last_login,  ausername, admin_name
'***********************************************************
	
	if Request.QueryString("ausername") <> "" AND Request.QueryString("last_login") <> "" then
		ausername = Request.QueryString("ausername")
		last_login = Request.QueryString("last_login")
	end if
	
	if Session("admin_name") ="" OR Session("ausername")="" OR Session("last_login")="" then
		Response.Redirect ("index.asp" )
	end if

	if Session("ausername") <> ausername then
		Response.Redirect ("index.asp" )
	end if
	
	admin_name = Session("admin_name")
'********************************************************************
	'revoke admission
	if Request.QueryString("deleteid") <> "" then
		'Dim Status_C, appID,queryS
		appID = Request.QueryString("deleteid")
		Status_C="0"
		queryS = "UPDATE student_record SET "
		queryS = queryS & "admissionStatus='" & Status_C
		queryS = queryS & "' Where appID='"& appID & "'"
		conn.Execute queryS
		'conn.close
	end if
'********************************************************************
%>
			<!-- MIDDLE -->
			<div class="row" style="margin-top:5px;">
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" style="background-color: white">
					<!--#include file ="settings/navigate_admin.asp"-->
				</div>
				<div class="col-xs-12 col-sm-6 col-md-8 col-lg-8" style="background-color: grey;padding:10px;margin-bottom:10px">
					<h4 style="text-align:center; color:white; font-weight:bold">WELSH UNIVERSITY AJAOKUTA - ADMIN HOME | - <a class="hidden-print" style="color: yellow;" href="adminlogout.asp">Sign Out</a> -</h4>
					<div class="col-xs-12 col-sm-6 col-md-12 col-lg-12" style="background-color:white;">
						<h4 style="text-align:center; font-weight:bold">LIST OF CLEARED ADMITTED STUDENT </h4>
							<table class="table table-hover">
								<thead>
									<tr>
										<th >SNo.</th>
										<th>Name.</th>
										<th>Gender.</th>
										<th>Application / Reg No.</th>
										<th>State / LGov.</th>
										<th>Faculty.</th>
										<th>Department.</th>
										<th></th>
									</tr>
								</thead>
								<tbody>	
								<%
									'check admission status
									if Request.QueryString("check") <> "" AND Request.QueryString("check") = "admissionlist" then
										'Dim Status_C, msg1,studFaculty,studCourse
										Status_C = "1"
										set rs = Server.CreateObject("ADODB.recordset")
										queryS = "Select * from student_record where admissionStatus='" & Status_C & "' AND reg_status='" & Status_C & "' order by id desc"  
										rs.Open queryS, conn
									
										if Not rs.EOF then
											'dim studName ,studState,studReg, Item
											Item = 1
											'admission is given
											do Until rs.EOF
												studState =rs.Fields.Item("studState") & " / " & rs.Fields.Item("studLg")
												studReg =rs.Fields.Item("appID") & " / " & rs.Fields.Item("regNo")
												studName = rs.Fields.Item("studTitle") & " " & rs.Fields.Item("studFName") & " "  & rs.Fields.Item("studLname")
												Response.write("<tr>")
													Response.write("<td>" & Item & "</td>")
													Response.write("<td>" & studName & "</td>")
													Response.write("<td>" & rs.Fields.Item("studGender") & "</td>")
													Response.write("<td>" & studReg & "</td>")
													Response.write("<td>" & studState & "</td>")
													Response.write("<td>" & rs.Fields.Item("studFaculty") & "</td>")
													Response.write("<td>" & rs.Fields.Item("studCourse") & "</td>")
													Response.write("<td><a href='admissionlist.asp?ausername=" & ausername & "&last_login=" & last_login & "&deleteid=" & rs.Fields.Item("appID") & "&check=admissionlist'><span  class='btn btn-primary hidden-print'>Revoke</span></a></td>")
												Response.write("<tr>")
												Item = Item + 1
												rs.MoveNext
											Loop
										else
											'admission not given
											msg1 = "<h4> No Admission Yet ! </h4>"
											msg1 = msg1 & "<p> No Applicant Has been Offered Admission Yet.. ! </p>"
											er_msg="<div class='alert alert-info alert-dismissable'>"
											er_msg= er_msg & "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'> &times;"
											er_msg= er_msg & "</button>" & msg1 & " </div>"
											Response.write(er_msg)
										end if
									end if	
								%>
								</tbody>
							</table>
					</div>	
				</div>
			</div>
			<!-- FOOTER -->
			<!--#include file ="settings/footer.asp"-->
		</body>
</html>
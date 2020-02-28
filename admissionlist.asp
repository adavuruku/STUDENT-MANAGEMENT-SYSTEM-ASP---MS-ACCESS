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
		Response.Redirect ("adminlogout.asp")
	end if

	if Session("ausername") <> ausername then
		Response.Redirect ("adminlogout.asp")
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
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="background-color:white;">
						<h4 style="text-align:center; font-weight:bold">LIST OF CLEARED ADMITTED STUDENT </h4>
						<%
							'*********************************************build modals
							Dim Status_C, msg1,studFaculty,studCourse
							dim studName ,studState,studReg, Item,id_link
							'check admission status
							if Request.QueryString("check") <> "" AND Request.QueryString("check") = "admissionlist" then
								
								Status_C = "1"
								set rs = Server.CreateObject("ADODB.recordset")
								queryS = "Select * from student_record where admissionStatus='" & Status_C & "' AND reg_status='" & Status_C & "' order by id desc"  
								rs.Open queryS, conn
							
								if Not rs.EOF then
									
									Item = 1
									'admission is given
									do Until rs.EOF
										studState =rs.Fields.Item("studState") & " / " & rs.Fields.Item("studLg")
										studReg = rs.Fields.Item("regNo")
										studName = rs.Fields.Item("studTitle") & " " & rs.Fields.Item("studFName") & " "  & rs.Fields.Item("studLname")
										id_link =" id='" & rs.Fields.Item("appID") & "'"
										filename = "Uploads/" & rs.Fields.Item("appID") & "." & rs.Fields.Item("fileext")
										
										Response.write("<div style='width:50%; margin:auto;' "& id_link & " class='modal fade'>")
											Response.write("<div style='width:100%;' class='modal-dialog'>")
												Response.write("<div style='width:100%;' class='modal-content'>")
													Response.write("<div class='modal-header label-primary'>")
														Response.write("<button type='button' class='close' data-dismiss='modal aria-hidden='true'>&times;</button>")
														Response.write("<h4 class='modal-title' style='color:yellow;'>Profile Details Of - " & studName &" </h4>")
													Response.write("</div>")
													Response.write("<div style='width:100%;' class='modal-body'>")
													Response.write("<table class='table table-condensed'>")
													Response.write("<tbody>")
														Response.write("<tr>")
															Response.write("<td colspan='3' rowspan='5' ><img src='" & filename & "' width='170' height='170' class='img-thumbnail' alt='Thumbnail Image'></td>")
															Response.write("<td colspan='4' align='center'><a href='admissionlist.asp?ausername=" & ausername & "&last_login=" & last_login & "&deleteid=" & rs.Fields.Item("appID") & "&check=admissionlist'><span  class='btn btn-primary hidden-print'>Revoke Admission</span></a></td>")
														Response.write("</tr>")
														Response.write("<tr>")
															Response.write("<td></td>")
															Response.write("<td>Applicant Name :</td>")
															Response.write("<td></td>")
															Response.write("<td>" & studName & "</td>")
														Response.write("</tr>")
														Response.write("<tr>")
															Response.write("<td></td>")
															Response.write("<td>Registration N<u>o</u> :</td>")
															Response.write("<td></td>")
															Response.write("<td>" & studReg & "</td>")
														Response.write("</tr>")
														Response.write("<tr>")
															Response.write("<td></td>")
															Response.write("<td>Application ID N<u>o</u> :</td>")
															Response.write("<td></td>")
															Response.write("<td>" & rs.Fields.Item("appID") & "</td>")
														Response.write("</tr>")
														Response.write("<tr>")
															Response.write("<td></td>")
															Response.write("<td>Phone N<u>o</u> / Email Add : </td>")
															Response.write("<td></td>")
															Response.write("<td>" & rs.Fields.Item("studPhone") & " / " & rs.Fields.Item("studEmail") & "</td>")
														Response.write("</tr>")
														Response.write("<tr>")
															Response.write("<td>State / Local Govt : </td>")
															Response.write("<td></td>")
															Response.write("<td>" & studState & "</td>")
															Response.write("<td></td>")
															Response.write("<td>Contact Address : </td>")
															Response.write("<td></td>")
															Response.write("<td>" & rs.Fields.Item("studAdd") & "</td>")
														Response.write("</tr>")
														Response.write("<tr>")
															Response.write("<td>Faculty : </td>")
															Response.write("<td></td>")
															Response.write("<td>" & rs.Fields.Item("studFaculty") & "</td>")
															Response.write("<td></td>")
															Response.write("<td>Department : </td>")
															Response.write("<td></td>")
															Response.write("<td>" & rs.Fields.Item("studCourse") & "</td>")
														Response.write("</tr>")
														Response.write("<tr>")
															Response.write("<td>Entrance Mode : </td>")
															Response.write("<td></td>")
															Response.write("<td>" & rs.Fields.Item("studMode") & "</td>")
															Response.write("<td></td>")
															Response.write("<td>Gender / DOB : </td>")
															Response.write("<td></td>")
															Response.write("<td>" & rs.Fields.Item("studGender") & " / " & rs.Fields.Item("studDob") & "</td>")
														Response.write("</tr>")
														Response.write("<tr>")
															Response.write("<td colspan='7' align='center'>Registered on the Date :" & rs.Fields.Item("DateReg") & " </td>")
														Response.write("</tr>")
												Response.write("</tbody>")
											Response.write("</table>")
											Response.write("</div>")	
											Response.write("<div class='modal-footer label-primary'>")
												Response.write("<button type='button' class='btn btn-default' data-dismiss='modal'>Close</button>")
											Response.write("</div>")
											Response.write("</div>")
											Response.write("</div>")
											Response.write("</div>")
										rs.MoveNext
									Loop
								End if
							End if
			'******************************modal ends
			
									'check admission status
									if Request.QueryString("check") <> "" AND Request.QueryString("check") = "admissionlist" then
										'Dim Status_C, msg1,studFaculty,studCourse
										Status_C = "1"
										set rs = Server.CreateObject("ADODB.recordset")
										queryS = "Select * from student_record where admissionStatus='" & Status_C & "' AND reg_status='" & Status_C & "' order by id desc"  
										rs.Open queryS, conn
									
										if Not rs.EOF then
											Response.write("<table class='table table-hover'>")
												Response.write("<thead>")
													Response.write("<tr>")
														Response.write("<th >SNo.</th>")
														Response.write("<th>Name.</th>")
														Response.write("<th>Application / Reg No.</th>")
														Response.write("<th>Faculty.</th>")
														Response.write("<th>Department.</th>")
														Response.write("<th></th>")
													Response.write("</tr>")
												Response.write("</thead>")
												Response.write("<tbody>")
											dim path_two
											Item = 1
											'admission is given
											do Until rs.EOF
												studState =rs.Fields.Item("studState") & " / " & rs.Fields.Item("studLg")
												studReg =rs.Fields.Item("appID") & " / " & rs.Fields.Item("regNo")
												studName = rs.Fields.Item("studTitle") & " " & rs.Fields.Item("studFName") & " "  & rs.Fields.Item("studLname")
												path_two = "#" & rs.Fields.Item("appID")
												Response.write("<tr>")
													Response.write("<td>" & Item & "</td>")
													Response.write("<td>" & studName & "</td>")
													Response.write("<td>" & studReg & "</td>")
													Response.write("<td>" & rs.Fields.Item("studFaculty") & "</td>")
													Response.write("<td>" & rs.Fields.Item("studCourse") & "</td>")
													'Response.write("<td><a href='" & path_two &"'><span  class='btn btn-primary hidden-print'>View Details</span></a></td>")
													Response.write("<td ><p class='btn btn-primary hidden-print' href='" & path_two &"' data-toggle='modal'> View Details </p></td>")
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
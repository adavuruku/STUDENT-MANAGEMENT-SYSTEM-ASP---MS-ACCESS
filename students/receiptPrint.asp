<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<%
	Dim regNom, emailID, queryS, errorS, appID, txttitle, txtfname, txtoname, txtAPhone, txtgender,txtstate, txtdob, txtlgov,  txtPermadd, txtentrance, txtfaculty, txtdept, filename,transID,DatePaid, AmountP, payType
'***********************************************************
	
	if Request.QueryString("lregNot") <> "" AND Request.QueryString("lstemaill") <> "" AND Request.QueryString("tD") <> "" then
		regNom = Request.QueryString("lregNot")
		emailID = Request.QueryString("lstemaill")
		transID = Request.QueryString("tD")
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
	
	'payment info
	'retrieve details
	Status_C = "1"
	set rs = Server.CreateObject("ADODB.recordset")
	queryS = "Select * from paymentdetails inner join payment_type on paymentdetails.code=payment_type.code where paymentdetails.regNo='" & regNom & "' AND paymentdetails.transId='" & transID & "' AND paymentdetails.payStatus='" & Status_C & "'" 
	rs.Open queryS, conn
	'Response.Write(rs.RecordCount) 
	if Not rs.EOF then
		rs.MoveFirst
			payType = rs.Fields.Item("payType")
			AmountP = rs.Fields.Item("amount")
			DatePaid = rs.Fields.Item("datePaid")																				
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
										<th colspan="7" style="text-align:center"><h4>WELSH UNIVERSITY AJAOKUTA - APPLICATION SLIP | - <a class="hidden-print" href="studentlogout.asp">Sign Out</a> -</h4></th>
									</tr>
									<tr>
										<th colspan="7" style="text-align:center"><h4>PAYMENT RECEIPT - Printed On <%=Now %></h4></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan="7" style="text-align:center"><h4>Student Information</h4></td>
									</tr>
									<tr>
										<td width="350px" align="right"><h4>Student Name :</h4></td>
										<td></td>
										<td width="350px"><h4><%=txttitle%></h4></td>
										<td></td>
										<td width="350px" align="right"><h4>Registration N<u>o</u> :</h4></td>
										<td></td>
										<td width="350px" align="left"><h4><%=regNom%></h4></td>
									</tr>
									<tr>
										<td width="350px" align="right"><h4>Faculty :</h4></td>
										<td></td>
										<td width="350px"><h4><%=txtfaculty%></h4></td>
										<td></td>
										<td width="350px" align="right"><h4>Department :</h4></td>
										<td></td>
										<td width="350px" align="left"><h4><%=txtdept%></h4></td>
									</tr>
									<tr>
										<td colspan="7" style="text-align:center"><h4>Payment Information</h4></td>
									</tr>
									<tr>  
										<td width="350px" align="right"><h4>Payment For :</h4></td>
										<td width="10px"></td>
										<td width="350px"><h4><%=payType%></h4></td>
										<td></td>
										<td width="350px" align="right"><h4>Payment ID N<u>o</u> :</h4></td>
										<td></td>
										<td width="350px" align="left"><h4><%=transID%></h4></td>
									</tr>
									
									<tr>
										<td width="350px" align="right"><h4>Amount Paid :</h4></td>
										<td width="10px"></td>
										<td width="350px"><h4>&#8358;<%=FormatNumber(AmountP)%> +  &#8358;<%=FormatNumber(250)%> For Bank Charges</h4></td>
										<td width="10px"></td>
										<td width="350px" align="right"><h4>Date Paid :</h4></td>
										<td width="10px"></td>
										<td width="350px" align="left"><h4><%=DatePaid%></h4></td>
									</tr>
									<tr>
										<td colspan="2"></td>
										<td>
											<p><span onClick="window.print();" class="btn btn-primary hidden-print">Print Receipt</span><p>
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
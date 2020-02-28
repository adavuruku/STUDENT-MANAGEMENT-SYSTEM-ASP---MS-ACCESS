<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<script type="text/javascript" src="settings/edit_goods.js"></script>
<%
	Dim regNom, emailID, queryS, er_msg, appID, txttitle, txtfname, txtoname, txtAPhone, txtgender,txtstate, txtdob, txtlgov,  txtPermadd, txtentrance, txtfaculty, txtdept, filename, transId, amountP, payTitle, totA, bankC, txtCP, txtCVC, txtEX, txtCN, txtCNA
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
'********************************************
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
		'Response.Redirect ("studentlogout.asp")
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
					<div class="col-xs-12 col-sm-6 col-md-12 col-lg-12" style="background-color:white;">
						<table class="table table-hover">
								<thead>
									<tr>
										<th colspan="5" style="text-align:center"><h4>WELSH UNIVERSITY AJAOKUTA - ACCOUNT DETAILS | - <a class="hidden-print" href="index.asp">Sign Out</a> -</h4></th>
									</tr>
									<tr>
										<th colspan="5" style="text-align:left"><p>List Of All Your Payment Transaction</p></th>
									</tr>
									<tr>
										<th  style="text-align:left">SNo.</th>
										<th  style="text-align:left">Payment Type</th>
										<th style="text-align:left">Transaction ID</th>
										<th style="text-align:left">Date</th>
										<th  style="text-align:center"></th>
									</tr>
								</thead>
								<tbody>
								<%
									'retrieve account verification
									'********************************************************************
										'retrieve details
										Status_C = "1"
										set rs = Server.CreateObject("ADODB.recordset")
										queryS = "Select * from paymentdetails inner join payment_type on paymentdetails.code=payment_type.code where paymentdetails.regNo='" & regNom & "' AND paymentdetails.payStatus='" & Status_C & "' order by paymentdetails.datePaid desc"  
										rs.Open queryS, conn
										'Response.Write(rs.RecordCount) 
										if Not rs.EOF then
											j = 1
											do Until rs.EOF
												Response.write("<tr>")
													Response.write("<td>" & j & "</td>")
													Response.write("<td>" & rs.Fields.Item("payType") & "</td>")
													Response.write("<td>" & rs.Fields.Item("transId") & "</td>")
													Response.write("<td>" & rs.Fields.Item("datePaid") & "</td>")
													Response.write("<td><a class='btn btn-primary' target='_blank' href=receiptPrint.asp?lstemaill=" & emailID & "&tD=" & rs.Fields.Item("transId") & "&lregNot="& regNom &">Print</a></td>")
												Response.write("</tr>")												
												rs.MoveNext
												j = j + 1
											Loop												
										Else
											Response.write("<tr>")
												Response.write ("<td colspan='5'>No Receipt Yet!!!</td>")
											Response.write("</tr>")
										End If
									%>	
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
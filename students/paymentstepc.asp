<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<script type="text/javascript" src="settings/edit_goods.js"></script>
<%
	Dim regNom, emailID, queryS, er_msg, appID, txttitle, txtfname, txtoname, txtAPhone, txtgender,txtstate, txtdob, txtlgov,  txtPermadd, txtentrance, txtfaculty, txtdept, filename, transId, amountP, payTitle, totA, bankC, txtCP, txtCVC, txtEX, txtCN, txtCNA
'*********************************************************** 
	if Request.Form("submit") = "Cancel Transaction" then
		regNom = Request.Form("regNoH")
		emailID = Request.Form("emailIDH")
		Response.Redirect ("studenthome.asp?lstemaill=" & emailID & "&lregNot=" & regNom)
	end if
	if Request.Form("submit") = "Make Payment" then
		if Request.Form("txtCP") <> "" AND Request.Form("txtCVC") <> "" AND Request.Form("txtEX") <> "" AND Request.Form("txtCN") <> "" AND Request.Form("txtCNA") <> "" Then   
			regNom = Request.Form("regNoH")
			emailID = Request.Form("emailIDH")
			transID = Request.Form("transID")
			Response.Redirect ("paymentstepd.asp?lstemaill=" & emailID & "&lregNot=" & regNom & "&tid=" & transID)
		end if
	else
		if Request.QueryString("lregNot") <> "" AND Request.QueryString("lstemaill") <> "" AND Request.QueryString("tid") <> "" then
			regNom = Request.QueryString("lregNot")
			emailID = Request.QueryString("lstemaill")
			transId = Request.QueryString("tid")
		end if
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
'retrieve account verification
'********************************************************************
	'retrieve details
	Status_C = "0"
	set rs = Server.CreateObject("ADODB.recordset")
	queryS = "Select * from paymentdetails inner join payment_type on paymentdetails.code=payment_type.code where paymentdetails.regNo='" & regNom & "' AND paymentdetails.transId='" & transId & "' AND paymentdetails.payStatus='" & Status_C & "'"  
	rs.Open queryS, conn
	'Response.Write(rs.RecordCount) 
	if Not rs.EOF then 
		rs.MoveFirst
			amountP=rs.Fields.Item("amount")
			bankC= 250
			totA = amountP + bankC
			payTitle= "Payment Of &#8358;" & FormatNumber(totA) & " For " & rs.Fields.Item("payType") & ", By " & txttitle & "."	
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
						<form role="form"  name="reg_form" id="form" class="form-vertical"  action="paymentstepc.asp" method="POST">
						<input type="hidden" name="regNoH" value="<%=regNom%>" />
						<input type="hidden" name="emailIDH" value="<%=emailID %>" />
						<input type="hidden" name="transID" value="<%=transId %>" />
						<table class="table table-hover">
								<thead>
									<tr>
										<th colspan="3" style="text-align:center"><h4>WELSH UNIVERSITY AJAOKUTA - ACCOUNT DETAILS | - <a class="hidden-print" href="index.asp">Sign Out</a> -</h4></th>
									</tr>
									<tr>
										<th colspan="3" style="text-align:center"><h3><b><%=payTitle%></b></h3></th>
									</tr>
									<tr>
										<th style="text-align:center" colspan="3"><h4 style="color:red">Important Information: Only Master Card is allowed for Payment in this portal  </h4></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td width="350px" align="right"><h4>Beneficiary :</h4></td>
										<td></td>
										<td><h4>Welsh University Ajaokuta</h4></td>
									</tr>
									<tr>
										<td width="350px" align="right"><h4>Payment ID N<u>o</u> :</h4></td>
										<td></td>
										<td><h4><%=transId%></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>ATM Card Holder's Name : </h4></td>
										<td></td>
										<td><input type="text" class="form-control" id="txtCNA" name="txtCNA" value=""  placeholder="HOLDER'S NAME" /></td>
									</tr>
									<tr>
										<td align="right"><h4>ATM Card Number : </h4></td>
										<td></td>
										<td><input type="text" class="form-control" onkeydown="return noNumbers(event,this)" id="txtCN" name="txtCN" value=""  placeholder="1233 3334 5585 6688" /></td>
									</tr>
									<tr>
										<td align="right"><h4>Expiry Date : </h4></td>
										<td></td>
										<td><input type="text" class="form-control" id="txtEX" name="txtEX" value=""  placeholder="MM/YY" /></td>
									</tr>
									<tr>
										<td align="right"><h3><b>CVC : </b></h3></td>
										<td></td>
										<td><input type="text" class="form-control" onkeydown="return noNumbers(event,this)" id="txtCVC" name="txtCVC" value=""  placeholder="CVC" /></td>
									</tr>
									<tr>
										<td align="right"><h3><b>CARD PIN : </b></h3></td>
										<td></td>
										<td><input type="password" class="form-control" onkeydown="return noNumbers(event,this)" id="txtCP" name="txtCP" value=""  placeholder="CARD 4 DIGIT PIN" /></td>
									</tr>
									<tr>
										<td align="right" colspan="3"></td>
									</tr>
									<tr>
										<td align="right"><input type="submit" name="submit" style="margin-bottom:10px;padding:5px 20px 5px 20px" value="Cancel Transaction" class="btn btn-danger btn-md"></input></td>
										<td></td>
										<td align="left">
											<input type="submit" name="submit" style="margin-bottom:10px;padding:5px 20px 5px 20px" value="Make Payment" class="btn btn-primary btn-md"></input>
										</td>
									</tr>
									<tr>
										<td align="center" colspan="3"><h4 style="color:red">Important Information: Only Master Card is allowed for Payment in this portal  </h4></td>
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
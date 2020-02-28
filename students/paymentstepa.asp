<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<%
	Dim regNom, emailID, queryS, er_msg, appID, txttitle, txtfname, txtoname, txtAPhone, txtgender,txtstate, txtdob, txtlgov,  txtPermadd, txtentrance, txtfaculty, txtdept, filename
'***********************************************************
	if Request.Form("submit") = "Generate Trans ID" then
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
	if Request.Form("txtpayType") <> "" AND Request.Form("txtpayType") <> "Select Payment Type" then
		Dim Status_C, msg1,studFaculty,studCourse,progyear
		txtpayType = Request.Form("txtpayType")
		Status_C = "1"
		set rs = Server.CreateObject("ADODB.recordset")
		queryS = "Select * from paymentdetails where regNo='" & regNom & "' AND code='" & txtpayType & "'"  
		rs.Open queryS, conn
		'Response.Write(rs.RecordCount) 
		if Not rs.EOF then
			'admission is given
			rs.MoveFirst
				tid=rs.Fields.Item("transId")
				if rs.Fields.Item("payStatus") ="1" then
					'redirect to download the receipt
					Response.Redirect ("receipt.asp?lstemaill=" & emailID & "&lregNot=" & regNom)
				else
					'redirect to continue payment with previous id
					Response.Redirect ("paymentstepb.asp?lstemaill=" & emailID & "&lregNot=" & regNom & "&tid=" & tid )
				end if
		else
			'initiate ne payment
			'generate new app id
			Dim dataList(5)
			dataList(0) = "AU"
			dataList(1) = "ZI"
			dataList(2) = "XC"
			dataList(3) = "PE"
			dataList(4) = "KJ"
			dataList(5) = "NC"
			Randomize
			min = 100000000000
			max = 999999999999
			min_a = 0
			max_a = 5
			transIDA = Int((max_a-min_a +1) *Rnd + min_a)
			transID = dataList(transIDA) & Int((max-min +1) *Rnd + min)
			
			'save as new record then continue
			on Error resume next
			dim stat_us
			stat_us ="0"
			queryS = "INSERT INTO paymentdetails (regNo,code,transId,payStatus,dateGen) VALUES ('" & regNom & "','" & txtpayType & "','" & transID &"','" & stat_us &"', now())" 
			conn.Execute queryS
			conn.close
			'redirect to continue payment with previous id
			Response.Redirect ("paymentstepb.asp?lstemaill=" & emailID & "&lregNot=" & regNom & "&tid=" & transID)
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
						<form role="form"  name="reg_form" id="form" class="form-vertical"  action="paymentstepa.asp" method="POST">
						<input type="hidden" name="regNoH" value="<%=regNom%>" />
						<input type="hidden" name="emailIDH" value="<%=emailID %>" />
						<table class="table table-hover">
								<thead>
									<tr>
										<th colspan="3" style="text-align:center"><h4>WELSH UNIVERSITY AJAOKUTA - ACCOUNT DETAILS | - <a class="hidden-print" href="index.asp">Sign Out</a> -</h4></th>
									</tr>
									<tr>
										<th colspan="3" style="text-align:center"><h4>GENERATE PAYMENT ID</h4></th>
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
										<td align="right"><h4>Payment For :</h4></td>
										<td></td>
										<td>
											<select class="form-control js-example-basic-single" name="txtpayType" id="txtpayType">    
												
												<option value="Select Payment Type">Select Payment Type</option>
												<%
													set rs = Server.CreateObject("ADODB.recordset")
													queryS = "Select * from payment_type order by payType asc"  
													rs.Open queryS, conn
													if Not rs.EOF then
														'admission is given
														do Until rs.EOF
															payType =rs.Fields.Item("payType")
															code = rs.Fields.Item("code")
															Response.write("<option  value='"& code & "'>" & payType & "</option>")
															rs.MoveNext
														Loop
													End if
												%>
											</select>
										</td>
									</tr>
									<tr>
										<td align="right" colspan="3"></td>
									</tr>
									<tr>
										<td align="right"><h4></h4></td>
										<td></td>
										<td align="right">
											<input type="submit" name="submit" style="margin-bottom:10px;padding:5px 20px 5px 20px" value="Generate Trans ID" class="btn btn-primary btn-md"></input>
										</td>
									</tr>
									<tr>
										<td align="right" colspan="3"></td>
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
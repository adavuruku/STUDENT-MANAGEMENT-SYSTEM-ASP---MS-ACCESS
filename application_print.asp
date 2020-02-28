<!--#include file ="settings/header.asp"-->
<!--#include file ="settings/connection.asp"-->
<%
	'retrieve the values
	Dim regNom, emailID, queryS, errorS, appID ,appIDA, dataList(5)
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

%>
			<!-- MIDDLE -->
			<div class="row" style="margin-top:5px;">
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4 hidden-print" style="background-color: white">
					<!--#include file ="settings/navigate.asp"-->
				</div>
				<div class="col-xs-12 col-sm-6 col-md-8 col-lg-8" style="background-color: grey;padding:10px;margin-bottom:5px">
					<div class="col-xs-12 col-sm-6 col-md-12 col-lg-12" style="background-color:white;">
						<table class="table table-hover">
							<thead>
								<tr>
									<th colspan="3" style="text-align:center"><h4>WELSH UNIVERSITY AJAOKUTA - ADMISSION APPLICATION SLIP</h4></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><h4>Registration N<u>o</u></h4></td>
									<td></td>
									<td><h4><%=regNom %></h4></td>
								</tr>
								<tr>
									<td colspan="3"></td>
								</tr>
								<tr>
									<td><h4>Email Address</h4></td>
									<td></td>
									<td><h4><%=emailID %></h4></td>
								</tr>
								<tr>
									<td colspan="3"></td>
								</tr>
								<tr>
									<td><h4>Application ID</h4></td>
									<td></td>
									<td><h4><b><%=appID %></b></h4></td>
								</tr>
								<tr>
									<td colspan="3"></td>
								</tr>
								<tr>
									<td><p class="hidden-print"><span onClick="window.print();" class="btn btn-info">Print Slip</span><p></td>
									<td></td>
									<td><a class="hidden-print" href="upload_details.asp?lstemaill=<%=emailID%>&lregNot=<%=regNom%> "><span class="btn btn-success">Continue Application >> </span></a></td>
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
<%
'save the records
	'set rs = Server.CreateObject("ADODB.recordset")
	on Error resume next
	dim stat_us
	stat_us ="0"
	queryS = "INSERT INTO student_record (regNo,studEmail,appID,reg_status) VALUES ('" & regNom & "','" & emailID & "','" & appID &"','" & stat_us &"')" 
	conn.Execute queryS
	conn.close
%>
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
		Response.Redirect ("adminlogout.asp" )
	end if

	if Session("ausername") <> ausername then
		Response.Redirect ("adminlogout.asp")
	end if
	
	admin_name = Session("admin_name")
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
						<table class="table table-hover">
								<thead>
									<tr>
										<th colspan="3" style="text-align:center"></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td align="right"><h4>Admin Name : </h4></td>
										<td></td>
										<td><h4><%=admin_name%></h4></td>
									</tr>
									<tr>
										<td width="350px" align="right"><h4>Admin ID :</h4></td>
										<td></td>
										<td><h4><%=ausername %></h4></td>
									</tr>
									<tr>
										<td align="right"><h4>Last Login :</h4></td>
										<td></td>
										<td><h4><b><%=last_login%></b></h4></td>
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
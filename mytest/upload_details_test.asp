<!--#include file ="settings/header.asp"-->
<!--#INCLUDE FILE="settings/clsUpload.asp"-->
<!--#INCLUDE FILE="settings/clsImage.asp"-->
<!--#include file ="settings/connection.asp"-->
<link rel="stylesheet" type="text/css" href="settings/css/select2.css"/>
<link rel="stylesheet" type="text/css" href="settings/css/select2.min.css"/>
<script type="text/javascript" src="settings/js/select2.js"></script>
<script type="text/javascript" src="settings/js/select2.min.js"></script>

<link rel="stylesheet" type="text/css" href="settings/plugins/css/bootstrap-datepicker.css" />
<link rel="stylesheet" type="text/css" href="settings/plugins/css/bootstrap-datepicker3.min.css" />
<script type="text/javascript" src="settings/plugins/js/bootstrap-datepicker.js"></script>

<script type="text/javascript" src="settings/edit_goods.js"></script>

<%
	'retrieve the values
	Dim regNom, emailID, queryS, errorS, appID, txttitle, txtfname, txtoname, txtAPhone, txtgender,txtstate, txtdob, txtlgov,  txtPermadd, txtentrance, txtfaculty, txtdept, Upload
	'Dim Upload
	
	Set Upload = New clsUpload
	'empty fields
		txttitle="Select Title"
		txtfname=""
		errorS=""
		txtoname=""
		txtAPhone=""
		txtgender="Select Gender"
		txtstate="Select State"
		txtdob=""
		txtlgov="Select Local Government"
		txtPermadd=""
		txtentrance="Select Entrance Mode"
		txtfaculty="Select Faculty"
		txtdept="Select Department"
		

	appID = Session("stappid")
	
	'***********************************************************
	'check if for is to edit
	if Request.QueryString("edit") ="yess" then
	
		set rs = Server.CreateObject("ADODB.recordset")
		queryS = "Select * from student_record where regNo='" & regNom & "' AND appID='" & appID & "'" 
		rs.Open queryS, conn
		'Response.Write(rs.RecordCount) 
		if Not rs.EOF then
			rs.MoveFirst
				if rs.Fields.Item("studTitle") = "" then
					txttitle=rs.Fields.Item("studTitle")
					txtfname= rs.Fields.Item("studFName") 
					txtoname = rs.Fields.Item("studLname")
					txtAPhone=rs.Fields.Item("studPhone")
					txtgender=rs.Fields.Item("studGender")
					txtstate=rs.Fields.Item("studState")
					txtdob=rs.Fields.Item("studDob")
					txtlgov=rs.Fields.Item("studLg")
					txtPermadd=rs.Fields.Item("studAdd")
					txtentrance=rs.Fields.Item("studMode")
					txtfaculty=rs.Fields.Item("studFaculty")
					txtdept=rs.Fields.Item("studCourse")
				else
					txttitle="Select Title"
					txtfname=""
					errorS=""
					txtoname=""
					txtAPhone=""
					txtgender="Select Gender"
					txtstate="Select State"
					txtdob=""
					txtlgov="Select Local Government"
					txtPermadd=""
					txtentrance="Select Entrance Mode"
					txtfaculty="Select Faculty"
					txtdept="Select Department"
				end if
		Else
			'Response.Redirect ("index.asp")
		End If
		rs.close
	end if
	'*********************************************************
	
'*********************************************************
'*********************************************************	
	
%>
			<!-- MIDDLE -->
			<div class="row" style="margin-top:5px;">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="background-color: grey;padding:10px;margin-bottom:5px;">
				<h3 style="color:white;text-align:center;font-weight:bold">WELSH UNIVERSITY AJAOKUTA - COMPLETE YOUR APPLICATION | - <a  class="hidden-print" style="color:yellow;text-align:center;font-weight:bold" href="index.asp">Sign Out</a> -</h3>
					<h5 style="color:white;text-align:center;font-weight:bold"><%=errorS%></h5>
					<form role="form"  name="reg_form" encType="multipart/form-data" id="form" class="form-vertical"  action="upload_details.asp" method="POST">
						<input type="hidden" name="regNoH" value="<%=regNom%>" />
						<input type="hidden" name="emailIDH" value="<%=emailID %>" />
						<!-- First Block -->
						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" style="background-color:white;">
							<table class="table table-hover">
								<tr>
									<td width="250px" align="right"></td>
									<td colspan="2">
										<div class="imageupload panel panel-primary" id="my-imageupload">
											<div class="panel-heading clearfix">
												<h3 class="panel-title pull-left">Upload Passport - jpg / jpeg - <= 500kb - 250 X 250</h3>
											</div>
											<div class="file-tab panel-body">
												<label class="btn btn-default btn-file">
													<span>Browse</span>
													<!-- The file is stored here. -->
													<input type="file" name="File1">
												</label>
												<button type="button" class="btn btn-default">Remove</button>
											</div>
										</div>
										<script src="settings/js/bootstrap-imageupload.js"></script>
										<script>
											var $imageupload = $('.imageupload');
											$imageupload.imageupload();
											$('#my-imageupload').imageupload({
												allowedFormats: [ 'jpg','jpeg' ],
												maxFileSizeKb: 500,
												maxWidth: auto,
												maxHeight: 250
											});
										</script>
									</td>
								</tr>
								<tr>
									<td width="250px" align="right"><h4>Registration N<u>o</u> :</h4></td>
									<td></td>
									<td><h4><%=regNom %></h4></td>
								</tr>
								<tr>
									<td align="right"><h4>Email Address : </h4></td>
									<td></td>
									<td><h4><%=emailID %></h4></td>
								</tr>
								<tr>
									<td align="right"><h4>Application ID :</h4></td>
									<td></td>
									<td><h4><b><%=appID %></b></h4></td>
								</tr>
								<tr>
									<td align="right"><h4>Title : </h4></td>
									<td></td>
									<td>
										<select class="form-control js-example-basic-single" id="txttitle" name="txttitle">
											<option value="<%=txttitle %>" ><%=txttitle %></option>
											<option value="Mr.">Mr.</option>
											<option value="Mrs.">Mrs.</option>
											<option value="Miss.">Miss.</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="right"><h4>First Name : </h4></td>
									<td></td>
									<td><input type="text" class="form-control" id="txtfname" name="txtfname" value="<%=txtfname%>" required="true" placeholder="Enter Your First Name" /></td>
								</tr>
								<tr>
									<td align="right"><h4>Other Name : </h4></td>
									<td></td>
									<td><input type="text" class="form-control" id="txtoname" name="txtoname" value="<%=txtoname%>" required="true" placeholder="Enter Your Other Names" /></td>
								</tr>
								<tr>
									<td align="right"><h4>Phone No : </h4></td>
									<td></td>
									<td><input type="text" class="form-control" onkeydown="return noNumbers(event,this)" id="txtAPhone" name="txtAPhone" value="<%=txtAPhone%>"  placeholder="Enter Your Phone No" /></td>
								</tr>
							</table>
						</div>
						<!-- Second Block -->
						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" style="background-color:white;">
							<table class="table table-hover">
								
								<tr>
									<td align="right"><h4>Gender : </h4></td>
									<td></td>
									<td>
										<select class="form-control js-example-basic-single" name="txtgender" id="txtgender">
											<option value="<%=txtgender %>" ><%=txtgender %></option>
											<option value="Male">Male</option>
											<option value="Female">Female</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="right" width="250px"><h4>Date Of Birth : </h4></td>
									<td></td>
									<td>
										<div class="input-group date" data-provide="datepicker">
											<input type="text" class="form-control"  id="txtdob" name="txtdob" value="<%=txtdob %>" required="true" />
											<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
										</div>
									</td>
								</tr>
								<tr>
									<td align="right"><h4>State Of Origin : </h4></td>
									<td></td>
									<td>
										<select class="form-control js-example-basic-single" id="cmbstate" name="txtstate" onchange="stateComboChange();">
											<option value="<%=txtstate %>" ><%=txtstate %></option>
											<option value="Abuja" title="Abuja">Abuja</option>
											<option value="Abia" title="Abia">Abia</option>
											<option value="Adamawa" title="Adamawa">Adamawa</option>
											<option value="Akwa Ibom" title="Akwa Ibom">Akwa Ibom</option>
											<option value="Anambra" title="Anambra">Anambra</option>
											<option value="Bauchi" title="Bauchi">Bauchi</option>
											<option value="Bayelsa" title="Bayelsa">Bayelsa</option>
											<option value="Benue" title="Benue">Benue</option>
											<option value="Bornu" title="Bornu">Bornu</option>
											<option value="Cross River" title="Cross River">Cross River</option>
											<option value="Delta" title="Delta">Delta</option>
											<option value="Ebonyi" title="Ebonyi">Ebonyi</option>
											<option value="Edo" title="Edo">Edo</option>
											<option value="Ekiti" title="Ekiti">Ekiti</option>
											<option value="Enugu" title="Enugu">Enugu</option>
											<option value="Gombe" title="Gombe">Gombe</option>
											<option value="Imo" title="Imo">Imo</option>
											<option value="Jigawa" title="Jigawa">Jigawa</option>
											<option value="Kaduna" title="Kaduna">Kaduna</option>
											<option value="Kano" title="Kano">Kano</option>
											<option value="Katsina" title="Katsina">Katsina</option>
											<option value="Kebbi" title="Kebbi">Kebbi</option>
											<option  value="Kogi" title="Kogi">Kogi</option>
											<option value="Kwara" title="Kwara">Kwara</option>
											<option value="Lagos" title="Lagos">Lagos</option>
											<option value="Nassarawa" title="Nassarawa">Nassarawa</option>
											<option value="Niger" title="Niger">Niger</option>
											<option value="Ogun" title="Ogun">Ogun</option>
											<option value="Ondo" title="Ondo">Ondo</option>
											<option value="Osun" title="Osun">Osun</option>
											<option value="Oyo" title="Oyo">Oyo</option>
											<option value="Plateau" title="Plateau">Plateau</option>
											<option value="Rivers" title="Rivers">Rivers</option>
											<option value="Sokoto" title="Sokoto">Sokoto</option>
											<option value="Taraba" title="Taraba">Taraba</option>
											<option value="Yobe" title="Yobe">Yobe</option>
											<option value="Zamfara" title="Zamfara">Zamfara</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="right"><h4>Local Government : </h4></td>
									<td></td>
									<td>
										<select class="form-control js-example-basic-single" id="cmblgov" name="txtlgov">
											<option value="<%=txtlgov %>" ><%=txtlgov %></option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="right"><h4>Contact Address : </h4></td>
									<td></td>
									<td>
										<textarea class="form-control"  rows="2" id="txtPermadd" name="txtPermadd" required="true" placeholder="Enter Your Contact Address">
										<%=txtPermadd %>
										</textarea>
									</td>
								</tr>
								<tr>
									<td align="right"><h4>Mode Of Application : </h4></td>
									<td></td>
									<td>
										<select class="form-control js-example-basic-single" name="txtentrance" id="txtentrance">
											<option value="<%=txtentrance %>" ><%=txtentrance %></option>
											<option value="Utme">Utme</option>
											<option value="DEntry">DEntry</option> 
										</select>
									</td>
								</tr>
								<tr>
									<td align="right"><h4>Choice Faculty : </h4></td>
									<td></td>
									<td>
										<select class="form-control js-example-basic-single" name="txtfaculty" id="faculty" onchange="schoolComboChange();">    
											<option value="<%=txtfaculty %>" ><%=txtfaculty %></option>
											<option value="Agriculture">Agriculture</option>
											<option value="Bussiness Studies">Bussiness Studies</option>
											<option value="Engineering">Engineering</option>
											<option value="Environmental Studies">Environmental Studies</option>
											<option value="Science">Science</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="right"><h4>Choice Department : </h4></td>
									<td></td>
									<td>
										<select class="form-control js-example-basic-single" id="department" name="txtdept">
											<option value="<%=txtdept %>" ><%=txtdept %></option>
										</select>
									</td>
								</tr>
								<tr class="hidden-print">
									<td colspan="2"></td>
									<td align="right">
										<input type="submit" name="submit" style="margin-bottom:10px;padding:5px 20px 5px 20px" value="Preview Details" class="btn btn-primary btn-md"></input>
									</td>
								</tr>
							</table>
						</div>
					</form>
				</div>
			</div>
			 <script type="text/javascript">
				$(document).ready(function() {
					$('.js-example-basic-single').select2();
				});
			</script>
			<!-- FOOTER -->
			<!--#include file ="settings/footer.asp"-->
		</body>
</html>

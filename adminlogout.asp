<%

	If Session.Contents("admin_name") <> "" then
		Session.Contents.Remove("admin_name")
	End If
	If Session.Contents("ausername") <> "" then
		Session.Contents.Remove("ausername")
	End If
	If Session.Contents("last_login") <> "" then
		Session.Contents.Remove("last_login")
	End If
	Response.Redirect ("Default.asp")
%>
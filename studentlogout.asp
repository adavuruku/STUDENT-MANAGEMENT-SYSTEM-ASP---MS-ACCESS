<%

	If Session.Contents("stemail") <> "" then
		Session.Contents.Remove("stemail")
	End If
	If Session.Contents("stregNo") <> "" then
		Session.Contents.Remove("stregNo")
	End If
	If Session.Contents("stappid") <> "" then
		Session.Contents.Remove("stappid")
	End If
	Response.Redirect ("Default.asp")
%>
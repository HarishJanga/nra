<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Note-Details</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
	$(document).ready(function(){
		$("#myModal").modal('show');
	});
	function rd()
	{
		console.log("clicked");
		window.location="logu.jsp";
	}
</script>
</head>
<style>
.fa-arrow-left:hover{
color:red;
font-size:30px;
}
</style>
<%
String n=request.getParameter("fck");
%>
<% 
HttpSession s=request.getSession();
String un=s.getAttribute("uid").toString();
%>
<%
Connection con=null;
Statement stmt=null;
try{  
	Class.forName("com.mysql.jdbc.Driver");  
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/examly","root","manager");   	
}catch(Exception e){ System.out.println(e);}
stmt=con.createStatement();
%>
<%
String startd="";
String endd="";
String rdate="";
String status_n="";
String tag_n="";
String desc_n="";
ResultSet rs=stmt.executeQuery("select * from unotes where name_n='"+n+"' and uname='"+un+"'");
while(rs.next())
{
	startd=rs.getString("startd");
	endd=rs.getString("endd");
	rdate=rs.getString("rdate");
	status_n=rs.getString("status_n");
	tag_n=rs.getString("tag_n");
	desc_n=rs.getString("desc_n");
}
%>
<body>
<div class="container-fluid">
<div id="myModal" class="modal fade">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
            <span onclick="rd()"><i class="fa fa-arrow-left mr-auto" style="font-size:25px;"></i></span>
                <h5 class="modal-title ml-auto"><%=n%> Details</h5>
            </div>
            <div class="modal-body">
			<table class="table table-striped table-responsive table-md">
  <tbody>
    <tr>
      <th scope="row">Start Date</th>
      <td><%=startd%></td>
    </tr>
    <tr>
      <th scope="row">End Date</th>
      <td><%=endd%></td>
    </tr>
    <tr>
      <th scope="row">Reminder Date</th>
      <td><%=rdate%></td>
    </tr>
    <tr>
      <th scope="row">Status</th>
      <td><%=status_n%></td>
    </tr>
    <tr>
      <th scope="row">Tag</th>
      <td><%=tag_n%></td>
    </tr>
    <tr>
      <th scope="row">Description</th>
      <td><%=desc_n%></td>
    </tr>
  </tbody>
</table>	
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>
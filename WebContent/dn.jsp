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
	function rdfp()
	{
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
HttpSession s=request.getSession();
String un=s.getAttribute("uid").toString();
String n="";
%>
<%
Connection con=null;
Statement stmt=null;
try{  
	Class.forName("com.mysql.jdbc.Driver");  
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/examly","root","manager");   	
}catch(Exception e){ System.out.println(e);}
stmt=con.createStatement();
n=request.getParameter("fck");
%>
<body>
<form method="post" action="./dnservlet">
<div id="myModal" class="modal fade">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
            <input type="hidden" name="one" value="<%=n%>">
			<h5>Are you sure You want to delete <%=n%>?</h5>	
            </div>
        <div class="modal-footer">
        <button type="submit" class="btn btn-primary">Delete</button>
        <button type="button" onclick="rdfp()" class="btn btn-danger">Cancel</button>
        </div>
        </div>
    </div>
</div>
</form>
</body>
</html>
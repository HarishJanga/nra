<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.OutputStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Profile</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<% 
HttpSession s=request.getSession();
String un=s.getAttribute("uid").toString();
%>
<script>
  function myfunction(){
    var p=document.getElementById("pwd").value;
    var cp=document.getElementById("cpwd").value;
    if(p==cp){
      document.getElementById("msg").style.color="green";
      document.getElementById("msg").innerHTML="passwords matched";
      document.getElementById("sbt").disabled = false;
      }
    else{
    	document.getElementById("msg").style.color="red";
    	document.getElementById("msg").innerHTML="passwords must  match";
    	document.getElementById("sbt").disabled = true;
    	}
  }
</script>
<body>
 <div class="header">
    <nav class="navbar navbar-light bg-light navbar-expand-md sticky-top">
        <a href="logu.jsp" class="nav-link"><i style="font-size:50px;" class="fa fa-arrow-circle-left"></i></a>
        <button class="navbar-toggler" data-toggle="collapse" data-target="#collapse_target">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="collapse_target">
        <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link text-info active h2" href="profile.jsp"><i class="fa fa-user"></i> My profile</a>
        </li>
    </ul>
    <ul class="navbar-nav ml-auto">
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle text-primary h5" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fa fa-user-circle" style="font-size:20px;"></i> <%= un%>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item text-primary h6" href="profile.jsp">View profile</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item text-primary h6" href="logout.jsp"><i class="fa fa-sign-out" style="font-size:20px;"></i> Logout</a>
        </div>
      </li>
    </ul>
</div>
</nav>
</div>
<%
Connection con=null;
Statement stmt=null;
try{  
	Class.forName("com.mysql.jdbc.Driver");  
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/examly","root","manager");   	
}catch(Exception e){ System.out.println(e);}
stmt=con.createStatement();
ResultSet rs=stmt.executeQuery("SELECT umail,upass,uphn from udetails WHERE umail='"+un+"'");
%>
<%
String cma="";
String cpa="";
String cph="";
while(rs.next()){
	cma=rs.getString("umail");
	cpa=rs.getString("upass");
	cph=rs.getString("uphn");
}
%>
<div class="container-fluid">
<div class="table-responsive">          
  <table class="table table-striped">
    <thead>
      <tr class="h5 text-primary">
        <th>My Details</th>
      </tr>
    </thead>
    <tbody>
      <tr class="h6">
        <td>Mail : <%= cma%></td>
        <td>Password : <%= cpa%>&emsp;<button class="btn btn-outline-primary" data-toggle="modal" data-target="#PModal"><i class="fa fa-edit"></i> Edit</button></td>
        <td>Mobile : <%= cph%>&emsp;<button class="btn btn-outline-primary" data-toggle="modal" data-target="#MModal"><i class="fa fa-edit"></i> Edit</button></td>
      </tr>
    </tbody>
  </table>
  </div>
</div>
<div class="modal fade" id="PModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-primary" id="exampleModalLabel">Update Password</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
         <form action="./passeservlet" method="post">
    <div class="form-group w-70">
      <label class="h5 text-primary" for="pwd">New Password:</label>
      <input name="nupass" type="password" autocomplete="off" class="form-control border-secondary" id="pwd" required>
    </div>
    <div class="form-group w-70">
      <label class="h5 text-primary" for="cpwd">Confirm New Password:</label>
      <input oninput="myfunction()" name="cnupass" type="password" autocomplete="off" class="form-control border-secondary c_password" id="cpwd" required>
    </div>
    <p class="h6" id="msg"></p>
    <div class="row">
    &emsp;
    <button id="sbt" type="submit" class="btn btn-primary col-md-5">Update</button>&emsp;
    <button type="reset" class="btn btn-danger col-md-5">Clear</button>
    </div>
  </form>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="MModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-primary" id="exampleModalLabel">Update Mobile</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="./mobeservlet" method="post">
    <div class="form-group w-70">
      <label class="h5 text-primary" for="pwd">New mobile:</label>
      <input name="nuphn" type="tel" maxlength="10" autocomplete="off" class="form-control border-secondary" id="pwd" required>
    </div>
    <div class="row">
    &emsp;
    <button id="sbt" type="submit" class="btn btn-primary col-md-5" >Update</button>&emsp;
    <button type="reset" class="btn btn-danger col-md-5">Clear</button>
    </div>
  </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="google" content="notranslate" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<style>
 #add {
 	position:fixed;
    right:0;
  }
  .float{
	position:fixed;
	width:60px;
	height:60px;
	bottom:40px;
	right:40px;
	text-align:center;
}

.my-float{
	margin-top:22px;
	color:blue;
}
.fa-plus-circle:hover {
	font-size:50px;
    color: red;
}
.icon-button {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  color: #333333;
  background: #dddddd;
  border: none;
  outline: none;
  border-radius: 50%;
}

.icon-button:hover {
  cursor: pointer;
}

.icon-button:active {
  background: #cccccc;
}

.icon-button__badge {
  position: absolute;
  top: -5px;
  right: -10px;
  width: 25px;
  height: 25px;
  background: red;
  color: #ffffff;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 50%;
}
</style>
<script>
function myFunction() {
    var now = new Date();

    var day = ("0" + now.getDate()).slice(-2);
    var month = ("0" + (now.getMonth() + 1)).slice(-2);

    var today = now.getFullYear() + "-" + (month) + "-" + (day);
    $('#stdate').attr('min', today);
    $('#eddate').attr('min', today);
    }
function df()
{
	var s=document.getElementById("stdate").value;
	var e=document.getElementById("eddate").value;
	console.log(s,e);
	$('#rddate').attr('min', s);
	$('#rddate').attr('max', e);
	}
$(document).on("click", ".open", function (e) {

	e.preventDefault();

	var _self = $(this);

	var myBookId = _self.data('id');
	$("#h").val(myBookId);

	$(_self.attr('href')).modal('show');
});
$(document).ready(function(){
    $('[data-toggle="popover"]').popover();   
});
</script>
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
<body>
<%
String sd,ed,rd;
int n=0;
%>
<%String cd=java.time.LocalDate.now().toString();%>
<%
        String qf3="select count(*) from unotes where rdate='"+cd+"' and uname='"+un+"'";
        ResultSet p3=stmt.executeQuery(qf3);
        while(p3.next()){
        	n=Integer.parseInt(p3.getString("count(*)"));
        }
%>
<div class="header">
    <nav class="navbar navbar-light bg-light navbar-expand-md sticky-top">
        <a href="logu.jsp" class="navbar-brand h5 text-dark"><i class="fa fa-home"></i> Home</a>
        <button class="navbar-toggler" data-toggle="collapse" data-target="#collapse_target">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="collapse_target">
        <ul class="navbar-nav ml-auto">
        <li><button type="button" class="icon-button" data-toggle="modal" data-target="#NModal">
    <span class="material-icons">notifications</span>
    <span class="icon-button__badge"><%=n%></span>
  </button></li>&emsp;
        <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle text-info h5" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <%= un%>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item text-info h6" href="profile.jsp"><i class="fa fa-user-circle" style="font-size:20px;"></i> View profile</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item text-info h6" href="logout.jsp"><i class="fa fa-sign-out" style="font-size:20px;"></i> Logout</a>
        </div>
      </li>
    </ul>
</div>
</nav>
</div>
<%
ResultSet rs=stmt.executeQuery("SELECT * from unotes where uname='"+un+"' order by startd");
%>
<br>
<%
while (rs.next()) {
%>
<div class="col d-flex justify-content-center">
<div class="card w-75 border-info bg-light"> 
  <div class="card-body">
  	<form method="post">
    <h4 class="card-title text-info"><%=rs.getString("name_n")%><button type="submit" formaction="./en.jsp" style="float:right;" class="btn btn-outline-primary"><i class="fa fa-edit"> Edit</i></button></h4>
    <hr style="height:2px;border-width:0;color:gray;background-color:gray">
    <p class="h5 text-secondary">started on : <%=rs.getString("startd")%></p><button type="submit" style="float:right;" formaction="./dn.jsp" class="btn btn-outline-primary"><i class="fa fa-trash"></i> Delete</button>
    <p class="h5 text-secondary">Status : <%=rs.getString("status_n") %></p>
    <p class=" h5 card-text text-secondary"><%=rs.getString("desc_n") %></p>
    <input type="hidden" value="<%=rs.getString("name_n")%>" name="fck">
   <button type="submit" formaction="./vn.jsp" class="btn btn-outline-primary" >View Details</button>
   </form>
  </div>
</div>
</div>
<br>
<% } %>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-primary" id="exampleModalLabel">Add A New Note</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="./adnts.jsp" method="post">
        <input type="hidden" value="<%=un%>" name="uname">
  <div class="form-row">
    <div class="form-group col-md-6">
      <label class="h6 text-primary" for="inputEmail4">Start Date</label>
      
      <input name="sdate" onclick="myFunction()" type="date" class="form-control" id="stdate" required>
    </div>
    <div class="form-group col-md-6">
      <label class="h6 text-primary" for="inputPassword4">End Date</label>
      <input name="edate" onclick="myFunction()" type="date" class="form-control" id="eddate" required>
    </div>
  </div>
  <div class="form-group">
    <label class="h6 text-primary" for="inputAddress">Reminder Date</label>
    <input name="rdate" onclick="df()" type="date" class="form-control" id="rddate" required>
  </div>
  <div class="form-group">
    <label class="h6 text-primary" for="inputAddress2">Note Name</label>
    <input name="nmn" autocomplete="off" type="text" class="form-control" id="inputAddress2" placeholder="Name of the note" required>
  </div>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label class="h6 text-primary" for="inputCity">Status</label>
      <input name="stat" autocomplete="off" type="text" class="form-control" id="inputCity" placeholder="status" required>
    </div>
    <div class="form-group col-md-6">
      <label class="h6 text-primary" for="inputCity">Tag</label>
      <input name="tg" autocomplete="off" type="text" class="form-control" id="inputCity" placeholder="Tag" required>
    </div>
    </div>
    <div class="form-group">
  <label class="h6 text-primary" for="comment">Description:</label>
  <textarea autocomplete="off" name="desc" class="form-control" rows="5" id="comment" placeholder="Description" required></textarea>
   </div>
  <button type="submit" class="btn btn-primary">Add</button>
</form>
      </div>
    </div>
  </div>
</div>
<div class="modal ml-auto" id="NModal" style="top:6%;left:35%;outline: none;">
    <div class="modal-dialog modal-sm modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header">
          <h6 class="modal-title">Notifications</h6>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body bg-secondary">
        <%ResultSet rsd=stmt.executeQuery("select name_n,endd from unotes where rdate='"+cd+"' and uname='"+un+"'");%>
        <%while(rsd.next()){ %>
        <div class="card">
  <div class="card-body bg-light">
  	<p class="h6 text-primary">Reminder for <%=rsd.getString("name_n")%></p>
    <p class="h6 text-primary">Last date is <%=rsd.getString("endd")%></p>
  </div>
</div>
<br>
<%}%>
        </div>
      </div>
    </div>
  </div>
<div class="float">
<dfn><abbr title="Add A New Note">
<i style="font-size:55px;" class="fa fa-plus-circle my-float" data-toggle="modal" data-target="#exampleModal"></i>
</abbr>
</dfn>
</div>
</body>
</html>
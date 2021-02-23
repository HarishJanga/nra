

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/mobeservlet")
public class mobeservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Connection con=null;
	Statement stmt=null; 
	public void init() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/examly", "root", "manager");
			stmt=con.createStatement();
		}catch(Exception e) {System.out.println(e);}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nuphn=request.getParameter("nuphn");
		PrintWriter out=response.getWriter();
		try {
			HttpSession s=request.getSession();
			String un=s.getAttribute("uid").toString();
			stmt.executeUpdate("update udetails set uphn='"+nuphn+"' WHERE umail='"+un+"'");
			   out.println("<script type=\"text/javascript\">");
			   out.println("alert('mobile updated successfully');");
			   out.println("location='profile.jsp';");
			   out.println("</script>");
		}catch(Exception e) {
			out.println("<script type=\"text/javascript\">");
			   out.println("alert('mobile number should not exceed more than 10 digits!!');");
			   out.println("location='profile.jsp';");
			   out.println("</script>");
			System.out.println(e);}
	}


}

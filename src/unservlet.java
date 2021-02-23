import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/unservlet")
public class unservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con=null;
	PreparedStatement stmt=null;
	public void init() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/examly", "root", "manager");
		}catch(Exception e) {System.out.println(e);}
	}  
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String one=request.getParameter("one");
		String two=request.getParameter("two");
		String three=request.getParameter("three");
		String four=request.getParameter("four");
		String five=request.getParameter("five");
		String six=request.getParameter("six");
		String seven=request.getParameter("seven");
		try {
			HttpSession s=request.getSession();
			String un=s.getAttribute("uid").toString();
			String q="update unotes set startd=?,endd=?,rdate=?,status_n=?,tag_n=?,desc_n=? where name_n=? and uname=?";
			stmt=con.prepareStatement(q);
			stmt.setString(1,two);
			stmt.setString(2,three);
			stmt.setString(3,four);
			stmt.setString(4,five);
			stmt.setString(5,six);
			stmt.setString(6,seven);
			stmt.setString(7,one);
			stmt.setString(8,un);
			stmt.executeUpdate();
			response.sendRedirect("uscss.jsp");
		}catch(Exception e) {System.out.println(e);}
	}
	}

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/anservlet")
public class anservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con=null;
	PreparedStatement stmt=null;
	public void init(ServletConfig config) throws ServletException {
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/examly","root","manager");
		}catch(Exception e){ System.out.println(e);}
	}
   	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		String sdate=request.getParameter("sdate");
		String edate=request.getParameter("edate");
		String rdate=request.getParameter("rdate");
		String nmn=request.getParameter("nmn");
		String stat=request.getParameter("stat");
		String tg=request.getParameter("tg");
		String desc=request.getParameter("desc");
		try {
			HttpSession s=request.getSession();
			String un=s.getAttribute("uid").toString();
		String query="insert into unotes(startd, endd, rdate,name_n,status_n,tag_n,desc_n,uname)"+" values (?,?, ?, ?, ?, ?, ?, ?)";
		stmt = con.prepareStatement(query);
		stmt.setString(1, sdate);
		stmt.setString(2, edate);
		stmt.setString(3, rdate);
		stmt.setString(4, nmn);
		stmt.setString(5, stat);
		stmt.setString(6, tg);
		stmt.setString(7, desc);
		stmt.setString(8, un);
		stmt.execute();
		response.sendRedirect("anscss.jsp");

		}catch(Exception e) {
			System.out.println(e);
			PrintWriter out=response.getWriter();
			   out.println("<script type=\"text/javascript\">");
			   out.println("alert('Sorry the name is already taken!!');");
			   out.println("location='logu.jsp';");
			   out.println("</script>");
			System.out.println(e);
			}
	}

}

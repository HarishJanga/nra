import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import java.sql.DriverManager;
import javax.servlet.ServletConfig;
import java.sql.PreparedStatement;
import java.sql.Connection;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
@WebServlet({ "/nusignupservlet" })
public class nusignupservlet extends HttpServlet
{
    private static final long serialVersionUID = 1L;
    Connection con;
    PreparedStatement stmt;
    
    public nusignupservlet() {
        this.con = null;
        this.stmt = null;
    }
    
    public void init(final ServletConfig config) throws ServletException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            this.con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examly", "root", "manager");
        }
        catch (Exception e) {
            System.out.println(e);
        }
    }
    
    protected void doPost(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        final String uname = request.getParameter("uname");
        final String upass = request.getParameter("upass");
        final String uphn = request.getParameter("uphn");
        try {
            final String query = " insert into udetails(umail, upass, uphn) values (?, ?, ?)";
            (this.stmt = this.con.prepareStatement(query)).setString(1, uname);
            this.stmt.setString(2, upass);
            this.stmt.setString(3, uphn);
            this.stmt.execute();
            response.sendRedirect("suscss.jsp");
        }
        catch (Exception e) {
            System.out.println(e);
            final PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You are already an existing user');");
            out.println("location='login.html';");
            out.println("</script>");
            System.out.println(e);
        }
    }
}
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
@WebServlet({ "/dnservlet" })
public class dnservlet extends HttpServlet
{
    private static final long serialVersionUID = 1L;
    Connection con;
    PreparedStatement stmt;
    
    public dnservlet() {
        this.con = null;
        this.stmt = null;
    }
    
    public void init() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            this.con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examly", "root", "manager");
        }
        catch (Exception e) {
            System.out.println(e);
        }
    }
    
    protected void doPost(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        final HttpSession s = request.getSession();
        final String un = s.getAttribute("uid").toString();
        final String one = request.getParameter("one");
        try {
            final String query = "delete from unotes where name_n=? and uname=?";
            (this.stmt = this.con.prepareStatement(query)).setString(1, one);
            this.stmt.setString(2, un);
            this.stmt.executeUpdate();
            response.sendRedirect("dscss.jsp");
        }
        catch (Exception e) {
            System.out.println(e);
        }
    }
}
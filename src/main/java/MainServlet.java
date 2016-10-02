import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/getit")
public class MainServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("index.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String doto = req.getParameter("doto");

        if (doto.equals("1")) {

            String sendWhat = req.getParameter("sender");
            String lat = req.getParameter("lat");
            String lng = req.getParameter("lng");

                CoorDatabase.getInstance()
                        .setCLL(sendWhat, lat, lng);
        }

        if (doto.equals("2")) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(CoorDatabase
                    .getInstance()
                    .getMarks());
        }
    }

}
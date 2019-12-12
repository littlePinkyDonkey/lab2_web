package servlet;

import model.Point;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/check")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Point userPoint = (Point) session.getAttribute("point");

        if (userPoint.checkArea()) {
            userPoint.setResult("included");
            session.setAttribute("answer",userPoint);
        }else {
            userPoint.setResult("not included");
            session.setAttribute("answer",userPoint);
        }
        req.getRequestDispatcher("result.jsp").forward(req,resp);
        session.removeAttribute("");
    }
}

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
        resp.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession();
        Point userPoint = (Point) req.getAttribute("point");

        if (userPoint.checkArea()) {
            userPoint.setResult("Входит");
        }else {
            userPoint.setResult("Не входит");
        }
        session.setAttribute("answer",userPoint);

        resp.sendRedirect("lab2");
    }
}

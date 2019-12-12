package servlet;

import beans.ResultBean;
import model.Point;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/lab2")
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (req.getParameterMap().size() != 0){
            String x = req.getParameter("x");
            String y = req.getParameter("y");
            String r = req.getParameter("r");

            session.setAttribute("x",x);
            session.setAttribute("y",y);
            session.setAttribute("r",r);

            resp.sendRedirect("check");
        }else {
            req.getRequestDispatcher("index.jsp").forward(req,resp);
//            if (session.getAttribute("answer") == null){
//                req.getRequestDispatcher("index.jsp").forward(req, resp);
//            }else {
//                String serverAnswer = (String) session.getAttribute("answer");
//                session.removeAttribute("answer");
//                resp.getWriter().write(serverAnswer);
//            }
        }
    }
}

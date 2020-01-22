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

@WebServlet("/check")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession();
        Point userPoint = creatPoint(req.getParameter("x"),
                req.getParameter("y"),req.getParameter("r"));

        if (userPoint.checkArea()) {
            userPoint.setResult("Входит");
        }else {
            userPoint.setResult("Не входит");
        }
        ResultBean resultBean = (ResultBean)session.getAttribute("historyBean");
        resultBean.setCurrentPoint(userPoint);
        session.setAttribute("historyBean",resultBean);
        req.getRequestDispatcher("index.jsp").forward(req,resp);
    }

    private synchronized Point creatPoint(String x_value, String y_value, String r_value){
        Point point = new Point();
        try{
            double x = Double.parseDouble(x_value);
            point.setX(x);
            double y = Double.parseDouble(y_value);
            point.setY(y);
            double r = Double.parseDouble(r_value);
            point.setR(r);
        }catch (NumberFormatException e){
            point.setResult("Данные не верны");
        }finally {
            return point;
        }
    }
}

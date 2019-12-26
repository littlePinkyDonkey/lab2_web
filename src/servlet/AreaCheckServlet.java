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
import java.util.Arrays;
import java.util.List;

@WebServlet("/check")
public class AreaCheckServlet extends HttpServlet {
    private final List<Double> X_VALUES = Arrays.asList(-3.0,-2.0,-1.0,0.0,1.0,2.0,3.0,4.0,5.0);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession();
        Point userPoint = validate(req.getParameter("x"),
                req.getParameter("y"),req.getParameter("r"));

        if (userPoint.getResult().equals("correct")){
            if (userPoint.checkArea()) {
                userPoint.setResult("Входит");
            }else {
                userPoint.setResult("Не входит");
            }
        }
        ResultBean resultBean = (ResultBean)session.getAttribute("historyBean");
        resultBean.setCurrentPoint(userPoint);
        session.setAttribute("historyBean",resultBean);
        req.getRequestDispatcher("index.jsp").forward(req,resp);
    }

    private synchronized Point validate(String x_value, String y_value, String r_value){
        Point point = new Point();
        try{
            double x = Double.parseDouble(x_value);
            point.setX(x);
            double y = Double.parseDouble(y_value);
            point.setY(y);
            double r = Double.parseDouble(r_value);
            point.setR(r);

            if ((x > -3 && x < 5) && (y > -3 && y < 5) && (r > 2 && r < 5)){
                point.setResult("correct");
                return point;
            }else throw new NumberFormatException();
        }catch (NumberFormatException e){
            point.setResult("Данные не входят в область допустимых значений");
            return point;
        }
    }
}

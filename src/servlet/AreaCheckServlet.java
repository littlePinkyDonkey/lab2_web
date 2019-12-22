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
        try{
            resp.setContentType("text/html;charset=UTF-8");

            HttpSession session = req.getSession();
            Point userPoint = validate(req.getParameter("x"),
                    req.getParameter("y"),req.getParameter("r"));

            if (userPoint.checkArea()) {
                userPoint.setResult("Входит");
            }else {
                userPoint.setResult("Не входит");
            }
            ResultBean resultBean = (ResultBean)session.getAttribute("historyBean");
            resultBean.setCurrentPoint(userPoint);
            session.setAttribute("historyBean",resultBean);
        }catch (NumberFormatException | NullPointerException e){

        }finally {
            req.getRequestDispatcher("index.jsp").forward(req,resp);
        }
    }

    private synchronized Point validate(String x_value, String y_value, String r_value) throws NumberFormatException{
        double x = Double.parseDouble(x_value);
        double y = Double.parseDouble(y_value);
        double r = Double.parseDouble(r_value);

        if ((X_VALUES.contains(x)) && (y > -3 && y < 5) && (r > 2 && r < 5)){
            return new Point(x,y,r);
        }

        return null;
    }
}

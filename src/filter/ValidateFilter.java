package filter;

import model.Point;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.List;

@WebFilter("/check")
public class ValidateFilter implements Filter {
    private final List<Double> X_VALUES = Arrays.asList(-3.0,-2.0,-1.0,0.0,1.0,2.0,3.0,4.0,5.0);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpSession session = ((HttpServletRequest)servletRequest).getSession();
        String x_value = (String)session.getAttribute("x");
        String y_value = (String)session.getAttribute("y");
        String r_value = (String)session.getAttribute("r");

        try{
            double x = Double.parseDouble(x_value);
            double y = Double.parseDouble(y_value);
            double r = Double.parseDouble(r_value);

            if ((X_VALUES.contains(x)) && (y > -3 && y < 5) && (r > 2 && r < 5)){
                session.setAttribute("point",new Point(x,y,r));
                filterChain.doFilter(servletRequest,servletResponse);
            }else throw new ClassCastException();
        }catch (ClassCastException e){
            ((HttpServletResponse)servletResponse).sendRedirect("lab2");
        }

    }

    @Override
    public void destroy() {

    }
}

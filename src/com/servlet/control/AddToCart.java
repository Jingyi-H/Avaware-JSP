package com.servlet.control;
import com.bean.data.Login;
import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddToCart extends HttpServlet{
    public void init(ServletConfig config)throws ServletException{
        super.init(config);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("utf-8");
        String goods = request.getParameter("pd");
        System.out.println(goods);
        Login loginBean = null;
        HttpSession session = request.getSession(true);
        try {
            loginBean = (Login) session.getAttribute("loginBean");
            boolean b = loginBean.getLogname() == null || loginBean.getLogname().length() == 0;
            if (b)
                response.sendRedirect("login.jsp");
            LinkedList<String> cart = loginBean.getCart();
            cart.add(goods);
            speakSomeMess(request, response, goods);
            RequestDispatcher dispatcher = request.getRequestDispatcher("lookProduct.jsp");
            dispatcher.forward(request,response);
        }
        catch (Exception exp){
            response.sendRedirect("login.jsp");
        }
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        doPost(request,response);
    }
    public void speakSomeMess(HttpServletRequest request, HttpServletResponse response, String goods) {
        response.setContentType("text/html;charset=utf-8");
        try {
            PrintWriter out = response.getWriter();
            out.print("<script type='text/javascript'>alert('添加成功');");
            /*
            out.print("<% @include file = 'nav.txt' %><HEAD>");
            out.println("<html><body>");
            out.println("<h2>" + goods + "放入购物车</h2>");
            out.println("查看购物车或返回浏览化妆品<br>");
            out.println("<a href = lookShoppingCart.jsp>查看购物车</a>");
            out.println("<br><a href = byPageShow.jsp>浏览化妆品</a>");
            out.println("</body></html>");
            */
        } catch (IOException exp) { }
    }
}

package com.servlet.control;
import com.bean.data.Login;
import java.sql.*;
import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class HandleBuyGoods extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try{
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(Exception e){}
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String buyGoodsMess = request.getParameter("buy");
        String pdlist = request.getParameter("pdlist");
        if(buyGoodsMess==null||buyGoodsMess.length()==0){
            fail(request,response,"购物车没有物品，无法生成订单");
            return;
        }
        String price = request.getParameter("price");
        if(price==null||price.length()==0){
            fail(request,response,"没有计算价格总和，无法生成订单");
            return;
        }
        float sum = Float.parseFloat(price);
        Login loginBean = null;
        HttpSession session = request.getSession(true);
        try{
            loginBean = (Login)session.getAttribute("loginBean");
            boolean b = loginBean.getLogname()==null||loginBean.getLogname().length()==0;
            if(b) response.sendRedirect("Login.jsp");
        }
        catch(Exception exp){
            response.sendRedirect("login.jsp");
        }
        String url = "jdbc:mysql://127.0.0.1/avaware?"+"user=root&password=&characterEncoding=utf-8";
        Connection con;
        PreparedStatement sql;
        ResultSet rs;
        try{
            con = DriverManager.getConnection(url);
            String insertCondition = "INSERT INTO orderform VALUES(?,?,?,?,?,?,?)";
            sql = con.prepareStatement(insertCondition, Statement.RETURN_GENERATED_KEYS);
            sql.setInt(1,0);
            sql.setString(2,loginBean.getLogname());
            sql.setString(3,buyGoodsMess);
            sql.setFloat(4,sum);
            sql.setString(5,"未支付");
            sql.setString(6,pdlist);
            sql.setString(7,"none");
            sql.executeUpdate();
            rs = sql.getGeneratedKeys();
            if (!rs.next()){
                System.err.println("获取ID失败");
            }
            int oid = rs.getInt(1);
            request.getServletContext().setAttribute("oid",oid);
            LinkedList cart = loginBean.getCart();
            cart.clear();

            request.getServletContext().setAttribute("sum",sum);

            success(request,response,"生成订单成功");
            con.close();
        }
        catch(SQLException exp){
            loginBean.setBackNews(exp.toString());
            fail(request,response,"生成订单失败"+exp);
        }
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        Connection con;
        Statement sql;
        ResultSet rs;
        try{
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch (Exception e) {}
        Login loginBean = null;
        HttpSession session = request.getSession(true);
        try{
            loginBean = (Login)session.getAttribute("loginBean");
            boolean b = loginBean.getLogname()==null||loginBean.getLogname().length()==0;
            if(b) response.sendRedirect("Login.jsp");
        }
        catch(Exception exp){
            response.sendRedirect("login.jsp");
        }
        try{
            String url = "jdbc:mysql://127.0.0.1:3306/avaware?" + "user=root&password=&characterEncoding=utf-8";
            con = DriverManager.getConnection(url);
            sql = con.createStatement();
            //String oid = request.getServletContext().getAttribute("oid").toString();
            int oid = Integer.parseInt(request.getParameter("oid"));
            String payID = request.getParameter("payID");
            int exc = sql.executeUpdate("UPDATE orderform SET status='已支付' AND payID='"+payID+"' WHERE orderID='"+oid+"'");
            if(exc > 0)
                response.sendRedirect("myAccount.jsp");
            con.close();
        }
        catch(SQLException e){
            loginBean.setBackNews(e.toString());
        }
    }
    public void success(HttpServletRequest request,HttpServletResponse response, String backNews) throws ServletException{
        response.setContentType("text/html;charset=utf-8");
        try {
            PrintWriter out = response.getWriter();
            out.print("<script type='text/javascript'>alert("+backNews+"');</script>");
            RequestDispatcher dispatcher = request.getRequestDispatcher("payment.jsp");
            dispatcher.forward(request,response);
        }
        catch (IOException exp){}
    }
    public void fail(HttpServletRequest request, HttpServletResponse response, String backNews) throws ServletException{
        response.setContentType("text/html;charset=utf-8");
        try{
            PrintWriter out = response.getWriter();
            out.print("<script type='text/javascript'>alert("+backNews+"');</script>");
            RequestDispatcher dispatcher = request.getRequestDispatcher("myCart.jsp");
            dispatcher.forward(request,response);
            /*
            out.println("<html><body>");
            out.println("<h2>"+backNews+"</h2>");
            out.println("返回主页");
            out.println("<a href = index.jsp>主页</a>");
            out.println("</body></html>");
            */
        }
        catch (IOException exp) {}
    }
}

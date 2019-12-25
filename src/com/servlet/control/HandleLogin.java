package com.servlet.control;
import com.bean.data.*;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class HandleLogin extends HttpServlet{
	public void init(ServletConfig config) throws ServletException{
		super.init(config);
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch(Exception e) {
		}
	}

	public String handleString(String s) {
		try {
			byte bb[] = s.getBytes("iso-8859-1");
			s = new String(bb);
		}
		catch(Exception ee) {

		}
		return s;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		String url = "jdbc:mysql://127.0.0.1:3306/avaware?" + "user=root&password=&characterEncoding=utf-8";
		Connection con;
		PreparedStatement sql;
		String username = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();
		username = handleString(username);
		password = handleString(password);
		if(username==null) username="";
		if(password==null) password="";

		boolean boo = username.length()>0&&password.length()>0;
		try {
			con = DriverManager.getConnection(url);
			String condition = "select * from user where username = '" + username +"' and password = '" + password + "'";
			sql = con.prepareStatement(condition);
			if(boo) {
				ResultSet rs = sql.executeQuery(condition);
				boolean m = rs.next();
				if(m == true) {
					success(request,response,username,password);
					RequestDispatcher dispatcher = request.getRequestDispatcher("lookProduct.jsp");
					dispatcher.forward(request, response);
				}
				else {
					String backNews = "您输入的用户名不存在，或密码不匹配";
					fail(request,response,username,backNews);
				}
			}
			else {
				String backNews = "请输入用户名和密码";
				fail(request,response,username,backNews);
			}
			con.close();
		}catch(SQLException exp) {
			String backNews = "" + exp;
			fail(request,response,username,backNews);
		}
	}

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		doPost(request,response);
	}

	public void success(HttpServletRequest request,HttpServletResponse response,String logname,String password) {
		Login loginBean = null;
		HttpSession session = request.getSession(true);
		try {
			loginBean = (Login)session.getAttribute("loginBean");
			if(loginBean == null) {
				loginBean = new Login();
				session.setAttribute("loginBean", loginBean);
				loginBean = (Login)session.getAttribute("loginBean");
			}
			String name = loginBean.getLogname();
			if(name.equals(logname)) {
				loginBean.setBackNews(logname + "已登录");
				loginBean.setLogname(logname);
			}
			else {
				loginBean.setBackNews(logname + "登录成功");
				loginBean.setLogname(logname);
			}
		}
		catch(Exception ee) {
			loginBean = new Login();
			session.setAttribute("loginBean", loginBean);
			loginBean.setBackNews(logname + "登录成功");
			loginBean.setLogname(logname);
		}
	}

	public void fail(HttpServletRequest request, HttpServletResponse response, String logname,String backNews) throws IOException{
		try {
			response.sendRedirect("login.jsp");
		}
		catch(Exception e){

		}
	}
}
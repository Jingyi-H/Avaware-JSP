package com.servlet.control;
import com.bean.data.*;
import java.sql.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.io.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import com.baidu.aip.ocr.AipOcr;
import org.json.JSONObject;

public class HandleRegister extends HttpServlet {

    public static final String APP_ID="18091992";
    public static final String API_KEY="xeQqTZXscNadI1me1oleU7YZ";
    public static final String SECRET_KEY="L78B5gBKatat2NGzo2yxwCs8mw96OYSs";

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try{
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(Exception e){}
    }

    public String handleString(String s){
        try{
            byte bb[] = s.getBytes("iso-8859-1");
            s = new String(bb);
        }
        catch(Exception e){}
        return s;
    }

    public String[] handleFormField(FileItem item) {
        // 获取 普通数据项中的 name值
        String fieldName = item.getFieldName();

        // 获取 普通数据项中的 value值
        String value = "";
        try {
            value = item.getString("utf-8");  // 以 utf-8的编码格式来解析 value值
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String[] result = {fieldName,value};
        // 输出到控制台
        System.out.println("fieldName:" + fieldName + "--value:" + value);
        return result;
    }

    public String handleFileField(FileItem item) {
        // 获取 文件数据项中的 文件名
        String fileName = item.getName();
        String name = "";
        // 判断 此文件的文件名是否合法
        if (fileName==null || "".equals(fileName)) {
            return name;
        }

        // 控制只能上传图片
        if (!item.getContentType().startsWith("image")) {
            return name;
        }

        // 将文件信息 输出到控制台
        System.out.println("fileName:" + fileName);         // 文件名
        System.out.println("fileSize:" + item.getSize());   // 文件大小

        // 获取 当前项目下的 /files 目录的绝对位置
        String path = this.getServletContext().getRealPath("/files");
        File file = new File(path);   // 创建 file对象

        // 创建 /files 目录
        if (!file.exists()) {
            file.mkdir();
        }

        // 将文件保存到服务器上（UUID是通用唯一标识码，不用担心会有重复的名字出现）
        try {
            name = UUID.randomUUID()+"_"+fileName;
            item.write(new File(file.toString(), name));


        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }


    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        //连接数据库
        String url = "jdbc:mysql://127.0.0.1:3306/avaware?"+"user=root&password=&characterEncoding=utf-8";
        Connection con;
        PreparedStatement sql;
        Register userBean = new Register();
        request.setAttribute("userBean",userBean);

        //获取提交的文本信息
        String username = "";
        String password = "";
        String again_password = "";
        String email = "";

        // 创建上传所需要的两个对象
        DiskFileItemFactory factory = new DiskFileItemFactory();  // 磁盘文件对象
        ServletFileUpload sfu = new ServletFileUpload(factory);   // 文件上传对象
        // 设置解析文件上传中的文件名的编码格式
        sfu.setHeaderEncoding("utf-8");
        // 创建 list容器用来保存 表单中的所有数据信息
        List<FileItem> items = new ArrayList<FileItem>();



        String img_path = "";
        String backNews = "";
        try {
            items = sfu.parseRequest(request);
            // 遍历 list容器，处理 每个数据项 中的信息
            for (FileItem item : items) {
                // 判断是否是普通项
                if (item.isFormField()) {
                    // 处理 普通数据项 信息
                    String varname = handleFormField(item)[0];
                    String value = handleFormField(item)[1];
                    if(varname.equals("username"))
                        username = value;
                    else if(varname.equals("password"))
                        password = value;
                    else if(varname.equals("again_password"))
                        again_password = value;
                    else if(varname.equals("email"))
                        email = value;
                }
                else {
                    // 处理 文件数据项 信息
                    img_path = handleFileField(item);
                }
            }
            //获取提交的文本信息
            username = handleString(username);
            password = handleString(password);
            email = handleString(email);

            if(username==null) username = "";
            if(password==null) password = "";
            boolean isLD = true;
            /*
            for(int i=0;i<username.length();i++) {
                char c = username.charAt(i);
                if (!((c <= 'z' && c > 'a') || (c <= 'z' && c >= 'A') || (c <= '9' && c >= '0')||(c=='-')||(c=='_')))
                    isLD = false;
            }
            */
            //数据库操作
            con = DriverManager.getConnection(url);
            String insertCondition = "INSERT INTO user VALUES(?,?,?,?)";
            sql = con.prepareStatement(insertCondition);
            boolean boo = username.length()>0&&password.length()>0&&isLD;
            if(boo) {
                sql.setString(1, username);
                sql.setString(2, password);
                sql.setString(3, email);
                sql.setString(4, img_path);
                int m = sql.executeUpdate();
                if (m != 0) {
                    backNews = "注册成功";
                    userBean.setBackNews(backNews);
                    userBean.setLogname(username);
                    userBean.setEmail(handleString(email));
                    request.getServletContext().setAttribute("backNews",backNews);
                }
            }
            else{
                backNews = "信息填写不完整或名字中有非法字符";
                userBean.setBackNews(backNews);
                request.getServletContext().setAttribute("backNews",backNews);
            }
            AipOcr client = new AipOcr(APP_ID, API_KEY, SECRET_KEY);
            client.setConnectionTimeoutInMillis(2000);
            client.setSocketTimeoutInMillis(60000);
            HashMap<String, String> options = new HashMap<>();
            options.put("detect_direction", "true");
            options.put("detect_risk", "false");

            JSONObject frontres = client.idcard("D:\\Tomcat\\webapps\\avaware-JSP\\files\\"+img_path, "front", options);
            JSONObject words_result=(JSONObject) frontres.get("words_result");
            JSONObject name = (JSONObject) words_result.get("姓名");
            JSONObject nation = (JSONObject) words_result.get("民族");
            JSONObject address = (JSONObject) words_result.get("住址");
            JSONObject IDNumber = (JSONObject) words_result.get("公民身份号码");
            JSONObject gender = (JSONObject) words_result.get("性别");
            request.setAttribute("name11",name.get("words"));
            request.setAttribute("nation1", nation.get("words"));
            request.setAttribute("address1", address.get("words"));
            request.setAttribute("IDNumber1", IDNumber.get("words"));
            request.setAttribute("gender1", gender.get("words"));
            con.close();
        }
        catch(SQLException exp){
            backNews = "该用户名已被占用，请更换\n" + exp;
            userBean.setBackNews(backNews);
            request.getServletContext().setAttribute("backNews",backNews);
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request,response);
            //PrintWriter out = response.getWriter();
            //out.print("<script type='text/javascript'>alert("+backNews+");</script>");
        }

        catch (FileUploadException e) {
            e.printStackTrace();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("sucReg.jsp");
        dispatcher.forward(request,response);
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        doPost(request,response);
    }

}

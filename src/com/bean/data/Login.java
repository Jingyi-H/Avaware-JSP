package com.bean.data;
import java.util.*;

public class Login {
    String logname = "", backNews = "未登录";
    LinkedList<String> cart;

    public Login(){
        cart = new LinkedList<String>();
    }

    public void setLogname(String logname){
        this.logname = logname;
    }

    public String getLogname() {
        return logname;
    }

    public String getBackNews() {
        return backNews;
    }

    public void setBackNews(String backNews) {
        this.backNews = backNews;
    }

    public LinkedList<String> getCart() {
        return cart;
    }

    public int getCartLength(){
        return cart.size();
    }
}

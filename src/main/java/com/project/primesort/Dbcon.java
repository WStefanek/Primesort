package com.project.primesort;

import java.sql.*;

public class Dbcon {
    private String url;
    private String username;
    private String password;
    public ResultSet rs;
    Connection con;
    PreparedStatement stmt;

    public Dbcon() {
        url = "jdbc:mysql://localhost:3306/primesort";
        username = "root";
        password = "";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
            con = DriverManager.getConnection(url, username, password);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }


    public void query(String sql) {
        try {
            stmt = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = stmt.executeQuery();
        } catch (SQLException throwables){
            throwables.printStackTrace();
            System.out.println("Wyjątek SQL");
        }
    }

    public int update(String sql){
        int i = 0;
        try {
            stmt = con.prepareStatement(sql);
            i = stmt.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return i;
    }

    public void close(){
        try {
            con.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

}

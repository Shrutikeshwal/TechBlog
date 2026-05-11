package com.tech.blog.dao;

import com.tech.blog.entities.User;

import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    public boolean saveUser(User user) {

        boolean f = false;

        try {

            // First check if email already exists
            String checkQuery = "SELECT * FROM user WHERE email = ?";
            PreparedStatement checkStmt = this.con.prepareStatement(checkQuery);
            checkStmt.setString(1, user.getEmail());

            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Email already exists
                System.out.println("Email already registered");
                return false;
            }

            // user --> database
            String query = "INSERT INTO user(name,email,password,gender,about) VALUES(?,?,?,?,?)";
            PreparedStatement pst = this.con.prepareStatement(query);

            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPassword());
            pst.setString(4, user.getGender());
            pst.setString(5, user.getAbout());

            pst.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Registration failed: " + e.getMessage());
        }

        return f;
    }
    //get user by useremail and userpassword

    public User getUserByEmailandpassword(String email, String password) {
        User user = null;

        try {

            String query = "select*from user where email =? and password=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet set = pst.executeQuery();

            if (set.next()) {
                user = new User();
                //Data from db
                String name = set.getString("name");
                //set data to user obj
                user.setName(name);

                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));


            }
        } catch (Exception e) {
            e.printStackTrace();
        }return user;
    }
    public boolean updateUser(User user){
boolean f = false;
        try {

            String query = "update user set name=? , email=? , password=? ,gender=?,about=?,profile=? where id=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3,user.getPassword());
            pst.setString(4, user.getGender());
            pst.setString(5, user.getAbout());
            pst.setString(6,user.getProfile());
            pst.setInt(7,user.getId());

            pst.executeUpdate();
            f = true;
        }catch (Exception e){
            e.printStackTrace();
        }return f;
    }
    public User getUserByUserId(int postId) throws SQLException{
        User user= null;

        try{
            String q = "select *from user where id=?";
            PreparedStatement pst = this.con.prepareStatement(q);

            ResultSet set = pst.executeQuery();
            user = new User();
            //Data from db
            String name = set.getString("name");
            //set data to user obj
            user.setName(name);

            user.setId(set.getInt("id"));
            user.setEmail(set.getString("email"));
            user.setPassword(set.getString("password"));
            user.setGender(set.getString("gender"));
            user.setAbout(set.getString("about"));
            user.setDateTime(set.getTimestamp("rdate"));
            user.setProfile(set.getString("profile"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}

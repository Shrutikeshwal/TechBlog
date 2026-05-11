package com.tech.blog.dao;

import ch.qos.logback.core.joran.action.AppenderRefAction;
import com.tech.blog.helper.ConnectionProvider;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeDao {

    Connection con ;
    public LikeDao(Connection con){
        this.con = con;
    }
    public boolean insertLike(int pid,int uid){

        boolean f = false;
        try{
            String q = "insert into likes(pid,uid)values(?,?)";
            PreparedStatement pst = this.con.prepareStatement(q);

            //value set...
            pst.setInt(1,pid);
            pst.setInt(2,uid);
            pst.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }return f;
    }
    public int countLikeOnPost(int pid){
        int count = 0;

        String q = "select count(*) from likes where pid=?";
        try{

            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1,pid);
            ResultSet rst = p.executeQuery();
            if(rst.next()){
                count = rst.getInt("count(*)");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }


        return count;
    }

    public boolean isLikedByUser(int pid,int uid){
        boolean f = false;
        try{
            PreparedStatement p = this.con.prepareStatement("select * from likes where pid=? and uid=?");
            p.setInt(1,pid);
            p.setInt(2,uid);
            ResultSet rst = p.executeQuery();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    public boolean deleteLike(int pid,int uid){
        boolean f = false;
        try {
            PreparedStatement p = this.con.prepareStatement("delete from likes where pid=? and uid=?");

            p.setInt(1,pid);
            p.setInt(2,uid);
            p.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }return f;
    }

}

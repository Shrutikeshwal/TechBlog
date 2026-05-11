package com.tech.blog.dao;
import com.tech.blog.entities.Categories;
import com.tech.blog.entities.Post;
import com.tech.blog.helper.ConnectionProvider;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    Connection con;

    public PostDao(Connection con){
        this.con = con;
    }
    public ArrayList<Categories> getAllCategoriess(){
        ArrayList<Categories>list = new ArrayList<>();

        try{
            String q = "select *from categories";
            Statement st = this.con.createStatement();
            ResultSet rst = st.executeQuery(q);
            while (rst.next()){
                int cid = rst.getInt("cid");
                String name = rst.getString("name");
                String desciption = rst.getString("description");
                Categories c = new Categories(cid,name, desciption);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public boolean savePost(Post p){
        boolean f = false;
        try{

            String q = "insert into post(pTitle,pContent,pCode,pPIc.catId,userId values(?,?,?,?,?,?,)";
            PreparedStatement pst = con.prepareStatement(q);
            pst.setString(1,p.getpTitle());
            pst.setString(2,p.getpContent());
            pst.setString(3,p.getpCode());
            pst.setString(4,p.getpPic());
            pst.setInt(5,p.getCatId());
            pst.setInt(6,p.getUserId());

            pst.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }return f;
    }
    //get all the post
    public List<Post> getAllPosts() throws SQLException {
        List<Post> list = new ArrayList<>();
        //fetch all the post


            try (PreparedStatement p = con.prepareStatement("Select * from post order by pid desc")) {
                ResultSet rst = p.executeQuery();
                while (rst.next()) {
                    int pid = rst.getInt("pid");
                    String pTitle = rst.getString("pTitle");
                    String pContent = rst.getString("pContent");
                    String pPic = rst.getString("pPic");
                    String pCode = rst.getString("pCode");
                    Timestamp date = rst.getTimestamp("pDate");
                    int catId = rst.getInt("catId");

                    int userId = rst.getInt("userId");
                    Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                    list.add(post);

                }
            } catch (Exception e) {
                e.printStackTrace();


        }
        return list;
    }

    public List<Post> getPostByCatId(int catId){
        List<Post> list = new ArrayList<>();
        //fetch all the post by id

        try (PreparedStatement p = con.prepareStatement("Select * from post where catId=?")) {
            p.setInt(1,catId);
            ResultSet rst = p.executeQuery();
            while (rst.next()) {
                int pid = rst.getInt("pid");
                String pTitle = rst.getString("pTitle");
                String pContent = rst.getString("pContent");
                String pPic = rst.getString("pPic");
                String pCode = rst.getString("pCode");
                Timestamp date = rst.getTimestamp("pDate");


                int userId = rst.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);

            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        return list;
    }
    public Post getPostByPostId(int postId){
        Post post = null;
        String q = "select * from post where pid=?";

        try{
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1,postId);
            ResultSet rst = p.executeQuery();
            if(rst.next()){
                int pid = rst.getInt("pid");
                String pTitle = rst.getString("pTitle");
                String pContent = rst.getString("pContent");
                String pPic = rst.getString("pPic");
                String pCode = rst.getString("pCode");

                Timestamp date = rst.getTimestamp("pDate");
                int catId = rst.getInt("catId");
                int userId = rst.getInt("userId");

                post = new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return post;

    }
}

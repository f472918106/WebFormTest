<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using System.Data.Sql;  //访问sqlserver必加
using System.Data;  //访问sqlserver必加
using System.Data.SqlClient;    //访问sqlserver必加


public class Handler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string username = context.Request["username"];
        //html中文本框为空，返回值为“”空串而不是null
        string passwd = context.Request["passwd"];
        string answer = context.Request["answer"];
        //取到的是answer对应value属性值
        string lesson = context.Request["lesson"];
        //当html中一个checkbox没有被选中，返回值为null
        string []splitLesson=lesson.Split(new char[1] { ','});
        //用split以逗号为标志分割lesson，存入新字符串数组
        string hobby = context.Request["hobby"];
        string information = context.Request["information"].Replace("\n","<br>");
        //用<br>替换\n
        string informationOperated = information.Replace("<br>", "");
        //用空字符串替换<br>

        context.Response.ContentType = "text/plain";
        //设置response编码格式

        string connString = @"Data Source=DESKTOP-BG6JJLQ;Database=Test;Integrated Security=true";
        //数据库连接字符串  
        SqlConnection conn = new SqlConnection(connString);
        //创建数据库连接实例
        try
        {
            conn.Open();
            //打开数据库连接

            //string sql = "insert into student (Id,username,answer,hobby) values('" + Guid.NewGuid().ToString() + "','" + username + "','" + answer + "','" + hobby + "')";
            //sql语句

            //SqlCommand sqlcommand = new SqlCommand(sql,conn);
            //创建数据库命令实例

            string sqlStr_InsertStudent = "insert into student (Id,username,answer,hobby) values(@Id,@username,@answer,@hobby)";
            string sqlStr_SelectId = "select Id from student where username='" + username + "'";
            SqlCommand sqlcommand_InsertStudent = new SqlCommand(sqlStr_InsertStudent, conn);
            SqlCommand sqlcommand_SelectId = new SqlCommand(sqlStr_SelectId, conn);
            sqlcommand_InsertStudent.Parameters.Add(new SqlParameter("@username",username));
            sqlcommand_InsertStudent.Parameters.Add(new SqlParameter("@answer", answer));
            sqlcommand_InsertStudent.Parameters.Add(new SqlParameter("@hobby", hobby));
            sqlcommand_InsertStudent.Parameters.Add(new SqlParameter("@Id",Guid.NewGuid().ToString()));
            //生成唯一32位id插入
            if (sqlcommand_InsertStudent.ExecuteNonQuery() != 0)
            {
                context.Response.Write("student表信息插入成功\n");
                if (sqlcommand_SelectId.ExecuteScalar() != null)
                {
                    string IdFromStudent = (string)sqlcommand_SelectId.ExecuteScalar();
                    context.Response.Write("student表中已存在此学生，Id为" + IdFromStudent + "\n");
                    int flag = 0;
                    foreach (string i in splitLesson)
                    {
                        //遍历新字符串数组splitLesson,将同名checkbox传入的多个value插入数据库不同项
                        string sqlStr_InsertCourse = "insert into course (course_Id,student_Id,lesson) values('" + Guid.NewGuid().ToString() + "','" + IdFromStudent + "','" + i + "')";
                        SqlCommand sqlcommand_InsertCourse = new SqlCommand(sqlStr_InsertCourse, conn);
                        if(sqlcommand_InsertCourse.ExecuteNonQuery()!=0)
                        {
                            flag++;
                            //flag标志插入course表是否成功
                        }
                    }
                    if(flag>0)
                    {
                        context.Response.Write("course表信息插入成功\n");
                    }
                }
            }
        }
        catch(Exception e)
        {
            context.Response.Write(e.Message);
            //输出错误信息e.Message
            context.Response.End();
        }
        finally
        {
            conn.Close();
        }

        context.Response.Write("账号:" + username+"\n");
        context.Response.Write("密码:" + passwd+"\n");
        if(username==passwd)
        {
            context.Response.Write("一致"+"\n");
        }
        else
        {
            context.Response.Write("不一致"+"\n");
        }
        context.Response.Write("回答是" + answer+"\n");
        context.Response.Write("选中的课程是" + lesson+"\n");
        context.Response.Write("爱好是" + hobby+"\n");
        context.Response.Write("个人简介:" + "\n" + informationOperated);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }
}
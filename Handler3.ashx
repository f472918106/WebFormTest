<%@ WebHandler Language="C#" Class="Handler3" %>

using System;
using System.Web;
using System.Data.Sql;  //访问sqlserver必加
using System.Data;  //访问sqlserver必加
using System.Data.SqlClient;    //访问sqlserver必加


public class Handler3 : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string connString = @"Data Source=DESKTOP-BG6JJLQ;Database=Test;Integrated Security=true";
        //数据库连接字符串
        SqlConnection conn = new SqlConnection(connString);
        //创建数据库连接实例
        context.Response.ContentType = "text/html";
        //设置输出流编码方式为html
        try
        {
            //作业：显示course表信息，不显示student_Id显示username
            conn.Open();
            //打开数据库链接
            string sql_SelectStudent = "select * from student";
            string sql_SelectCourse = "select username as name, course_Id, lesson from course, student where course.student_Id=student.Id";
            SqlCommand sqlcommand_SelectStudent = new SqlCommand(sql_SelectStudent, conn);
            SqlCommand sqlcommand_SelectCourse = new SqlCommand(sql_SelectCourse, conn);
            //创建命令实例
            SqlDataAdapter adapter_SelectStudent = new SqlDataAdapter(sqlcommand_SelectStudent);
            SqlDataAdapter adapter_SelectCourse = new SqlDataAdapter(sqlcommand_SelectCourse);
            //用一个DataSet接收命令查询结果
            DataTable table_SelectStudent =new DataTable();
            DataTable table_SelectCourse = new DataTable();
            //创建数据表实例
            adapter_SelectStudent.Fill(table_SelectStudent);
            adapter_SelectCourse.Fill(table_SelectCourse);
            //用adapter获取的DataSet填充table
            context.Response.ContentType = "text/html";
            context.Response.Write("<html><body>");
            //返回一个网页
            foreach (DataRow row in table_SelectStudent.Rows)
            {
                context.Response.Write("用户名：" + row["username"] + "&nbsp&nbsp");
                //row["username"]表示列名对应的数据项
                context.Response.Write("爱好：" + row["hobby"] + "<BR>");
            }
            foreach(DataRow row in table_SelectCourse.Rows)
            {
                context.Response.Write("姓名：" + row["name"] + "&nbsp&nbsp");
                context.Response.Write("选课记录：" + row["course_Id"] + "&nbsp&nbsp");
                context.Response.Write("课程名：" + row["lesson"] + "<BR>");
            }
            context.Response.Write("</body></html>");
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
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}

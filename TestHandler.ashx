<%@ WebHandler Language="C#" Class="TestHandler" %>

using System;
using System.Web;
using System.Data.Sql;  //访问sqlserver必加
using System.Data;  //访问sqlserver必加
using System.Data.SqlClient;    //访问sqlserver必加


public class TestHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string username = context.Request["user"];
        string connString = @"Data Source=DESKTOP-9GAHG02;Database=test;Integrated Security=true";
        SqlConnection conn = new SqlConnection(connString);
        try
        {
            conn.Open();
            //打开数据库链接
            string sql_SelectStudent = "select * from student where username='"+username+"'";
            //查询字符串
            SqlCommand sqlcommand_SelectStudent = new SqlCommand(sql_SelectStudent, conn);
            //创建命令实例
            SqlDataAdapter adapter_SelectStudent = new SqlDataAdapter(sqlcommand_SelectStudent);
            //用一个DataSet接收命令查询结果
            DataTable table_SelectStudent =new DataTable();
            //创建数据表实例
            adapter_SelectStudent.Fill(table_SelectStudent);
            //填充table_SelectStudent
            if(table_SelectStudent.Rows.Count>0)
            {
                context.Response.Write("No");
            }
            else
            {
                context.Response.Write("OK");
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
        context.Response.ContentType = "text/plain";
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
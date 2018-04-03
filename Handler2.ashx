<%@ WebHandler Language="C#" Class="Handler2" %>

using System;
using System.Web;

public class Handler2 : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //设置输出流编码格式为纯文本text

        /* 单文件上传
         * HttpPostedFile files = HttpContext.Current.Request.Files["files"];
         * if (files == null)
         * {
         *     context.Response.Write("请选择文件上传");
         * }
         * else
         * {
         *     string savepath = context.Server.MapPath("pictures")+"\\"+files.FileName;
         *     files.SaveAs(savepath);
         *     context.Response.Write("保存成功" + files.FileName);
         * } 
         */

        HttpFileCollection files = HttpContext.Current.Request.Files;
        //用HttpFileCollection组织接收到的文件，生成files数组
        if (files.Count == 0)
        {
            context.Response.Write("请选择文件上传");
        }
        else
        {
            for (int i = 0; i < files.Count; i++)
            {
                //通过遍历实现对file数组中指向的多个文件依次存取
                HttpPostedFile postedFile = files[i];
                //提供对当前单个文件的访问
                string savePath = context.Server.MapPath("files") + "\\" + postedFile.FileName;
                //MapPath获取Web服务器后台指定文件目录地址
                postedFile.SaveAs(savePath);
                //在指定路径保存文件的内容
                context.Response.Write("文件"+postedFile.FileName+"上传成功");
            }
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
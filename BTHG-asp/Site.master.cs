using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Site : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //read maintenance
        string strPathFolder = Server.MapPath(Global.PATH_FILES);
        StreamReader stream = File.OpenText(strPathFolder +"maintenance.txt");
        String status = stream.ReadLine();
        stream.Close();
        if ("1".Equals(status))
        {
            //under maintenance
            Response.Redirect("~/Maintenance.aspx");
        }        
    }
}

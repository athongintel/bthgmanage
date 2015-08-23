using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Maintenance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strPathFolder = Server.MapPath(Global.PATH_FILES);
        StreamReader stream = File.OpenText(strPathFolder + "maintenance.txt");
        String status = stream.ReadLine();
        String time = stream.ReadLine();
        stream.Close();
        lbTime.Text = time;
    }
}
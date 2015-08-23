using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Secretary_Secretary : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Authentication auth = (Authentication)Session[Global.LOGIN];
            if (auth == null || auth.Privilege != Authentication.SECRETARY)
            {
                auth = new Authentication(Authentication.VISITOR);
                Response.Redirect("~/Login.aspx", true);
            }
            lbUserName.Text = auth.Username;
            lbToday.Text = Global.getCurrentDateTime().ToLongDateString() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        }
    }

    protected void lkbLogout_Click(object sender, EventArgs e)
    {
        Authentication auth = (Authentication)Session[Global.LOGIN];
        auth.Privilege = Authentication.VISITOR;
        Response.Redirect("~/Default.aspx", true);
    }
}

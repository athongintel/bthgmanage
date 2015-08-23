using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Manage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Authentication auth = (Authentication)Session[Global.LOGIN];
            if (auth==null || auth.Privilege == Authentication.VISITOR)
            {
                //redirect
                Response.Redirect("~/Login.aspx");
            }
        }
    }

    protected void btBack_Click(object sender, EventArgs e)
    {
        Authentication auth = (Authentication)Session[Global.LOGIN];
        if (auth == null)
        {
            Response.Redirect("~/Login.aspx", true);
        }
        else
        {
            if (auth.Privilege == Authentication.DIRECTOR)
            {
                Response.Redirect("~/Manage/Director/Default.aspx");
            }
            else if (auth.Privilege == Authentication.SECRETARY)
            {
                Response.Redirect("~/Manage/Secretary/Default.aspx");
            }
            else
            {
                Response.Redirect("~/Login.aspx", true);
            }
        }
    }
}

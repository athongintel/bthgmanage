using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string infolocation=Server.MapPath(Global.PATH_INFO);
            //load company info
            string[] info = System.Text.Encoding.Unicode.GetString(System.IO.File.ReadAllBytes(infolocation)).Split(new[] { "\n" }, StringSplitOptions.None);
            lbName.Text = info[1]!=null? info[1].Trim():"";
            lbDomain.Text = info[2]!=null? info[2].Trim():"";
            lbInfo.Text = info[3]!=null? info[3].Trim():"";
            lbAddress.Text = info[4]!=null?info[4].Trim():"";
        }
    }
    protected void btEdit_Click(object sender, EventArgs e)
    {
        btEdit.Visible = false;
        btSave.Visible = true;
        btCancel.Visible = true;

        txtName.Visible = true;
        txtDomain.Visible = true;
        txtInfo.Visible = true;
        txtAddress.Visible = true;

        txtName.Text = lbName.Text;
        txtDomain.Text = lbDomain.Text;
        txtInfo.Text = lbInfo.Text;
        txtAddress.Text = lbAddress.Text;

        lbName.Visible = false;
        lbDomain.Visible = false;
        lbInfo.Visible = false;
        lbAddress.Visible = false;
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        //save info       

        lbName.Text=txtName.Text.Trim();
        lbDomain.Text=txtDomain.Text.Trim();
        lbInfo.Text=txtInfo.Text.Trim();
        lbAddress.Text=txtAddress.Text.Trim();

        string info = "[company info]\n" +lbName.Text + "\n"
            + lbDomain.Text + "\n"
            + lbInfo.Text + "\n"
            + lbAddress.Text;
        System.IO.File.WriteAllText(Server.MapPath(Global.PATH_INFO),info,System.Text.Encoding.Unicode);

        btCancel_Click(null,null);
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        btEdit.Visible = true;
        btSave.Visible = false;
        btCancel.Visible = false;

        lbName.Visible = true;
        lbDomain.Visible = true;
        lbInfo.Visible = true;
        lbAddress.Visible = true;

        txtName.Visible = false;
        txtDomain.Visible = false;
        txtInfo.Visible = false;
        txtAddress.Visible = false;
    }
}
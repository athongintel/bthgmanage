using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_Account : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        pnAdd.Visible = false;
        btCancel.Visible = false;
        btAdd.Visible = true;

        txtUsername.Text = ".";
        txtPassword.Text = ".";
        txtRePassword.Text = ".";

    }
    protected void btAdd_Click(object sender, EventArgs e)
    {
        pnAdd.Visible = true;
        txtUsername.Text = "";
        txtPassword.Text = "";
        txtRePassword.Text = "";
        liStaff.DataBind();
    }
    protected void btAddAccount_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        tbLogin login = new tbLogin();
        login.Username = txtUsername.Text.Trim();
        //check username
        if (db.tbLogin.Count(x => x.Username.Equals(login.Username)) > 0)
        {
            Response.Write("<script>alert('Tên tài khoản đã được sử dụng!')</script");
        }
        else
        {
            login.Password = txtPassword.Text;
            login.IDStaff = Int32.Parse(liStaff.SelectedValue);
            login.Role = Int32.Parse(liRole.SelectedValue);
            db.tbLogin.InsertOnSubmit(login);
            db.SubmitChanges();
            GridView1.DataBind();
            btCancel_Click(null, null);
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_Login : System.Web.UI.UserControl
{
    static BTHGDataContext db;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btLogin_Click(object sender, EventArgs e)
    {
        db = new BTHGDataContext();
        string username = tbUserName.Text.Trim();
        string password = tbPassword.Text.Trim();
        tbLogin l = null;
        l = db.tbLogins.FirstOrDefault(x=>x.Username.Equals(username));
        if (l == null)
        {
            Response.Write("<script>alert('Tài khoản không tồn tại!')</script>");
        }
        else if (!l.Password.Equals(password))
        {
            Response.Write("<script>alert('Sai mật khẩu!')</script>");
        }
        else
        {
            //chuyen trang
            int role = l.Role;
            Authentication auth = new Authentication(role);
            auth.Username = l.Username;
            auth.IDStaff = l.IDStaff;
            Session[Global.LOGIN] = auth;
            switch (role)
            {
                case Authentication.DIRECTOR:
                    Response.Redirect("~/Manage/Director/Default.aspx",true);
                    break;
                case Authentication.SECRETARY:
                    Response.Redirect("~/Manage/Secretary/Default.aspx",true);
                    break;
            }
        }
    }
}
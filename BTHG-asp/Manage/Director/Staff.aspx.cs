using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_Staff : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridView1.DataBind();
        }
    }
    protected void btAdd_Click(object sender, EventArgs e)
    {
        pnAdd.Visible = true;
        btAdd.Visible = false;
        btCancel.Visible = true;
    }
    protected void btAddStaff_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        tbStaff staff = new tbStaff();
        staff.Name = txtName.Text.Trim();
        staff.Position = txtPosition.Text.Trim();
        staff.Email = txtEmail.Text.Trim();
        staff.Tel = txtTel.Text.Trim();
        db.tbStaffs.InsertOnSubmit(staff);
        db.SubmitChanges();
        GridView1.DataBind();
        btCancel_Click(null, null);
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        txtName.Text = "";
        txtPosition.Text = "";
        txtEmail.Text = "";
        txtTel.Text = "";
        btCancel.Visible = false;
        btAdd.Visible = true;
        pnAdd.Visible = false;
    }
}
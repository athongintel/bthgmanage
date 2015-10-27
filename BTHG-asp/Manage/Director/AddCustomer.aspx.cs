using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_AddCustomer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }
    protected void btAddCustomer_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();

        tbCustomer customer = new tbCustomer();
        customer.Name = txtName.Text;
        customer.CustomerCode = txtCustomerCode.Text;
        if (db.tbCustomer.Count(x=>x.Name.Equals(customer.Name))>0)
        {
            Response.Write("<script>alert('Tên khách hàng bị trùng!')</script>");
        }
        else if (db.tbCustomer.Count(x=>x.CustomerCode.Equals(customer.CustomerCode))>0)
        {
            Response.Write("<script>alert('Mã khách hàng bị trùng!')</script>");
        }
        else
        {
            customer.Address = txtAddress.Text;
            customer.Fax = txtFax.Text;
            customer.Tel = txtTel.Text;
            customer.TaxNumber = txtTaxNumber.Text;

            db.tbCustomer.InsertOnSubmit(customer);
            db.SubmitChanges();
            Response.Redirect("~/Manage/Customer.aspx");
        }
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Manage/Customer.aspx");
    }
}
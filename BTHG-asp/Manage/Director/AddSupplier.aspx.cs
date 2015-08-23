using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_AddSupplier : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btAdd_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        tbSupplier supplier = new tbSupplier();
        supplier.Name = txtName.Text.Trim();
        supplier.BankAddress = txtBankAddress.Text.Trim();
        supplier.Bank = txtBank.Text.Trim();
        supplier.Address = txtAddress.Text.Trim();
        supplier.Tel = txtTel.Text.Trim();
        supplier.IBAN = txtIBAN.Text.Trim();
        supplier.SWIFT = txtSWIFT.Text.Trim();
        supplier.Website = txtWebsite.Text.Trim();

        db.tbSuppliers.InsertOnSubmit(supplier);
        db.SubmitChanges();
        Response.Redirect("~/Manage/Supplier.aspx");
    }
}
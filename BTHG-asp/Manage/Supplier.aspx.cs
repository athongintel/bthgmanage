using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_Supplier : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            //check privilege
            if (Session[Global.LOGIN] != null)
            {
                Authentication auth = (Authentication)Session[Global.LOGIN];
                if (auth.Privilege == Authentication.DIRECTOR)
                {
                    btEdit.Visible = true;
                    btAddContact.Visible = Global.isAdmin();
                }
            }
            liSupplier.DataBound += liSupplier_DataBound;
            liSupplier.DataBind();            
        }
    }

    void liSupplier_DataBound(object sender, EventArgs e)
    {
        if (Request.QueryString["IDSupplier"] != null)
        {
            liSupplier.SelectedValue = Request.QueryString["IDSupplier"];
        }
        updateInfo();
    }

    private void updateInfo()
    {
        if (!"".Equals(liSupplier.SelectedValue))
        {
            BTHGDataContext db = new BTHGDataContext();
            tbSupplier supplier = db.tbSupplier.Single(x => x.IDSupplier.ToString().Equals(liSupplier.SelectedValue));
            lbName.Text = supplier.Name;
            lbBank.Text = supplier.Bank;
            lbBankAddress.Text = supplier.BankAddress;
            lbAddress.Text = supplier.Address;
            lbTel.Text = supplier.Tel;
            lbSWIFT.Text = supplier.SWIFT;
            lbIBAN.Text = supplier.IBAN;
            lbWebsite.Text = supplier.Website;
            loadContact();
        }
        else
        {
            btEdit.Visible = false;
        }
    }


    protected void liSupplier_SelectedIndexChanged(object sender, EventArgs e)
    {
        updateInfo();
    }
    protected void btEdit_Click(object sender, EventArgs e)
    {
        RequiredFieldValidator2.Visible = true;
        btEdit.Visible = false;
        btSave.Visible = true;
        btCancel.Visible = true;

        lbName.Visible = false;
        lbBank.Visible = false;
        lbAddress.Visible = false;
        lbBankAddress.Visible = false;
        lbTel.Visible = false;
        lbSWIFT.Visible = false;
        lbIBAN.Visible = false;
        lbWebsite.Visible = false;

        txtEditName.Text = lbName.Text;
        txtEditBank.Text=lbBank.Text;
        txtEditBankAddress.Text=lbBankAddress.Text;
        txtEditAddress.Text=lbAddress.Text;
        txtEditTel.Text=lbTel.Text;
        txtEditSWIFT.Text=lbSWIFT.Text;
        txtEditIBAN.Text=lbIBAN.Text;
        txtEditWebsite.Text=lbWebsite.Text;

        txtEditName.Visible = true;
        txtEditBank.Visible = true;
        txtEditBankAddress.Visible = true;
        txtEditAddress.Visible = true;
        txtEditTel.Visible = true;
        txtEditSWIFT.Visible = true;
        txtEditIBAN.Visible = true;
        txtEditWebsite.Visible = true;

        liSupplier.Enabled = false;
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        RequiredFieldValidator2.Visible = false;
        btEdit.Visible = true;
        btSave.Visible = false;
        btCancel.Visible = false;

        lbName.Visible = true;
        lbBank.Visible = true;
        lbAddress.Visible = true;
        lbBankAddress.Visible = true;
        lbTel.Visible = true;
        lbSWIFT.Visible = true;
        lbIBAN.Visible = true;
        lbWebsite.Visible = true;

        txtEditName.Visible = false;
        txtEditBank.Visible = false;
        txtEditBankAddress.Visible = false;
        txtEditAddress.Visible = false;
        txtEditTel.Visible = false;
        txtEditSWIFT.Visible = false;
        txtEditIBAN.Visible = false;
        txtEditWebsite.Visible = false;

        liSupplier.Enabled = true;
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        tbSupplier supplier = db.tbSupplier.Single(x=>x.IDSupplier.ToString().Equals(liSupplier.SelectedValue));

        supplier.Name = txtEditName.Text.Trim();
        supplier.Bank = txtEditBank.Text.Trim();
        supplier.BankAddress = txtEditBankAddress.Text.Trim();
        supplier.Address = txtEditAddress.Text.Trim();
        supplier.Tel = txtEditTel.Text.Trim();
        supplier.SWIFT = txtEditSWIFT.Text.Trim();
        supplier.IBAN = txtEditIBAN.Text.Trim();
        supplier.Website = txtEditWebsite.Text.Trim();

        lbName.Text = supplier.Name;
        lbBank.Text = supplier.Bank;
        lbBankAddress.Text = supplier.BankAddress;
        lbAddress.Text = supplier.Address;
        lbTel.Text = supplier.Tel;
        lbSWIFT.Text = supplier.SWIFT;
        lbIBAN.Text = supplier.IBAN;
        lbWebsite.Text = supplier.Website;

        db.SubmitChanges();
        btCancel_Click(null, null);
    }

    protected void btAddContact_Click(object sender, EventArgs e)
    {
        btAddContact.Visible = false;
        btCancelAdd.Visible = true;
        pnAdd.Visible = true;
    }


    protected void btAdd_Click(object sender, EventArgs e)
    {
        if (!"".Equals(liSupplier.SelectedValue))
        {
            BTHGDataContext db = new BTHGDataContext();
            tbSupplierContact contact = new tbSupplierContact();
            contact.IDSupplier = Int32.Parse(liSupplier.SelectedValue);
            contact.Name = txtName.Text.Trim();
            contact.Email = txtEmail.Text.Trim();
            contact.Tel = txtTel.Text.Trim();
            db.tbSupplierContact.InsertOnSubmit(contact);
            db.SubmitChanges();
            btCancelAdd_Click(null, null);
            loadContact();
        }
    }
    protected void btCancelAdd_Click(object sender, EventArgs e)
    {
        btAddContact.Visible = true;
        btCancelAdd.Visible = false;
        pnAdd.Visible = false;
        txtName.Text = "";
        txtTel.Text = "";
        txtEmail.Text = "";
    }

    private void loadContact()
    {
        supplierContactDS.SelectParameters["IDSupplier"].DefaultValue = liSupplier.SelectedValue;
        GridView1.DataBind();
    }
}
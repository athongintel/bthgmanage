using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_Customer : System.Web.UI.Page
{
    int currenttab=0;
    string currentCustomerID;

    protected override void OnInit(EventArgs e)
    {
        listCustomer2.register(loadCustomerByID);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //check privilege
            if (Session[Global.LOGIN]!=null)
            {
                Authentication auth = (Authentication)Session[Global.LOGIN];
                if (auth.Privilege==Authentication.DIRECTOR)
                {
                    btEdit.Visible = true;
                    btAddContact.Visible = true;
                }
            }

            ViewState["currenttab"] = currenttab;
            ViewState["currentCustomerID"] = currentCustomerID;
            TabContainer1.ActiveTabIndex = currenttab;
            LoadComplete+=Manage_Director_Customer_Load;
        }        
    }

    private void Manage_Director_Customer_Load(object sender, EventArgs e)
    {
        if (TabContainer1.ActiveTabIndex == 0)
        {
            loadCustomerByID(listCustomer2.SelectedValue);
        }
    }

    private void loadCustomerByID(string ID)
    {
        BTHGDataContext db = new BTHGDataContext();
        ViewState["currentCustomerID"]=ID;
        tbCustomer customer = db.tbCustomer.FirstOrDefault(x => x.IDCustomer.ToString().Equals(ID));
        lbCustomerName.Text = customer.Name;
        lbAddress.Text = customer.Address;
        lbFax.Text = customer.Fax;
        lbTel.Text = customer.Tel;
        lbTaxNumber.Text = customer.TaxNumber;
        lbCustomerCode.Text = customer.CustomerCode;

        contactDS.SelectParameters["IDCustomer"].DefaultValue = ID;
        gvContact.DataBind();
    }


    protected void tabchanged(object sender, EventArgs e)
    {
        currenttab = TabContainer1.ActiveTabIndex;
        switch (currenttab)
        {
            case 0:
                break;
            case 2:
                break;
        }
    }

    protected void btAddContact_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        tbCustomerContact c = new tbCustomerContact();
        currentCustomerID = (string)ViewState["currentCustomerID"];
        c.FirstName = txtFirstName.Text;
        c.LastName = txtLastName.Text;
        c.Title = liTitle.SelectedValue;
        c.Tel = tbTel.Text;
        c.Position = tbPosition.Text;
        c.Commission = Int32.Parse(tbCommission.Text);
        c.Email = tbEmail.Text;
        c.IDCustomer = Int32.Parse(currentCustomerID);
        db.tbCustomerContact.InsertOnSubmit(c);
        db.SubmitChanges();
        pnAdd.Visible = false;
        btAddContact.Text = "Thêm contact";

        gvContact.DataBind();

    }

    protected void btAdd_Click(object sender, EventArgs e)
    {
        if (pnAdd.Visible)
        {
            btAddContact.Text = "Thêm người liên hệ";
            pnAdd.Visible = false;
        }
        else
        {
            btAddContact.Text = "Hủy";
            pnAdd.Visible = true;
            txtFirstName.Text = "";
            txtLastName.Text = "";
            tbTel.Text = "";
            tbPosition.Text = "";
            tbEmail.Text = "";
            pnAdd.Visible = true;
        }
    }

    protected void btEdit_Click(object sender, EventArgs e)
    {
        txtEditName.Text = lbCustomerName.Text;
        txtEditCode.Text = lbCustomerCode.Text;
        txtEditTel.Text = lbTel.Text;
        txtEditTax.Text = lbTaxNumber.Text;
        txtEditFax.Text = lbFax.Text;
        txtEditAddress.Text = lbAddress.Text;

        txtEditName.Visible=true;
        txtEditCode.Visible = true;
        txtEditAddress.Visible = true;
        txtEditFax.Visible = true;
        txtEditTax.Visible = true;
        txtEditTel.Visible = true;

        lbCustomerName.Visible=false;
        lbCustomerCode.Visible=false;
        lbTel.Visible = false;
        lbTaxNumber.Visible = false;
        lbAddress.Visible = false;
        lbFax.Visible = false;

        btEdit.Visible = false;
        btSave.Visible = true;
        btCancel.Visible = true;
    }
    protected void btCancel_Click1(object sender, EventArgs e)
    {
        txtEditName.Visible = false;
        txtEditCode.Visible = false;
        txtEditAddress.Visible = false;
        txtEditFax.Visible = false;
        txtEditTax.Visible = false;
        txtEditTel.Visible = false;

        lbCustomerName.Visible = true;
        lbCustomerCode.Visible = true;
        lbTel.Visible = true;
        lbTaxNumber.Visible = true;
        lbAddress.Visible = true;
        lbFax.Visible = true;

        btEdit.Visible = true;
        btSave.Visible = false;
        btCancel.Visible = false;
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        currentCustomerID = (string)ViewState["currentCustomerID"];
        BTHGDataContext db = new BTHGDataContext();
        tbCustomer customer = db.tbCustomer.Single(x => x.IDCustomer.ToString().Equals(currentCustomerID));
        if (!customer.Name.Equals(txtEditName.Text) && db.tbCustomer.Count(x => x.Name.Equals(txtEditName.Text)) > 0)
        {
            Response.Write("<script>alert('Tên khách hàng mới bị trùng!')</script>");
        }
        else if (!customer.CustomerCode.Equals(txtEditCode.Text) && db.tbCustomer.Count(x => x.CustomerCode.Equals(txtEditCode.Text)) > 0)
        {
            Response.Write("<script>alert('Mã khách hàng mới bị trùng!')</script>");
        }
        else
        {
            customer.Name = txtEditName.Text;
            customer.CustomerCode = txtEditCode.Text;
            customer.Fax = txtEditFax.Text;
            customer.TaxNumber = txtEditTax.Text;
            customer.Tel = txtEditTel.Text;
            customer.Address = txtEditAddress.Text;
            db.SubmitChanges();

            btCancel_Click1(null, null);
            lbCustomerName.Text = txtEditName.Text;
            lbCustomerCode.Text = txtEditCode.Text;
            lbTel.Text = txtEditTel.Text;
            lbTaxNumber.Text = txtEditTax.Text;
            lbAddress.Text = txtEditAddress.Text;
            lbFax.Text = txtEditFax.Text;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_Supplies : System.Web.UI.UserControl
{
    protected int productID;   

    public void viewMode(int IDProduct)
    {
        BTHGDataContext db = new BTHGDataContext();
        List<tbSupply> supplies;
        supplies = db.tbSupply.Where(x => x.IDProduct == IDProduct).ToList();
        if (supplies.Count==0)
        {
            lbNoInfo.Visible = true;
        }
        else
        {
            pnViewMode.Visible = true;
            rptView.DataSource = supplies;
            rptView.DataBind();
        }
    }

    public void editMode(int IDProduct)
    {
        BTHGDataContext db = new BTHGDataContext();
        productID = IDProduct;
        ViewState["IDProduct"] = IDProduct;
        pnEditMode.Visible = true;

        rptEdit.DataSource = db.tbSupplier.Where(x => true).ToList();
        rptEdit.DataBind();
    }

    public void save()
    {
        BTHGDataContext db = new BTHGDataContext();
        productID = (int)ViewState["IDProduct"];
        //save

        foreach (RepeaterItem item in rptEdit.Items)
        {
            CheckBox c = (CheckBox)item.FindControl("ch");
            int IDSupplier = Int32.Parse(((HiddenField)item.FindControl("hidden")).Value);
            if (c.Checked)
            {
                 //check if item is already in collection
                tbSupply supply = db.tbSupply.FirstOrDefault(x => x.IDProduct == productID && x.IDSupplier == IDSupplier);
                if (supply==null)
                {
                    //insert new
                    tbSupply newSupply = new tbSupply();
                    newSupply.IDProduct = productID;
                    newSupply.IDSupplier = IDSupplier;
                    db.tbSupply.InsertOnSubmit(newSupply);
                }
            }
            else
            {
                //check if item is already in collection
                tbSupply supply = db.tbSupply.FirstOrDefault(x => x.IDProduct == productID && x.IDSupplier == IDSupplier);
                if (supply!=null)
                {
                    //remove
                    db.tbSupply.DeleteOnSubmit(supply);
                }
            }
        }
        db.SubmitChanges();
    }
}
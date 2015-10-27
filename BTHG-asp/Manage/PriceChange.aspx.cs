using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_PriceChange : System.Web.UI.Page
{
    BTHGDataContext db;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            liGroup.DataBound += liGroup_DataBound;
            liGroup.DataBind();            
        }
    }

    void liGroup_DataBound(object sender, EventArgs e)
    {
        loadType();
    }

    protected void liProductType_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadProduct();
    }

    private void loadProduct()
    {
        if (!"".Equals(liProductType.SelectedValue))
        {
            db = new BTHGDataContext();
            liProduct.DataSource = db.tbProduct.Where(x => x.IDProductType.ToString().Equals(liProductType.SelectedValue)).OrderBy(x=>x.Model).ToList();
            liProduct.DataBind();
            refreshList();
        }
    }
    protected void liProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        refreshList();
    }

    protected void refreshList()
    {
        db = new BTHGDataContext();
        if (!"".Equals(liProduct.SelectedValue))
        {            
            GridView1.DataSource = db.tbPriceHistory.Where(x => x.IDProduct.ToString().Equals(liProduct.SelectedValue)).OrderByDescending(x=>x.ChangeDate).ToList();            
        }
        else
        {
            GridView1.DataSource = null;
        }
        GridView1.DataBind();
    }

    protected string getStaffName(int IDStaff)
    {
        db = new BTHGDataContext();
        return db.tbStaff.Single(x => x.IDStaff==IDStaff).Name;
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
    protected void liGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadType();
    }

    protected void loadType()
    {
        if (!"".Equals(liGroup.SelectedValue))
        {
            BTHGDataContext db = new BTHGDataContext();
            liProductType.DataSource = db.tbProductType.Where(x => x.IDGroup.ToString().Equals(liGroup.SelectedValue)).OrderBy(x => x.Name);
            liProductType.DataBound += liProductType_DataBound;
            liProductType.DataBind();
        }
    }

    void liProductType_DataBound(object sender, EventArgs e)
    {
        loadProduct();
    }
}
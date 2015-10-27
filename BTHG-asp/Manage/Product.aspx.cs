using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_Product : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            liGroup.DataBound += ProductGroup1_DataBound;
            liGroup.DataBind();
        }
    }

    void ProductGroup1_DataBound(object sender, EventArgs e)
    {
        loadType();
    }

    protected void loadType()
    {
        if (!"".Equals(liGroup.SelectedValue))
        {
            BTHGDataContext db = new BTHGDataContext();
            liType.DataSource = db.tbProductType.Where(x=>x.IDGroup.ToString().Equals(liGroup.SelectedValue)).OrderBy(x=>x.Name);
            liType.DataBound += liType_DataBound;
            liType.DataBind();
        }
    }

    void liType_DataBound(object sender, EventArgs e)
    {
        loadBrand();
    }

    protected void loadBrand()
    {
        if (!"".Equals(liGroup.SelectedValue))
        {
            BTHGDataContext db = new BTHGDataContext();
            liBrand.DataSource = db.tbBrand.Where(x => db.tbProduct.Count(y => y.IDProductType.ToString().Equals(liType.SelectedValue) && y.IDBrand == x.IDBrand) > 0).OrderBy(x=>x.Name);
            liBrand.DataBind();            
        }
    }

    protected void btFindProduct_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        List<tbProduct> list;

        if (rbShowAll.Checked)
        {
            list = db.tbProduct.Where(x => true).OrderBy(x=>x.tbProductType.Name).ToList();
            GridView1.DataSource = list;
            GridView1.DataBind();
        }
        else if (rbShowByType.Checked)
        {
            if (!liBrand.SelectedValue.Equals(""))
            {
                list = db.tbProduct.Where(x => x.IDProductType.ToString().Equals(liType.SelectedValue) && x.IDBrand.ToString().Equals(liBrand.SelectedValue)).OrderBy(x=>x.tbProductType.Name).ToList();
                GridView1.DataSource = list;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
    }

    protected void lkbProductDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect(""+(sender as LinkButton).CommandArgument);
    }


    protected void btAddProduct_Click(object sender, EventArgs e)
    {
        Response.Redirect("");
    }

    protected void liGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadType();
    }
    protected void liType_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadBrand();
    }
}
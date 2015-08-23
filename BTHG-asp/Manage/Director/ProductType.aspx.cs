using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_ProductType : System.Web.UI.Page
{
    int currentTab = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridView3.DataBind();
            if (ViewState["currenttab"] != null)
                currentTab = (int)ViewState["currenttab"];
            TabContainer1.ActiveTabIndex = currentTab;            
            liGroup.DataBound += liGroup_DataBound;
            liGroup.DataBind();
        }

    }

    void liGroup_DataBound(object sender, EventArgs e)
    {
        loadProductType();
    }

    protected void loadProductType()
    {
        if (!"".Equals(liGroup.SelectedValue))
        {
            producttypeDS.SelectParameters["IDGroup"].DefaultValue = liGroup.SelectedValue;
            GridView1.DataBind();
        }
    }


    protected void btAddProductType_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        if (!txtProductType.Text.Equals(""))
        {
            tbProductType productType = new tbProductType();
            productType.Name = txtProductType.Text;
            productType.IDGroup = Int32.Parse(liGroup.SelectedValue);
            if (db.tbProductTypes.Count(x => x.Name.Equals(productType.Name)) > 0)
            {
                //product exist
                Response.Write("<script>alert('Loại sản phẩm đã tồn tại!')</script>");
            }
            else
            {
                db.tbProductTypes.InsertOnSubmit(productType);
                db.SubmitChanges();
                GridView1.DataBind();
            }
            txtProductType.Text = "";
        }
    }

    protected void btShowHide_Click(object sender, EventArgs e)
    {
        if (pnAdd.Visible)
        {
            btShowHide.Text = "Thêm thương hiệu";
            pnAdd.Visible = false;
            txtName.Text = "";
            txtOrigin.Text = "";
        }
        else
        {
            btShowHide.Text = "Đóng lại";
            pnAdd.Visible = true;
        }
    }
    protected void btAdd_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        tbBrand brand = new tbBrand();
        brand.Name = txtName.Text;
        //check
        if (db.tbBrands.Count(x => x.Name.Equals(brand.Name)) > 0)
        {
            Response.Write("<script>alert('Thương hiệu đã tồn tại!')</script>");
        }
        else
        {
            brand.Origin = txtOrigin.Text;
            db.tbBrands.InsertOnSubmit(brand);
            db.SubmitChanges();
            txtName.Text = "";
            txtOrigin.Text = "";
            GridView2.DataBind();
        }
    }
    protected void TabContainer1_ActiveTabChanged(object sender, EventArgs e)
    {
        currentTab = TabContainer1.ActiveTabIndex;
        switch (currentTab)
        {
            case 0:
                if (pnShowHide2.Visible)
                {
                    btShowhide2_Click(null, null);
                }
                if (pnAdd.Visible)
                {
                    btShowHide_Click(null, null);
                }
                break;
            case 1:
                if (pnAdd.Visible)
                {
                    btShowHide_Click(null, null);
                }
                if (pnGroup.Visible)
                {
                    btGroupCancel_Click(null, null);
                }                
                liGroup.DataBind();
                loadProductType();
                break;
            case 2:
                if (pnShowHide2.Visible)
                {
                    btShowhide2_Click(null, null);
                }
                if (pnGroup.Visible)
                {
                    btGroupCancel_Click(null, null);
                }
                break;
        }
        ViewState["currenttab"] = currentTab;
    }
    protected void btShowhide2_Click(object sender, EventArgs e)
    {
        if (pnShowHide2.Visible)
        {
            pnShowHide2.Visible = false;
            txtProductType.Text = "";
            btShowhide2.Text = "Thêm loại sản phẩm";
        }
        else
        {
            pnShowHide2.Visible = true;
            btShowhide2.Text = "Đóng lại";
        }
    }
    protected void btGroupCancel_Click(object sender, EventArgs e)
    {
        pnGroup.Visible = false;
        txtGroupName.Text = "";
        btAddGroup.Visible = true;
        btGroupCancel.Visible = false;
    }
    protected void btAddGroup_Click(object sender, EventArgs e)
    {
        pnGroup.Visible = true;
        btAddGroup.Visible = false;
        btGroupCancel.Visible = true;
    }
    protected void btAddGroup2_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        tbProductGroup group = new tbProductGroup();
        group.Name = txtGroupName.Text;
        //check if exist
        if (db.tbProductGroups.Count(x => x.Name.Equals(group.Name)) > 0)
        {
            Response.Write("<script>alert('Tên nhóm đã tồn tại')</script>");
        }
        else
        {
            db.tbProductGroups.InsertOnSubmit(group);
            db.SubmitChanges();
            GridView3.DataBind();
            btGroupCancel_Click(null, null);
        }

    }
    protected void liGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadProductType();
    }
}
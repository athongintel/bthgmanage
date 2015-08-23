using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_ProductGroup : System.Web.UI.UserControl
{
    public string SelectedValue
    {
        set
        {
            DropDownList1.SelectedValue = value;
        }
        get
        {
            return DropDownList1.SelectedValue;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DropDownList1.DataBind();
        }
    }
}
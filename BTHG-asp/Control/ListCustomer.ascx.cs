using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_ListCustomer : System.Web.UI.UserControl
{
    public delegate void oneIntParamDelegate(string ID);
    private event oneIntParamDelegate eventhandler;

    public string SelectedValue
    {
        get
        {
            return DropDownList1.SelectedValue;
        }
        set
        {
            DropDownList1.SelectedValue = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DropDownList1.DataBind();
        }
    }

    public void firstAction()
    {
        //eventhandler(DropDownList1.SelectedValue);
    }

    public void register(oneIntParamDelegate del)
    {
        //eventhandler = new oneIntParamDelegate(del);
        
        DropDownList1.AutoPostBack = true;
        eventhandler += new oneIntParamDelegate(del);
        Session["event"] = eventhandler;

    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        eventhandler = (oneIntParamDelegate)Session["event"];
        eventhandler(DropDownList1.SelectedValue);
    }
}
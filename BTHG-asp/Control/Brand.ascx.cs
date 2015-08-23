using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_Brand : System.Web.UI.UserControl
{
    public string SelectedValue
    {
        get
        {
            return liBrand.SelectedValue;
        }
        set
        {
            liBrand.SelectedValue = value;
        }
    }
}
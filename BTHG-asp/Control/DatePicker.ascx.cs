using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

public partial class Manage_DatePicker : System.Web.UI.UserControl
{
    public string Text
    {
        get
        {
            return getDateString();
        }
        set
        {
            tbDate.Text = value;
        }
    }

    public DateTime Date
    {
        set
        {
            tbDate.Text = value.ToString("dd-MM-yyyy");
        }
        get
        {
            return DateTime.ParseExact(getDateString(), "dd-MM-yyyy", CultureInfo.InvariantCulture);
        }
    }

    public bool ReadOnly
    {
        get
        {
            return tbDate.ReadOnly;
        }
        set
        {
            tbDate.Enabled = !value;
            Image2.Visible = !value;
        }
    }


    public string getDateString()
    {
        return tbDate.Text;
    }

    public void clear()
    {
        tbDate.Text = "";
    }
    protected void Image2_Click(object sender, EventArgs e)
    {

    }
}
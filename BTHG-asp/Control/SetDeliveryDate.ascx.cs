using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_SetDeliveryDate : System.Web.UI.UserControl
{
    private DateTime ddate;
    private string order;

    public DateTime DeliveryDate
    {
        set
        {
            lbDelivery.Visible = !value.Equals(DateTime.Parse("01-01-1010"));
            lbDelivery.Text = value.ToString("dd-MM-yyyy");
            lkbDelivery.Visible = !lbDelivery.Visible;
            ddate = value;
        }
        get
        {
            return ddate;
        }
    }

    public string orderNo
    {
        get
        {
            return order;
        }
        set
        {
            lbOrderNo.Text = value;
            order = value;
        }
    }


    protected void btSet_Click(object sender, EventArgs e)
    {
        //set orderdate
        BTHGDataContext db = new BTHGDataContext();
        tbSellingHistory order = db.tbSellingHistory.Single(x => x.OrderNo.Equals(lbOrderNo.Text));
        order.DeliveryDate = DatePicker1.Date;
        db.SubmitChanges();
        Response.Redirect("~/Manage/OrderList.aspx?IDCustomer="+order.tbCustomerContact.tbCustomer.IDCustomer);
    }
}
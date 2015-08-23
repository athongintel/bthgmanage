using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_SetOrderName : System.Web.UI.UserControl
{
    private DateTime ddate;
    private string order;

    public DateTime DeliveryDate
    {
        set
        {
            lkbDelivery.Visible = !value.Equals(DateTime.Parse("01-01-1010"));
            lkbDelivery.Text = value.ToString("dd-MM-yyyy");
            lkbDelivery.Visible = !lkbDelivery.Visible;
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
        tbSellingHistory order = db.tbSellingHistories.Single(x => x.OrderNo.Equals(lbOrderNo.Text));
        order.DeliveryDate = DatePicker1.Date;
        db.SubmitChanges();
        Response.Redirect("~/Manage/OrderList.aspx?IDCustomer="+order.tbCustomerContact.tbCustomer.IDCustomer);
    }
}
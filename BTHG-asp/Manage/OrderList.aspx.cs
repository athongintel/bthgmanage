using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_OrderList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {            
            DropDownList1.DataBind();
            LoadComplete += Manage_Director_OrderList_LoadComplete;
        }
    }

    void Manage_Director_OrderList_LoadComplete(object sender, EventArgs e)
    {
        if (Request.QueryString["IDCustomer"] != null)
        {
            DropDownList1.SelectedValue = Request.QueryString["IDCustomer"];
        }
        refreshList();
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        refreshList();
    }
    protected void refreshList()
    {        
        if (!"".Equals(DropDownList1.SelectedValue))
        {
            BTHGDataContext db = new BTHGDataContext();
            List<tbSellingHistory> listSH;
            listSH = db.tbSellingHistory.Where(x => x.IsHidden==0 && x.tbCustomerContact.tbCustomer.IDCustomer.ToString().Equals(DropDownList1.SelectedValue) && !x.Terms.Equals("")).OrderByDescending(x=>x.OrderDate).ToList();

            int soldcount=0;
            foreach (tbSellingHistory item in listSH)
            {
                if (item.DeliveryDate!=null)
                {
                    soldcount++;
                }
            }

            if (listSH.Count>0)
            {
                pnStat.Visible = true;
                lbSold.Text = soldcount.ToString();
                lbOrder.Text = listSH.Count.ToString();
            }
            else
            {
                pnStat.Visible = false;
            }

            GridView1.DataSource = listSH;           
        }
        else
        {
            GridView1.DataSource = null;
        }
        GridView1.DataBind();
    }

    protected void lbkDelete_Click(object sender, EventArgs e)
    {        
        string order = (sender as LinkButton).CommandArgument;
        BTHGDataContext db = new BTHGDataContext();
        //check datetime
        tbSellingHistory history = db.tbSellingHistory.Single(x => x.OrderNo.Equals(order));

        //remove all record in selling details
        db.tbSellingHistoryDetail.DeleteAllOnSubmit(db.tbSellingHistoryDetail.Where(x=>x.OrderNo.Equals(order)));
        //remove terms to save space
        history.Terms = "";
        history.IsHidden = 1;
        db.SubmitChanges();
        refreshList();
    }

    protected void lbkModify_Click(object sender, EventArgs e)
    {
        string orderNo = (sender as LinkButton).CommandArgument;
        BTHGDataContext db = new BTHGDataContext();

        tbSellingHistory order = db.tbSellingHistory.Single(x => x.OrderNo.Equals(orderNo));
        Response.Redirect("~/Manage/AddOrder.aspx?orderNo=" + orderNo, true);
    }
}
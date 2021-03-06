﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Manage_Director_AddOrder : System.Web.UI.Page
{
    protected static string[] terms;

    [Serializable]
    private class Info
    {
        public int Order
        { get; set; }
        public int IDProduct
        { get; set; }
        public string ProductType
        { get; set; }
        public String Name
        { get; set; }
        public int Quantity
        { get; set; }
        public String Model
        { get; set; }
        public String Note
        { get; set; }
        public double Scale
        { get; set; }
        public double Price
        { get; set; }
    }    

    List<Info> liDetails;
    String orderNo;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            liDetails = new List<Info>();
            ViewState["details"] = liDetails;            
            
            tbSellingHistory order=null;
            bool orderModify=false;

            //orderNo
            if (Request.QueryString!=null)
            {
                orderNo = Request.QueryString["orderNo"];
                if (orderNo!=null)
                {
                    //ok, we will replace older order based on this information
                    BTHGDataContext db = new BTHGDataContext();
                    order = db.tbSellingHistory.FirstOrDefault(x => x.OrderNo.Equals(orderNo));                    
                    if (order!=null)
                    {                        
                        liCustomer.Enabled = false; //disable the customer list because change in this field leads to change in ordernumber
                        ViewState["oldOrder"] = orderNo;
                        txtOrderName.Text = order.OrderName;
                        lbOrderNumber.Text = orderNo;
                        orderModify = true;
                        //add info of this order to details
                        List<tbSellingHistoryDetail> orderDetails = db.tbSellingHistoryDetail.Where(x => x.OrderNo.Equals(orderNo)).ToList();
                        foreach (tbSellingHistoryDetail detail in orderDetails)
                        {
                            Info info = new Info();
                            info.IDProduct = detail.IDProduct;
                            info.ProductType = detail.tbProduct.tbProductType.Name;
                            info.Quantity = detail.Quantity;
                            info.Note = detail.Note;
                            info.Model = detail.tbProduct.Model;
                            info.Scale = detail.Scale;
                            info.Price = detail.tbProduct.Price;
                            liDetails.Add(info);
                        }
                        refreshProductList();                        
                    }
                }
            }
            //          
            if (orderModify)
            {
                liCustomer.SelectedValue = order.tbCustomerContact.tbCustomer.IDCustomer.ToString();
                liContact.SelectedValue = order.tbCustomerContact.IDCustomerContact.ToString();
            }

            liGroup.DataBound += liGroup_DataBound;
            liCustomer.DataBound += liCustomer_DataBound;
            liCustomer.DataBind();
            liGroup.DataBind();           
        }
    }

    void liCustomer_DataBound(object sender, EventArgs e)
    {
        loadContact();
    }

    void liGroup_DataBound(object sender, EventArgs e)
    {
        loadType();
    }

    void liType_DataBound(object sender, EventArgs e)
    {
        loadBrand(liType.SelectedValue);
        refreshProductList();
    }

    public void loadType()
    {
        BTHGDataContext db = new BTHGDataContext();
        liType.DataSource = db.tbProductType.Where(x => x.IDGroup.ToString().Equals(liGroup.SelectedValue)).OrderBy(x=>x.Name);
        liType.DataBound += liType_DataBound;
        liType.DataBind();
    }

    public void loadContact()
    {
        BTHGDataContext db = new BTHGDataContext();
        liContact.DataSource = db.tbCustomerContact.Where(x => x.IDCustomer.ToString().Equals(liCustomer.SelectedValue)).OrderBy(x=>x.LastName);
        liContact.DataBind();
        
        //if this is a new order, we refresh the list
        if (ViewState["oldOrder"]==null) 
            updateOrderNumber(liCustomer.SelectedValue);
    }

    public void loadBrand(string ID)
    {
        BTHGDataContext db = new BTHGDataContext();
        liBrand.DataBound += liBrand_DataBound;
        if (!"".Equals(liType.SelectedValue))
        {            
            db = new BTHGDataContext();
            liBrand.DataSource = db.tbBrand.Where(x => db.tbProduct.Count(y => y.IDProductType.ToString().Equals(ID) && y.IDBrand == x.IDBrand) > 0).OrderBy(x=>x.Name);            
        }
        else
        {
            liBrand.DataSource = db.tbBrand.Where(x=>false);
        }
        liBrand.DataBind();        
    }

    void liBrand_DataBound(object sender, EventArgs e)
    {
        loadModel();
    }

    public void loadModel()
    {
        BTHGDataContext db = new BTHGDataContext();
        liProduct.DataBound += liProduct_DataBound;
        if (!"".Equals(liBrand.SelectedValue))
        {            
            db = new BTHGDataContext();
            liProduct.DataSource = db.tbProduct.Where(x => x.IDProductType.ToString().Equals(liType.SelectedValue) && x.IDBrand.ToString().Equals(liBrand.SelectedValue)).OrderBy(x => x.Model);            
        }
        else
        {
            liProduct.DataSource = db.tbProduct.Where(x=>false);
        }
        liProduct.DataBind();
    }

    void liProduct_DataBound(object sender, EventArgs e)
    {
        loadImage();
    }

    private void updateOrderNumber(string IDCustomer)
    {
        BTHGDataContext db = new BTHGDataContext();
        tbCustomer customer = db.tbCustomer.Single(x => x.IDCustomer.ToString().Equals(IDCustomer));
        int numberOfOrders = db.tbSellingHistory.Count(x => x.tbCustomerContact.IDCustomer.ToString().Equals(IDCustomer) && x.OrderDate.Year == Global.getCurrentDateTime().Year) + 1;
        string orderNo = customer.CustomerCode + "-" + fixLength(3, numberOfOrders) + "/" + Global.getCurrentDateTime().Year.ToString() + "-BG";
        lbOrderNumber.Text = orderNo;
    }

    private string fixLength(int length, int number)
    {
        string result = "";
        for (int i = 0; i < length - number.ToString().Length; i++)
        {
            result += "0";
        }
        return result + number.ToString();
    }

    protected void btAdd_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        string IDProduct = liProduct.SelectedValue;
        liDetails = (List<Info>)ViewState["details"];
        if (!"".Equals(IDProduct))
        {
            //check if exist
            db = new BTHGDataContext();            

            bool exist = false;
            foreach (Info info1 in liDetails)
            {
                if (info1.IDProduct.ToString().Equals(IDProduct))
                {
                    exist = true;
                    break;
                }
            }

            if (exist)
            {
                Response.Write("<script>alert('Sản phẩm đã có trong danh sách!')</script>");
            }
            else
            {
                tbProduct p = db.tbProduct.Single(x => x.IDProduct.ToString().Equals(liProduct.SelectedValue));
                Info info = new Info();
                info.IDProduct = p.IDProduct;
                info.ProductType = p.tbProductType.Name;
                info.Quantity = Int32.Parse(txtQuantity.Text);
                info.Note = txtNote.Text;
                info.Model = p.Model;
                info.Scale = Double.Parse(txtScale.Text);
                info.Price = p.Price;
                liDetails.Add(info);            
                refreshProductList();
            }       
        }
        else
        {
            Response.Write("<script>alert('Không có model thuộc loại này!')</script>");
        }
    }

    private void refreshProductList()
    {
        liDetails = (List<Info>)ViewState["details"];
        //refresh order
        for (int i = 0; i < liDetails.Count; i++)
        {
            Info info2 = liDetails.ElementAt(i);
            info2.Order = i + 1;
        }
        gvProduct.DataSource = liDetails;
        gvProduct.DataBind();     
    }

    protected void liCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadContact();
    }
    protected void liType_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadBrand(liType.SelectedValue);
    }
    protected void lkbRemove_Click(object sender, EventArgs e)
    {
        LinkButton lkb = sender as LinkButton;
        int order = Int32.Parse(lkb.CommandArgument);
        liDetails = (List<Info>)ViewState["details"];
        foreach (Info info in liDetails)
        {
            if (info.Order == order)
            {
                liDetails.Remove(info);
                break;
            }
        }
        refreshProductList();
    }

    protected void btSaveOrder_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();
        liDetails = (List<Info>)ViewState["details"];
        if (liDetails.Count == 0)
        {
            Response.Write("<script>alert('Báo giá chưa có sản phẩm nào!')</script>");
        }
        else
        {
            db = new BTHGDataContext();            
            tbSellingHistory history = new tbSellingHistory();
            Authentication auth = (Authentication)Session[Global.LOGIN];

            tbSellingHistory oldOrder=null;
            if (ViewState["oldOrder"]!=null)
            {
                oldOrder = db.tbSellingHistory.FirstOrDefault(x => x.OrderNo.Equals(ViewState["oldOrder"]));
            }

            if (oldOrder != null)
            {
                history.OrderNo = oldOrder.OrderNo;
                history.DeliveryDate = oldOrder.DeliveryDate;
                history.OrderDate = oldOrder.OrderDate;

                //remove old order
                db.tbSellingHistoryDetail.DeleteAllOnSubmit(db.tbSellingHistoryDetail.Where(x => x.OrderNo.Equals(oldOrder.OrderNo)));
                db.SubmitChanges();
                db.tbSellingHistory.DeleteOnSubmit(oldOrder);
                db.SubmitChanges();
            }
            else
            {
                history.OrderNo = lbOrderNumber.Text;
                history.DeliveryDate = null;
                history.OrderDate = Global.getCurrentDateTime();
            }            
            history.OrderName = txtOrderName.Text;
            history.IDCustomerContact = Int32.Parse(liContact.SelectedValue);
            history.IDStaff = auth.IDStaff;
                                  
            db.tbSellingHistory.InsertOnSubmit(history);

            //insert details
            foreach (Info info in liDetails)
            {
                tbSellingHistoryDetail detail = new tbSellingHistoryDetail();
                detail.OrderNo = history.OrderNo;
                detail.IDProduct = info.IDProduct;
                detail.Quantity = info.Quantity;
                detail.Note = info.Note;
                detail.Scale = info.Scale;
                detail.No = info.Order;
                db.tbSellingHistoryDetail.InsertOnSubmit(detail);
            }
            db.SubmitChanges();

            //forward
            Response.Redirect("~/Manage/OrderDetails.aspx?order=" + history.OrderNo, true);
        }
    }


    private void loadImage()
    {
        if (!"".Equals(liProduct.SelectedValue))
        {
            BTHGDataContext db = new BTHGDataContext();
            tbProduct p = db.tbProduct.Single(x => x.IDProduct.ToString().Equals(liProduct.SelectedValue));
            lbPrice.Text = Global.currencyFormat(p.Price);
            txtSpec.Text = p.Specification;
            if (p.Image1 != null)
            {
                imgProduct.ImageUrl = Global.PATH_PRODUCTIMAGE + p.Image1;
            }
            else
            {
                imgProduct.ImageUrl = Global.PATH_PRODUCTIMAGE + "noimage.jpg";
            }
        }
        else
        {
            imgProduct.ImageUrl = "";
        }
    }

    protected void liProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadImage();
    }
    protected void liBrand_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadModel();
    }
    protected void liGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadType();
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_ProductDetail : System.Web.UI.Page
{
    public const string VIEW_MODE = "view";
    public const string EDIT_MODE = "edit";
    public const string NEW_MODE = "new";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString != null)
            {
                //check privilege
                if (Session[Global.LOGIN] != null)
                {
                    Authentication auth = (Authentication)Session[Global.LOGIN];
                    if (auth.Privilege == Authentication.DIRECTOR)
                    {
                        pnAdmin.Visible = true;
                    }
                }

                BTHGDataContext db = new BTHGDataContext();

                string mode = Request.QueryString["mode"];
                if (mode != null)
                {
                    if (NEW_MODE.Equals(mode))
                    {
                        txtPrice.Visible = true;
                        txtModel.Visible = true;
                        txtDiscount.Visible = true;
                        liGroup.Visible = true;
                        liType.Visible = true;
                        Brand1.Visible = true;
                        txtAvailable.Visible = true;
                        txtSpecification.Visible = true;
                        txtSpecification.Enabled = true;

                        Supplies1.Visible = false;
                        btAdd.Visible = true;
                        ImageUploader1.Visible = true;
                        ImageUploader2.Visible = true;
                        ImageUploader3.Visible = true;
                        chkKeep.Visible = true;

                        RequiredFieldValidator2.Visible = true;
                        RequiredFieldValidator3.Visible = true;
                        RequiredFieldValidator4.Visible = true;
                        RequiredFieldValidator5.Visible = true;
                        liGroup.DataBound += liGroup_DataBound;
                        liGroup.DataBind();
                        loadType(liGroup.SelectedValue);                        
                    }
                    else if (VIEW_MODE.Equals(mode))
                    {
                        lbPrice.Visible = true;
                        lbModel.Visible = true;
                        lbDiscount.Visible = pnAdmin.Visible;
                        lbProductType.Visible = true;
                        lbBrand.Visible = true;
                        lbAvailable.Visible = true;
                        txtSpecification.Visible = true;
                        txtSpecification.Enabled = false;
                        btEdit.Visible = true;
                        img1.Visible = true;
                        img2.Visible = true;
                        img3.Visible = true;

                        int productID = Int32.Parse(Request.QueryString["IDProduct"]);
                        tbProduct p = db.tbProducts.FirstOrDefault(x => x.IDProduct == productID);
                        if (p != null)
                        {
                            lbModel.Text = p.Model;
                            lbPrice.Text = Global.currencyFormat(p.Price);
                            lbAvailable.Text = p.AvailableNumber.ToString();
                            lbDiscount.Text = Global.currencyFormat(p.Discount);
                            if (p.Image1 != null) img1.ImageUrl = Global.PATH_PRODUCTIMAGE + p.Image1;
                            if (p.Image2 != null) img2.ImageUrl = Global.PATH_PRODUCTIMAGE + p.Image2;
                            if (p.Image3 != null) img3.ImageUrl = Global.PATH_PRODUCTIMAGE + p.Image3;

                            txtSpecification.Text = p.Specification.Trim();
                            lbProductType.Text = p.tbProductType.Name;
                            lbBrand.Text = p.tbBrand.Name;
                            Supplies1.Visible = true;
                            Supplies1.viewMode(p.IDProduct);

                            txtModel.Visible = false;
                            txtPrice.Visible = false;
                            txtAvailable.Visible = false;
                            txtDiscount.Visible = false;
                            ImageUploader1.Visible = false;
                            ImageUploader2.Visible = false;
                            ImageUploader3.Visible = false;
                            txtSpecification.Enabled = false;
                            Brand1.Visible = false;
                            liGroup.Visible = false;
                            liType.Visible = false;
                        }
                    }
                    else if (EDIT_MODE.Equals(mode))
                    {

                        txtPrice.Visible = true;
                        txtModel.Visible = true;
                        txtDiscount.Visible = true;
                        liGroup.Visible = true;
                        liType.Visible = true;
                        Brand1.Visible = true;
                        txtAvailable.Visible = true;
                        txtSpecification.Visible = true;
                        txtSpecification.Enabled = true;

                        btCancel.Visible = true;
                        btSave.Visible = true;
                        ImageUploader1.Visible = true;
                        ImageUploader2.Visible = true;
                        ImageUploader3.Visible = true;

                        RequiredFieldValidator2.Visible = true;
                        RequiredFieldValidator3.Visible = true;
                        RequiredFieldValidator4.Visible = true;
                        RequiredFieldValidator5.Visible = true;

                        int productID = Int32.Parse(Request.QueryString["IDProduct"]);
                        tbProduct p = db.tbProducts.FirstOrDefault(x => x.IDProduct == productID);
                        if (p != null)
                        {
                            txtModel.Text = p.Model;
                            txtPrice.Text = Global.currencyFormat(p.Price);
                            txtAvailable.Text = p.AvailableNumber.ToString();
                            txtDiscount.Text = Global.currencyFormat(p.Discount);
                            Supplies1.editMode(p.IDProduct);

                            ImageUploader1.setImage(p.Image1);
                            ImageUploader2.setImage(p.Image2);
                            ImageUploader3.setImage(p.Image3);

                            txtSpecification.Text = p.Specification.Trim();
                            liGroup.DataBound -= liGroup_DataBound;
                            liGroup.DataBind();
                            liGroup.SelectedValue = p.tbProductType.IDGroup.ToString();

                            loadType(p.tbProductType.IDGroup.ToString());
                            liType.SelectedValue = p.IDProductType.ToString();
                            Brand1.SelectedValue = p.tbBrand.IDBrand.ToString();
                        }
                    }
                }
            }
        }
    }

    void liGroup_DataBound(object sender, EventArgs e)
    {
        loadType(liGroup.SelectedValue);
    }
    protected void btAdd_Click(object sender, EventArgs e)
    {
        if (!"".Equals(liType.SelectedValue))
        {
            BTHGDataContext db = new BTHGDataContext();
            tbProduct product = new tbProduct();
            product.IDBrand = Int32.Parse(Brand1.SelectedValue);
            product.IDProductType = Int32.Parse(liType.SelectedValue);
            product.Model = txtModel.Text;

            //check if product exist
            if (db.tbProducts.Count(x => x.IDProductType == product.IDProductType && x.Model.Equals(product.Model)) > 0)
            {
                Response.Write("<script>alert('Sản phẩm đã tồn tại!')</script>");
            }
            else
            {

                product.Specification = txtSpecification.Text.Trim();
                if (ImageUploader1.getData() != null)
                    product.Image1 = ImageUploader1.saveFile();
                if (ImageUploader2.getData() != null)
                    product.Image2 = ImageUploader2.saveFile();
                if (ImageUploader3.getData() != null)
                    product.Image3 = ImageUploader3.saveFile();

                product.Price = Global.removeCurrencyFormat(txtPrice.Text);
                product.Discount = Global.removeCurrencyFormat(txtDiscount.Text);
                product.AvailableNumber = Int32.Parse(txtAvailable.Text);

                db.tbProducts.InsertOnSubmit(product);
                db.SubmitChanges();

                if (chkKeep.Checked)
                {
                    txtModel.Text = "";
                    txtSpecification.Text = "";
                    ImageUploader1.clear();
                    ImageUploader2.clear();
                    ImageUploader3.clear();
                    txtPrice.Text = "0";
                    txtDiscount.Text = "0";
                    txtAvailable.Text = "0";
                    Response.Write("<script>alert('Thêm thành công!')</script>");
                }
                else
                {
                    Response.Redirect("~/Manage/Product.aspx");
                }
            }
        }
        else
        {
            Response.Write("<script>alert('Chưa chọn loại sản phấm!')</script>");
        }
    }
    protected void btEdit_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Manage/ProductDetail.aspx?mode=edit&IDProduct=" + Request.QueryString["IDProduct"]);
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        BTHGDataContext db = new BTHGDataContext();

        tbProduct product = db.tbProducts.FirstOrDefault(x => x.IDProduct == Int32.Parse(Request.QueryString["IDProduct"]));

        if (product != null)
        {
            int selectedBrand = -1;
            if (!"".Equals(Brand1.SelectedValue))
                selectedBrand = Int32.Parse(Brand1.SelectedValue);

            int selectedProductType = -1;
            if (!"".Equals(liType.SelectedValue))
                selectedProductType = Int32.Parse(liType.SelectedValue);

            if (selectedBrand == -1)
                Response.Write("<script>alert('Chưa chọn nhãn hiệu sản phấm!')</script>");
            else if (selectedProductType == -1)
                Response.Write("<script>alert('Chưa chọn loại sản phấm!')</script>");
            else
            {

                if (selectedBrand != product.tbBrand.IDBrand)
                {
                    product.tbBrand = db.tbBrands.Single(x => x.IDBrand == selectedBrand);
                }

                if (selectedProductType != product.tbProductType.IDProductType)
                {
                    product.tbProductType = db.tbProductTypes.Single(x => x.IDProductType == selectedProductType);
                }

                product.Model = txtModel.Text;
                product.Specification = txtSpecification.Text.Trim();

                if (ImageUploader1.imageChanged())
                    product.Image1 = ImageUploader1.saveFile();
                if (ImageUploader2.imageChanged())
                    product.Image2 = ImageUploader2.saveFile();
                if (ImageUploader3.imageChanged())
                    product.Image3 = ImageUploader3.saveFile();

                double newProductPrice = Global.removeCurrencyFormat(txtPrice.Text);
                if (newProductPrice != product.Price)
                {
                    //update new price
                    tbPriceHistory priceHistory = new tbPriceHistory();
                    priceHistory.IDProduct = product.IDProduct;
                    priceHistory.ChangeDate = Global.getCurrentDateTime();
                    priceHistory.FromPrice = product.Price;
                    priceHistory.ToPrice = newProductPrice;
                    priceHistory.IDStaff = ((Authentication)Session[Global.LOGIN]).IDStaff;
                    db.tbPriceHistories.InsertOnSubmit(priceHistory);
                }
                Supplies1.save();
                product.Price = newProductPrice;
                product.Discount = Global.removeCurrencyFormat(txtDiscount.Text);
                product.AvailableNumber = Int32.Parse(txtAvailable.Text);

                db.SubmitChanges();

                Response.Redirect("~/Manage/ProductDetail.aspx?mode=view&IDProduct=" + Request.QueryString["IDProduct"]);
            }
        }
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Manage/ProductDetail.aspx?mode=view&IDProduct=" + Request.QueryString["IDProduct"]);
    }

    protected void liGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadType(liGroup.SelectedValue);
    }

    protected void loadType(string IDGroup)
    {
        if (!"".Equals(IDGroup))
        {
            BTHGDataContext db = new BTHGDataContext();
            liType.DataSource = db.tbProductTypes.Where(x => x.IDGroup.ToString().Equals(IDGroup)).OrderBy(x => x.Name);
            liType.DataBind();
        }
    }
}
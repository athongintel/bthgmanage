using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using GemBox.Spreadsheet;

public partial class Manage_Director_OrderDetails : System.Web.UI.Page
{    
    BTHGDataContext db;
    List<Info> liInfo;

    [Serializable]
    private class Info
    {
        public int Order
        { get; set; }
        public int IDProduct
        { get; set; }
        public String Name
        { get; set; }
        public String Image
        { get; set; }
        public int Quantity
        { get; set; }
        public String Model
        { get; set; }
        public double Price
        { get; set; }
        public String Note
        { get; set; }
        public double Scale
        { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {            
            string order = Request.QueryString["order"];
            db = new BTHGDataContext();
            tbSellingHistory history = db.tbSellingHistories.FirstOrDefault(x => x.OrderNo.Equals(order));
            if (history!=null)
            {
                lbOrderName.Text = history.OrderName;
                lbCustomer.Text = history.tbCustomerContact.tbCustomer.Name;
                lbContact.Text = history.tbCustomerContact.FirstName + " " + history.tbCustomerContact.LastName;
                lbOrderNo.Text = history.OrderNo;
                lbOrderDate.Text = history.OrderDate.ToString("dd/MM/yyyy HH:mm:ss");                
                lbStaff.Text = history.tbStaff.Name;
                txtTerms.Text = history.Terms;
                List<tbSellingHistoryDetail> details = db.tbSellingHistoryDetails.Where(x => x.OrderNo.Equals(order)).OrderBy(x=>x.No).ToList();
                
                liInfo = new List<Info>();
                double totalprice = 0;
                for(int i=0;i<details.Count;i++)
                {
                    tbSellingHistoryDetail detail = details.ElementAt(i);
                    Info info = new Info();
                    info.Order = i + 1;
                    info.IDProduct = detail.IDProduct;
                    info.Name=detail.tbProduct.tbProductType.Name;
                    info.Model = detail.tbProduct.Model;
                    info.Image = detail.tbProduct.Image1;
                    info.Quantity = detail.Quantity;
                    info.Price = Global.getPrice(history.OrderDate, detail.IDProduct);
                    info.Scale = detail.Scale;
                    info.Note = detail.Note;
                    liInfo.Add(info);
                    totalprice += info.Price*(1.0+detail.Scale/100) * info.Quantity;
                }
                lbTotalPrice.Text = Global.currencyFormat(totalprice);
                ViewState["listInfo"] = liInfo;
                gvProduct.DataSource = liInfo;
                gvProduct.DataBind();
                btExcel.Visible = Global.isAdmin();
                btPDF.Visible = true;
            }
            
        }
    }



    
    private void makeExcelFile()
    {
        btExcel.Enabled = false;
        //init data
        db = new BTHGDataContext();
        tbSellingHistory history = db.tbSellingHistories.FirstOrDefault(x => x.OrderNo.Equals(lbOrderNo.Text));
        liInfo = (List<Info>)ViewState["listInfo"];

        //load info
        string[] companyinfo = System.Text.Encoding.Unicode.GetString(System.IO.File.ReadAllBytes(Server.MapPath(Global.PATH_INFO))).Split(new[] { "\n" }, StringSplitOptions.None);


        SpreadsheetInfo.SetLicense("FREE-LIMITED-KEY");
        var xlWorkBook = new ExcelFile();
        ExcelWorksheet xlWorkSheet = xlWorkBook.Worksheets.Add("baogia");
        CellRange range;
        ExcelCell cell;

        //// Add Data
        //// ========= HEADER ============== 

        //--manualfit columns
        xlWorkSheet.Columns["A"].Width = (int)LengthUnitConverter.Convert(100, LengthUnit.Pixel, LengthUnit.ZeroCharacterWidth256thPart);
        xlWorkSheet.Columns["B"].Width = (int)LengthUnitConverter.Convert(150, LengthUnit.Pixel, LengthUnit.ZeroCharacterWidth256thPart);
        xlWorkSheet.Columns["C"].Width = (int)LengthUnitConverter.Convert(300, LengthUnit.Pixel, LengthUnit.ZeroCharacterWidth256thPart);
        xlWorkSheet.Columns["D"].Width = (int)LengthUnitConverter.Convert(250, LengthUnit.Pixel, LengthUnit.ZeroCharacterWidth256thPart);
        xlWorkSheet.Columns["E"].Width = (int)LengthUnitConverter.Convert(100, LengthUnit.Pixel, LengthUnit.ZeroCharacterWidth256thPart);
        xlWorkSheet.Columns["F"].Width = (int)LengthUnitConverter.Convert(150, LengthUnit.Pixel, LengthUnit.ZeroCharacterWidth256thPart);
        xlWorkSheet.Columns["G"].Width = (int)LengthUnitConverter.Convert(150, LengthUnit.Pixel, LengthUnit.ZeroCharacterWidth256thPart);
        xlWorkSheet.Columns["H"].Width = (int)LengthUnitConverter.Convert(100, LengthUnit.Pixel, LengthUnit.ZeroCharacterWidth256thPart);    

        range = xlWorkSheet.Cells.GetSubrange("A1", "H6");
        range.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

        range = xlWorkSheet.Cells.GetSubrange("A2", "H2");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.DarkBlue;
        range.Value = companyinfo[2].Trim();

        range = xlWorkSheet.Cells.GetSubrange("A3", "H3");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 25 * 20;
        range.Style.Font.Color = Color.DarkRed;
        range.Style.Font.Weight = ExcelFont.BoldWeight;
        range.Value = companyinfo[1].Trim();

        range = xlWorkSheet.Cells.GetSubrange("A4", "H4");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 13 * 20;
        range.Style.Font.Color = Color.DarkBlue;
        range.Value = companyinfo[3].Trim();

        range = xlWorkSheet.Cells.GetSubrange("A5", "H5");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 13 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = companyinfo[4].Trim();

        range = xlWorkSheet.Cells.GetSubrange("A10", "H15");
        range.SetBorders(MultipleBorders.Top | MultipleBorders.Bottom, Color.Black, LineStyle.Medium);

        range = xlWorkSheet.Cells.GetSubrange("A8", "H8");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 30 * 20;
        range.Style.Font.Color = Color.Black;
        range.Style.Font.Weight = ExcelFont.BoldWeight;
        range.Value = "BÁO GIÁ CUNG CẤP THIẾT BỊ";

        //-----------ADDRESS
        cell = xlWorkSheet.Cells["A10"];        
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Bottom;
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.Name = "Arial";
        cell.Style.Font.Color = Color.Black;
        cell.Value = "To";

        cell = xlWorkSheet.Cells["A11"];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;        
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.Name = "Arial";
        cell.Style.Font.Color = Color.Black;
        cell.Value = "Add";

        cell = xlWorkSheet.Cells["A12"];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.Name = "Arial";
        cell.Style.Font.Color = Color.Black;
        cell.Value = "Att";

        cell = xlWorkSheet.Cells["A13"];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.Name = "Arial";
        cell.Style.Font.Color = Color.Black;
        cell.Value = "Position";

        cell = xlWorkSheet.Cells["A14"];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.Name = "Arial";
        cell.Style.Font.Color = Color.Black;
        cell.Value = "Email";

        cell = xlWorkSheet.Cells["A15"];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Top;
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.Name = "Arial";
        cell.Style.Font.Color = Color.Black;
        cell.Value = "Phone";

        range = xlWorkSheet.Cells.GetSubrange("B10", "C10");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Bottom;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbCustomerContact.tbCustomer.Name;

        range = xlWorkSheet.Cells.GetSubrange("B11", "D11");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbCustomerContact.tbCustomer.Address;

        range = xlWorkSheet.Cells.GetSubrange("B12", "C12");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbCustomerContact.Title + " " + history.tbCustomerContact.LastName;

        range = xlWorkSheet.Cells.GetSubrange("B13", "C13");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbCustomerContact.Position;

        range = xlWorkSheet.Cells.GetSubrange("B14", "C14");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbCustomerContact.Email;

        range = xlWorkSheet.Cells.GetSubrange("B15", "C15");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Top;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbCustomerContact.Tel;

        range = xlWorkSheet.Cells.GetSubrange("E10", "E10");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Bottom;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = "No";

        range = xlWorkSheet.Cells.GetSubrange("E11", "E11");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = "Date";

        range = xlWorkSheet.Cells.GetSubrange("E12", "E12");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = "Sales person";

        range = xlWorkSheet.Cells.GetSubrange("E13", "E13");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = "Position";

        range = xlWorkSheet.Cells.GetSubrange("E14", "E14");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = "Email";

        range = xlWorkSheet.Cells.GetSubrange("E15", "E15");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Top;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = "Phone";

        range = xlWorkSheet.Cells.GetSubrange("F10", "H10");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Bottom;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.OrderNo;

        range = xlWorkSheet.Cells.GetSubrange("F11", "H11");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.OrderDate.ToString("dd/MM/yyyy");

        range = xlWorkSheet.Cells.GetSubrange("F12", "H12");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbStaff.Name;

        range = xlWorkSheet.Cells.GetSubrange("F13", "H13");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbStaff.Position;

        range = xlWorkSheet.Cells.GetSubrange("F14", "H14");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbStaff.Email;

        range = xlWorkSheet.Cells.GetSubrange("F15", "H15");
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Top;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbStaff.Tel;

        range = xlWorkSheet.Cells.GetSubrange("A10", "H15");
        range.SetBorders(MultipleBorders.Top, Color.Black, LineStyle.Medium);
        range.SetBorders(MultipleBorders.Bottom, Color.Black, LineStyle.Medium);

        //--------------GREETINGS
        range = xlWorkSheet.Cells.GetSubrange("A17", "H17");
        range.Merged = true;
        range.Style.Font.Size = 16 * 20;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Value = "Kính gửi " + history.tbCustomerContact.Title + " " + history.tbCustomerContact.LastName;

        range = xlWorkSheet.Cells.GetSubrange("A18", "H18");
        range.Merged = true;
        range.Style.Font.Size = 16 * 20;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Value = "Cảm ơn Quý khách đã quan tâm và sử dụng dịch vụ của công ty chúng tôi";

        range = xlWorkSheet.Cells.GetSubrange("A19", "H19");
        range.Merged = true;
        range.Style.Font.Size = 16 * 20;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Value = "Theo yêu cầu của Quý khách, chúng tôi kính gởi báo giá cung cấp/sửa chữa thiết bị như bên dưới.";


        range = xlWorkSheet.Cells.GetSubrange("A21", "A22");
        range.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);
        range.Merged = true;
        range.Style.Font.Size = 16 * 20;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Value = "No.";
        range.Style.Font.Weight = ExcelFont.BoldWeight;


        range = xlWorkSheet.Cells.GetSubrange("B21", "D21");
        range.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);
        range.Merged = true;
        range.Style.Font.Size = 16 * 20;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Value = "Chi tiết";
        range.Style.Font.Weight = ExcelFont.BoldWeight;


        range = xlWorkSheet.Cells.GetSubrange("E21", "E22");
        range.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);
        range.Merged = true;
        range.Style.Font.Size = 16 * 20;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Value = "Slg";
        range.Style.Font.Weight = ExcelFont.BoldWeight;


        range = xlWorkSheet.Cells.GetSubrange("F21", "F22");
        range.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);
        range.Merged = true;
        range.Style.WrapText = true;
        range.Style.Font.Size = 16 * 20;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Value = "Đơn giá (VND)";
        range.Style.Font.Weight = ExcelFont.BoldWeight;


        range = xlWorkSheet.Cells.GetSubrange("G21", "G22");
        range.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);
        range.Merged = true;
        range.Style.WrapText = true;
        range.Style.Font.Size = 16 * 20;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Value = "Giá thành (VND)";
        range.Style.Font.Weight = ExcelFont.BoldWeight;


        range = xlWorkSheet.Cells.GetSubrange("H21", "H22");
        range.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);
        range.Merged = true;
        range.Style.Font.Size = 16 * 20;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Value = "Ghi chú";
        range.Style.Font.Weight = ExcelFont.BoldWeight;


        cell = xlWorkSheet.Cells["B22"];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        cell.Value = "Thiết bị";
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.UnderlineStyle = UnderlineStyle.Single;
        cell.Style.Font.Color = Color.DarkBlue;
        cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

        cell = xlWorkSheet.Cells["C22"];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        cell.Style.WrapText = true;
        cell.Value = "Model, Thông số kỹ thuật";
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.UnderlineStyle = UnderlineStyle.Single;
        cell.Style.Font.Color = Color.DarkBlue;
        cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

        cell = xlWorkSheet.Cells["D22"];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        cell.Value = "Hình ảnh";
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.UnderlineStyle = UnderlineStyle.Single;
        cell.Style.Font.Color = Color.DarkBlue;
        cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

        string imagelocation = Server.MapPath(Global.PATH_PRODUCTIMAGE);
        int startrow = 23;
        for (int i = 0; i < liInfo.Count; i++)
        {
            Info info = liInfo.ElementAt(i);
            tbProduct p = db.tbProducts.Single(x => x.IDProduct == info.IDProduct);
            cell = xlWorkSheet.Cells["A" + (startrow + i)];
            cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
            cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
            cell.Style.Font.Size = 16 * 20;           
            cell.Style.Font.Name = "Arial";
            cell.Style.Font.Color = Color.Black;
            cell.Value = info.Order.ToString();
            cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

            cell = xlWorkSheet.Cells["B" + (startrow + i)];
            cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
            cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
            cell.Style.Font.Size = 16 * 20;
            cell.Style.Indent = 2;
            cell.Style.WrapText = true;
            cell.Style.Font.Name = "Arial";
            cell.Style.Font.Color = Color.Black;
            cell.Value = info.Name;
            cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

            cell = xlWorkSheet.Cells["C" + (startrow + i)];
            cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
            cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;            
            cell.Style.Indent = 2;
            cell.Style.Font.Name = "Arial";
            cell.Style.Font.Size = 16 * 20;
            cell.Style.WrapText = true;
            cell.Style.Font.Color = Color.Black;
            string model = "\n"                            
                            + p.tbBrand.Name + " - " + p.tbBrand.Origin + "\n"
                            + "Model: " + info.Model + "\n\n"
                            + p.Specification.Trim() + "\n"
                            + "\n";
                        
            cell.Value = model.Replace((char)13, ' ');
            cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

            cell = xlWorkSheet.Cells["D" + (startrow + i)];
            cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

            cell = xlWorkSheet.Cells["E" + (startrow + i)];
            cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
            cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
            cell.Style.Font.Size = 16 * 20;
            cell.Style.Font.Name = "Arial";
            cell.Style.Font.Color = Color.Black;
            cell.Value = info.Quantity.ToString();
            cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

            cell = xlWorkSheet.Cells["F" + (startrow + i)];
            cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
            cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
            cell.Style.Font.Size = 16 * 20;
            cell.Style.Font.Name = "Arial";
            cell.Style.Font.Color = Color.Black;
            cell.Value = Global.currencyFormat(info.Price * (1.0 + info.Scale / 100));
            cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

            cell = xlWorkSheet.Cells["G" + (startrow + i)];

            cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
            cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
            cell.Style.Font.Size = 16 * 20;
            cell.Style.Font.Name = "Arial";
            cell.Style.Font.Color = Color.Black;
            cell.Value = Global.currencyFormat(info.Price*(1.0 + info.Scale/100) * info.Quantity);
            cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

            cell = xlWorkSheet.Cells["H" + (startrow + i)];

            cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Justify;
            cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
            cell.Style.Font.Size = 16 * 20;
            cell.Style.Font.Name = "Arial";
            cell.Style.Font.Color = Color.Black;
            cell.Value = info.Note;
            cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

            xlWorkSheet.Rows[startrow + i - 1].AutoFit();
        }

        cell = xlWorkSheet.Cells["F" + (startrow + liInfo.Count)];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.Weight = ExcelFont.BoldWeight;
        cell.Style.Font.Name = "Arial";
        cell.Style.Font.Color = Color.Black;
        cell.Value = "Tổng cộng";
        cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

        cell = xlWorkSheet.Cells["G" + (startrow + liInfo.Count)];
        cell.Style.HorizontalAlignment = HorizontalAlignmentStyle.Right;
        cell.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        cell.Style.Font.Size = 16 * 20;
        cell.Style.Font.Weight = ExcelFont.BoldWeight;
        cell.Style.Font.Name = "Arial";
        cell.Style.Font.Color = Color.Black;
        cell.Value = lbTotalPrice.Text;
        cell.SetBorders(MultipleBorders.Outside, Color.Black, LineStyle.Medium);

        xlWorkSheet.Rows[startrow + liInfo.Count - 1].Height = (int)LengthUnitConverter.Convert(40, LengthUnit.Pixel, LengthUnit.Twip);

        //---------------FOOTER-------------
        int footerstart = startrow + liInfo.Count + 1;
        range = xlWorkSheet.Cells.GetSubrange("A" + footerstart, "H" + footerstart);
        range.Merged = true;

        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Weight = ExcelFont.BoldWeight;
        range.Style.Font.UnderlineStyle = UnderlineStyle.Single;

        range.Style.Font.Color = Color.Black;
        range.Value = "Terms & Conditions :";

        //--terms
        string[] terms = history.Terms.Split(new[] { "\n" }, StringSplitOptions.RemoveEmptyEntries);
        for (int i = 0; i < terms.Length; i++)
        {
            range = xlWorkSheet.Cells.GetSubrange("A" + (footerstart + 2 + i), "H" + (footerstart + 2 + i));
            range.Merged = true;
            range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Left;
            range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
            range.Style.Font.Size = 16 * 20;
            range.Style.Font.Color = Color.Black;
            range.Value = terms[i].Replace((char)13, ' ');
        }

        //--sign
        range = xlWorkSheet.Cells.GetSubrange("B" + (footerstart + 3 + terms.Length), "C" + (footerstart + 3 + terms.Length));
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = "Xác nhận của khách hàng";

        range = xlWorkSheet.Cells.GetSubrange("F" + (footerstart + 3 + terms.Length), "G" + (footerstart + 3 + terms.Length));
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = "Người lập báo giá";

        range = xlWorkSheet.Cells.GetSubrange("F" + (footerstart + 4 + terms.Length), "G" + (footerstart + 4 + terms.Length));
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbStaff.Position;

        range = xlWorkSheet.Cells.GetSubrange("F" + (footerstart + 12 + terms.Length), "G" + (footerstart + 12 + terms.Length));
        range.Merged = true;
        range.Style.HorizontalAlignment = HorizontalAlignmentStyle.Center;
        range.Style.VerticalAlignment = VerticalAlignmentStyle.Center;
        range.Style.Font.Size = 16 * 20;
        range.Style.Font.Color = Color.Black;
        range.Value = history.tbStaff.Name;            

        //--set height
        for (int i = 0; i < startrow - 1; i++)
        {
            if (i == 2 || i == 7)
                xlWorkSheet.Rows[i].Height = (int)LengthUnitConverter.Convert(45, LengthUnit.Pixel, LengthUnit.Twip);            
            else
                xlWorkSheet.Rows[i].Height = (int)LengthUnitConverter.Convert(25, LengthUnit.Pixel, LengthUnit.Twip);
        }

        //--manualfit row
        xlWorkSheet.Rows[20].Height = (int)LengthUnitConverter.Convert(50, LengthUnit.Pixel, LengthUnit.Twip);
        xlWorkSheet.Rows[21].Height = (int)LengthUnitConverter.Convert(70, LengthUnit.Pixel, LengthUnit.Twip);

        //--header fix border
        xlWorkSheet.Rows[9].Height = (int)LengthUnitConverter.Convert(40, LengthUnit.Pixel, LengthUnit.Twip);        
        xlWorkSheet.Rows[14].Height = (int)LengthUnitConverter.Convert(40, LengthUnit.Pixel, LengthUnit.Twip);        
        
        double margin = 10;

        //remove image info if image not found      
        for (int i = 0; i < liInfo.Count; i++)
        {
            Info info = liInfo.ElementAt(i);
            try
            {
                System.Drawing.Image img = System.Drawing.Image.FromFile(imagelocation + info.Image);
            }
            catch (FileNotFoundException ex)
            {
                //set product image to null;
                tbProduct p = db.tbProducts.Single(x => x.IDProduct == info.IDProduct);
                p.Image1 = null;
                db.SubmitChanges();
                info.Image = null;
            }
        }

        int maxwidth = 300;

        xlWorkSheet.Columns["D"].Width = (int)LengthUnitConverter.Convert(maxwidth + 2 * margin, LengthUnit.Pixel, LengthUnit.ZeroCharacterWidth256thPart); //chuyen tu pixel sang zerocharacter

        double leftposition = LengthUnitConverter.Convert(xlWorkSheet.Columns["A"].Width + xlWorkSheet.Columns["B"].Width + xlWorkSheet.Columns["C"].Width, LengthUnit.ZeroCharacterWidth256thPart, LengthUnit.Pixel); //tinh bang pixel
        double topposition = 0; //tinh bang pixel

        for (int i = 0; i < startrow - 1; i++)
        {
            topposition += xlWorkSheet.Rows[i].Height;
        }

        topposition = LengthUnitConverter.Convert(topposition, LengthUnit.Twip, LengthUnit.Pixel);
        int minheight = 100; //in pixel
        for (int i = 0; i < liInfo.Count; i++)
        {
            Info info = liInfo.ElementAt(i);
            double imageheight = 0;
            double imagewidth = 0;
            if (info.Image!=null)
            {
                double cellheight=LengthUnitConverter.Convert(xlWorkSheet.Rows[startrow+i-1].Height,LengthUnit.Twip,LengthUnit.Pixel);
                //check if cellheight> image height +2 * margin
                System.Drawing.Image img = System.Drawing.Image.FromFile(imagelocation + info.Image);
                imageheight = img.Height;
                imagewidth = img.Width;

                if (cellheight < (img.Height+2*margin))
                {
                    cellheight = imageheight + 2 * margin;
                    if (cellheight < minheight)
                        cellheight = minheight;
                }
                xlWorkSheet.Rows[startrow + i - 1].Height = (int)(LengthUnitConverter.Convert(cellheight, LengthUnit.Pixel, LengthUnit.Twip));
                
                xlWorkSheet.Pictures.Add(Path.Combine(imagelocation, info.Image), leftposition + margin + (maxwidth - imagewidth) / 2,
                topposition + (cellheight-imageheight)/2, LengthUnit.Pixel);                
            }            
            topposition += LengthUnitConverter.Convert(xlWorkSheet.Rows[startrow + i - 1].Height, LengthUnit.Twip, LengthUnit.Pixel);
        }

        // Return to Client
        string strPathFolder = Server.MapPath(Global.PATH_FILES);
        string strPDFFileName = "baogia.pdf";
        string strExcelFileName = "baogia.xlsx";

        //remove existed files
        if (System.IO.File.Exists(strPathFolder + strPDFFileName))
        {
            File.Delete(strPathFolder + strPDFFileName);
        }
        if (System.IO.File.Exists(strPathFolder + strExcelFileName))
        {
            File.Delete(strPathFolder + strExcelFileName);
        }

        xlWorkSheet.PrintOptions.PaperType = PaperType.A4;
        xlWorkSheet.PrintOptions.FitWorksheetWidthToPages = 1;
        xlWorkSheet.PrintOptions.FitWorksheetHeightToPages = 0;

        //save .xlsx
        xlWorkBook.Save(strPathFolder + strExcelFileName);

        //save .pdf
        xlWorkBook.Save(strPathFolder + strPDFFileName);
    }

    protected void btPDF_Click(object sender, EventArgs e)
    {
        string strPathFolder = Server.MapPath(Global.PATH_FILES);
        string strPDFFilename = "baogia.pdf";

        makeExcelFile();

        Response.Buffer = true;
        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment; filename=" + strPDFFilename);
        Response.TransmitFile(strPathFolder + strPDFFilename);
        Response.Flush();
        Response.End();
    }

    protected void btExcel_Click(object sender, EventArgs e)
    {
        string strPathFolder = Server.MapPath(Global.PATH_FILES);
        string strExcelFileName = "baogia.xlsx";

        makeExcelFile();

        Response.Buffer = true;
        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment; filename=" + strExcelFileName);
        Response.TransmitFile(strPathFolder + strExcelFileName);
        Response.Flush();
        Response.End();
    }

}
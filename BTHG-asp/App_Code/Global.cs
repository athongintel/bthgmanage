using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Global
/// </summary>
public class Global
{
    //--paths
    public const string PATH_FILES = "~/Files/";
    public const string PATH_PRODUCTIMAGE = "~/Files/productimage/";    
    
    public const string PATH_TERMS = "~/Files/terms.txt";
    public const string PATH_INFO = "~/Files/info.txt";

    //--constants
    public const string LOGIN = "login"; 
 
    public static DateTime getCurrentDateTime()
    {
        return DateTime.Now.AddHours(12);
    }

    public static string getBrandName(int IDBrand)
    {
        BTHGDataContext db = new BTHGDataContext();
        return db.tbBrand.Single(x=>x.IDBrand==IDBrand).Name;
    }

    public static string currencyFormat(double price)
    {
        string p = price.ToString();
        string p2 = "";
        //find point position

        int pointPos = p.Length ;
        for (int i=0;i<p.Length;i++)
        {
            if (".".Equals(p.Substring(i,1)))
            {
                pointPos = i;
                break;
            }
        }
        
        if (pointPos!=p.Length)
        {
            p2 = "," + p.Substring(pointPos+1) + p2;
        }

        int count=0;
        for (int i = pointPos; i >= 1; i--)
        {
            count++;
            p2 = p.Substring(i-1,1)+p2;
            if (count==3 && i>1)
            {
                count = 0;
                p2 = "." + p2;
            }
        }

        return p2;
    }

    public static double removeCurrencyFormat(string price)
    {
        string p = price.ToString();
        string p2="";

        for (int i = 0; i < p.Length; i++)
        {
            //change ',' to '.'
            if (",".Equals(p.Substring(i, 1)))
                p2 += ".";
            else if (!".".Equals(p.Substring(i, 1)))
                p2 += p.Substring(i, 1);
            //ignore '.'
        }

        return Double.Parse(p2);
    }

    public static double getPrice(DateTime atDate, int IDProduct)
    {
        BTHGDataContext db;

        double result;
        db = new BTHGDataContext();
        result = db.tbProduct.Single(x => x.IDProduct == IDProduct).Price;

        List<tbPriceHistory> priceHistory = db.tbPriceHistory.Where(x => x.IDProduct == IDProduct).OrderByDescending(x => x.ChangeDate).ToList();
        foreach (tbPriceHistory price in priceHistory)
        {
            if (atDate <= price.ChangeDate)
            {
                result = price.FromPrice;
            }
            else
            {
                break;
            }
        }
        return result;
    }

    public static string getStaffName(int IDStaff)
    {
        BTHGDataContext db = new BTHGDataContext();
        return db.tbStaff.Single(x => x.IDStaff == IDStaff).Name;
    }

    public static string getRoleName(int Role)
    {
        if (Role == 1)
            return "Thư ký";
        else if (Role == 2)
            return "Admin";
        else
            return "Khách";
    }

    public static string censorPassword(string password)
    {
        return password.Substring(0, 2) + "****" + password.Substring(password.Length - 2);
    }

    public static string getProductTypeName(int IDProductType)
    {
        BTHGDataContext db = new BTHGDataContext();
        return db.tbProductType.Single(x => x.IDProductType == IDProductType).Name;
    }

    public static string getSupplierName(int IDSupplier)
    {
        BTHGDataContext db = new BTHGDataContext();
        return db.tbSupplier.Single(x => x.IDSupplier == IDSupplier).Name;
    }

    public static bool isVendor(int IDSupplier, int IDProduct)
    {
        BTHGDataContext db = new BTHGDataContext();
        return db.tbSupply.Where(x => x.IDSupplier == IDSupplier && x.IDProduct==IDProduct).ToList().Count==1;
    }

    public static bool isAdmin()
    {
        if (System.Web.HttpContext.Current.Session[Global.LOGIN] != null)
        {
            Authentication auth = (Authentication)System.Web.HttpContext.Current.Session[Global.LOGIN];
            return (auth.Privilege == Authentication.DIRECTOR);
        }
        else
            return false;
    }

    public static int getCurrentIDStaff()
    {
        Authentication auth = (Authentication)System.Web.HttpContext.Current.Session[Global.LOGIN];
        return auth.IDStaff;
    }

}
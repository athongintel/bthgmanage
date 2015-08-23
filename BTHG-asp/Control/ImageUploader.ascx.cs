using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_ImageUploader : System.Web.UI.UserControl
{
    private byte[] data;  

    public byte[] getData()
    {
        return (byte[])ViewState["imagedata"];
    }

    public bool imageChanged()
    {
        return ViewState["imagechanged"]!=null? (bool)ViewState["imagechanged"]:false;
    }

    public void setImage(string image)
    {
        ViewState["imagechanged"] = false;
        if (image != null)
        {           
            ViewState["imagename"] = image;
            Image1.ImageUrl = Global.PATH_PRODUCTIMAGE + image;
            Image1.Visible = true;
            FileUpload1.Visible = false;
            btUpload.Visible = false;
            btCancel.Visible = true;
        }
        else
        {
            Image1.Visible = false;
            FileUpload1.Visible = true;
            btUpload.Visible = true;
            btCancel.Visible = false;
        }
    }

    private void upload()
    {
        if (FileUpload1.HasFile)
        {
            ViewState["imagechanged"] = true;
            FileUpload1.Visible = false;            
            btUpload.Visible = false;            
            Stream fs = FileUpload1.PostedFile.InputStream;
            BinaryReader br = new BinaryReader(fs);
            data = br.ReadBytes((Int32)fs.Length);            
            Image1.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(data, 0, data.Length);
            Image1.Visible = true;
            btCancel.Visible = true;
            ViewState["imagedata"] = data;
        }
        else
        {
            data = null;
        }
    }

    public string saveFile()
    {
        string folder = Server.MapPath(Global.PATH_PRODUCTIMAGE);

        //remove old image
        if (ViewState["imagename"]!=null)
        {
            if (imageChanged())
            {
                if (System.IO.File.Exists(folder+(string)ViewState["imagename"]))
                {
                    System.IO.File.Delete(folder + (string)ViewState["imagename"]);
                }
            }
        }

        string file = null;
        if (ViewState["imagedata"] != null)
        {
            //save new image        
            file = Global.getCurrentDateTime().Ticks.ToString() + ".jpg";

            data = (byte[])ViewState["imagedata"];
            Stream stream = new MemoryStream(data);
            using (Stream f = File.Create(folder + file))
            {
                CopyStream(stream, f);
            }
        }
        return file;
    }

    public void clear()
    {
        btCancel_Click(null, null);
    }

    public void CopyStream(Stream input, Stream output)
    {
        byte[] buffer = new byte[8 * 1024];
        int len;
        while ((len = input.Read(buffer, 0, buffer.Length)) > 0)
        {
            output.Write(buffer, 0, len);
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        upload();
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        ViewState["imagechanged"] = true;
        ViewState["imagedata"] = null;
        btCancel.Visible = false;
        Image1.Visible = false;
        data = null;
        FileUpload1.Visible = true;
        btUpload.Visible = true;
    }
}
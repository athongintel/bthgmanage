using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manage_Director_Languages : System.Web.UI.Page
{
    BTHGDataContext db;
    protected void Page_Load(object sender, EventArgs e)
    {
       db  = new BTHGDataContext();
    }
    protected void btAddConcept_Click(object sender, EventArgs e)
    {
        String conceptString = txtNewConcept.Text;
        tbLanguageConcept concept = null;
        concept = db.tbLanguageConcept.FirstOrDefault(x => x.LanguageConcept.Equals(conceptString));
        if (concept != null)
        {
            Response.Write("<script>alert('This concept exists already!')</script>");
        }
        else
        {
            concept = new tbLanguageConcept();
            concept.LanguageConcept = conceptString;
            db.tbLanguageConcept.InsertOnSubmit(concept);
            List<tbLanguage> languages = db.tbLanguage.Where(x => true).ToList();
            languages.ForEach(x =>
            {
                tbLanguageTranslation t = new tbLanguageTranslation();
                t.IDLanguage = x.IDLanguage;
                t.LanguageConcept = conceptString;
                t.Translation = "";
                db.tbLanguageTranslation.InsertOnSubmit(t);
            });
            db.SubmitChanges();
            listConcept.DataBind();
            txtNewConcept.Text = "";
        }
    }
    protected void listConcept_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (listConcept.SelectedIndex != -1)
        {
            String conceptString = listConcept.SelectedValue;
            //load language translations
            IEnumerable<Object> translation = db.tbLanguageTranslation
                .Where(x => x.LanguageConcept.Equals(conceptString)).Select(x => new { LanguageID = x.IDLanguage, LanguageName = x.tbLanguage.LanguageName, Translation = x.Translation });
            listTranslation.DataSource = translation;
            listTranslation.DataBind();
        }
        else
        {
            listTranslation.DataSource = null;
            listTranslation.DataBind();
        }
    }
    protected void btUpdateTranslation_Click(object sender, EventArgs e)
    {
        if (listConcept.SelectedIndex != -1)
        {
            String conceptString = listConcept.SelectedValue;
            
            for (int i = 0; i < listTranslation.Items.Count; i++)
            {
                Label lbLangID = (Label)listTranslation.Items[i].FindControl("lbLanguageID");
                TextBox tbTrans = (TextBox)listTranslation.Items[i].FindControl("txtTranslation");
                tbLanguageTranslation trans = db.tbLanguageTranslation.First(x => (x.IDLanguage == Int32.Parse(lbLangID.Text)) && (x.LanguageConcept.Equals(conceptString)));
                trans.Translation = tbTrans.Text;
            }
            db.SubmitChanges();
        }
    }
    protected void btRemoveConcept_Click(object sender, EventArgs e)
    {
        if (listConcept.SelectedIndex != -1)
        {
            String conceptString = listConcept.SelectedValue;
            //load language translations
            db.tbLanguageTranslation.DeleteAllOnSubmit(db.tbLanguageTranslation.Where(x => x.LanguageConcept.Equals(conceptString)).ToList());
            db.tbLanguageConcept.DeleteOnSubmit(db.tbLanguageConcept.First(x => x.LanguageConcept.Equals(conceptString)));
            db.SubmitChanges();
            listConcept.DataBind();
            listTranslation.DataSource = null;
            listTranslation.DataBind();
        }
    }
}
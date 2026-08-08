using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Telkom.CustomerDashboard
{
    public partial class Customer : System.Web.UI.MasterPage
    {
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    // Set user name and initials from session
                    if (Session["FullName"] != null)
                    {
                        lblUserName.Text = Session["FullName"].ToString();
                        string fullName = Session["FullName"].ToString();
                        string[] names = fullName.Split(' ');
                        string initials = (names.Length > 0 ? names[0][0].ToString() : "") + (names.Length > 1 ? names[1][0].ToString() : "");
                        lblUserInitials.Text = initials.ToUpper();
                    }
                    else
                    {
                        lblUserName.Text = "User";
                        lblUserInitials.Text = "UI";
                    }
                }
            }
        }
    }
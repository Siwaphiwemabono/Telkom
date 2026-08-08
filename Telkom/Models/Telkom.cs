using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Telkom.Models
{
    public class Telkom
    {
    }
    public class TelkomUser
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Role { get; set; }
        public string FullName { get; set; }
    }
}
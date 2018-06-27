using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectOnlineShop.Commons
{
    [Serializable]
    public class UserSession
    {
        public long UserID { get; set; }
        public string Username { get; set; }
    }
}
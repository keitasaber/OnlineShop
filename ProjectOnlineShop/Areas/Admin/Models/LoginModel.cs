using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ProjectOnlineShop.Areas.Admin.Models
{
    public class LoginModel
    {
        [Required(ErrorMessage = "Enter username!")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Enter password!")]
        public string Password { get; set; }

        public bool RememberMe { get; set; }
    }
}
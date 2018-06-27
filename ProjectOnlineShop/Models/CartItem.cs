using Model.EF;
using Model.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectOnlineShop.Models
{
    public class CartItem
    {
        public ProductViewModel Product { get; set; }
        public int Quantity { get; set; }
    }
}
using Model.Dao;
using ProjectOnlineShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace ProjectOnlineShop.Controllers
{
    public class CartController : Controller
    {
        private const string CartSession = "CartSession";
        
        // GET: Cart
        public ActionResult Index()
        {
            try
            {
                var list = new List<CartItem>();
                var cart = Session["CartSession"];
                if (cart != null)
                {
                    list = (List<CartItem>)cart;
                }

                return View(list);
            }
            catch
            {
                return RedirectToAction("Index", "Error");
            }
        }

        [HttpGet]
        public ActionResult AddItem(long productID, int quantity)
        {
            var product = new ProductDao().GetByID(productID);
            var cart = Session["CartSession"];
            if (cart != null)
            {
                var list = (List<CartItem>)cart;
                if (list.Exists(x => x.Product.ID == productID))
                {
                    foreach (var item in list)
                    {
                        if (item.Product.ID == productID)
                        {
                            item.Quantity += quantity;
                        }
                    }
                }
                else
                {
                    var item = new CartItem();
                    item.Product = product;
                    item.Quantity = quantity;
                    list.Add(item);

                    Session["CartSession"] = list;
                }
            }
            else
            {
                var list = new List<CartItem>();
                var item = new CartItem();
                item.Product = product;
                item.Quantity = quantity;
                list.Add(item);

                Session["CartSession"] = list;
            }
            return Json(new { added = true }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult Update(long productID, int quantity)
        {
            var product = new ProductDao().GetByID(productID);
            var cart = Session["CartSession"];
            if (cart != null)
            {
                var list = (List<CartItem>)cart;
                if (list.Exists(x => x.Product.ID == productID))
                {
                    foreach (var item in list)
                    {
                        if (item.Product.ID == productID)
                        {
                            item.Quantity = quantity;
                        }
                    }
                }

            }
            return Json(new { updating = true }, JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public ActionResult Delete(long productID)
        {
            var product = new ProductDao().GetByID(productID);
            var cart = Session["CartSession"];
            if (cart != null)
            {
                var list = (List<CartItem>)cart;
                if (list.Exists(x => x.Product.ID == productID))
                {
                    for (int i = 0; i < list.Count; i++)
                    {
                        if (list[i].Product.ID == productID)
                        {
                            list.Remove(list[i]);
                        }
                    }
                }

            }
            return Json(new { delete = true }, JsonRequestBehavior.AllowGet);
        }
    }
}
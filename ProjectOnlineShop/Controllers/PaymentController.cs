using Model.EF;
using Model.Dao;
using ProjectOnlineShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Threading;

namespace ProjectOnlineShop.Controllers
{
    public class PaymentController : Controller
    {
        // GET: Payment
        public ActionResult Index()
        {
            try
            {
                if  (Session["CartSession"] == null || ((List < CartItem > )Session["CartSession"]).Count == 0)
                {
                    return RedirectToAction("Index", "Error");
                }
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

        [HttpPost]
        public ActionResult Create(string nameCustomer, string emailCustomer, string phoneCustomer, string addressCustomer)
        {
            if (Session["CartSession"] != null)
            {
                Order order = new Order();
                order.CustomerName = nameCustomer;
                order.CustomerEmail = emailCustomer;
                order.CustomerMobile = Int64.Parse(phoneCustomer);
                order.CustomerAddress = addressCustomer;
                order.CreatedDate = DateTime.Now;

                var orderDao = new OrderDao();
                long orderID = orderDao.InsertOrder(order);

                var detailDao = new DetailDao();
                List<CartItem> cart = (List<CartItem>)Session["CartSession"];
                foreach (var item in cart)
                {
                    detailDao.InsertOrderDetail(item.Product.ID, (float)item.Product.Price, item.Quantity, orderID);
                }
                Session.Remove("CartSession");
                Thread.Sleep(1000);
                return Json(new { added = true }, JsonRequestBehavior.AllowGet);
            }

            return Json(new { added = false }, JsonRequestBehavior.AllowGet);
        }
    }
}
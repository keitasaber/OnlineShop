using Model.Dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace ProjectOnlineShop.Areas.Admin.Controllers
{
    public class OrderController : BaseController
    {
        // GET: Admin/Order
        public ActionResult Index(string customerName, DateTime? date1 , DateTime? date2, bool state = false, int page = 1, int pageSize = 8)
        {
            ViewBag.CustomerName = customerName;
            if (date1 != null)
            {
                ViewBag.Date1 = date1.Value.ToString(@"yyyy-MM-ddTHH:mm:ss");
            }
            if (date2 != null)
            {
                date2.Value.AddMilliseconds(59);
                ViewBag.Date2 = date2.Value.ToString(@"yyyy-MM-ddTHH:mm:ss");
            }
            //bool stateDone;
            //if (state == "1")
            //{
            //    stateDone = true;
            //}
            //else
            //{
            //    stateDone = false;
            //}
            ViewBag.State = state;

            var orderDao = new OrderDao();
            var model = orderDao.GetList(customerName, date1, date2, state, page, pageSize);
            return View(model);
        }

        [HttpGet]
        public ActionResult GetOrderDetail(string id)
        {
            var detailDao = new DetailDao();
            var list = detailDao.GetListDetail(Int64.Parse(id));
            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(list);
            return Json(new { search = true, data = json }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult Update(string id)
        {
            var orderDao = new OrderDao();
            var state = orderDao.UpdateStateOrder(Int64.Parse(id));
            return Json(new { data = state }, JsonRequestBehavior.AllowGet);
        }
    }
}
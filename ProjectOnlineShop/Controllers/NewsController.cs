using Model.Dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace ProjectOnlineShop.Controllers
{
    public class NewsController : Controller
    {
        // GET: News
        public ActionResult Index()
        {
            try
            {
                var categoryDao = new CategoryDao();
                var model = categoryDao.ListAll(false);

                return View(model);
            }
            catch
            {
                return RedirectToAction("Index", "Error");
            }
        }

        [HttpGet]
        public ActionResult GetData(string idCategory, string currentIndex)
        {
            var contentDao = new ContentDao();
            var list = contentDao.GetListByCategoryID(Int64.Parse(idCategory), Int32.Parse(currentIndex), 3);
            var checkNext = contentDao.IsHaveNextPage(Int64.Parse(idCategory), Int32.Parse(currentIndex)+1, 3);
            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(list);
            return Json(new { success = true, data = json, checkNext = checkNext, nextPage = Int32.Parse(currentIndex) + 1 }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult Detail(string metatitle, string id)
        {
            try
            {
                if (metatitle == null && id == null)
                {
                    return RedirectToAction("Index", "News");
                }

                var contentDao = new ContentDao();
                var model = contentDao.GetByID(Int32.Parse(id));

                return View(model);
            }
            catch
            {
                return RedirectToAction("Index", "Error");
            }
        }

    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.Dao;

namespace ProjectOnlineShop.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            try
            {
                ProductCategoryDao productCategoryDao = new ProductCategoryDao();
                var model = productCategoryDao.ListAllShowOnHome();

                return View(model);
            }
            catch
            {
                return RedirectToAction("Index", "Error");
            }
        }       

    }
}
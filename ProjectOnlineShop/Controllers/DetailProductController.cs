using Model.Dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjectOnlineShop.Controllers
{
    public class DetailProductController : Controller
    {

        // GET: DetailProduct
        public ActionResult Index(String id)
        {
            try
            {
                var productDao = new ProductDao();
                var model = productDao.GetByID(Int32.Parse(id));
                SetViewBagMoreImage(model.MoreImages);
                return View(model);
            }
            catch
            {
                return RedirectToAction("Index", "Error");
            }
        }

        public void SetViewBagMoreImage(string moreImage)
        {
            if (moreImage != null)
            {
                string[] moreImages = moreImage.Split('|');
                ViewBag.MoreImages = moreImages;
            }
            else
            {
                string[] moreImages = { "", "", "" };
                ViewBag.MoreImages = moreImages;
            }
        }
    }
}
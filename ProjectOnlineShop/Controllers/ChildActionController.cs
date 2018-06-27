using Model.Dao;
using Model.EF;
using Model.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace ProjectOnlineShop.Controllers
{
    public class ChildActionController : Controller
    {
        [ChildActionOnly]
        public ActionResult CategoryInHeader()
        {
            var productCategoryDao = new ProductCategoryDao();

            var list = productCategoryDao.ListAll(false);

            return PartialView(list);
        }

        [ChildActionOnly]
        public ActionResult MenuTop()
        {
            var menuDao = new MenuDao();
            var list = menuDao.ListByTypeID(2);
            return PartialView(list);
        }

        [ChildActionOnly]
        public ActionResult FeaturedProduct()
        {
            Dictionary<ProductViewModel, string> listFeaturedProduct = new Dictionary<ProductViewModel, string>();
            ProductDao productDao = new ProductDao();
            var model = productDao.ListAllTopHot();
            foreach (var item in model)
            {
                listFeaturedProduct.Add(item, item.CategoryName);
            }

            SetViewBagProductCategory(model);
            
            return PartialView(listFeaturedProduct);
        }
        public void SetViewBagProductCategory(List<ProductViewModel> list)
        {
            ProductCategoryDao productCategoryDao = new ProductCategoryDao();
            List<ProductCategory> listFeaturedProductCateogry = new List<ProductCategory>();
            foreach (var item in list)
            {
                if (!listFeaturedProductCateogry.Contains(productCategoryDao.GetByID(item.CategoryID)))
                {
                    listFeaturedProductCateogry.Add(productCategoryDao.GetByID(item.CategoryID));
                }
            }

            ViewBag.FeaturedProductCateogries = listFeaturedProductCateogry;
        }

        [ChildActionOnly]
        public ActionResult SearchInHeader()
        {
            return PartialView();
        }

        [HttpGet]
        public ActionResult GetSearch(string test)
        {
            var productDao = new ProductDao();
            var list = productDao.SearchTop4ByName(test);
            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(list);
            return Json(new { success = true, data = json }, JsonRequestBehavior.AllowGet);
        }
    }
}
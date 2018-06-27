using Model.Dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjectOnlineShop.Controllers
{
    public class CategoryController : Controller
    {
        // GET: Category
        public ActionResult Index(string id, string name, string[] priceSearch, string[] brandID, string page = "1", string pageSize = "8", string filter = "1")
        {
            try
            {
                var productDao = new ProductDao();
                int totalRecord = 0;
                var model = productDao.ListAllAtClient(Int64.Parse(id), name, brandID, priceSearch, Int32.Parse(filter), ref totalRecord, Int32.Parse(page), Int32.Parse(pageSize));

                ViewBag.TotalRecord = totalRecord;
                ViewBag.CurrentPage = Int32.Parse(page);

                int maxPage = 5;
                int totalPage = 0;

                totalPage = (int)Math.Ceiling((double)(totalRecord * 1.0 / Int32.Parse(pageSize)));
                ViewBag.TotalPage = totalPage;
                ViewBag.MaxPage = maxPage;
                ViewBag.FirstPage = 1;
                ViewBag.LastPage = totalPage;
                ViewBag.NextPage = Int32.Parse(page) + 1;
                ViewBag.PreviousPage = Int32.Parse(page) - 1;
                ViewBag.id = id;
                ViewBag.MetaTitle = (new ProductCategoryDao()).GetByID(Int32.Parse(id)).MetaTitle;
                ViewBag.NameCategory = (new ProductCategoryDao()).GetByID(Int32.Parse(id)).Name;
                SetViewBagPrice(Int32.Parse(id));
                SetViewBagBrand(Int32.Parse(id));
                SetViewBagSelectedPrices(brandID);
                SetViewBagSelectedBrands(priceSearch);
                SetViewBagNameSearch(name);
                SetVewBagSelectedFilter(Int32.Parse(filter));
                SetViewBagFilter();

                return View(model);
            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }

        }

        public void SetViewBagSelectedPrices(string[] brandID)
        {
            if (brandID != null)
            {
                ViewBag.SelectedBrandID = brandID;
            }
        }

        public void SetViewBagSelectedBrands(string[] priceSearch)
        {
            if (priceSearch != null)
            {
                ViewBag.SelectedPriceSearch = priceSearch;
            }
        }

        public void SetViewBagPrice(int categoryID)
        {
            Dictionary<int, string> priceList = new Dictionary<int, string>();
            var productDao = new ProductDao();
            var maxPrice = productDao.GetMaxPriceByCateogoryID(categoryID);
            int pricePoint = 0;
            priceList.Add(1, "$" + (pricePoint) + " - " + "$" + (pricePoint + 400));
            for (int i = 2; pricePoint + 400 <= maxPrice; i++)
            {
                pricePoint += 400;
                priceList.Add(i, "$" + (pricePoint) + " - " + "$" + (pricePoint + 400));
            }
            ViewBag.SearchPrice = priceList;
        }

        public void SetViewBagNameSearch(string name)
        {
            if (!string.IsNullOrEmpty(name))
            {
                ViewBag.NameSearch = name;
            }
        }

        public void SetViewBagBrand(int categoryID)
        {
            var brandDao = new BrandDao();
            ViewBag.ListBrand = brandDao.GetBrandByCategoryID(categoryID);
        }

        public void SetViewBagFilter()
        {
            Dictionary<int, string> listFilter = new Dictionary<int, string>();
            listFilter.Add(1, "Low Price");
            listFilter.Add(2, "Hight Price");
            ViewBag.ListFilter = listFilter;
        }

        public void SetVewBagSelectedFilter(int value)
        {
            ViewBag.SelectedFilter = value;
        }
    }
}
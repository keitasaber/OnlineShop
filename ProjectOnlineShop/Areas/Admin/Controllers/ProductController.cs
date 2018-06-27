using Model.Dao;
using Model.EF;
using Model.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace ProjectOnlineShop.Areas.Admin.Controllers
{
    public class ProductController : BaseController
    {
        // GET: Admin/Product
        public ActionResult Index(string name, string state = "0", string categoryID = "0", string brandID = "0", int page = 1, int pageSize = 8)
        {

            int totalRecord = 0;

            var productDao = new ProductDao();
            var model = productDao.ListAll(name, int.Parse(state), long.Parse(categoryID), long.Parse(brandID), ref totalRecord, page, pageSize);

            ViewBag.TotalRecord = totalRecord;
            ViewBag.CurrentPage = page;

            int maxPage = 5;
            int totalPage = 0;

            totalPage = (int)Math.Ceiling((double)(totalRecord * 1.0 / pageSize));
            ViewBag.TotalPage = totalPage;
            ViewBag.MaxPage = maxPage;
            ViewBag.FirstPage = 1;
            ViewBag.LastPage = totalPage;
            ViewBag.NextPage = page + 1;
            ViewBag.PreviousPage = page - 1;

            if (Int32.Parse(state) == 0)
            {
                ViewBag.AllState = "selected";
            }
            else if (Int32.Parse(state) == -1)
            {
                ViewBag.LockState = "selected";
            }
            else if (Int32.Parse(state) == 1)
            {
                ViewBag.OpenState = "selected";
            }
            ViewBag.State = state;
            ViewBag.Name = name;
            ViewBag.CategoryID = long.Parse(categoryID);
            ViewBag.BrandID = long.Parse(brandID);

            SetViewBagCategory(long.Parse(categoryID), true);
            SetViewBagBrand(long.Parse(brandID), true);
            
            return View(model);
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

        public void SetViewBagCategory(long? categoryID, bool isShow)
        {
            var productCategoryDao = new ProductCategoryDao();
            ViewBag.Categories = new SelectList(productCategoryDao.ListAll(isShow), "ID", "Name", categoryID);
        }

        public void SetViewBagBrand(long? brandID, bool isShow)
        {
            var brandDao = new BrandDao();
            ViewBag.Brands = new SelectList(brandDao.ListAll(isShow), "ID", "Name", brandID);
        }

        [HttpGet]
        public ActionResult Create()
        {
            SetViewBagBrand(null, false);
            SetViewBagCategory(null, false);
            return View();
        }

        [HttpPost]
        public ActionResult Create(ProductViewModel entity)
        {
            if (ModelState.IsValid)
            {
                var product = new Product();
                product.Name = entity.Name.Trim();
                product.MetaTitle = entity.MetaTitle;
                product.Description = entity.Description;
                product.Image = entity.Image;
                product.MoreImages = entity.MoreImages;
                product.Price = entity.Price;
                product.CategoryID = entity.CategoryID;
                product.Detail = entity.Detail;
                product.BrandID = entity.BrandID;
                product.Status = entity.Status;
                product.TopHot = entity.TopHot;

                var productDao = new ProductDao();
                var categoryDao = new CategoryDao();
                var brandDao = new BrandDao();

                long result = productDao.Insert(product);
                if (result > 0)
                {
                    ShowNotify("Update successfully", "success");
                    return RedirectToAction("Index", "Product");
                }
                else if (result == -1)
                {
                    ShowNotify("This '" + categoryDao.GetByID(product.CategoryID).Name + "' category is locked", "error");
                }
                else if (result == -2)
                {
                    ShowNotify("This '" + brandDao.GetByID(product.BrandID).Name + "' brand is locked", "error");
                }
                else if(result == -3)
                {
                    ShowNotify("Input price of product please !!!", "error");
                }
                else
                {
                    ShowNotify("System error", "error");
                }
            }

            return View("Create");
        }

        [HttpGet]
        public ActionResult Edit(string id)
        {
            if (id == null || !Regex.IsMatch(id, @"\d"))
            {
                return RedirectToAction("Index", "Content");
            }

            var productDao = new ProductDao();
            var product = productDao.GetByID(Int32.Parse(id));
            if (product == null)
            {
                return RedirectToAction("Index", "Content");
            }
            string moreImage = product.MoreImages;
            SetViewBagMoreImage(moreImage);
            SetViewBagCategory(product.CategoryID, false);
            SetViewBagBrand(product.BrandID, false);
            string format = @"yyyy-MM-ddTHH:mm:ss";
            try
            {
                ViewBag.TopHot = product.TopHot.Value.ToString(format);
            }
            catch
            {
                ViewBag.TopHot = null;
            }
            return View(product);

        }

        [HttpPost]
        public ActionResult Edit(ProductViewModel entity)
        {
            if (ModelState.IsValid)
            {
                var product = new Product();
                product.ID = entity.ID;
                product.Name = entity.Name.Trim();
                product.MetaTitle = entity.MetaTitle;
                product.Description = entity.Description;
                product.Image = entity.Image;
                product.MoreImages = entity.MoreImages;
                product.Price = entity.Price;
                product.CategoryID = entity.CategoryID;
                product.Detail = entity.Detail;
                product.BrandID = entity.BrandID;
                product.Status = entity.Status;
                product.TopHot = entity.TopHot;

                var productDao = new ProductDao();
                var categoryDao = new CategoryDao();
                var brandDao = new BrandDao();

                long result = productDao.Update(product);
                if (result > 0)
                {
                    ShowNotify("Update successfully", "success");
                    return RedirectToAction("Index", "Product");
                }
                else if (result == -1)
                {
                    ShowNotify("This '" + categoryDao.GetByID(product.CategoryID).Name + "' category is locked", "error");
                }
                else if (result == -2)
                {
                    ShowNotify("This '" + brandDao.GetByID(product.BrandID).Name + "' brand is locked", "error");
                }
                else if (result == -3)
                {
                    ShowNotify("Input price of product please !!!", "error");
                }
                else
                {
                    ShowNotify("System error", "error");
                }
            }
            SetViewBagBrand(entity.BrandID, false);
            SetViewBagCategory(entity.CategoryID, false);
            return View("Edit");
        }

        [HttpGet]
        public ActionResult Delete(string id)
        {
            if (id == null || !Regex.IsMatch(id, @"\d"))
            {
                return RedirectToAction("Index", "Content");
            }

            var productDao = new ProductDao();

            productDao.Delete(Int32.Parse(id));

            ShowNotify("Delete successfully", "success");
            return RedirectToAction("Index");
        }
    }
}
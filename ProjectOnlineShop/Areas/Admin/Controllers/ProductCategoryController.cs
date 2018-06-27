using Model.Dao;
using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.IO;

namespace ProjectOnlineShop.Areas.Admin.Controllers
{
    public class ProductCategoryController : BaseController
    {
        // GET: Admin/ProductCategory
        public ActionResult Index(string name, string state = "0", string showOnHome = "0", int page = 1, int pageSize = 8)
        {

            ViewBag.Name = name;

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

            if (Int32.Parse(showOnHome) == 0)
            {
                ViewBag.AllShowOnHome = "selected";
            }
            else if (Int32.Parse(showOnHome) == -1)
            {
                ViewBag.LockShowOnHome = "selected";
            }
            else if (Int32.Parse(showOnHome) == 1)
            {
                ViewBag.OpenShowOnHome = "selected";
            }
            ViewBag.ShowOnHome = showOnHome;

            var productCategoryDao = new ProductCategoryDao();
            var model = productCategoryDao.ListAll(name, Int32.Parse(state), Int32.Parse(showOnHome), page, pageSize);
            return View(model);
        }

        [HttpGet]
        public ActionResult Create()
        {
            SetViewBagICon(null);
            return View();
        }

        [HttpGet]
        public ActionResult Edit(String id)
        {
            if (id == null || !Regex.IsMatch(id, @"\d"))
            {
                return RedirectToAction("Index", "ProductCategory");
            }

            
            var categoryDao = new ProductCategoryDao();
            var category = categoryDao.GetByID(Int32.Parse(id));
            if (category == null)
            {
                return RedirectToAction("Index", "ProductCategory");
            }
            SetViewBagICon(category.Icon);
            return View(category);
        }

        public void SetViewBagICon(string keySelected)
        {

            string json = System.IO.File.ReadAllText(Server.MapPath(@"~/App_Data/fa-icons.json"));
            var listIcon = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);
            ViewBag.Icons = new SelectList(listIcon, "Key", "Value", keySelected);
        }

        [HttpPost]
        public ActionResult Create(ProductCategory entity)
        {
            if (ModelState.IsValid)
            {
                var productCategoryDao = new ProductCategoryDao();
                entity.Name = entity.Name.Trim();
                long result = productCategoryDao.Insert(entity);

                if (result > 0)
                {
                    ShowNotify("Add successfully", "success");
                    return RedirectToAction("Index", "ProductCategory");
                }
                else if (result == -1)
                {
                    ShowNotify("This name already exists", "error");
                }
                else
                {
                    ShowNotify("System error", "error");
                }
            }
            return View("Create");
        }

        [HttpPost]
        public ActionResult Edit(ProductCategory entity)
        {
            if (ModelState.IsValid)
            {                
                var productCategoryDao = new ProductCategoryDao();
                entity.Name = entity.Name.Trim();
                int result = productCategoryDao.Update(entity);
                if (result == 1)
                {
                    ShowNotify("Update successfully", "success");
                    return RedirectToAction("Index", "ProductCategory");
                }
                else if (result == -1)
                {
                    ShowNotify("This name already exists", "error");
                }
                else if(result == 0)
                {
                    ShowNotify("System error", "error");
                }
            }
            return View("Edit");
        }

        [HttpGet]
        public ActionResult Delete(string id)
        {
            if (id == null || !Regex.IsMatch(id, @"\d"))
            {
                return RedirectToAction("Index", "ProductCategory");
            }

            var productCategoryDao = new ProductCategoryDao();

            productCategoryDao.Delete(Int32.Parse(id));

            ShowNotify("Delete successfully", "success");
            return RedirectToAction("Index");
        }        
    }
}
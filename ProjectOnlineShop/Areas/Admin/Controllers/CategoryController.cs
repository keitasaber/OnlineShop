using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.Dao;
using ProjectOnlineShop.Areas.Admin.Models;
using Model.EF;
using System.Text.RegularExpressions;

namespace ProjectOnlineShop.Areas.Admin.Controllers
{
    public class CategoryController : BaseController
    {
        // GET: Admin/Category
        public ActionResult Index(string name, string state = "0", int page = 1, int pageSize = 8)
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

            var categoryDao = new CategoryDao();
            var model = categoryDao.ListAll(name, Int32.Parse(state), page, pageSize);
            return View(model);
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Edit(string id)
        {
            if (id == null || !Regex.IsMatch(id, @"\d"))
            {
                return RedirectToAction("Index", "Category");
            }

            var categoryDao = new CategoryDao();
            var category = categoryDao.GetByID(Int32.Parse(id));
            if (category == null)
            {
                return RedirectToAction("Index", "Category");
            }

            return View(category);
        }

        [HttpPost]
        public ActionResult Create(Category entity)
        {
            if (ModelState.IsValid)
            {
                var categoryDao = new CategoryDao();

                entity.Name = entity.Name.Trim();
                long result = categoryDao.Insert(entity);
                if (result > 0)
                {
                    ShowNotify("Add successfully", "success");
                    return RedirectToAction("Index", "Category");
                }
                else if (result == -1)
                {
                    ShowNotify("This name of category already exists", "error");
                }
                else
                {
                    ShowNotify("System error", "error");
                }
            }

            return View("Create");
        }

        [HttpPost]
        public ActionResult Edit(Category entity)
        {
            if (ModelState.IsValid)
            {
                var categoryDao = new CategoryDao();
                entity.Name = entity.Name.Trim();
                int result = categoryDao.Update(entity);
                if (result == 1)
                {
                    ShowNotify("Update successfully", "success");
                    return RedirectToAction("Index", "Category");
                }
                else if (result == -1)
                {
                    ShowNotify("This name already exists", "error");
                }
                else if (result == 0)
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
                return RedirectToAction("Index", "Category");
            }

            var categoryDao = new CategoryDao();

            categoryDao.Delete(Int32.Parse(id));

            ShowNotify("Delete successfully", "success");
            return RedirectToAction("Index");
        }
    }
}
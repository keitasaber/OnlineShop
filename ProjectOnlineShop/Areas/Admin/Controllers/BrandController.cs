using Model.Dao;
using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace ProjectOnlineShop.Areas.Admin.Controllers
{
    public class BrandController : BaseController
    {
        // GET: Admin/Brand
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

            var brandDao = new BrandDao();
            var model = brandDao.ListAll(name, Int32.Parse(state), page, pageSize);
            return View(model);
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Brand entity)
        {
            if (ModelState.IsValid)
            {
                var brandDao = new BrandDao();

                entity.Name = entity.Name.Trim();
                long result = brandDao.Insert(entity);
                if (result > 0)
                {
                    ShowNotify("Update successfully", "success");
                    return RedirectToAction("Index", "Brand");
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

        [HttpGet]
        public ActionResult Edit(string id)
        {
            if (id == null || !Regex.IsMatch(id, @"\d"))
            {
                return RedirectToAction("Index", "Brand");
            }

            var brandDao = new BrandDao();
            var product = brandDao.GetByID(Int32.Parse(id));
            if (product == null)
            {
                return RedirectToAction("Index", "Brand");
            }

            return View(product);
        }

        [HttpPost]
        public ActionResult Edit(Brand entity)
        {
            if (ModelState.IsValid)
            {
                var brandDao = new BrandDao();
                entity.Name = entity.Name.Trim();
                int result = brandDao.Update(entity);
                if (result == 1)
                {
                    ShowNotify("Update successfully", "success");
                    return RedirectToAction("Index", "Brand");
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
                return RedirectToAction("Index", "Brand");
            }

            var brandDao = new BrandDao();

            brandDao.Delete(Int32.Parse(id));

            ShowNotify("Delete successfully", "success");
            return RedirectToAction("Index");
        }
    }
}
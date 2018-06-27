using Model.Dao;
using Model.EF;
using Model.ViewModel;
using ProjectOnlineShop.Areas.Admin.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace ProjectOnlineShop.Areas.Admin.Controllers
{
    public class ContentController : BaseController
    {
        // GET: Admin/Content
        public ActionResult Index(string name, string state = "0", string categoryID = "0" ,int page = 1, int pageSize = 8)
        {
            var contentDao = new ContentDao();

            int totalRecord = 0;
            List<ContentViewModel> list = contentDao.ListAll(name, int.Parse(state), long.Parse(categoryID),ref totalRecord, page, pageSize);
            ViewBag.TotalRecord = totalRecord;
            ViewBag.CurrentPage = page;

            int maxPage = 5;
            int totalPage = 0;

            totalPage = (int)Math.Ceiling((double)(totalRecord*1.0 / pageSize));
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

            SetViewBagCategory(long.Parse(categoryID), true); 

            return View(list);
        }

        public void SetViewBagCategory(long? categoryID, bool isShow)
        {
            var categoryDao = new CategoryDao();
            ViewBag.Categories = new SelectList(categoryDao.ListAll(isShow), "ID", "Name", categoryID);
        }

        [HttpGet]
        public ActionResult Edit(string id)
        {
            if (id == null || !Regex.IsMatch(id, @"\d"))
            {
                return RedirectToAction("Index", "Content");
            }

            var contentDao = new ContentDao();
            var content = contentDao.GetByID(Int32.Parse(id));
            if (content == null)
            {
                return RedirectToAction("Index", "Content");
            }

            SetViewBagCategory(content.CategoryID, false);

            return View(content);
        }

        [HttpPost]
        public ActionResult Edit(ContentViewModel contentView)
        {            

           if (ModelState.IsValid)
            {
                Content content = new Content();
                content.ID = contentView.ID;
                content.Name = contentView.Name;
                content.MetaTitle = contentView.MetaTitle;
                content.Image = contentView.Image;
                content.Description = contentView.Description;
                content.Detail = contentView.Detail;
                content.CategoryID = contentView.CategoryID;
                content.Status = contentView.Status;

                var contentDao = new ContentDao();
                var categoryDao = new CategoryDao();

                int result = contentDao.Update(content);
                if (result == 1)
                {
                    ShowNotify("Update successfully", "success");
                    return RedirectToAction("Index", "Content");
                }
                else if (result == -1)
                {
                    ShowNotify("This '" + categoryDao.GetByID(content.CategoryID).Name + "' category is locked", "error");
                }
                else if (result == 0)
                {
                    ShowNotify("System error", "error");
                }
            }

            SetViewBagCategory(contentView.ID, false);

            return View("Edit");
        }

        [HttpGet]
        public ActionResult Create()
        {
            SetViewBagCategory(null, false);
            return View();
        }

        [HttpPost]
        public ActionResult Create(ContentViewModel contentView)
        {
            if (ModelState.IsValid)
            {
                Content content = new Content();
                content.Name = contentView.Name.Trim() ;
                content.MetaTitle = contentView.MetaTitle;
                content.Image = contentView.Image;
                content.Description = contentView.Description;
                content.Detail = contentView.Detail;
                content.CategoryID = contentView.CategoryID;
                content.Status = contentView.Status;

                var contentDao = new ContentDao();
                var categoryDao = new CategoryDao();

                long result = contentDao.Insert(content);
                if (result > 0)
                {
                    ShowNotify("Add successfully", "success");
                    return RedirectToAction("Index", "Content");
                }
                else if (result == -1)
                {
                    ShowNotify("This '" + categoryDao.GetByID(content.CategoryID).Name + "' category is locked", "error");
                }
                else
                {
                    ShowNotify("System error", "error");
                }
            }

            SetViewBagCategory(null, false);
            return View("Create");
        }

        [HttpGet]
        public ActionResult Delete(string id)
        {
            if (id == null || !Regex.IsMatch(id, @"\d"))
            {
                return RedirectToAction("Index", "Content");
            }

            var contentDao = new ContentDao();

            contentDao.Delete(Int32.Parse(id));

            ShowNotify("Delete successfully", "success");
            return RedirectToAction("Index");
        }
    }
}
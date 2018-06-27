using Model.Dao;
using ProjectOnlineShop.Areas.Admin.Models;
using ProjectOnlineShop.Commons;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjectOnlineShop.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        // GET: Admin/Login
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login(LoginModel loginModel)
        {
            if (ModelState.IsValid)
            {
                var userDao = new UserDao();
                var result = userDao.Login(loginModel.Username, Encryptor.MD5Hash(loginModel.Password));
                if (result == 1)
                {
                    var userLogined = userDao.GetByUsername(loginModel.Username);
                    var userSesison = new UserSession();
                    userSesison.UserID = userLogined.ID;
                    userSesison.Username = userLogined.Username;
                    Session.Add(CommonConstants.USER_SESSION, userSesison);
                    return RedirectToAction("Index", "Home");
                }
                else if (result == 0)
                {
                    ModelState.AddModelError("", "This account is currently not available!");
                }
                else if (result == -1)
                {
                    ModelState.AddModelError("", "this account is locked!");
                }
                else if (result == -2)
                {
                    ModelState.AddModelError("", "Wrong password!");
                }

            }
            return View("Index");
        }

        public ActionResult Logout()
        {
            if(Session[CommonConstants.USER_SESSION] != null)
            {
                Session.Remove(CommonConstants.USER_SESSION);
                return RedirectToAction("Index", "Login", new { area = "admin" });
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }

        }
    }
}
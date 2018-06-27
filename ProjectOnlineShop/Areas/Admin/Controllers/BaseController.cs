using ProjectOnlineShop.Commons;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjectOnlineShop.Areas.Admin.Controllers
{
    public class BaseController : Controller
    {
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            var session = (UserSession)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                filterContext.Result = new RedirectToRouteResult(
                    new System.Web.Routing.RouteValueDictionary(new { controller = "Login", action = "Index", Area = "Admin"}));
            }
            base.OnActionExecuted(filterContext);
        }

        public void ShowNotify(string message, string type)
        {
            TempData["ShowMessage"] = message;
            if (type == "success")
            {
                TempData["MessageType"] = "success";
            }
            else if (type == "error")
            {
                TempData["MessageType"] = "error";
            }
        }
    }
}
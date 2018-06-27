using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ProjectOnlineShop
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            // show product in category
            routes.MapRoute(
                name: "Category",
                url: "category/{metatitle}-{id}",
                defaults: new { controller = "Category", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "ProjectOnlineShop.Controllers" }
            );

            // detail of product
            routes.MapRoute(
                name: "DetailProduct",
                url: "detail/{metatitle}-{id}",
                defaults: new { controller = "DetailProduct", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "ProjectOnlineShop.Controllers" }
            );

            // show detail news con client
            routes.MapRoute(
                name: "DetailNews",
                url: "news/{metatitle}-{id}",
                defaults: new { controller = "News", action = "Detail", id = UrlParameter.Optional },
                namespaces: new[] { "ProjectOnlineShop.Controllers" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "ProjectOnlineShop.Controllers" }
            );

        }
    }
}

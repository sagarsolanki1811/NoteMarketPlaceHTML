using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace WebApplication
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            /* routes.MapRoute(
                 name: "returnURL",
                 url: "{controller}/{action}/{ReturnUrl}",
                 defaults: new { controller = "Auth", action = "LogIn", ReturnUrl = UrlParameter.Optional }
             );
            */

           /* routes.MapRoute(
               name: "buyerAck",
               url: "{controller}/{action}/{id}/{memberid}/{search}/{sortBy}",
               defaults: new { controller = "Auth", action = "SignUp", id = UrlParameter.Optional, memberid = UrlParameter.Optional, search=UrlParameter.Optional, sortBy = UrlParameter.Optional }
           ); */

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Auth", action = "LogIn", id = UrlParameter.Optional }
            );          
        }
    }
}

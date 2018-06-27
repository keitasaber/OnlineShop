using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ProjectOnlineShop.Startup))]
namespace ProjectOnlineShop
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            
        }
    }
}

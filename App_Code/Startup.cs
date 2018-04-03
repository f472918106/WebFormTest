using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ASP_test.Startup))]
namespace ASP_test
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

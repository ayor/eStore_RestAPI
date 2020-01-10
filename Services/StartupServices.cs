using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using VideoRentalApi.Context;

namespace VideoRentalApi.Services
{
    public class StartupServices
    {
        public static void Authenticate(IServiceCollection services)
        {
            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
               options.TokenValidationParameters = new TokenValidationParameters
               {
                   ValidateIssuer = true,
                   ValidateAudience = true,
                   ValidateIssuerSigningKey = true,
                   ValidIssuer = "ay.com",
                   ValidAudience = "ay.com",
                   IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(("!@#%&hggsu()si(&d*()(*&@&^%")))
               }
           );
        }
        public static void AddDBContext(IServiceCollection services, IConfiguration Configuration)
        {
            services.AddDbContextPool<ApiContext>(options =>
                options.UseSqlServer(Configuration.GetConnectionString("RentalStoreDBConnection"))
            );
        }

        public static void AddCors(IServiceCollection services)
        {
            services.AddCors(options =>
            {
                options.AddPolicy("CorsPolicy", builder => builder.AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader()
                .AllowAnyOrigin()
                .AllowCredentials()
                .WithExposedHeaders("token", "errorMessage", "expiresIn"));

            });
        }

        public static void AddSwagger(IServiceCollection services)
        {
            services.AddSwaggerDocument(service =>
            {
                service.Version = "V1";
                service.Title = "VideoRental Api";
                service.Description = "A web Api for the video rental project ";
            }
                );
        }
    }
}

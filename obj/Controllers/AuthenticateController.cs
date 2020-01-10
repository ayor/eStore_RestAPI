using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using videorentalapi_aws.Context;
using videorentalapi_aws.Models;

namespace videorentalapi_aws.Controllers
{
    public class AuthenticateController : ControllerBase
    {
        private ApiContext _apicontext;

        public AuthenticateController(ApiContext apicontext)
        {
            _apicontext = apicontext;
        }

        #region AuthenticateUser
        [Route("api/v1/user")]
        [HttpPost("auth")]
        public IActionResult AuthenticateUser([FromBody] Customer customerData)
        {
            try
            {
                //if user is valid
                bool IsValidUser = _apicontext.Customer.Any(el => el.Name == customerData.Name && el.Password == customerData.Password);

                Customer validUser = _apicontext.Customer.Single(el => el.Name == customerData.Name && el.Password == customerData.Password);

                if (IsValidUser)
                {
                    //implement the Json Web Token authentication 
                    Claim[] claimsData = new[] { new Claim(ClaimTypes.Name, customerData.Name), new Claim(ClaimTypes.OtherPhone, customerData.Password) };

                    var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("!@#%&hggsu()si(&d*()(*&@&^%"));
                    var signInCred = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

                    var token = new JwtSecurityToken(
                        issuer: "ay.com",
                        audience: "ay.com",
                        claims: claimsData,
                        expires: DateTime.Now.AddMinutes(1),
                        signingCredentials: signInCred
                        );

                    var tokenString = new JwtSecurityTokenHandler().WriteToken(token);

                    //send token to user 
                    Response.Headers.Add("token", tokenString);
                    Response.Headers.Add("expiresIn", token.ValidTo.AddHours(1).ToString());

                    return Ok(validUser);

                }
            }
            catch (Exception ex)
            {
                Response.Headers.Add("errorMessage", ex.Message);
            }
            return Unauthorized();
        }

        #endregion

        #region RegisterUser
        [HttpPost("Register")]
        public void Register([FromBody] Customer customer)
        {
            //check if user exists 
            bool customerExists = _apicontext.Customer.Any(el => el.Name == customer.Name && el.Email == customer.Email);

            // if (customerExists)
            if (customerExists)

            {
                Response.Headers.Add("errorMessage", "User Name Already Exists");

                return;
            }
            else
            {
                //save Customer
                _apicontext.Customer.Add(customer);
                _apicontext.SaveChanges();
            }

        }
        #endregion
    }
}
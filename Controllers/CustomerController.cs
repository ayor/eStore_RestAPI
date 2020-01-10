using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using VideoRentalApi.Models;
using VideoRentalApi.Context;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Microsoft.AspNetCore.Authorization;

namespace VideoRentalApi.Controllers
{
    
    [Route("api/v1/[controller]")]
    [ApiController]
    [Authorize]
    public  class CustomerController : ControllerBase
    {
        #region Constructor
        private ApiContext _apiContext;
        public CustomerController(ApiContext apicontext)
        {
            this._apiContext = apicontext;
        }
        #endregion

        #region GetUser
        // GET api/values
        [HttpGet()]
        public List<Customer> Get()
        {

            List<Customer> customerList = _apiContext.Customer.ToList<Customer>();
            return customerList;
        }

        //[HttpGet("Get")]
        //public Customer  Get([FromBody] Customer customerData)
        //{
            
        //   var customer = _apiContext.Customer.Where(cust => cust.Name == customerData.Name && cust.Password == customerData.Password).FirstOrDefault();
        //   return customer;
        //}

        #endregion

        #region 
        [HttpPut("{customer}")]
        public void Put(Customer customer)
        {         
        }
        [HttpDelete("{customer}")]
        public void Delete(Customer customer)
        {         
        }
        #endregion
    }
}

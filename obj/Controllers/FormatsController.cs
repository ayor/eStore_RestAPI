using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using videorentalapi_aws.Context;
using videorentalapi_aws.Models;

namespace videorentalapi_aws.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FormatsController
    {
        private ApiContext _apiContext;
        public FormatsController(ApiContext apiContext)
        {
            _apiContext = apiContext;
        }
        [HttpGet]
        public List<VideoFormat> Get()
        {
            return _apiContext.Formats.ToList();
        }
    }
}

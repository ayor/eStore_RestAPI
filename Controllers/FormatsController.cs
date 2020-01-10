using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VideoRentalApi.Context;
using VideoRentalApi.Models;

namespace VideoRentalApi.Controllers
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

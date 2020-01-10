using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VideoRentalApi.Models;
using VideoRentalApi.Context;

namespace VideoRentalApi.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class VideoController : Controller
    {
        private ApiContext _apiContext;
        public VideoController(ApiContext apiContext)
        {
            this._apiContext = apiContext;
        }
        [HttpGet()]
        public List<Videos> Get()
        {
            List<Videos> videoList =   _apiContext.Videos.ToList<Videos>();
            return videoList;
        }
        [HttpGet("{id}")]
        public Videos Get(int id)
        {
            return _apiContext.Videos.Where(video => video.ID == id).FirstOrDefault();
        }
        [HttpPost()]
        public void Post([FromBody]Videos video)
        {
            _apiContext.Videos.Add(video);
            _apiContext.SaveChanges();    
        }
        [HttpPut()]
        public void Put(Videos video)
        {
            
        }
         [HttpDelete()]
        public void Delete(Videos video)
        {
            
        }


    }
}

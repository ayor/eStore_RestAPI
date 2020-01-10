using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using VideoRentalApi.Context;
using VideoRentalApi.Models;
using System;

namespace VideoRentalApi.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class RentalController : Controller
    {
        private ApiContext _apiContext;
        public RentalController(ApiContext apiContext)
        {
            this._apiContext = apiContext;
        }

        [HttpGet()]
        public List<Rental> Get()
        {
            return _apiContext.Rental.ToList();

        }


        [HttpGet("{userid}")]
        public List<string> Get(int userid)
        {
            List<Rental> userRentals = _apiContext.Rental.Where(rental => rental.CustomerID == userid).ToList();

            List<string> videoTitles = new List<string>();

            foreach (Rental rental in userRentals)
            {
                videoTitles.Add(rental.VideoTitle);
            }

            return videoTitles;
        }

        [HttpPost]
        public void Post([FromBody]Rental rentalData)
        {
            /*
             * reduce the Video stock by the requestedQuantity 
             */
            Videos rentedVideo = _apiContext.Videos.Where(video => video.ID == rentalData.VideoID).FirstOrDefault();
            rentedVideo.Stock -= rentalData.RentedQuantity;

            _apiContext.Videos.Update(rentedVideo);

            /*            
                - Save data in the rental database 
               */
            _apiContext.Rental.Add(rentalData);
            _apiContext.SaveChanges();
        }
        [HttpPut]
        public void Put([FromBody] Rental rentalData)
        {
           Rental updatedRental =  _apiContext.Rental.Where(rental => (rental.CustomerID == rentalData.CustomerID) && (rental.RentalDate == rentalData.RentalDate)).FirstOrDefault();
            updatedRental.ReturnDate = DateTime.Now;
            _apiContext.Rental.Update(updatedRental);

           Videos returningVideo =  _apiContext.Videos.Where(video => video.ID == updatedRental.VideoID).FirstOrDefault();
            returningVideo.Stock += updatedRental.RentedQuantity;

            _apiContext.Videos.Update(returningVideo);
            _apiContext.SaveChanges();
        }
        [HttpDelete]
        public void Delete()
        {

        }



    }
}

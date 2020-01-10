using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VideoRentalApi.Models
{
    public class Rental
    {
        public  int Id { get; set; }
        public int VideoID { get; set; }
        public int CustomerID { get; set; }
        public string VideoTitle { get; set; }
        public string CustomerName { get; set; }
        public string VideoFormat { get; set; }
        public int RentedQuantity { get; set; }
        public DateTime? RentalDate { get; set; }
        public DateTime? ReturnDate { get; set; }

    }
}

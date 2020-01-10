using Microsoft.EntityFrameworkCore;
using System;
using VideoRentalApi.Models;

namespace VideoRentalApi.Context
{
    public class ApiContext : DbContext
    {
        public ApiContext(DbContextOptions<ApiContext> options) : base(options)
        {

        }
        public DbSet<Videos> Videos { get; set; }
        public DbSet<Customer> Customer { get; set; }
        public DbSet<VideoFormat> Formats { get; set; }
        public DbSet<Rental> Rental { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<VideoFormat>().HasData(
                new VideoFormat
                {
                    Id = 1,
                    Formats = "Blueray"
                },
                new VideoFormat
                {
                    Id = 2,
                    Formats = "Hd-Rip"
                },
                new VideoFormat
                {
                    Id = 3,
                    Formats = "Cam-Rip"
                }
                );
            modelBuilder.Entity<Rental>().HasData(
                new Rental
                {
                    Id = 1,
                    CustomerID = 1,
                    CustomerName = "ayo",
                    VideoID = 1,
                    VideoFormat = "Blueray",
                    VideoTitle = "Bat Man",
                    RentedQuantity = 1,
                    RentalDate = DateTime.Now,
                    ReturnDate = null
                });
            modelBuilder.Entity<Customer>().HasData(
                new Customer
                {
                    ID = 1,
                    Name = "admin",
                    Password = "admin",
                    Address = "admin",
                }
                );
            modelBuilder.Entity<Videos>().HasData(
                new Videos
                {
                    ID =1,
                    Title = "Test Video",
                    Stock = 10
                });
        }
    }
}


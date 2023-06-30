using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace Lab2.Models
{
    public partial class Model1 : DbContext
    {
        public Model1()
            : base("name=Model1")
        {
        }

        public virtual DbSet<Countries> Countries { get; set; }
        public virtual DbSet<Orders> Orders { get; set; }
        public virtual DbSet<Touroperators> Touroperators { get; set; }
        public virtual DbSet<Tours> Tours { get; set; }
        public virtual DbSet<Vouchers> Vouchers { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Tours>()
                .HasMany(e => e.Vouchers)
                .WithOptional(e => e.Tours)
                .HasForeignKey(e => e.idTour);

            modelBuilder.Entity<Vouchers>()
                .Property(e => e.price)
                .HasPrecision(19, 4);
        }
    }
}

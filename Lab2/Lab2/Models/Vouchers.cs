namespace Lab2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Vouchers
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Vouchers()
        {
            Orders = new HashSet<Orders>();
        }

        [Key]
        public int idVoucher { get; set; }

        public int? idTour { get; set; }

        [StringLength(255)]
        public string voucherName { get; set; }

        [StringLength(255)]
        public string descr { get; set; }

        [Column(TypeName = "money")]
        public decimal? price { get; set; }

        public int? numberOfPeople { get; set; }

        public bool? nutrition { get; set; }

        public bool? accommodation { get; set; }

        public bool? hot { get; set; }

        public int? discount { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Orders> Orders { get; set; }

        public virtual Tours Tours { get; set; }
    }
}

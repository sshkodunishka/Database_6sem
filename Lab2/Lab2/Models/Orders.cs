namespace Lab2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Orders
    {
        [Key]
        public int idOrder { get; set; }

        public int? idVoucher { get; set; }

        [StringLength(255)]
        public string customer { get; set; }

        public bool? pay { get; set; }

        public virtual Vouchers Vouchers { get; set; }
    }
}

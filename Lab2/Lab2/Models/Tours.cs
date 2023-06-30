namespace Lab2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Tours
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Tours()
        {
            Vouchers = new HashSet<Vouchers>();
        }

        [Key]
        public int idTours { get; set; }

        public int? idCountry { get; set; }

        public int? idOperator { get; set; }

        [StringLength(255)]
        public string tourName { get; set; }

        [StringLength(255)]
        public string descr { get; set; }

        public virtual Countries Countries { get; set; }

        public virtual Touroperators Touroperators { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Vouchers> Vouchers { get; set; }
    }
}

namespace Lab2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Touroperators
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Touroperators()
        {
            Tours = new HashSet<Tours>();
        }

        [Key]
        public int idOperator { get; set; }

        [StringLength(150)]
        public string name { get; set; }

        [StringLength(11)]
        public string phoneNumber { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Tours> Tours { get; set; }
    }
}

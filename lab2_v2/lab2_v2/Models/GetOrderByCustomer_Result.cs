//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace lab2_v2.Models
{
    using System;
    
    public partial class GetOrderByCustomer_Result
    {
        public int idOrder { get; set; }
        public Nullable<int> idVoucher { get; set; }
        public string customer { get; set; }
        public Nullable<bool> pay { get; set; }
    }
}

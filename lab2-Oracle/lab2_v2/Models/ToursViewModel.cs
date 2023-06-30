using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace lab2_v2.Models
{
    public class ToursViewModel
    {
        public IEnumerable<Tours> Tours { get; set; }
        public SelectList Statuses { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using lab2_v2.DAL;
using lab2_v2.Models;
using WebGrease.Css.Extensions;

namespace lab2_v2.Controllers
{
    public class ToursController : Controller
    {
        private TravelAgencyEntities db = new TravelAgencyEntities();

        // GET: Tours
        public ActionResult Index(string status)
        {
            //TourRepository tourRepository = new TourRepository();
            //var tours = tourRepository.GetAllTours();
            //return View(tours.ToList());
            CountriesRepository countryRepository= new CountriesRepository();
            TourRepository tourRepository = new TourRepository();
            IEnumerable<Tours> tours = tourRepository.GetAllTours();
            if (status == null || Int32.Parse(status) == -1)
            {
                tours = db.Tours.Include(v => v.Countries).ToList();
            }
            else if (Int32.Parse(status) != -1 && status!=null)
            {
                var id = Int32.Parse(status);
                tours = db.Tours.Include(v => v.Countries).Where(x => x.idCountry == id).ToList();
            }
            tours.ForEach(tour =>
            {
                var contry = db.Countries.Find(tour.idCountry);
                tour.Countries = contry;
            });
            var countries = db.Countries.ToList();
            Countries allCountry = new Countries();
            allCountry.idCountry = -1;
            allCountry.country = "Все";
            countries.Insert(0, allCountry);
            ToursViewModel ilvm = new ToursViewModel
            {
                Tours = tours,
                Statuses = new SelectList(countries, "idCountry", "country")
            };
            return View(ilvm);
        }

        // GET: Tours/Create
        public ActionResult Create()
        {
            ViewBag.idCountry = new SelectList(db.Countries, "idCountry", "country");
            ViewBag.idOperator = new SelectList(db.Touroperators, "idOperator", "name");
            return View();
        }

        [HttpPost]
        public ActionResult Create([Bind(Include = "idTours,idCountry,idOperator,tourName,descr")] Tours tours)
        {
            if (ModelState.IsValid)
            {
                TourRepository tourRepository = new TourRepository();
                tourRepository.AddTour(tours);
                return RedirectToAction("Index");
            }

            ViewBag.idCountry = new SelectList(db.Countries, "idCountry", "country", tours.idCountry);
            ViewBag.idOperator = new SelectList(db.Touroperators, "idOperator", "name", tours.idOperator);
            return View(tours);
        }

        // GET: Tours/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Tours tours = db.Tours.Find(id);
            if (tours == null)
            {
                return HttpNotFound();
            }
            ViewBag.idCountry = new SelectList(db.Countries, "idCountry", "country", tours.idCountry);
            ViewBag.idOperator = new SelectList(db.Touroperators, "idOperator", "name", tours.idOperator);
            return View(tours);
        }

        [HttpPost]
        public ActionResult Edit([Bind(Include = "idTours,idCountry,idOperator,tourName,descr")] Tours tours)
        {
            if (ModelState.IsValid)
            {
                TourRepository tourRepository = new TourRepository();
                tourRepository.UpdateTour(tours);
                return RedirectToAction("Index");
            }
            ViewBag.idCountry = new SelectList(db.Countries, "idCountry", "country", tours.idCountry);
            ViewBag.idOperator = new SelectList(db.Touroperators, "idOperator", "name", tours.idOperator);
            return View(tours);
        }

        // GET: Tours/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Tours tours = db.Tours.Find(id);
            if (tours == null)
            {
                return HttpNotFound();
            }
            return View(tours);
        }

        // POST: Tours/Delete/5
        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            TourRepository tourRepository = new TourRepository();
            tourRepository.DeleteTour(id);
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using lab2_v2.Models;

namespace lab2_v2.Controllers
{
    public class TouroperatorsController : Controller
    {
        private TravelAgencyEntities db = new TravelAgencyEntities();

        // GET: Touroperators
        public ActionResult Index()
        {
            return View(db.Touroperators.ToList());
        }

        // GET: Touroperators/Create
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create([Bind(Include = "idOperator,name,phoneNumber")] Touroperators touroperators)
        {
            if (ModelState.IsValid)
            {
                db.Touroperators.Add(touroperators);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(touroperators);
        }

        // GET: Touroperators/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Touroperators touroperators = db.Touroperators.Find(id);
            if (touroperators == null)
            {
                return HttpNotFound();
            }
            return View(touroperators);
        }

        // POST: Touroperators/Edit/5
        [HttpPost]
        public ActionResult Edit([Bind(Include = "idOperator,name,phoneNumber")] Touroperators touroperators)
        {
            if (ModelState.IsValid)
            {
                db.Entry(touroperators).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(touroperators);
        }

        // GET: Touroperators/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Touroperators touroperators = db.Touroperators.Find(id);
            if (touroperators == null)
            {
                return HttpNotFound();
            }
            return View(touroperators);
        }

        // POST: Touroperators/Delete/5
        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Touroperators touroperators = db.Touroperators.Find(id);
            db.Touroperators.Remove(touroperators);
            db.SaveChanges();
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

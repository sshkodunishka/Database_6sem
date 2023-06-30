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
    public class VouchersController : Controller
    {
        private TravelAgencyEntities db = new TravelAgencyEntities();

        // GET: Vouchers
        public ActionResult Index()
        {
            var vouchers = db.Vouchers.Include(v => v.Tours);
            return View(vouchers.ToList());
        }

        // GET: Vouchers/Create
        public ActionResult Create()
        {
            ViewBag.idTour = new SelectList(db.Tours, "idTours", "tourName");
            return View();
        }

        [HttpPost]
        public ActionResult Create([Bind(Include = "idVoucher,idTour,voucherName,descr,price,numberOfPeople,nutrition,accommodation,hot,discount")] Vouchers vouchers)
        {
            if (ModelState.IsValid)
            {
                db.Vouchers.Add(vouchers);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idTour = new SelectList(db.Tours, "idTours", "tourName", vouchers.idTour);
            return View(vouchers);
        }

        // GET: Vouchers/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Vouchers vouchers = db.Vouchers.Find(id);
            if (vouchers == null)
            {
                return HttpNotFound();
            }
            ViewBag.idTour = new SelectList(db.Tours, "idTours", "tourName", vouchers.idTour);
            return View(vouchers);
        }

        // POST: Vouchers/Edit/5
        [HttpPost]
        public ActionResult Edit([Bind(Include = "idVoucher,idTour,voucherName,descr,price,numberOfPeople,nutrition,accommodation,hot,discount")] Vouchers vouchers)
        {
            if (ModelState.IsValid)
            {
                db.Entry(vouchers).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idTour = new SelectList(db.Tours, "idTours", "tourName", vouchers.idTour);
            return View(vouchers);
        }

        // GET: Vouchers/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Vouchers vouchers = db.Vouchers.Find(id);
            if (vouchers == null)
            {
                return HttpNotFound();
            }
            return View(vouchers);
        }

        // POST: Vouchers/Delete/5
        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Vouchers vouchers = db.Vouchers.Find(id);
            db.Vouchers.Remove(vouchers);
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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication.Models;

namespace WebApplication.Controllers
{
    public class OtherEventController : Controller
    {
        

        //In ADD NOTE when publish form with modal confirmation 
        [HttpPost]
        public ActionResult AddNotesPublish(NoteDetail note)
        {

            return Content("Note Published Successfully inside modal");
        }

        //In BUYER table(or any) eye icon in each row
        public ActionResult Show()
        {
            return Content("Note Show Succesfull");
        }

        //In BUYER table 3 dots->Yes I received in each row
        public ActionResult ReceivedAck()
        {
            return Content("Yes I received Succesfull");
        }

        //In BUYER table 3 dots->Yes I received in each row
        public ActionResult SendAck()
        {
            return Content("Request send to owner of note");
        }

        //In BUYER,DASHBOARD,MY DOWNLOAD,MY SOLD NOTES page search button
        public ActionResult Search()
        {
            return Content("search successfull");
        }

        //In CONTACT US page when submit a form
        public ActionResult ContactUsSubmit()
        {
            return Content("contact page submitted successfully");
        }

        //In DASHBOARD in table delete icon in the modal
        public ActionResult Delete()
        {
            return Content("delete successfull");
        }

        //In MY DOWNLOAD PAGE in table 3 dots -> report as an inappropriate
        public ActionResult Spam()
        {
            return Content("Spam successfull");
        }

        //In MY DOWNLOAD PAGE(or in any page) 
        public ActionResult DownloadNote()
        {
            return Content("Download Note successfull");
        }

        //In MY DOWNLOAD PAGE in table 3 dots -> report as an inappropriate
        public ActionResult SubmitReview()
        {
            return Content("Your review  successfull");
        }

        //In MY PROFILE page when submit a form [deleted]
        public ActionResult MyProfileSubmit()
        {
            return Content("my profile page submitted successfully");
        }
    }
}
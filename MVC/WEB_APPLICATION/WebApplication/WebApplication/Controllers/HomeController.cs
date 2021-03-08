using AutoMapper;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Diagnostics;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using WebApplication.Models;
using PagedList;
using PagedList.Mvc;

namespace WebApplication.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public ActionResult AddNotes(int ?id)
        {
            TatvaDBEntities dc = new TatvaDBEntities();
            List<Country> countries = dc.Countries.ToList();
            TempData["CountriesList"] = countries;
            List<Category> categories = dc.Categories.ToList();
            TempData["CategoriesList"] = categories;
            List<NoteType> types = dc.NoteTypes.ToList();
            TempData["TypesList"] = types;

            var note = dc.NoteDetails.Where(a => a.note_id == id).FirstOrDefault();
            return View(note);
        }

        //update date nu ama batavanu
        [HttpPost]
        public ActionResult AddNotes(NoteDetail note,int ?id)
        {
            TatvaDBEntities dc = new TatvaDBEntities();
            List<Country> countries = dc.Countries.ToList();
            TempData["CountriesList"] = countries;
            List<Category> categories = dc.Categories.ToList();
            TempData["CategoriesList"] = categories;
            List<NoteType> types = dc.NoteTypes.ToList();
            TempData["TypesList"] = types;

            if (id.HasValue)
            {
                NoteDetail upnote = dc.NoteDetails.Where(a => a.note_id == id).FirstOrDefault();
                
                
                
                dc.SaveChanges();
            }
            else
            {
                note.user_id = (int)Session["id"];
                note.Status = "Draft";
                note.Created_Date = DateTime.Now;

                var data = dc.NoteDetails.OrderByDescending(a => a.note_id).FirstOrDefault();

                var noteidforpath = (data == null) ? 1 : (data.note_id + 1);

                if (note.Display_Pic != null)
                {
                    string FilePath = Server.MapPath("~/Members/");
                    string FileName = Path.GetFileName(note.Display_Pic.FileName);
                    string FullPath = Path.Combine(FilePath, note.user_id.ToString(), noteidforpath.ToString());
                    //not directory then create
                    if (!System.IO.Directory.Exists(FullPath))
                    {
                        System.IO.Directory.CreateDirectory(System.IO.Path.Combine(FilePath, note.user_id.ToString(), noteidforpath.ToString()));
                    }
                    //if file does not exists then save
                    if (!System.IO.File.Exists(FullPath + "/" + "NOTE_DP_" + FileName))
                    {
                        note.Display_Pic.SaveAs(FullPath + "/" + "NOTE_DP_" + FileName);
                    }
                    note.Display_Picture = "/Members/" + note.user_id + "/" + noteidforpath + "/" + "NOTE_DP_" + FileName;
                }

                //for file upload
                string FilePath2 = Server.MapPath("~/Members/");
                string FileName2 = Path.GetFileName(note.Up_Note.FileName);
                string FullPath2 = Path.Combine(FilePath2, note.user_id.ToString(), noteidforpath.ToString());
                //not directory then create
                if (!System.IO.Directory.Exists(FullPath2))
                {
                    System.IO.Directory.CreateDirectory(System.IO.Path.Combine(FilePath2, note.user_id.ToString(), noteidforpath.ToString()));
                }
                //if file does not exists then save
                if (!System.IO.File.Exists(FullPath2 + "/" + "NOTE_FILE_" + FileName2))
                {
                    note.Up_Note.SaveAs(FullPath2 + "/" + "NOTE_FILE_" + FileName2);
                }
                note.File_Path = "/Members/" + note.user_id + "/" + noteidforpath + "/" + "NOTE_FILE_" + FileName2;

                if (note.Sell_Price > 0)
                {
                    note.IsPaid = true;
                    if (note.Up_Preview != null)
                    {
                        //for preview upload
                        string FilePath3 = Server.MapPath("~/Members/");
                        string FileName3 = Path.GetFileName(note.Up_Preview.FileName);
                        string FullPath3 = Path.Combine(FilePath3, note.user_id.ToString(), noteidforpath.ToString());
                        //not directory then create
                        if (!System.IO.Directory.Exists(FullPath3))
                        {
                            System.IO.Directory.CreateDirectory(System.IO.Path.Combine(FilePath3, note.user_id.ToString(), noteidforpath.ToString()));
                        }
                        //if file does not exists then save
                        if (!System.IO.File.Exists(FullPath3 + "/" + "NOTE_PREVIEW_" + FileName3))
                        {
                            note.Up_Preview.SaveAs(FullPath3 + "/" + "NOTE_PREVIEW_" + FileName3);
                        }
                        note.Note_Preview = "/Members/" + note.user_id + "/" + noteidforpath + "/" + "NOTE_PREVIEW_" + FileName3;
                    }
                    else
                    {
                        //ahiya error batavani che.
                        ModelState.AddModelError("PreviewNeeded", "You Need To Upload Preview For Paid Notes.");
                    }
                }
                else
                {
                    if (note.Up_Preview != null)
                    {
                        //for preview upload
                        string FilePath3 = Server.MapPath("~/Members/");
                        string FileName3 = Path.GetFileName(note.Up_Preview.FileName);
                        string FullPath3 = Path.Combine(FilePath3, note.user_id.ToString(), noteidforpath.ToString());
                        //not directory then create
                        if (!System.IO.Directory.Exists(FullPath3))
                        {
                            System.IO.Directory.CreateDirectory(System.IO.Path.Combine(FilePath3, note.user_id.ToString(), noteidforpath.ToString()));
                        }
                        //if file does not exists then save
                        if (!System.IO.File.Exists(FullPath3 + "/" + "NOTE_PREVIEW_" + FileName3))
                        {
                            note.Up_Preview.SaveAs(FullPath3 + "/" + "NOTE_PREVIEW_" + FileName3);
                        }
                        note.Up_Preview.SaveAs(FullPath3 + "/" + FileName3);
                        note.Note_Preview = "/Members/" + note.user_id + "/" + noteidforpath + "/" + "NOTE_PREVIEW_" + FileName3;
                    }
                }
                dc.NoteDetails.Add(note);
                dc.SaveChanges();
            }            
            ViewData["AddNoteOnSave"] = "Your Note Save Successfully.";
            return View();
        }


        public ActionResult DeleteNotes(int ?id)
        {
            TatvaDBEntities dc = new TatvaDBEntities();
            var note = dc.NoteDetails.Where(a => a.note_id == id).FirstOrDefault();
            note.Status = "Deleted";
            dc.SaveChanges();
            return RedirectToAction("Dashboard","Home");
        }

        [HttpGet]
        public ActionResult Dashboard(int ?page,string search,string search1,string sortBy,string sortBy1)
        {
            int aa = (int)Session["id"];
            int pageSize = 1;
            TatvaDBEntities dc = new TatvaDBEntities();
            //sold notes count
            var NoteCount = dc.NoteDetails.Where(a=>a.No_Of_Download > 0).Count();
            //sold notes earning money
            var NoteEarning = dc.NoteDetails.Sum(a=>a.Earning_Amount);
            //no of download notes
            var DownloadNotes = dc.BuyerReqs.Where(a => a.user_id == aa && a.Status == true).Count();
            //no. of my rejected notes
            var Rejected_Notes_No = dc.NoteDetails.Where(a => a.user_id == aa && a.Status == "Rejected").Count();
            //no. of my notes buyer requests
            var Buyer_Req_No = dc.BuyerReqs.Where(a => a.NoteDetail.user_id == aa).Count();

            //progress notes in table
            List<NoteDetail> Progress = dc.NoteDetails.Where(a => a.Status != "Published" && a.Status != "Rejected" && a.Status!="Deleted").AsQueryable().ToList();
            ViewBag.sortByTitle = sortBy == "TITLE" ? "TITLE DESC" : "TITLE"; ;
            ViewBag.sortByCategory = sortBy == "CATEGORY" ? "CATEGORY DESC" : "CATEGORY";
            ViewBag.sortByStatus = sortBy == "STATUS" ? "STATUS DESC" : "STATUS";
            ViewBag.sortByDate = string.IsNullOrEmpty(sortBy) ? "ADDED DATE ASC" : "";
            switch (sortBy)
            {
                default:
                    Progress = Progress.OrderByDescending(a => a.Published_Date).ToList();
                    break;
                case "ADDED DATE ASC":
                    Progress = Progress.OrderBy(a => a.Published_Date).ToList();
                    break;
                case "TITLE DESC":
                    Progress = Progress.OrderByDescending(a => a.File_Name).ToList();
                    break;
                case "TITLE":
                    Progress = Progress.OrderBy(a => a.File_Name).ToList();
                    break;
                case "CATEGORY DESC":
                    Progress = Progress.OrderByDescending(a => a.Category).ToList();
                    break;
                case "CATEGORY":
                    Progress = Progress.OrderBy(a => a.Category).ToList();
                    break;
                case "STATUS DESC":
                    Progress = Progress.OrderByDescending(a => a.Status).ToList();
                    break;
                case "STATUS":
                    Progress = Progress.OrderBy(a => a.Status).ToList();
                    break;
            }
            if (search != null)
            {
                Progress = Progress.Where(a => a.File_Name.ToLower().StartsWith(search.ToLower()) || a.Category.ToLower().StartsWith(search) || a.Status.ToLower().StartsWith(search.ToLower())).ToList();
            }

            //published notes in table
            List<NoteDetail> Published = dc.NoteDetails.Where(a => a.Status == "Published").AsQueryable().ToList();
            ViewBag.sortByTitle1 = sortBy1 == "TITLE" ? "TITLE DESC" : "TITLE"; ;
            ViewBag.sortByCategory1 = sortBy1 == "CATEGORY" ? "CATEGORY DESC" : "CATEGORY";
            ViewBag.sortBySellType = sortBy1 == "SELL TYPE" ? "SELL TYPE DESC" : "SELL TYPE";
            ViewBag.sortByPrice = sortBy1 == "PRICE" ? "PRICE DESC" : "PRICE";
            ViewBag.sortByDate1 = string.IsNullOrEmpty(sortBy) ? "ADDED DATE ASC" : "";
            switch (sortBy1)
            {
                default:
                    Published = Published.OrderByDescending(a => a.Published_Date).ToList();
                    break;
                case "ADDED DATE ASC":
                    Published = Published.OrderBy(a => a.Published_Date).ToList();
                    break;
                case "TITLE DESC":
                    Published = Published.OrderByDescending(a => a.File_Name).ToList();
                    break;
                case "TITLE":
                    Published = Published.OrderBy(a => a.File_Name).ToList();
                    break;
                case "CATEGORY DESC":
                    Published = Published.OrderByDescending(a => a.Category).ToList();
                    break;
                case "CATEGORY":
                    Published = Published.OrderBy(a => a.Category).ToList();
                    break;
                case "SELL TYPE DESC":
                    Published = Published.OrderByDescending(a => a.IsPaid).ToList();
                    break;
                case "SELL TYPE":
                    Published = Published.OrderBy(a => a.IsPaid).ToList();
                    break;
                case "PRICE DESC":
                    Published = Published.OrderByDescending(a => a.Sell_Price).ToList();
                    break;
                case "PRICE":
                    Published = Published.OrderBy(a => a.Sell_Price).ToList();
                    break;
            }
            if (search1 != null)
            {
                if (search1.ToLower().ToString() == "paid")
                {
                    Published = Published.Where(a => a.IsPaid.Equals(true)).ToList();
                }
                else if (search1.ToLower().ToString() == "free")
                {
                    Published = Published.Where(a => a.IsPaid.Equals(false)).ToList();
                }
                else
                {
                    Published = Published.Where(a => a.File_Name.ToLower().StartsWith(search1.ToLower()) || a.Category.ToLower().StartsWith(search1.ToLower())).ToList();
                }
            }

            ViewBag.one = NoteCount;
            ViewBag.two = NoteEarning;
            ViewBag.three = DownloadNotes;
            ViewBag.four = Rejected_Notes_No;
            ViewBag.five = Buyer_Req_No;
            ViewBag.ProgressList = Progress.ToPagedList(page ?? 1, pageSize);
            ViewBag.PublishedList = Published.ToPagedList(page ?? 1, pageSize);
            return View();
        }


        public ActionResult MyDownload()
        {
            //aa badhu post ma aavse maybe or get ma actionlink thi
            //user id session mathi lai levani
            //note id row upar click kare tyathi lai levani
            //comments and reviews to aai jase
            //date aajni add kar devani

            return View();
        }

        public ActionResult MyRejectedNotes()
        {
            return View();
        }

        public ActionResult MySoldNotes()
        {
            return View();
        }

        public ActionResult DownloadFile(string FileName)
        {
            string file1 = FileName.Remove(0,8);
            string path = Server.MapPath("~/Members/")+file1;
            byte[] bytes = System.IO.File.ReadAllBytes(path);
            return File(bytes,"application/octet-stream",FileName);
        }

        [HttpGet]
        public ActionResult NoteDetails(int ?id,string download)
        {
            TatvaDBEntities dc = new TatvaDBEntities();
            int aa = (int)Session["id"];
            string vv = Session["user"].ToString();
            var note = dc.NoteDetails.Where(a => a.note_id == id).FirstOrDefault();
            List<Review> review = dc.Reviews.Where(a => a.note_id == id).ToList();

            //to know who is buyer
            var person = dc.Users.Where(a => a.Email == vv).FirstOrDefault();
            var sys = dc.SystemConfigs.First();
            ViewBag.review_list = review;
            ViewBag.JustForName = person;
            ViewBag.NoteData = note;
            ViewBag.SystemData = sys;


            if(id.HasValue && download!=null)
            {
                //for check owner or not
                bool owner = dc.NoteDetails.Where(a => a.note_id == id && a.user_id==aa).Count()==0;

                //if owner wants to download
                if (!owner)
                {
                    return RedirectToAction("DownloadFile", "Home", new { FileName = note.File_Path });
                }
                else
                {
                    if (download== "FreeDownload")
                    {
                        bool check = dc.BuyerReqs.Where(a => a.user_id == aa && a.note_id == note.note_id).Count()==0;
                        //entry nathi atle padvani
                        if (check)
                        {
                            BuyerReq buyer = new BuyerReq();
                            buyer.user_id = aa;
                            buyer.note_id = note.note_id;
                            buyer.Status = true;
                            buyer.Req_Created_Date = DateTime.Now;
                            dc.BuyerReqs.Add(buyer);
                            dc.SaveChanges();
                        }
                        //no_of_download and earning ma sahej vicharvanu che
                        return RedirectToAction("DownloadFile", "Home", new { FileName = note.File_Path });
                    }
                    //when it is paid notes
                    else
                    {
                        bool check = dc.BuyerReqs.Where(a => a.user_id == aa && a.note_id == id).Count() == 0;
                        //entry nathi atle padvani
                        if (check)
                        {
                            BuyerReq buyer = new BuyerReq();
                            buyer.user_id = aa;
                            buyer.note_id = note.note_id;
                            buyer.Status = false;
                            buyer.Req_Created_Date = DateTime.Now;
                            dc.BuyerReqs.Add(buyer);
                            dc.SaveChanges();

                            SystemConfig system = DEFAULT.GetData();
                            MailMessage mail = new MailMessage(system.Support_Email_Address, note.User.Email);
                            mail.Body = "Hello," +note.User.Fname+ "<br>" + "We would like to inform you that,"+ person.Fname+ "wants to purchase your notes. Please see Buyer Requests tab and allow download access to Buyer if you have received the payment from him."+ "Regards, <br>" + "Notes Marketplace";
                            mail.IsBodyHtml = true;
                            mail.Subject = person.Fname+ "wants to purchase your notes";
                            SmtpClient SMTP = new SmtpClient();
                            SMTP.Host = "smtp.gmail.com";
                            SMTP.Port = 587;
                            SMTP.EnableSsl = true;
                            SMTP.DeliveryMethod = SmtpDeliveryMethod.Network;
                            SMTP.UseDefaultCredentials = false;
                            SMTP.Credentials = new NetworkCredential(system.Support_Email_Address, system.Password);
                            SMTP.Send(mail);
                            ViewBag.ReqSubmitted = "Your Request For Download Note Has Been Submitted.";
                            return View();
                        }
                        //entry chee then
                        else
                        {
                            bool allow = dc.BuyerReqs.Where(a => a.user_id == aa && a.note_id == id && a.Status==true).Count() == 0;
                           //entry che pan status true nathi then..
                            if (allow)
                            {
                                ViewBag.mess = "Your Request Yet Not Reviewd By Owner Of The Note. As Soon As Owner Verify You Will Get Email.";
                                return View();
                            }
                            //entry che and status pan true che 
                            else
                            {
                                //no_of_download and earning ma sahej vicharvanu che
                                return RedirectToAction("DownloadFile", "Home", new { FileName = note.File_Path });
                            }
                        }
                    }

                }
            }
            else
            {
                return View();
            }
        }


        [HttpGet]
        public ActionResult Buyer(int? id,int? memberid,int? page,string search,string sortBy)
        {
            TatvaDBEntities dc = new TatvaDBEntities();
            var ab = (int)Session["id"];
            ViewBag.sortByTitle = sortBy == "NOTE TITLE" ? "NOTE TITLE DESC" : "NOTE TITLE"; ;
            ViewBag.sortByCategory = sortBy == "CATEGORY"? "CATEGORY DESC" : "CATEGORY";
            ViewBag.sortByBuyer = sortBy == "BUYER" ? "BUYER DESC" : "BUYER"; 
            ViewBag.sortByPhoneNo = sortBy == "PHONE NO." ? "PHONE NO. DESC" : "PHONE NO.";
            ViewBag.sortBySellType = sortBy == "SELL TYPE" ? "SELL TYPE DESC" : "SELL TYPE"; ;
            ViewBag.sortByPrice = sortBy == "PRICE" ? "PRICE DESC" : "PRICE";
            ViewBag.sortByDate = string.IsNullOrEmpty(sortBy) ?"Date ASC":"";

            if (id.HasValue && !memberid.HasValue)
            {
                var Eye = dc.BuyerReqs.Where(a => a.note_id == id && a.user_id != memberid).FirstOrDefault();
                if (Eye != null)
                {
                    return RedirectToAction("NoteDetails", "Home", new { id = Eye.note_id });
                }
            }

            //JAADU
            List<BuyerReq> DATA = dc.BuyerReqs.Where(a => a.NoteDetail.user_id == ab).AsQueryable().ToList();
            int pageSize = 5;

            if (search !=null)
            {
                if (search.ToLower().ToString() == "paid" )
                {
                    DATA = DATA.Where(a => a.NoteDetail.IsPaid.Equals(true)).ToList();
                    //DATA = DATA.Where(a => a.NoteDetail.IsPaid.Equals(true)).ToPagedList(page ?? 1, pageSize);
                }
                else if (search.ToLower().ToString() == "free")
                {
                    DATA = DATA.Where(a => a.NoteDetail.IsPaid.Equals(false)).ToList();
                   // DATA = DATA.Where(a => a.NoteDetail.IsPaid.Equals(false)).ToPagedList(page ?? 1, pageSize);
                }
                else
                {
                    DATA = DATA.Where(a => a.NoteDetail.File_Name.ToLower().StartsWith(search.ToLower()) || a.NoteDetail.Category.ToLower().StartsWith(search.ToLower()) || a.User.Email.ToLower().StartsWith(search.ToLower()) || a.NoteDetail.Sell_Price.ToString().StartsWith(search)).ToList();
                }
            }

            var Received = dc.BuyerReqs.Where(a => a.note_id == id && a.user_id == memberid).FirstOrDefault();
            if (Received != null)
            {
                Received.Status = true;
                dc.SaveChanges();
            }

            //1 vaar pacchi bji var press karie atle sell type 0 0 hoy to date wise nai avtu search and sort
              switch (sortBy)
               {
                   default:
                        DATA = DATA.OrderByDescending(a=>a.Req_Created_Date).ToList();
                    break;
                  case "Date ASC":
                      DATA = DATA.OrderBy(a=>a.Req_Created_Date).ToList();
                    break;
                   case "NOTE TITLE DESC":
                        DATA = DATA.OrderByDescending(a=>a.NoteDetail.File_Name).ToList();
                    break;
                  case "NOTE TITLE":
                        DATA = DATA.OrderBy(a=>a.NoteDetail.File_Name).ToList();
                    break;
                  case "CATEGORY DESC":
                        DATA = DATA.OrderByDescending(a=>a.NoteDetail.Category).ToList();
                    break;
                  case "CATEGORY":
                        DATA = DATA.OrderBy(a=>a.NoteDetail.Category).ToList();
                    break;
                  case "BUYER DESC":
                       DATA = DATA.OrderByDescending(a=>a.User.Email).ToList();
                    break;
                  case "BUYER":
                       DATA = DATA.OrderBy(a=>a.User.Email).ToList();
                    break;
                  case "PHONE NO. DESC":
                      DATA = DATA.OrderByDescending(a=>a.User.Phone_Number_Country_Code).ToList();
                    break;
                  case "PHONE NO.":
                      DATA = DATA.OrderBy(a=>a.User.Phone_Number_Country_Code).ToList();
                    break;
                  case "SELL TYPE DESC":
                       DATA = DATA.OrderByDescending(a=>a.NoteDetail.IsPaid).ToList();
                    break;
                  case "SELL TYPE":
                      DATA = DATA.OrderBy(a=>a.NoteDetail.IsPaid).ToList();
                    break;
                  case "PRICE DESC":
                       DATA = DATA.OrderByDescending(a=>a.NoteDetail.Sell_Price).ToList();
                    break;
                  case "PRICE":
                      DATA = DATA.OrderBy(a=>a.NoteDetail.Sell_Price).ToList();
                    break;
              }

            ViewBag.buyerList = DATA.ToPagedList(page ?? 1, pageSize);

            return View();

        }

        [HttpGet]
        public ActionResult MyProfile()
        {
            TatvaDBEntities dc = new TatvaDBEntities();
            List<Country> countries= dc.Countries.ToList();
            TempData["CountriesList"] = countries;
            //SelectList list = new SelectList(dd,"country_code","country_code");
            //ViewBag.data = list;  
            if (Session["user"] != null)
            {
                User user = new User();
                user.Email = (string)Session["user"];
                var v = dc.Users.Where(a => a.Email == user.Email).FirstOrDefault();
                user.Fname = v.Fname;
                user.Lname =v.Lname;
                return View(user);
            }
            else
            {
                return View();
            }
        }

        [HttpPost]
        public ActionResult MyProfile(User user)
        {
            ModelState.Remove("Password");
            ModelState.Remove("Confirm_Password");
            ModelState.Remove("New_Password");
            ModelState.Remove("New_Confirm_Password");
            if (ModelState.IsValid)
            {
                using (TatvaDBEntities dc = new TatvaDBEntities())
                    {
                        List<Country> countries= dc.Countries.ToList();
                        TempData["CountriesList"] = countries;

                        try
                        {
                            var val = (string)Session["user"];
                            var v = dc.Users.Where(a => a.Email == val).FirstOrDefault();
                            v.DOB = user.DOB;
                            v.Gender = user.Gender;
                            v.Phone_Number = user.Phone_Number;
                            v.Phone_Number_Country_Code = user.Phone_Number_Country_Code;
                            v.Address_1 = user.Address_1;
                            v.Address_2 = user.Address_2;
                            v.ZipCode = user.ZipCode;
                            v.City = user.City;
                            v.State = user.State;
                            v.Country = user.Country;
                            v.College = user.College;
                            v.University = user.University;
                            v.Modified_Date= DateTime.Now;

                            if (user.Dummy != null)
                            {
                                string uid=v.user_id.ToString();
                                string FilePath = Server.MapPath("~/Members/");
                                string FileName = Path.GetFileName(user.Dummy.FileName);
                                string FullPath = Path.Combine(FilePath, uid);
                                //not directory then create
                                if (!System.IO.Directory.Exists(FullPath))
                                {
                                     System.IO.Directory.CreateDirectory(System.IO.Path.Combine(FilePath, uid));
                                }
                                
                                //member folder ma save karva mate
                                if(!System.IO.File.Exists(FullPath + "/" + "USER_DP_" + FileName)){
                                    user.Dummy.SaveAs(FullPath+"/"+ "USER_DP_" + FileName);
                                }

                                user.Profile_Picture = "/Members/" + uid + "/" + "USER_DP_" + FileName;
                                v.Profile_Picture = user.Profile_Picture;
                                Session["UserImg"]=v.Profile_Picture;
                            }
                            dc.SaveChanges();
                            return RedirectToAction("Search", "Home");
                        }
                        catch(Exception ex)
                        {
                            Console.WriteLine(ex.GetType().FullName);
                            Console.WriteLine(ex.Message);
                            return RedirectToAction("MyProfile", "Home");
                        }
                    }
            }
            else
            {
                using (TatvaDBEntities dc = new TatvaDBEntities())
                {
                    List<Country> countries = dc.Countries.ToList();
                    TempData["CountriesList"] = countries;
                    return View(user);
                }
            }
        }

        [HttpGet]
        public ActionResult ContactUs()
        {
            if (Session["user"] != null)
            {
                    TatvaDBEntities dc = new TatvaDBEntities();
                    ContactU contact = new ContactU();
                    contact.Email = (string)Session["user"];
                    var v = dc.Users.Where(a => a.Email == contact.Email).FirstOrDefault();
                    contact.Full_name = v.Fname +" "+v.Lname;
                    ViewBag.obj = contact;
                    return View("ContactUs");

            }
            else
            {
                return View();
            }
        }

        [HttpPost]
        public ActionResult ContactUs(ContactU contact)
        {
            SystemConfig system = DEFAULT.GetData();
            MailMessage mail = new MailMessage(system.Support_Email_Address, system.EmailForNotify);
            mail.Body = "Hello, <br>" + contact.Comments_Questions +"<br>"+ "Regards, <br>" + contact.Full_name ;
            mail.IsBodyHtml = true;
            mail.Subject = contact.Full_name + " - Query";
            SmtpClient SMTP = new SmtpClient();
            SMTP.Host = "smtp.gmail.com";
            SMTP.Port = 587;
            SMTP.EnableSsl = true;
            SMTP.DeliveryMethod = SmtpDeliveryMethod.Network;
            SMTP.UseDefaultCredentials = false;
            SMTP.Credentials = new NetworkCredential(system.Support_Email_Address, system.Password);
            SMTP.Send(mail);
            TempData["ContactUs"] = "Your Query Send SuccessFully.";
            return RedirectToAction("ContactUs", "Home");
        }

        [HttpPost]
        public ActionResult PublishReq()
        {
            return View("AddNotes");
        }

        [HttpGet]
        public ActionResult FAQ()
        {
            return View();
        }

        public ActionResult Home()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Search(string text, string val1, string val2, string val3, string val4, string val5,int ?val6,int ?page)
        {
            int pageSize = 2;
            TatvaDBEntities dc = new TatvaDBEntities();
            var types = dc.NoteDetails.Where(a => a.Status == "Draft").Select(a => a.Type).Distinct().ToList();
            var categories = dc.NoteDetails.Where(a => a.Status == "Draft").Select(a=>a.Category).Distinct().ToList();
            var universities = dc.NoteDetails.Where(a => a.Status == "Draft").Select(a => a.Institute_Name).Distinct().ToList();
            var courses = dc.NoteDetails.Where(a => a.Status == "Draft").Select(a => a.Course_Name).Distinct().ToList();
            var countries = dc.NoteDetails.Where(a => a.Status == "Draft").Select(a => a.Country).Distinct().ToList();
            List<NoteDetail> notes = dc.NoteDetails.Where(a => a.Status == "Draft").AsQueryable().ToList();

            if (text != null)
            {
                notes = notes.Where(a => a.File_Name.ToLower().Contains(text.ToLower()) || a.Category.ToLower().Contains(text.ToLower())).ToList();
            }
            if (val1 != null)
            {
                notes = notes.Where(a => a.Type == val1).ToList();
            }
            if (val2 != null)
            {
                notes = notes.Where(a => a.Category == val2).ToList();
            }
            if (val3 != null)
            {
                notes = notes.Where(a => a.Institute_Name == val3).ToList();
            }
            if (val4 != null)
            {
                notes = notes.Where(a => a.Course_Name == val4).ToList();
            }
            if (val5 != null)
            {
                notes = notes.Where(a => a.Country == val5).ToList();
            }
            if (val6.HasValue)
            {
                notes = notes.Where(a => a.Reviews.Average(aa => aa.Rating) > val6).ToList();
            }

            ViewBag.TypeList = types;
            ViewBag.CategoriesList = categories;
            ViewBag.UniversitiesList = universities;
            ViewBag.CoursesList = courses;
            ViewBag.CountriesList = countries;
            ViewBag.no_of_notes = notes.Count();
            ViewBag.notes = notes.ToPagedList(page ?? 1, pageSize); ;
            return View();
        }
    }
    
}
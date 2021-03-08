using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNetCore.Identity;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration; 
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Web.Mvc;
using WebApplication.Models;
using System.Text;
using System.Data.Entity.Validation;
using System.Net.Mail;
using System.Security.Principal;
using System.Web.Security;

namespace WebApplication.Controllers
{
    public class AuthController : Controller
    {

        //function to check email is already exist or not : signup controller
        [NonAction]
        public bool IsEmailExist(string email)
        {
            using (TatvaDBEntities dc = new TatvaDBEntities())
            {
                if (email != null)
                {
                    var v = dc.Users.Where(a => a.Email == email).FirstOrDefault();
                    return v != null;
                }
            }
            return true;
        }

      
        [HttpGet]
        public ActionResult SignUp()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SignUp(User user)
        {

            ModelState.Remove("Phone_Number");
            ModelState.Remove("Phone_Number_Country_Code");
            ModelState.Remove("Address_1");
            ModelState.Remove("Address_2");
            ModelState.Remove("ZipCode");
            ModelState.Remove("City");
            ModelState.Remove("State");
            ModelState.Remove("Country");
            ModelState.Remove("New_Password");
            ModelState.Remove("New_Confirm_Password");

            if (ModelState.IsValid)
            {
                //chack email is already exist
                var isExist = IsEmailExist(user.Email);
                if (isExist)
                {
                    ModelState.AddModelError("EmailExist","Email Already Exist");
                    return View(user);
                }

                //save to db
                using (TatvaDBEntities dc = new TatvaDBEntities())
                {
                  //  try
                    //{
                        user.IsActive = true;
                        user.Created_Date = DateTime.Now;
                        //generate activation code
                        user.Activation_Code = Guid.NewGuid();
                        dc.Users.Add(user);
                        dc.SaveChanges();

                        //Admin adminClass = ADMINDATA.GetAdmin();
                        SystemConfig system = DEFAULT.GetData();

                        var verifyURL = "https://localhost:44386/Auth/EmailVerification?id=" + user.Activation_Code;
                        MailMessage mail = new MailMessage(system.Support_Email_Address,user.Email);
                        mail.Body = "Hello " +user.Fname+ "<br> Thank you for signing up with us. <br> Please click on below link to verify your email address and to do login. <br>" + verifyURL +  "<br>  Regards,  <br> <b>Notes Marketplace</b>";
                        mail.IsBodyHtml = true;
                        mail.Subject ="Note Marketplace - Email Verification";
                        SmtpClient SMTP = new SmtpClient();
                        SMTP.Host = "smtp.gmail.com";
                        SMTP.Port = 587;
                        SMTP.EnableSsl = true;
                        SMTP.DeliveryMethod = SmtpDeliveryMethod.Network;
                        SMTP.UseDefaultCredentials = false;
                        SMTP.Credentials = new NetworkCredential(system.Support_Email_Address, system.Password);                        
                        SMTP.Send(mail);
                        TempData["SignUp"] = "Your Account Created Successfully.";
                        return RedirectToAction("LogIn", "Auth");
                   // }

                    /*  catch (Exception ex)
                        {
                            //Console.WriteLine("Exception caught in RetryIfBusy(): {0}",ex.ToString());
                            return View();
                        }
                    */
                }

            }
        else
        {
            return View(user);
        }
        }




        [HttpGet]
        public ActionResult LogIn()
        {
            if (Request.Cookies["TatvaUser"] != null && Request.Cookies["TatvaPassword"] != null)
            {
                User user = new User();
                user.Email = Request.Cookies["TatvaUser"].Value;
                user.Password = Request.Cookies["TatvaPassword"].Value;
                user.ReturnUrl = Request.QueryString["ReturnUrl"];
                ViewBag.url = user.ReturnUrl;
                return View(user);
            }
            else
            {
                return View();
            }

        }


        [HttpPost]
        public ActionResult LogIn(User user)  
        {
                //check whether user already created account or not
                var isExist = IsEmailExist(user.Email);
                if (!isExist)
                {
                    ViewBag.message = "You have to first create an account. Your account does not exist.";
                    return View(user);
                }

                using (TatvaDBEntities dc = new TatvaDBEntities())
                {
                    var v = dc.Users.Where(a => a.Email == user.Email).FirstOrDefault();
                    if (v != null)
                    {
                        if (v.Password == user.Password)
                        {
                            if (v.IsEmailVerified == false)
                            {
                                ViewBag.message = "We have send you email for user verification. First go there and then do login.";
                                return View();
                            }
                            else
                            {
                                if (user.remember_me)
                                {
                                    HttpCookie cook = new HttpCookie("TatvaUser",user.Email);
                                    HttpCookie cook1 = new HttpCookie("TatvaPassword",user.Password);                           
                                    Response.SetCookie(cook);
                                    Response.SetCookie(cook1);
                                    cook.Expires = DateTime.Now.AddYears(1);
                                    cook1.Expires = DateTime.Now.AddYears(1);
                                }

                                //store session for user
                                Session["user"] = user.Email;
                                Session["id"] = v.user_id;


                            //if authenticate user (here put code of direct URl)
                               if (!String.IsNullOrEmpty(user.ReturnUrl))
                                {
                                //ViewBag.ReturnUrl = ReturnUrl;
                                    return Redirect(user.ReturnUrl);
                                }
                                else
                                    {
                                    if (v.Phone_Number == null)
                                    {
                                        var va = dc.SystemConfigs.First().Default_User_Profile_Picture;
                                        Session["UserImg"]=va;
                                        return RedirectToAction("MyProfile", "Home");

                                    }
                                    else
                                    {
                                        //when user updated their profile.
                                        Session["UserImg"]=v.Profile_Picture;
                                        return RedirectToAction("Search", "Home");
                                    }
                                }
                            }
                        }
                        else
                        {
                            ViewBag.message = "Invalid credentials.";
                            return View();
                        }

                    }
                    else
                    {
                        ViewBag.message = "Invalid credentials.";
                        return View();
                    }
                }
        }


       
       
        public ActionResult LogOut()
        {
            //back button functionality
            FormsAuthentication.SignOut();
            Session.Remove("user");
            return RedirectToAction("SignUp","Auth");
        }

        [HttpGet]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ForgotPassword(string email)
        {
            using (TatvaDBEntities dc = new TatvaDBEntities())
            {
                var v = dc.Users.Where(a=>a.Email==email).FirstOrDefault();
                if(v!=null)
                {
                    //generate random password
                    var RandomPassword = System.Web.Security.Membership.GeneratePassword(8,0);
                    //Admin adminClass = ADMINDATA.GetAdmin();
                    SystemConfig system = DEFAULT.GetData();
                    MailMessage mail = new MailMessage(system.Support_Email_Address, v.Email);
                    mail.Body = "Hello " + v.Fname + "<br> We have generated a new password for you.<br> Password :"+ RandomPassword + "<br> Regards, <br> <b>Notes Marketplace</b>";
                    mail.IsBodyHtml = true;
                    mail.Subject = "New Temporary Password has been created for you";
                    SmtpClient SMTP = new SmtpClient();
                    SMTP.Host = "smtp.gmail.com";
                    SMTP.Port = 587;
                    SMTP.EnableSsl = true;
                    SMTP.DeliveryMethod = SmtpDeliveryMethod.Network;
                    SMTP.UseDefaultCredentials = false;
                    SMTP.Credentials = new NetworkCredential(system.Support_Email_Address, system.Password);
                    SMTP.Send(mail);

                    //update the password and confirm password in db.
                    v.Password = RandomPassword;
                    v.Confirm_Password = RandomPassword;
                    dc.SaveChanges();
                    TempData["ForgotPassword"] = "We have sent you new password to your email address.";
                    return RedirectToAction("LogIn", "Auth");
                }
                else
                {
                    ViewBag.messageDanger = "Account not found.";
                    return View();
                }
            }
        }

        [HttpGet]
        public ActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ChangePassword(User user)
        {
            using (TatvaDBEntities dc = new TatvaDBEntities())
            {
                var verify = dc.Users.Where(a => a.Email == user.Email).FirstOrDefault();

                if (verify != null)
                {
                    if (user.Password == verify.Password)
                    {                       
                        verify.Password = user.New_Password;
                        verify.Confirm_Password = user.New_Confirm_Password;
                        dc.SaveChanges();
                        TempData["ChangePassword"] = "Your Password Changed Successfully";
                        return RedirectToAction("LogIn", "Auth");
                    }
                    else
                    {
                        ModelState.AddModelError("PasswordExist", "Password Not Match With Your Old Password.");
                        return View();
                    }
                }
                else
                {
                    ModelState.AddModelError("EmailExist", "Email Not Exist");
                    return View();
                }
            }
        }


        //(string id) ma apdu activation code jase url mathi id ni value fetch kare
        [HttpGet]
        public ActionResult EmailVerification(string id)
        {
            using (TatvaDBEntities dc = new TatvaDBEntities())
            {
                var verify = dc.Users.Where(a=>a.Activation_Code==new Guid(id)).FirstOrDefault();
                if (verify != null) 
                {
                    verify.IsEmailVerified = true;
                    ViewBag.message = verify.Fname;
                    TempData["Emailverification"] = "Email Verified Successfully";
                    dc.SaveChanges();
                }
            }
            return View();
        }
                
    }

    

     public class DEFAULT
     {
         public static SystemConfig GetData()
         {
            TatvaDBEntities db = new TatvaDBEntities();
            SystemConfig ad = db.SystemConfigs.Where(a => a.system_id==1 ).FirstOrDefault();
            ad.Password = "sagarsolanki749@749";
            return ad;
         }
    }
}
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketplace.Controllers
{
    public class AuthController : Controller
    {
        NotesMarketplaceEntities data = new NotesMarketplaceEntities();
        // GET: Auth
        [Route("Auth/Login")]
        public ActionResult Login()
        {
            User user = new User();
            if (Request.Cookies["Login"] != null)
            {
                user.EmailID = Request.Cookies["Login"].Values["EmailID"];
                user.Password = Request.Cookies["Login"].Values["Password"];
            }
            return View(user);
        }

        [HttpPost]
        [Route("Auth/check")]
        public ActionResult check([Bind(Include = "EmailID,LoginPassword,RememberMe")] User user)
        {
            ModelState.Remove("FirstName");
            ModelState.Remove("LastName");
            ModelState.Remove("Password");
            ModelState.Remove("ConfirmPassword");
            ModelState.Remove("NewPassword");
            ModelState.Remove("ConfirmNewPassword");
            if (!ModelState.IsValid)
            {
                return View("login");
            }
            else
            {
                User u = data.Users.Where(s => s.EmailID == user.EmailID && s.Password == user.LoginPassword).FirstOrDefault<User>();

                if (u != null && u.IsActive == true)
                {
                    if (u.IsEmailVerified == true)
                    {
                        Session["userId"] = u.UserID;
                        if (user.RememberMe)
                        {
                            HttpCookie cookie = new HttpCookie("Login");
                            cookie.Values.Add("EmailID",user.EmailID);
                            cookie.Values.Add("Password",user.LoginPassword);
                            cookie.Expires = DateTime.Now.AddDays(15);
                            Response.Cookies.Add(cookie);
                        }

                        UserInfo userInfo = data.UserInfoes.Where(i => i.UserID == u.UserID).FirstOrDefault();
                        if (userInfo == null)
                        {
                            return RedirectToAction("MyProfile", "User");
                        }
                        else
                        {
                            return RedirectToAction("SearchNotes", "User");
                        }
                    }
                    else
                    {
                        SendVerificationLinkEmail(u.EmailID, u.UserID, u.Password);
                        return View("EmailVarification");
                    }
                }
                else
                {
                    ViewBag.message = "The password that you've entered is incorrect.";
                    return View("Login");
                }
            }
        }

        [Route("Auth/Signup")]
        public ActionResult Signup()
        {
            return View("Signup");
        }

        [HttpPost]
        [Route("Auth/Save")]
        public ActionResult Save([Bind(Include = "FirstName,LastName,EmailID,Password,ConfirmPassword")] User user)
        {
            ModelState.Remove("ConfirmPassword");
            ModelState.Remove("NewPassword");
            ModelState.Remove("ConfirmNewPassword");
            if (!ModelState.IsValid)
            {
                return View("Signup");
            }
            else
            {
                user.RoleID = 3;
                user.IsEmailVerified = false;
                user.IsActive = true;
                /* To buypass validation Error*/
                user.NewPassword = "Sagar@211099";
                user.ConfirmNewPassword = "Sagar@211099";
                /**/
                data.Users.Add(user);
                data.SaveChanges();


                SendVerificationLinkEmail(user.EmailID, user.UserID, user.Password);

                ViewBag.name = user.FirstName;

                return View("EmailVarification");
            }
        }

        [Route("Auth/VarifyEmail/{id}/{activationcode}")]
        public ActionResult VarifyEmail(int id,string activationcode)
        {
            User u = data.Users.Find(id);
            if (u.Password.Equals(activationcode))
            {
                u.ConfirmPassword = u.Password;
                u.NewPassword = "Sagar@211099";
                u.ConfirmNewPassword = "Sagar@211099";
                u.IsEmailVerified = true;
                data.Entry(u).State = System.Data.Entity.EntityState.Modified;
                data.SaveChanges();
                return RedirectToAction("Login");
            }
            else
            {
                return Content("You can't do this...");
            }
        }

        [Route("Auth/ForgetPassword")]
        public ActionResult ForgetPassword()
        {
            return View();
        }

        [Route("Auth/SendPassword")]
        public ActionResult SendPassword(User u)
        {
            string newPassword = SendPassword(u.EmailID);
            User user = data.Users.Where(m => m.EmailID.Equals(u.EmailID)).FirstOrDefault();
            user.Password = newPassword;
            user.ConfirmPassword = newPassword;
            user.NewPassword = newPassword;
            user.ConfirmNewPassword = newPassword;
            data.SaveChanges();
            return RedirectToAction("Login");
        }





        private void SendVerificationLinkEmail(string emailId, int id, string activationcode)
        {
            var varifyUrl = "http" + "://" + "localhost" + ":" + "4421" + "/Auth/VarifyEmail/"+id +"/" + activationcode;
            var fromMail = new MailAddress("sagar.new4041@gmail.com", "Notes Marketplace");
            var toMail = new MailAddress(emailId);
            var frontEmailPassowrd = "";
            string subject = "Note Marketplace - Email Verification";
            string body = "<br/><br/>We are excited to tell you that your account is" +
              " successfully created. Please click on the below link to verify your account" +
              " <br/><br/><a href='" + varifyUrl + "'>" + varifyUrl + "</a> ";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromMail.Address, frontEmailPassowrd)

            };
            using (var message = new MailMessage(fromMail, toMail)
            {
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            })
                smtp.Send(message);
        }

        private string SendPassword(string emailId)
        {
            string capital = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            string small = "abcdefghijklmnopqrstuvwxyz";
            string symbol = "~!@#$%^&()";
            string newPassword = "";
            
            Random r = new Random();
            newPassword += capital.ToCharArray()[r.Next(0,25)];
            newPassword += small.ToCharArray()[r.Next(0,25)];
            newPassword += symbol.ToCharArray()[r.Next(0,9)];
            newPassword += r.Next(0, 9);
            newPassword += small.ToCharArray()[r.Next(0, 25)];
            newPassword += capital.ToCharArray()[r.Next(0, 25)];
            newPassword += small.ToCharArray()[r.Next(0, 25)];
            newPassword += capital.ToCharArray()[r.Next(0, 25)];

            /*newPassword = System.Web.Security.Membership.GeneratePassword(8, 1);*/

            //var varifyUrl = "http" + "://" + "localhost" + ":" + "4421" + "/Auth/VarifyEmail/" + id + "/" + activationcode;
           var fromMail = new MailAddress("sagar.new4041@gmail.com", "Notes Marketplace");
            var toMail = new MailAddress(emailId);
            var frontEmailPassowrd = "";
            string subject = "New Temporary Password has been created for you";
            string body = "<br/><br/>Hello, <br/><br/>" +
              "We have generated a new password for you <br/><br/>" +
              "Password: "+ newPassword +
              "<br/><br/> Regards,"+
              "<br/><br/> Notes Marketplace";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromMail.Address, frontEmailPassowrd)

            };
            using (var message = new MailMessage(fromMail, toMail)
            {
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            })
                smtp.Send(message);

            return newPassword;

        }

        [Route("Auth/Logout")]
        public ActionResult Logout()
        {
            Session.Remove("userId");
            return RedirectToAction("Login");
        }

        [Route("Auth/ChangePassword")]
        public ActionResult ChangePassword()
        {
            return View();
        }

        [Route("Auth/UpdatePassword")]
        public ActionResult UpdatePassword(User user)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                User currentUser = data.Users.Find(user.UserID);
                if (user.Password.Equals(currentUser.Password))
                {
                    currentUser.Password = user.NewPassword;
                    currentUser.ConfirmPassword = user.NewPassword;
                    currentUser.NewPassword = user.NewPassword;
                    currentUser.ConfirmNewPassword = user.NewPassword;
                    data.Entry(currentUser).State = System.Data.Entity.EntityState.Modified;
                    data.SaveChanges();
                    return RedirectToAction("Login", "Auth");
                }
                else
                {
                    return Content("The Old Password Not Matched !!!");
                    //return RedirectToAction("ChangePassword", "Auth");
                }
            }
            }



        }
}
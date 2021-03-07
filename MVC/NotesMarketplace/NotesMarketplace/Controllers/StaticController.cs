using NotesMarketplace.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketplace.Controllers
{
    public class StaticController : Controller
    {
        // GET: Static
        [Route("Static/Faq")]
        public ActionResult Faq()
        {
            return View();
        }

        [HttpGet]
        [Route("Static/ContactUs")]
        public ActionResult ContactUs()
        {
            return View();
        }

        [HttpPost]
        [Route("Static/ContactUs")]
        public ActionResult ContactUs(ContactUs contactUs)
        {
            SendComments(contactUs);
            return RedirectToAction("ContactUs");
        }



        private void SendComments(ContactUs contactUs)
        { 
            var fromMail = new MailAddress("sagar.new4041@gmail.com", contactUs.FullName + " - Query");
            var toMail = new MailAddress(contactUs.Email);
            var frontEmailPassowrd = "Sagar@211099";
            string subject = contactUs.FullName + " - Query";
            string body = "<br/><br/>Hello, <br/><br/>" +
                contactUs.Comments
              + "<br/><br/>" +
              
              "Regards," +
              "<br/><br/>" + 
              contactUs.FullName;

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

    }
}
using NotesMarketplace.ViewModels;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using PagedList;

namespace NotesMarketplace.Controllers
{
    public class UserController : Controller
    {
        NotesMarketplaceEntities data = new NotesMarketplaceEntities();


        [Route("User/Home")]
        public ActionResult Home()
        {
            return View();
        }



        // GET: User
        [HttpGet]
        [Route("User/AddNotes")]
        public ActionResult AddNotes()
        {
            /*Temp session to avoid login*/
            Session["userId"] =0;

            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                ViewBag.categoryList = data.Categories.AsEnumerable<Category>();
                ViewBag.typeList = data.Types.ToList<Type>();
                ViewBag.countryList = data.Countries.ToList<Country>();
                return View("addNotes");
            }
        }

        [Route("User/EditNote/{id}")]
        public ActionResult EditNote(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                ViewBag.categoryList = data.Categories.AsEnumerable<Category>();
                ViewBag.typeList = data.Types.ToList<Type>();
                ViewBag.countryList = data.Countries.ToList<Country>();
                NotesDetail noteDetails = data.NotesDetails.Where(n => n.ID == id).FirstOrDefault();
                Addnotes note = new Addnotes();
                note.notesDetail = noteDetails;
                return View(note);
            }
        }

        [Route("User/DeleteNote/{id}")]
        public ActionResult DeleteNote(int id)
        {
            if(Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                data.NotesDetails.Where(n => n.ID == id).FirstOrDefault().IsActive = false;
                data.SaveChanges();
                return RedirectToAction("Dashboard");
            }
        }






        [HttpPost]
        [Route("User/SaveNotes")]
        public ActionResult SaveNotes(Addnotes note, string flag)
        {

            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {

                int userId = (int)Session["userID"];
                NotesDetail notesDetail;

                if (flag.Equals("edit"))
                {
                    notesDetail = data.NotesDetails.Find(note.notesDetail.ID);

                    /*This is the flow for file upload*/


                    /*DisplayPicture*/
                    if (notesDetail.DisplayPicture == null || notesDetail.DisplayPicture.Equals(""))
                    {
                        String DpFileName1 = Path.GetFileName(note.displayPicture.FileName);
                        string DpPath1 = Path.Combine(Server.MapPath("~/Uploads"), DpFileName1);
                        note.displayPicture.SaveAs(DpPath1);
                        notesDetail.DisplayPicture = DpPath1;
                    }
                    else
                    {
                        try
                        {
                            String DpFileName1 = Path.GetFileName(note.displayPicture.FileName);
                            string DpPath1 = Path.Combine(Server.MapPath("~/Uploads"), DpFileName1);
                            note.displayPicture.SaveAs(DpPath1);
                            notesDetail.DisplayPicture = DpPath1;
                        }
                        catch (Exception e)
                        {
                            /*notesDetail.DisplayPicture = notesDetail.DisplayPicture;*/
                            System.Diagnostics.Debug.WriteLine(e);
                        }
                    }


                    /*Upload notes*/

                    if (notesDetail.NotesAttachments == null)
                    {
                        String NotesFileName1 = Path.GetFileName(note.notes.FileName);
                        string NotesPath1 = Path.Combine(Server.MapPath("~/Uploads"), NotesFileName1);
                        note.notes.SaveAs(NotesPath1);

                        // Creating list for notes attachments
                        List<NotesAttachment> notesAttachmentsList1 = new List<NotesAttachment>();

                        // Creating Object for notes attachments
                        NotesAttachment notesAttachment1 = new NotesAttachment();
                        notesAttachment1.NoteID = note.notesDetail.ID;
                        notesAttachment1.FileName = NotesFileName1;
                        notesAttachment1.FilePath = NotesPath1;
                        notesAttachment1.IsActive = true;

                        // Adding to list
                        notesAttachmentsList1.Add(notesAttachment1);

                        // saving object to notedetails
                        notesDetail.NotesAttachments = notesAttachmentsList1;
                    }
                    else
                    {
                        try
                        {
                            String NotesFileName1 = Path.GetFileName(note.notes.FileName);
                            string NotesPath1 = Path.Combine(Server.MapPath("~/Uploads"), NotesFileName1);
                            note.notes.SaveAs(NotesPath1);

                            // Creating list for notes attachments
                            List<NotesAttachment> notesAttachmentsList1 = new List<NotesAttachment>();

                            // Creating Object for notes attachments
                            NotesAttachment notesAttachment1 = new NotesAttachment();
                            notesAttachment1.NoteID = note.notesDetail.ID;
                            notesAttachment1.FileName = NotesFileName1;
                            notesAttachment1.FilePath = NotesPath1;
                            notesAttachment1.IsActive = true;

                            // Adding to list
                            notesAttachmentsList1.Add(notesAttachment1);

                            // saving object to notedetails
                            notesDetail.NotesAttachments = notesAttachmentsList1;
                        }
                        catch (Exception e)
                        {
                            System.Diagnostics.Debug.WriteLine(e);
                        }
                    }


                    /*Notes preview*/
                    if (notesDetail.NotePreview == null || notesDetail.NotePreview.Equals(""))
                    {
                        String NpFileName1 = Path.GetFileName(note.notePreview.FileName);
                        string NpPath1 = Path.Combine(Server.MapPath("~/Uploads"), NpFileName1);
                        note.notePreview.SaveAs(NpPath1);
                        notesDetail.NotePreview = NpPath1;
                    }
                    else
                    {
                        try
                        {
                            String NpFileName1 = Path.GetFileName(note.notePreview.FileName);
                            string NpPath1 = Path.Combine(Server.MapPath("~/Uploads"), NpFileName1);
                            note.notePreview.SaveAs(NpPath1);
                            notesDetail.NotePreview = NpPath1;
                        }
                        catch (Exception e)
                        {
                            System.Diagnostics.Debug.WriteLine(e);
                        }
                    }





                }
                else
                {

                    /*Creat one object to assign value from the form which is catch by Custom ViewModel Addnotes*/
                    notesDetail = new NotesDetail();
                }
                /* Assigning individual values */

                notesDetail.Title = note.notesDetail.Title;


                notesDetail.CategoryID = note.notesDetail.CategoryID;

                /*DisplayPicture*/
                if(flag.Equals("save"))
                { 
                String DpFileName = Path.GetFileName(note.displayPicture.FileName);
                string DpPath = Path.Combine(Server.MapPath("~/Uploads"), DpFileName);
                note.displayPicture.SaveAs(DpPath);
                notesDetail.DisplayPicture = DpPath;

                /*Upload notes*/

                String NotesFileName = Path.GetFileName(note.notes.FileName);
                string NotesPath = Path.Combine(Server.MapPath("~/Uploads"), NotesFileName);
                note.notes.SaveAs(NotesPath);

                // Creating list for notes attachments
                List<NotesAttachment> notesAttachmentsList = new List<NotesAttachment>();

                // Creating Object for notes attachments
                NotesAttachment notesAttachment = new NotesAttachment();
                notesAttachment.NoteID = note.notesDetail.ID;
                notesAttachment.FileName = NotesFileName;
                notesAttachment.FilePath = NotesPath;
                notesAttachment.IsActive = true;

                // Adding to list
                notesAttachmentsList.Add(notesAttachment);

                // saving object to notedetails
                notesDetail.NotesAttachments = notesAttachmentsList;
                /*Notes preview*/

                String NpFileName = Path.GetFileName(note.notePreview.FileName);
                string NpPath = Path.Combine(Server.MapPath("~/Uploads"), NpFileName);
                note.notePreview.SaveAs(NpPath);
                notesDetail.NotePreview = NpPath;
            }


                notesDetail.TypeID = note.notesDetail.TypeID;

                        notesDetail.NumberOfPages = note.notesDetail.NumberOfPages;

                        notesDetail.Description = note.notesDetail.Description;


                        notesDetail.CountryID = note.notesDetail.CountryID;

                        notesDetail.UniversityName = note.notesDetail.UniversityName;

                        notesDetail.Course = note.notesDetail.Course;

                        notesDetail.CourseCode = note.notesDetail.CourseCode;

                        notesDetail.Professor = note.notesDetail.Professor;

                        /*Is paid radio button*/
                        notesDetail.IsPaid = note.notesDetail.IsPaid;

                        notesDetail.Price = note.notesDetail.Price;


                        

                        notesDetail.IsActive = true;
                        notesDetail.SellerID = userId;

                        /* Checking status based upon button clicked */
                        notesDetail.Status = note.submitButton.Equals("SAVE") ? "Draft" : "Submitted";

                        /*Dummy entires*/
                        notesDetail.PublishedDate = System.DateTime.Now;
                        notesDetail.DateAdded = System.DateTime.Now;
                        notesDetail.ActionedBy = userId;

                        
                if(flag.Equals("save"))
                    {
                    data.NotesDetails.Add(notesDetail);
                }

                    
                        data.SaveChanges();
                    

                    return RedirectToAction("Dashboard");
                }
            
                
        }


        /*[HttpPost]
        [Route("User/UpdateNotes")]
        public ActionResult UpdateNotes(Addnotes note)
        {

            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {

                return RedirectToAction("Dashboard");
            }


        }*/



        [Route("User/NoteDetails/{id}")]
        public ActionResult NoteDetails(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                try
                {
                    NotesDetail notesDetail = data.NotesDetails.Where(n => n.ID == id && n.IsActive == true).FirstOrDefault();
                    List<Review> reviews = data.Reviews.Where(m => m.ReviewedNoteID == notesDetail.ID).ToList<Review>();
                    if (reviews.Count() != 0)
                    {
                        notesDetail.NumberOfRatings = reviews.Count();
                        notesDetail.AverageRatings = (int)Math.Round(reviews.Average(m => m.Ratings), 0);
                    }
                    else
                    {
                        notesDetail.NumberOfRatings = 0;
                        notesDetail.AverageRatings = 0;
                    }
                    List<SpamReport> spamReports = data.SpamReports.Where(m => m.NoteID == notesDetail.ID).ToList<SpamReport>();
                    if (spamReports != null)
                    {
                        notesDetail.NumberOfSpamReports = spamReports.Count();
                    }
                    else
                    {
                        notesDetail.NumberOfSpamReports = 0;
                    }

                    List<UserInfo> raters = new List<UserInfo>();
                    foreach (Review r in reviews)
                    {
                        UserInfo u = data.UserInfoes.Where(m => m.UserID == r.ReviewedByUserID).FirstOrDefault();
                        raters.Add(u);
                    }
                    ViewBag.raters = raters;
                    ViewBag.reviews = reviews;
                    return View(notesDetail);
                }
                catch (Exception e)
                {
                    return Content("Something Went wrong...\n"+e.Message);
                }
            }
        }

        [Route("User/DownloadedNoteDetails/{id}")]
        public ActionResult DownloadedNoteDetails(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                try
                {

                    NotesDetail notesDetail = data.NotesDetails.Where(n => n.ID == id && n.IsActive == true).FirstOrDefault();
                    List<Review> reviews = data.Reviews.Where(m => m.ReviewedNoteID == notesDetail.ID).ToList<Review>();
                    if (reviews.Count() != 0)
                    {
                        notesDetail.NumberOfRatings = reviews.Count();
                        notesDetail.AverageRatings = (int)Math.Round(reviews.Average(m => m.Ratings), 0);
                    }
                    else
                    {
                        notesDetail.NumberOfRatings = 0;
                        notesDetail.AverageRatings = 0;
                    }
                    List<SpamReport> spamReports = data.SpamReports.Where(m => m.NoteID == notesDetail.ID).ToList<SpamReport>();
                    if (spamReports != null)
                    {
                        notesDetail.NumberOfSpamReports = spamReports.Count();
                    }
                    else
                    {
                        notesDetail.NumberOfSpamReports = 0;
                    }

                    List<UserInfo> raters = new List<UserInfo>();
                    foreach (Review r in reviews)
                    {
                        UserInfo u = data.UserInfoes.Where(m => m.UserID == r.ReviewedByUserID).FirstOrDefault();
                        raters.Add(u);
                    }
                    ViewBag.raters = raters;
                    ViewBag.reviews = reviews;

                    /* Getting Buyer and seller name for displaying in thanksPopUp */
                    ViewBag.buyerName = data.Users.Find(Session["userId"]).FirstName;
                    ViewBag.sellerName = data.Users.Find(notesDetail.SellerID).FirstName;


                    return View(notesDetail);
                }
                catch (Exception e)
                {
                    return Content("Something Went wrong...\n" + e.Message);
                }
            }
        }


        [Route("User/BuyerRequests")]
        public ActionResult BuyerRequests()
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                return View();
            }
        }

        [HttpPost]
        [Route("User/BuyerRequestsData")]
        public JsonResult BuyerRequestsData()
        {
            if (Session["userId"] == null)
            {
                return Json(new { ErrorMessage = "User Not logged in !" });
            }
            else
            {
                int userId = (int)Session["userID"];

                /* Suppose logged in userid is 0 */
                List<Download> buyerRequests = data.Downloads.Where(m => m.Seller == userId && m.IsSellerHasAllowedDownload == false).ToList<Download>();

                List<BuyerRequest> buyerRequestsData = new List<BuyerRequest>();
                int i = 0;
                foreach (Download d in buyerRequests)
                {
                    i++;
                    User u = data.Users.Find(d.Downloader);
                    UserInfo un = data.UserInfoes.Where(m => m.UserID == d.Downloader).FirstOrDefault();

                    BuyerRequest br = new BuyerRequest();
                    br.SrNo = i;
                    br.NoteId = d.NoteID;
                    br.id = d.ID;
                    br.NoteTitle = d.NoteTitle;
                    br.NoteCategory = d.NoteCategory;
                    br.Buyer = u.EmailID;
                    br.PhoneNo = un.PhoneNumber;
                    /*br.SellType = d.IsPaid ? true : false;*/
                    br.SellType = d.IsPaid ? "Paid" : "Free";
                    br.Price = (int)d.PurchasedPrice;
                    br.DonwloadedTime = d.AttachmentDownloadedDate.ToString();


                    /* Add to the model list */
                    buyerRequestsData.Add(br);
                }
                return Json(buyerRequestsData);
            }


        }


        [Route("User/allowDownload/{id}")]
        public ActionResult AllowDownload(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];

                /* Suppose logged in userid 0 */
                Download download = data.Downloads.Where(d => d.ID == id && d.Seller == userId).FirstOrDefault();
                download.IsSellerHasAllowedDownload = true;
                data.SaveChanges();
                User buyer = data.Users.Find(download.Downloader);
                User seller = data.Users.Find(download.Seller);
                NotifyBuyer(buyer.EmailID,buyer.FirstName,seller.FirstName);
                return RedirectToAction("BuyerRequests");
            }
        }

        private void NotifyBuyer(String email, string buyerName, string sellerName)
        {
            var fromMail = new MailAddress("sagar.new4041@gmail.com");
            var toMail = new MailAddress(email);
            var frontEmailPassowrd = "";
            string subject = sellerName + " Allows you to download a note";
            string body = "<br/><br/>Hello " + buyerName +
                ", <br/><br/>" +
                "We would like to inform you that, "+ sellerName +" Allows you to download a note.<br>"+
                "Please login and see My Download tabs to download particular note.<br/><br/>" +
                "Regards,<br/><br/> Notes Marketplace";

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


        [Route("User/Dashboard")]
        public ActionResult Dashboard()
        {
            

            if (Session["userId"] == null)
            {
                return RedirectToAction("Login","Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                /* Suppose logged in userid 0 */

                Dashboard dashboard = new Dashboard();

                /* Number Of Sold Notes */
                try
                {
                    dashboard.NumberOfSoldNotes = data.Downloads.Where(d => d.Seller == userId && d.IsSellerHasAllowedDownload == true).Count();
                }
                catch (Exception e)
                {
                    dashboard.NumberOfSoldNotes = 0;
                    System.Diagnostics.Debug.WriteLine(e);
                }


                /* Total Money Earned by user */
                try
                {
                    dashboard.MoneyEarned = (int)data.Downloads.Where(d => d.Seller == userId && d.IsSellerHasAllowedDownload == true).Sum(d => d.PurchasedPrice);
                }
                catch (Exception e)
                {
                    dashboard.MoneyEarned = 0;
                    System.Diagnostics.Debug.WriteLine(e);
                }

                /* Number Of Notes Downloaded By user */
                try
                {
                    /*dashboard.MyDownloads = data.Downloads.Where(d => d.Downloader == userId && d.IsSellerHasAllowedDownload == true && d.IsAttachmentDownloaded == true).Count();*/
                    dashboard.MyDownloads = data.Downloads.Where(d => d.Downloader == userId && d.IsSellerHasAllowedDownload == true).Count();
                }
                catch (Exception e)
                {
                    dashboard.MyDownloads = 0;
                    System.Diagnostics.Debug.WriteLine(e);
                }

                /* Number Of Rejected Notes by Admin */
                try
                {
                    dashboard.MyRejectedNotes = data.NotesDetails.Where(d => d.SellerID == userId && d.Status.Equals("Rejected")).Count();
                }
                catch (Exception e)
                {
                    dashboard.MyRejectedNotes = 0;
                    System.Diagnostics.Debug.WriteLine(e);
                }

                /* Number Of Buyer Requests */
                try
                {
                    dashboard.BuyerRequests = data.Downloads.Where(d => d.Seller == userId && d.IsSellerHasAllowedDownload == false).Count();
                }
                catch (Exception e)
                { 
                    dashboard.BuyerRequests = 0;
                    System.Diagnostics.Debug.WriteLine(e);
                }

                return View(dashboard);
            }
            
        }


        [Route("User/InProgressNotes")]
        public JsonResult InProgressNotes()
        {
            if (Session["userId"] == null)
            {
                return Json(new { ErrorMessage = "User Not logged in !" });
            }
            else
            {
                int userId = (int)Session["userID"];

                /* Suppose logged in userid 0 */

                List<NotesDetail> inProgressNotes = data.NotesDetails.Where(n => n.SellerID == userId && n.IsActive == true &&
                (n.Status.Equals("Draft") || n.Status.Equals("InReview") || n.Status.Equals("Submitted"))).ToList<NotesDetail>();

                List<DashboardNotes> dashboardNotesData = new List<DashboardNotes>();

                foreach (NotesDetail notesDetail in inProgressNotes)
                {
                    DashboardNotes dashboardNotes = new DashboardNotes();
                    dashboardNotes.id = notesDetail.ID;
                    DateTime d = (DateTime)notesDetail.DateAdded;
                    String format = "dd-MM-yyyy";
                    dashboardNotes.AddedDate = d.ToString(format);
                    dashboardNotes.Title = notesDetail.Title;
                    dashboardNotes.Category = notesDetail.Category.CategoryName;
                    dashboardNotes.Status = notesDetail.Status;

                    dashboardNotesData.Add(dashboardNotes);
                }

                return Json(dashboardNotesData);
            }
        }


        [Route("User/PublishedNotes")]
        public JsonResult PublishedNotes()
        {
            if (Session["userId"] == null)
            {
                return Json(new { ErrorMessage = "User Not logged in !"});
            }
            else
            {
                int userId = (int)Session["userID"];

                /* Suppose logged in userid 0 */

                List<NotesDetail> publishedNotes = data.NotesDetails.Where(n => n.SellerID == userId && n.IsActive == true && n.Status.Equals("Published")).ToList<NotesDetail>();

                List<DashboardNotes> dashboardNotesData = new List<DashboardNotes>();

                foreach (NotesDetail notesDetail in publishedNotes)
                {
                    DashboardNotes dashboardNotes = new DashboardNotes();
                    dashboardNotes.id = notesDetail.ID;
                    DateTime d = (DateTime)notesDetail.PublishedDate;
                    String format = "dd-MM-yyyy";
                    dashboardNotes.AddedDate = d.ToString(format);
                    dashboardNotes.Title = notesDetail.Title;
                    dashboardNotes.Category = notesDetail.Category.CategoryName;
                    dashboardNotes.SellType = notesDetail.IsPaid ? "Paid" : "Free";
                    dashboardNotes.Price = notesDetail.Price;

                    dashboardNotesData.Add(dashboardNotes);
                }

                return Json(dashboardNotesData);
            }
        }



        [Route("User/DownloadNote/{id}")]
        public ActionResult DownloadNote(int id)
        {
            /* Here the buyer request is generated */
            if (Session["userId"] == null)
            {
                return Json(new { ErrorMessage = "User Not logged in !" });
            }
            else
            {
                int userId = (int)Session["userID"];

                NotesDetail noteDetails = data.NotesDetails.Find(id);

                /* There is one assumption that there is only one attachment available with note */
                NotesAttachment notesAttachment = data.NotesAttachments.Where(n => n.NoteID == id).FirstOrDefault();
                Download download = new Download();

                download.NoteID = noteDetails.ID;
                download.Seller = noteDetails.SellerID;
                download.Downloader = userId;
                
                download.AttachmentPath = notesAttachment.FilePath;

                download.NoteTitle = noteDetails.Title;
                download.NoteCategory = data.Categories.Find(noteDetails.CategoryID).CategoryName;
                download.AttachmentDownloadedDate = (DateTime)System.DateTime.Now;
                download.IsPaid = noteDetails.IsPaid;
                if (noteDetails.IsPaid)
                {
                    //paid
                    download.IsSellerHasAllowedDownload = false;
                    download.IsAttachmentDownloaded = false;
                    download.PurchasedPrice = noteDetails.Price;
                    data.Downloads.Add(download);
                    data.SaveChanges();

                    /*Sending an email to the seller that logged in user wants to buy the paid notes*/
                    User Seller = data.Users.Find(data.NotesDetails.Find(id).SellerID);
                    User Buyer = data.Users.Find(userId);
                    RequestFromBuyer(Seller.EmailID,Seller.FirstName,Buyer.FirstName);
                    return RedirectToAction("DownloadedNoteDetails/" + id);
                }
                else
                {
                    //Free
                    //FileResult f = DownloadAttachment(Path.GetFileName(notesAttachment.FilePath));
                    download.IsSellerHasAllowedDownload = true;
                    download.AttachmentDownloadedDate = (DateTime)System.DateTime.Now;
                    download.IsAttachmentDownloaded = true;
                    download.PurchasedPrice = 0;

                    //return RedirectToAction("DownloadAttachment/"+ Path.GetFileName(notesAttachment.FilePath));
                    data.Downloads.Add(download);
                    data.SaveChanges();
                    return DownloadAttachment(Path.GetFileName(notesAttachment.FilePath));
                }

                
            }
        }

        private void RequestFromBuyer(String email, string sellerName, string buyerName)
        {
            var fromMail = new MailAddress("sagar.new4041@gmail.com");
            var toMail = new MailAddress(email);
            var frontEmailPassowrd = "";
            string subject = buyerName + " wants to purchase your notes";
            string body = "<br/><br/>Hello " + sellerName +
                ", <br/><br/>" +
                "We would like to inform you that, " + buyerName + " wants to purchase your notes. Please see" +
                "Buyer Requests tab and allow download access to Buyer if you have received the payment from him.<br/><br/>" +
                "Regards,<br/><br/> Notes Marketplace";

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




        public ActionResult DownloadAttachment(string fileName)
        {
            string path = AppDomain.CurrentDomain.BaseDirectory + "Uploads/";
            byte[] fileBytes = System.IO.File.ReadAllBytes(path + fileName);
            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }

        /* For Downloading of note from Id */
        [Route("User/DownloadNoteById/{id}")]
        public ActionResult DownloadNoteById(int id)
        {
            string fileName = data.NotesAttachments.Where(d => d.NoteID == id).FirstOrDefault().FileName;
            return DownloadAttachment(fileName);
        }



        [Route("User/Faq")]
        public ActionResult Faq()
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                return View();
            }
        }

        [HttpGet]
        [Route("User/ContactUs")]
        public ActionResult ContactUs()
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                return View();
            }
        }

        [HttpPost]
        [Route("User/ContactUs")]
        public ActionResult ContactUs(ContactUs contactUs)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                SendComments(contactUs);
                return RedirectToAction("ContactUs");
            }
        }



        private void SendComments(ContactUs contactUs)
        {
            var fromMail = new MailAddress("sagar.new4041@gmail.com", contactUs.FullName + " - Query");
            var toMail = new MailAddress(contactUs.Email);
            var frontEmailPassowrd = "";
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


        /* User Navigation Submenu */

        /* User Profile */

        [Route("User/MyProfile")]
        public ActionResult MyProfile()
        {
            

            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                User u = data.Users.Find(userId);
                UserInfo user;
                user = data.UserInfoes.Where(m => m.UserID == userId).FirstOrDefault();
                if (user != null)
                {
                    user.FirstName = u.FirstName;
                    user.LastName = u.LastName;
                }
                else
                {
                    user = new UserInfo();
                }
                ViewBag.countryList = data.Countries.ToList<Country>();

                return View(user);
            }
        }

        [HttpPost]
        [Route("User/SaveProfile")]
        public ActionResult SaveProfile(UserInfo userInfo)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];

                UserInfo userData = userInfo;

                /* Profile Picture*/
                if (userData.ProfilePicture == null || userData.ProfilePicture.Equals(""))
                {
                    String DpFileName = Path.GetFileName(userInfo.file.FileName);
                    string DpPath = Path.Combine(Server.MapPath("~/Uploads"), DpFileName);
                    userInfo.file.SaveAs(DpPath);
                    userData.ProfilePicture = DpPath;
                }
                else
                {
                    try
                    {
                        String DpFileName = Path.GetFileName(userInfo.file.FileName);
                        string DpPath = Path.Combine(Server.MapPath("~/Uploads"), DpFileName);
                        userInfo.file.SaveAs(DpPath);
                        userData.ProfilePicture = DpPath;
                    }
                    catch (Exception e)
                    {
                        System.Diagnostics.Debug.WriteLine(e);
                    }
                }
                

                /* Who's Profile */
                userData.UserID = userId;

                
                userData.DateOfBirth = userInfo.DateOfBirth;
                

                /*Date added and Added By*/
                userData.DateAdded = (DateTime)System.DateTime.Now;
                userData.AddedBy = userId;
                data.UserInfoes.Add(userData);
                if (userData.ID != 0)
                { 
                    data.Entry(userData).State = System.Data.Entity.EntityState.Modified; 
                }
                data.SaveChanges();

                return RedirectToAction("SearchNotes", "User");
            }
        }

        [Route("User/MyDownloads")]
        public ActionResult MyDownloads()
        {
            return View();        
        }

        [Route("User/MyDownloadsData")]
        public JsonResult MyDownloadsData()
        {
            if (Session["userId"] == null)
            {
                return Json(new { ErrorMessage = "User Not logged in !" });
            }
            else
            {
                int userId = (int)Session["userID"];

                List<Download> downloads = data.Downloads.Where(d => d.Downloader == userId && d.IsSellerHasAllowedDownload == true).ToList<Download>();

                List<NotesHelp> downloadsData = new List<NotesHelp>();
                int i = 0;
                foreach (Download download in downloads)
                {
                    i++;
                    NotesHelp notesHelp = new NotesHelp();
                    notesHelp.SrNo = i;
                    notesHelp.id = download.NoteID;
                    notesHelp.downloadId = download.ID;
                    notesHelp.NoteTitle = download.NoteTitle;
                    notesHelp.Category = download.NoteCategory;
                    notesHelp.Seller = data.Users.Find(download.Seller).EmailID;
                    notesHelp.SellType = download.IsPaid ? "Paid" : "Free";
                    notesHelp.Price = (int)download.PurchasedPrice;
                    DateTime d = (DateTime)download.AttachmentDownloadedDate;
                    String format = "dd MMM yyyy, hh:mm:ss";
                    notesHelp.DownloadDateTime = d.ToString(format);
                    downloadsData.Add(notesHelp);
                }

                return Json(downloadsData, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        [Route("User/AddReview")]
        public ActionResult AddReview(int downloadID, string comments)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                Download download = data.Downloads.Find(downloadID);
                Review review = new Review();
                review.AgainstDownloadsID = downloadID;
                review.ReviewedByUserID = userId;
                review.ReviewedNoteID = download.NoteID;
                review.Ratings = 5;
                review.Comments = comments;
                review.DateReviewed = (DateTime)System.DateTime.Now;
                review.ReviewedBy = userId;
                review.IsActive = true;

                data.Reviews.Add(review);
                data.SaveChanges();
                return RedirectToAction("MyDownloads"); 
            }
        }

        [HttpPost]
        [Route("User/ReportIssue")]
        public ActionResult ReportIssue(int downloadID2, string comments)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                SpamReport spamReport = new SpamReport();
                Download download = data.Downloads.Find(downloadID2);

                spamReport.NoteID = download.NoteID;
                spamReport.ReportedByUserID = userId;
                spamReport.AgainstDownloadID = download.ID;
                spamReport.DateReported = (DateTime)System.DateTime.Now;
                spamReport.Remarks = comments;
                spamReport.AddedBy = userId;

                data.SpamReports.Add(spamReport);
                data.SaveChanges();

                string user = data.Users.Find(userId).FirstName;
                string seller = data.Users.Find(download.Seller).FirstName;
                string title = download.NoteTitle;
                SendSpamReport(user,seller,title);

                return RedirectToAction("MyDownloads");
            }
        }

        private void SendSpamReport(string member, string seller, string title)
        {
            var fromMail = new MailAddress("sagar.new4041@gmail.com");
            var toMail = new MailAddress("sagarvaghela4041@gmail.com");
            var frontEmailPassowrd = "";
            string subject = member + " Reported an issue for "+ title;
            string body = "<br/><br/>Hello Admins, <br/><br/>" +
                "We want to inform you that, " + member + " Reported an issue for "+ seller+"’s Note with title "
                + title+". Please look at the notes and take required actions. "
              + "<br/><br/>" +

              "Regards," +
              "<br/><br/>" +
              "Notes Marketplace";

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


        [Route("User/MySoldNotes")]
        public ActionResult MySoldNotes()
        {
            return View();        
        }


        [Route("User/MySoldNotesData")]
        public JsonResult MySoldNotesData()
        {
            if (Session["userId"] == null)
            {
                return Json(new { ErrorMessage = "User Not logged in !" });
            }
            else
            {
                int userId = (int)Session["userID"];

                List<Download> downloads = data.Downloads.Where(d => d.Seller == userId && d.IsSellerHasAllowedDownload == true).ToList<Download>();
                List<NotesHelp> SoldNotesData = new List<NotesHelp>();
                int i = 0;
                foreach (Download download in downloads)
                {
                    i++;
                    NotesHelp notesHelp = new NotesHelp();

                    notesHelp.SrNo = i;
                    notesHelp.id = download.NoteID;
                    notesHelp.NoteTitle = download.NoteTitle;
                    notesHelp.Category = download.NoteCategory;
                    notesHelp.Buyer = data.Users.Find(download.Downloader).EmailID;
                    notesHelp.SellType = download.IsPaid ? "Paid" : "Free";
                    notesHelp.Price = (int)download.PurchasedPrice;
                    DateTime d = (DateTime)download.AttachmentDownloadedDate;
                    String format = "dd MMM yyyy, hh:mm:ss";
                    notesHelp.DownloadDateTime = d.ToString(format);
                    SoldNotesData.Add(notesHelp);
                }

                return Json(SoldNotesData, JsonRequestBehavior.AllowGet);
            }
        }


        [Route("User/MyRejectedNotes")]
        public ActionResult MyRejectedNotes()
        {
            return View();
        }

        [Route("User/MyRejectedNotesData")]
        public JsonResult MyRejectedNotesData()
        {
            if (Session["userId"] == null)
            {
                return Json(new { ErrorMessage = "User Not logged in !" });
            }
            else
            {
                int userId = (int)Session["userID"];
                List<NotesDetail> notes = data.NotesDetails.Where(n => n.SellerID == userId && n.Status.Equals("Rejected")).ToList<NotesDetail>();

                List<NotesHelp> rejectedNotesData = new List<NotesHelp>();
                int i = 0;
                foreach (NotesDetail notesDetail in notes)
                {
                    i++;
                    NotesHelp notesHelp = new NotesHelp();

                    notesHelp.SrNo = i;
                    notesHelp.id = notesDetail.ID;
                    notesHelp.NoteTitle = notesDetail.Title;
                    notesHelp.Category = data.Categories.Find(notesDetail.CategoryID).CategoryName;
                    notesHelp.Remarks = notesDetail.AdminRemarks;
                    rejectedNotesData.Add(notesHelp);
                }
                return Json(rejectedNotesData, JsonRequestBehavior.AllowGet);
            }
        }

        [Route("User/SearchNotes")]
        public ActionResult SearchNotes(int? page, int? type, int? category, int? country, string university, 
                                string course, int? rating, string search)
        {
            /*Temp session set to avoid login repeatedly*/
            /*Session["userId"] = 0;*/

            if (Session["userId"] == null)
            {
                ViewBag.layout = "~/Views/Shared/_Static.cshtml";
            }
            else
            {
                ViewBag.layout = "~/Views/Shared/_User.cshtml";
            }


                List<NotesDetail> notesData = data.NotesDetails
                .Where(n => n.IsActive == true)
                .Where(n => n.TypeID == type || type == null || type == 0)
                .Where(n => n.CategoryID == category || category == null || category == 0)
                .Where(n => n.CountryID == country || country == null || country == 0)
                .Where(n => n.UniversityName.Equals(university) || university == null || university == "")
                .Where(n => n.Course.Equals(course) || course == null || course == "")
                .ToList<NotesDetail>();

            notesData = notesData.FindAll(n => n.Title.Equals(search) || 
                            n.UniversityName.Equals(search) ||
                            n.Country.CountryName.Equals(search) ||
                            search ==null || search == ""
                            ).ToList<NotesDetail>();

            

            foreach(NotesDetail note in notesData)
            {
                /* For getting the list, count and average reviews of the individual note */
                List<Review> reviews = data.Reviews.Where(m => m.ReviewedNoteID == note.ID).ToList<Review>();
                if (reviews.Count() != 0)
                {
                    note.NumberOfRatings = reviews.Count();
                    note.AverageRatings = (int)Math.Round(reviews.Average(m => m.Ratings),0);
                }
                else 
                {
                    note.NumberOfRatings = 0;
                    note.AverageRatings = 0;
                }

                /* For getting the number of spam reports for individual note*/
                note.NumberOfSpamReports = data.SpamReports.Where(m => m.NoteID == note.ID).Count() == 0 ? 0: data.SpamReports.Where(m => m.NoteID == note.ID).Count();
            }

            notesData = notesData.FindAll(n => n.AverageRatings == rating 
                                        || rating == null || rating == 0).ToList<NotesDetail>();

            ViewBag.TotalNotes = notesData.Count();


            ViewBag.type = new SelectList(data.NotesDetails.GroupBy(m => m.Type).Select(
                 v => new SelectListItem
                 {
                     Value = v.Key.TypeID.ToString(),
                     Text = v.Key.TypeName
                 }
                ).ToList(), "Value", "Text") ;

            ViewBag.category = new SelectList(data.NotesDetails.GroupBy(m => m.Category).Select(
                 v => new SelectListItem
                 {
                     Value = v.Key.CategoryID.ToString(),
                     Text = v.Key.CategoryName
                 }
                ).ToList(), "Value", "Text");

            ViewBag.university = new SelectList(data.NotesDetails.GroupBy(m => m.UniversityName).Select(
                 v => new SelectListItem
                 {
                     Value = v.Key.ToString(),
                     Text = v.Key
                 }
                ).ToList(), "Value", "Text");

            ViewBag.course = new SelectList(data.NotesDetails.GroupBy(m => m.Course).Select(
                 v => new SelectListItem
                 {
                     Value = v.Key.ToString(),
                     Text = v.Key
                 }
                ).ToList(), "Value", "Text");

            ViewBag.country = new SelectList(data.NotesDetails.GroupBy(m => m.Country).Select(
                 v => new SelectListItem
                 {
                     Value = v.Key.CountryID.ToString(),
                     Text = v.Key.CountryName
                 }
                ).ToList(), "Value", "Text");

            List<SelectListItem> ratings = new List<SelectListItem>();
            ratings.Add(new SelectListItem { Text = "1", Value = "1" });
            ratings.Add(new SelectListItem { Text = "2", Value = "2" });
            ratings.Add(new SelectListItem { Text = "3", Value = "3" });
            ratings.Add(new SelectListItem { Text = "4", Value = "4" });
            ratings.Add(new SelectListItem { Text = "5", Value = "5" });

            ViewBag.rating = ratings;

            int pageSize = 9;
            int pageNumber = (page ?? 1);
            System.Diagnostics.Debug.WriteLine(type + "\n" +
                category + "\n" +
                university + "\n" +
                course + "\n" +
                country + "\n" +
                rating + "\n" +
                search );
            return View(notesData.ToPagedList(pageNumber, pageSize));
        }





    }
}
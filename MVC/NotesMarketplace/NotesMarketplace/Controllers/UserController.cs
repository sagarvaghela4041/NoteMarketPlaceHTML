using NotesMarketplace.ViewModels;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketplace.Controllers
{
    public class UserController : Controller
    {
        NotesMarketplaceEntities data = new NotesMarketplaceEntities();

        // GET: User
        [HttpGet]
        [Route("User/AddNotes")]
        public ActionResult AddNotes()
        {

            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                ViewBag.categoryList = data.Categories.ToList<Category>();
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
                return View("Dashboard");
            }
        }






        [HttpPost]
        [Route("User/SaveNotes")]
        public ActionResult SaveNotes(Addnotes note)
        {
            
                if (Session["userId"] == null)
                {
                    return RedirectToAction("Login", "Auth");
                }
                else
                {
                    int userId = (int)Session["userID"];

                    /*Creat one object to assign value from the form which is catch by Custom ViewModel Addnotes*/
                    NotesDetail notesDetail = new NotesDetail();

                    /* Assigning individual values */

                    notesDetail.Title = note.notesDetail.Title;

                    /* Dummy data as of now I can't get the drop downvalue*/
                    notesDetail.CategoryID = 1;

                    /*DisplayPicture*/

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

                    /*Dummy data as of now I can't get the drop downvalue*/
                    notesDetail.TypeID = 1;

                    notesDetail.NumberOfPages = note.notesDetail.NumberOfPages;

                    notesDetail.Description = note.notesDetail.Description;

                    /*Dummy data as of now I can't get the drop downvalue*/
                    notesDetail.CountryID = 1;

                    notesDetail.UniversityName = note.notesDetail.UniversityName;

                    notesDetail.Course = note.notesDetail.Course;

                    notesDetail.CourseCode = note.notesDetail.CourseCode;

                    notesDetail.Professor = note.notesDetail.Professor;

                    /*Is paid radio button*/
                    notesDetail.IsPaid = note.notesDetail.IsPaid;

                    notesDetail.Price = note.notesDetail.Price;


                    /*Notes preview*/

                    String NpFileName = Path.GetFileName(note.notePreview.FileName);
                    string NpPath = Path.Combine(Server.MapPath("~/Uploads"), NpFileName);
                    note.notePreview.SaveAs(NpPath);
                    notesDetail.NotePreview = NpPath;

                    notesDetail.IsActive = true;
                    notesDetail.SellerID = userId;

                    /* Checking status based upon button clicked */
                    notesDetail.Status = note.submitButton.Equals("SAVE")?"Draft":"Submitted" ;

                    /*Dummy entires*/
                    notesDetail.PublishedDate = System.DateTime.Now;
                    notesDetail.DateAdded = System.DateTime.Now;
                    notesDetail.ActionedBy = userId;

                    data.NotesDetails.Add(notesDetail);
                    data.SaveChanges();

                    return RedirectToAction("Dashboard");
                }
            
                
        }



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
                    ViewBag.reviewsCount = reviews.Count();
                    ViewBag.averageRating = reviews.Average(m => m.Ratings);
                    List<UserInfo> raters = new List<UserInfo>();
                    foreach (Review r in reviews)
                    {
                        UserInfo u = data.UserInfoes.Find(r.ReviewedByUserID);
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

                foreach (Download d in buyerRequests)
                {
                    User u = data.Users.Find(d.Downloader);
                    UserInfo un = data.UserInfoes.Where(m => m.UserID == d.Downloader).FirstOrDefault();

                    BuyerRequest br = new BuyerRequest();

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

                data.Downloads.Where(d => d.ID == id && d.Seller == userId).FirstOrDefault().IsSellerHasAllowedDownload = true;
                data.SaveChanges();

                return RedirectToAction("BuyerRequests");
            }
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

                dashboard.NumberOfSoldNotes = data.Downloads.Where(d => d.Seller == userId && d.IsSellerHasAllowedDownload == true).Count();

                dashboard.MoneyEarned = (int)data.Downloads.Where(d => d.Seller == userId && d.IsSellerHasAllowedDownload == true).Sum(d => d.PurchasedPrice);

                dashboard.MyDownloads = data.Downloads.Where(d => d.Downloader == userId && d.IsSellerHasAllowedDownload == true && d.IsAttachmentDownloaded == true).Count();

                dashboard.MyRejectedNotes = data.NotesDetails.Where(d => d.SellerID == userId && d.Status.Equals("Rejected")).Count();

                dashboard.BuyerRequests = data.Downloads.Where(d => d.Seller == userId && d.IsSellerHasAllowedDownload == false).Count();

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

                if (noteDetails.IsPaid)
                {
                    //paid
                    download.IsSellerHasAllowedDownload = false;
                    download.IsAttachmentDownloaded = false;
                    download.PurchasedPrice = noteDetails.Price;
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
                }

                data.Downloads.Add(download);
                data.SaveChanges();

                return RedirectToAction("NoteDetails/" + id);
            }
        }


        public ActionResult DownloadAttachment(string fileName)
        {
            string path = AppDomain.CurrentDomain.BaseDirectory + "Uploads/";
            byte[] fileBytes = System.IO.File.ReadAllBytes(path + fileName);
            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }














    }
}
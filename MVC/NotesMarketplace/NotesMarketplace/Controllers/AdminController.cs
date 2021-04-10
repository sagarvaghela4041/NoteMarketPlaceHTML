using NotesMarketplace.ViewModels;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketplace.Controllers
{
    public class AdminController : Controller
    {
        private NotesMarketplaceEntities data = new NotesMarketplaceEntities();
        // GET: Admin

        /* Section 4.2 */
        /* Dashboard */

        [Route("Admin/Dashboard")]
        public ActionResult Dashboard()
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                DateTime CompareDate = DateTime.Now.AddDays(-7);
                ViewBag.NumberOfNotesInReview =
                    data.NotesDetails.Where(
                        n => n.Status.Equals("Submitted") || n.Status.Equals("InReview")).Count();

                ViewBag.NumberOfNotesDownloaded =
                    data.Downloads.Where(d => d.IsSellerHasAllowedDownload == true &&
                          d.AttachmentDownloadedDate > CompareDate).Count();


                ViewBag.NumberOfNewRegistration =
                    data.Users.Where(u => u.RoleID == 3 &&
                          u.DateAdded > CompareDate).Count();

                List<SelectListItem> Months = new List<SelectListItem>();
                int month = System.DateTime.Now.Month;
                ViewBag.SelectedMonth = month;
                for (int i = 0; i < 6; i++)
                {
                    if (month == 0)
                    {
                        month = 12;
                    }
                    DateTime d = new DateTime(2021, month, 1);
                    Months.Add(new SelectListItem { Text = d.ToString("MMM"), Value = month + "" });
                    month--;
                }

                ViewBag.Months = Months;
                return View();
            }

        }

        /* Data for published notes on dashboard */
        [Route("Admin/DashboardData/{month}")]
        public JsonResult DashboardData(int? month)
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                System.Diagnostics.Debug.WriteLine("Ajax" + month);
                List<NoteStatus> DashboardData = new List<NoteStatus>();
                List<NotesDetail> notes = null;
                if (month != 0)
                {
                    notes = data.NotesDetails.
                    Where(n => n.Status.Equals("Published") &&
                               n.IsActive == true &&
                               n.PublishedDate.Month == month).ToList<NotesDetail>();
                }
                else
                {
                    notes = data.NotesDetails.
                    Where(n => n.Status.Equals("Published") &&
                               n.IsActive == true).ToList<NotesDetail>();
                }

                int i = 0;
                foreach (NotesDetail note in notes)
                {
                    i++;
                    NoteStatus noteStatus = new NoteStatus();
                    noteStatus.SrNo = i;
                    noteStatus.NoteID = note.ID;
                    noteStatus.NoteTitle = note.Title;
                    noteStatus.NoteCategory = note.Category.CategoryName;

                    /* Here Remarks is the attachment size */
                    try
                    {
                        FileInfo file = new FileInfo(data.NotesAttachments.Where(n => n.NoteID == note.ID).FirstOrDefault().FilePath);
                        long size = file.Length / 1000;
                        noteStatus.Remarks = size + " KB";
                    }
                    catch (Exception e)
                    {
                        noteStatus.Remarks = "0 KB";
                    }

                    noteStatus.SellType = note.IsPaid ? "Paid" : "Free";
                    noteStatus.Price = note.Price;

                    /* Publisher */
                    noteStatus.ActionedBy = data.Users.Find(note.ActionedBy).FirstName + " " + data.Users.Find(note.ActionedBy).LastName;

                    DateTime d = note.PublishedDate;
                    string format = "dd-MM-yyyy, hh:mm";
                    noteStatus.GeneralDateTime = d.ToString(format);

                    try
                    {
                        noteStatus.NumberOfDownloads = data.Downloads.
                            Where(m => m.NoteID == note.ID && m.IsSellerHasAllowedDownload == true).Count();
                    }
                    catch (Exception e)
                    {
                        noteStatus.NumberOfDownloads = 0;
                    }

                    DashboardData.Add(noteStatus);

                }
                return Json(DashboardData, JsonRequestBehavior.AllowGet);
            }
        }

        /* Section 4.3 */
        /* Notes Under Review ,
         * So all the notes which status is submitted or in review should display here 
         */

        [Route("Admin/NotesUnderReview")]
        public ActionResult NotesUnderReview(int? userID)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];

                var NotesBySeller = data.NotesDetails.Where(n => n.Status.Equals("Submitted") || n.Status.Equals("InReview")).GroupBy(m => m.SellerID).Select(x => x.FirstOrDefault()).ToList();
                List<SelectListItem> seller = new List<SelectListItem>();

                foreach (NotesDetail notesDetail in NotesBySeller)
                {
                    User user = data.Users.Find(notesDetail.SellerID);
                    seller.Add(new SelectListItem
                    {
                        Text = user.FirstName + " " + user.LastName,
                        Value = user.FirstName + " " + user.LastName
                    });
                }

                ViewBag.Seller = seller;
                ViewBag.userID = userID;
                return View();
            }
        }

        [Route("Admin/NotesUnderReviewData")]
        public JsonResult NotesUnderReviewData(int? userID)
        {
            if (Session["userId"] == null)
            {
                return Json("Admin Not Logged In !");
            }
            else
            {
                int userId = (int)Session["userID"];

                /* For specific members under review notes */
                List<NotesDetail> Notes = null;
                if (userID != null)
                {
                    Notes = data.NotesDetails.Where(n => n.SellerID == userID &&
                   (n.Status.Equals("Submitted") || n.Status.Equals("InReview"))).ToList<NotesDetail>();
                }
                else
                {
                    Notes = data.NotesDetails.Where(
                    n => n.Status.Equals("Submitted") || n.Status.Equals("InReview")).ToList<NotesDetail>();
                }
                List<NoteStatus> NotesData = new List<NoteStatus>();
                

                int i = 0;
                foreach (NotesDetail note in Notes)
                {
                    i++;
                    NoteStatus noteStatus = new NoteStatus();
                    noteStatus.SrNo = i;
                    noteStatus.UserID = note.SellerID;
                    noteStatus.NoteTitle = note.Title;
                    noteStatus.NoteCategory = note.Category.CategoryName;
                    noteStatus.Seller = data.Users.Find(note.SellerID).FirstName + " " + data.Users.Find(note.SellerID).LastName;
                    DateTime d = (DateTime)note.DateAdded;
                    String format = "dd-MM-yyyy, hh:mm";
                    noteStatus.GeneralDateTime = d.ToString(format);
                    noteStatus.Status = note.Status;

                    noteStatus.NoteID = note.ID;

                    NotesData.Add(noteStatus);

                }
                return Json(NotesData, JsonRequestBehavior.AllowGet);
            }
        }

        /* Change Note Status from Submitted to InReview When admin clicks on InReview Button */
        [Route("Admin/MakeStatusInReview/{id}")]
        public ActionResult MakeStatusInReview(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                data.NotesDetails.Find(id).Status = "InReview";
                data.SaveChanges();
                return RedirectToAction("NotesUnderReview", "Admin");
            }
        }

        /* When Admin Clicks On Publish Button */
        [Route("Admin/MakeStatusPublished/{id}")]
        public ActionResult MakeStatusPublished(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                NotesDetail note = data.NotesDetails.Find(id);
                note.Status = "Published";
                note.PublishedDate = (DateTime)System.DateTime.Now;
                data.SaveChanges();
                return RedirectToAction("NotesUnderReview", "Admin");
            }
        }

        /* When Note is rejected by admin */
        [Route("Admin/RejectNote")]
        public ActionResult RejectNote(int RejectID, string comments)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                NotesDetail note = data.NotesDetails.Find(RejectID);
                note.Status = "Rejected";
                note.AdminRemarks = comments;
                note.IsActive = false;
                data.SaveChanges();
                return RedirectToAction("NotesUnderReview", "Admin");
            }
        }


        /* Published Notes */
        [Route("Admin/PublishedNotes")]
        public ActionResult PublishedNotes(int? userID)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];

                var NotesBySeller = data.NotesDetails.Where(n => n.Status.Equals("Published")).GroupBy(m => m.SellerID).Select(x => x.FirstOrDefault()).ToList();
                List<SelectListItem> seller = new List<SelectListItem>();

                foreach (NotesDetail notesDetail in NotesBySeller)
                {
                    User user = data.Users.Find(notesDetail.SellerID);
                    seller.Add(new SelectListItem
                    {
                        Text = user.FirstName + " " + user.LastName,
                        Value = user.FirstName + " " + user.LastName
                    });
                }

                ViewBag.Seller = seller;
                ViewBag.userID = userID;
                return View();
            }
        }

        [Route("Admin/PublishedNotesData")]
        public JsonResult PublishedNotesData(int? userID)
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                /* For specific users published notes only */
                List<NotesDetail> notes = null;
                if (userID != null)
                {
                    notes = data.NotesDetails.Where(n => n.SellerID == userID &&
                   n.Status.Equals("Published")).ToList<NotesDetail>();
                }
                else
                {
                    notes = data.NotesDetails.Where(
                    n => n.Status.Equals("Published")).ToList<NotesDetail>();
                }
                List<NoteStatus> NotesData = new List<NoteStatus>();

                int i = 0;
                foreach (NotesDetail note in notes)
                {
                    i++;
                    NoteStatus noteStatus = new NoteStatus();
                    noteStatus.SrNo = i;
                    noteStatus.NoteID = note.ID;
                    noteStatus.NoteTitle = note.Title;
                    noteStatus.NoteCategory = note.Category.CategoryName;
                    noteStatus.SellType = note.IsPaid ? "Paid" : "Free";
                    noteStatus.Price = note.Price;
                    noteStatus.UserID = note.SellerID;
                    noteStatus.Seller = data.Users.Find(note.SellerID).FirstName + " " + data.Users.Find(note.SellerID).LastName;
                    DateTime d = note.PublishedDate;
                    string format = "dd-MM-yyyy, hh:mm";
                    noteStatus.GeneralDateTime = d.ToString(format);
                    noteStatus.ActionedBy = data.Users.Find(note.ActionedBy).FirstName + " " + data.Users.Find(note.ActionedBy).LastName;
                    try
                    {
                        noteStatus.NumberOfDownloads = data.Downloads.
                            Where(m => m.NoteID == note.ID && m.IsSellerHasAllowedDownload == true).Count();
                    }
                    catch (Exception e)
                    {
                        noteStatus.NumberOfDownloads = 0;
                    }

                    NotesData.Add(noteStatus);

                }
                return Json(NotesData, JsonRequestBehavior.AllowGet);
            }
        }

        /* UnpublishNote */
        [Route("Admin/UnpublishNote")]
        public ActionResult UnpublishNote(int RejectID, string comments, string redirection)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                NotesDetail note = data.NotesDetails.Find(RejectID);
                note.Status = "Removed";
                note.AdminRemarks = comments;
                note.IsActive = false;
                data.SaveChanges();
                return RedirectToAction(redirection, "Admin");
            }
        }


        /* Downloaded Notes */
        [Route("Admin/DownloadedNotes")]
        public ActionResult DownloadedNotes(int? noteID, int? userID)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                ViewBag.noteTitle = new SelectList(data.Downloads.GroupBy(m => m.NoteTitle).Select(
                 v => new SelectListItem
                 {
                     Value = v.Key.ToString(),
                     Text = v.Key.ToString()
                 }
                ).ToList(), "Value", "Text");

                var downloadsForSeller = data.Downloads.GroupBy(m => m.Seller).Select(x => x.FirstOrDefault()).ToList();
                List<SelectListItem> seller = new List<SelectListItem>();

                foreach (Download download in downloadsForSeller)
                {
                    User user = data.Users.Find(download.Seller);
                    seller.Add(new SelectListItem
                    {
                        Text = user.FirstName + " " + user.LastName,
                        Value = user.FirstName + " " + user.LastName
                    });
                }

                ViewBag.Seller = seller;

                var downloadsForBuyer = data.Downloads.GroupBy(m => m.Downloader).Select(x => x.FirstOrDefault()).ToList();
                List<SelectListItem> buyer = new List<SelectListItem>();

                foreach (Download download in downloadsForBuyer)
                {
                    User user = data.Users.Find(download.Downloader);
                    buyer.Add(new SelectListItem
                    {
                        Text = user.FirstName + " " + user.LastName,
                        Value = user.FirstName + " " + user.LastName
                    });
                }

                ViewBag.Buyer = buyer;
                ViewBag.noteID = noteID;
                ViewBag.userID = userID;

                return View();
            }
        }

        [Route("Admin/DownloadedNotesData")]
        public JsonResult DownloadedNotesData(int? noteID, int? userID)
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];

                List<Download> notes = null;
                /* For Specific note only*/
                if (noteID != null || userID != null)
                {
                    if (noteID != null)
                    {
                        notes = data.Downloads.Where(n => n.NoteID == noteID && n.IsSellerHasAllowedDownload == true).ToList<Download>();
                    }
                    if (userID != null)
                    {
                        notes = data.Downloads.Where(n => n.Downloader == userID && n.IsSellerHasAllowedDownload == true).ToList<Download>();
                    }
                }
                else
                {
                    notes = data.Downloads.ToList<Download>();
                }
                List<NoteStatus> NotesData = new List<NoteStatus>();

                int i = 0;
                foreach (Download download in notes)
                {
                    i++;
                    NoteStatus noteStatus = new NoteStatus();
                    noteStatus.SrNo = i;
                    noteStatus.NoteID = download.NoteID;
                    noteStatus.NoteTitle = download.NoteTitle;
                    noteStatus.NoteCategory = download.NoteCategory;
                    noteStatus.UserID = download.Downloader;
                    noteStatus.UserID2 = download.Seller;
                    noteStatus.Buyer = data.Users.Find(download.Downloader).FirstName + " " + data.Users.Find(download.Downloader).LastName;
                    noteStatus.Seller = data.Users.Find(download.Seller).FirstName + " " + data.Users.Find(download.Seller).LastName;
                    noteStatus.SellType = download.IsPaid ? "Paid" : "Free";
                    noteStatus.Price = (int)download.PurchasedPrice;
                    DateTime d = (DateTime)download.AttachmentDownloadedDate;
                    string format = "dd-MM-yyyy, hh-mm";
                    noteStatus.GeneralDateTime = d.ToString(format);

                    NotesData.Add(noteStatus);

                }
                return Json(NotesData, JsonRequestBehavior.AllowGet);
            }
        }


        /* Rejected Notes */

        [Route("Admin/RejectedNotes")]
        public ActionResult RejectedNotes()
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];

                var NotesBySeller = data.NotesDetails.Where(n => n.Status.Equals("Rejected")).GroupBy(m => m.SellerID).Select(x => x.FirstOrDefault()).ToList();
                List<SelectListItem> seller = new List<SelectListItem>();

                foreach (NotesDetail notesDetail in NotesBySeller)
                {
                    User user = data.Users.Find(notesDetail.SellerID);
                    seller.Add(new SelectListItem
                    {
                        Text = user.FirstName + " " + user.LastName,
                        Value = user.FirstName + " " + user.LastName
                    });
                }

                ViewBag.Seller = seller;

                return View();
            }
        }

        [Route("Admin/RejectedNotesData")]
        public JsonResult RejectedNotesData()
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                List<NoteStatus> NotesData = new List<NoteStatus>();
                List<NotesDetail> notes = data.NotesDetails.Where(
                    n => n.Status.Equals("Rejected")).ToList<NotesDetail>();
                int i = 0;
                foreach (NotesDetail note in notes)
                {
                    i++;
                    NoteStatus noteStatus = new NoteStatus();
                    noteStatus.SrNo = i;
                    noteStatus.NoteID = note.ID;
                    noteStatus.NoteTitle = note.Title;
                    noteStatus.NoteCategory = note.Category.CategoryName;
                    noteStatus.UserID = note.SellerID;
                    noteStatus.Seller = data.Users.Find(note.SellerID).FirstName + " " + data.Users.Find(note.SellerID).LastName;
                    DateTime d = (DateTime)note.DateAdded;
                    string format = "dd-MM-yyyy, hh:mm";
                    noteStatus.GeneralDateTime = d.ToString(format);
                    noteStatus.ActionedBy = data.Users.Find(note.ActionedBy).FirstName + " " + data.Users.Find(note.ActionedBy).LastName;
                    noteStatus.Remarks = note.AdminRemarks;

                    NotesData.Add(noteStatus);

                }
                return Json(NotesData, JsonRequestBehavior.AllowGet);
            }
        }

        /* ApproveNote */
        [Route("Admin/ApproveNote/{id}")]
        public ActionResult ApproveNote(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                NotesDetail note = data.NotesDetails.Find(id);
                note.Status = "Published";
                note.IsActive = true;
                data.SaveChanges();
                return RedirectToAction("RejectedNotes", "Admin");
            }
        }


        /* Section 4.4 */
        /* Member */
        [Route("Admin/Members")]
        public ActionResult Members()
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

        [Route("Admin/MembersData")]
        public JsonResult MembersData()
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                List<MembersHelp> MembersData = new List<MembersHelp>();
                List<User> users = data.Users.Where(u => u.IsActive == true && u.RoleID == 3).OrderByDescending(u => u.DateAdded).ToList<User>();
                int i = 0;
                foreach (User user in users)
                {
                    i++;
                    MembersHelp member = new MembersHelp();
                    member.SrNo = i;
                    member.UserId = user.UserID;
                    member.FirstName = user.FirstName;
                    member.LastName = user.LastName;
                    member.Email = user.EmailID;
                    DateTime d = (DateTime)user.DateAdded;
                    string format = "dd-MM-yyyy, hh:mm";
                    member.JoiningDate = d.ToString(format);
                    try
                    {
                        member.UnderReviewNotes = data.NotesDetails.
                                    Where(n => n.SellerID == user.UserID &&
                                         (n.Status.Equals("Submitted") || n.Status.Equals("InReview"))).Count();
                    }
                    catch (Exception e)
                    {
                        member.UnderReviewNotes = 0;
                    }

                    try
                    {
                        member.PublishedNotes = data.NotesDetails.
                                    Where(n => n.SellerID == user.UserID &&
                                         n.Status.Equals("Published")).Count();
                    }
                    catch (Exception e)
                    {
                        member.PublishedNotes = 0;
                    }

                    try
                    {
                        member.DownloadedNotes = data.Downloads.
                            Where(n => n.Downloader == user.UserID &&
                                 n.IsSellerHasAllowedDownload == true).Count();
                    }
                    catch (Exception e)
                    {
                        member.DownloadedNotes = 0;
                    }

                    try
                    {
                        member.TotalExpenses = (int)data.Downloads.
                            Where(n => n.Downloader == user.UserID &&
                                 n.IsSellerHasAllowedDownload == true).Sum(n => n.PurchasedPrice);
                    }
                    catch (Exception e)
                    {
                        member.TotalExpenses = 0;
                    }

                    try
                    {
                        member.TotalEarnings = (int)data.Downloads.
                            Where(n => n.Seller == user.UserID &&
                                 n.IsSellerHasAllowedDownload == true).Sum(n => n.PurchasedPrice);
                    }
                    catch (Exception e)
                    {
                        member.TotalEarnings = 0;
                    }

                    MembersData.Add(member);


                }
                return Json(MembersData, JsonRequestBehavior.AllowGet);
            }
        }

        /* Deactivate User */
        [Route("Admin/DeactivateUser/{id}")]
        public ActionResult DeactivateUser(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                User user = data.Users.Find(id);
                user.IsActive = false;
                /* Get rid of entity validation error */
                user.ConfirmPassword = user.Password;
                user.NewPassword = user.Password;
                user.ConfirmNewPassword = user.Password;
                data.SaveChanges();
                /* Add Code to remove all notes of this perticualr user */
                return RedirectToAction("Members", "Admin");
            }
        }

        [Route("MembersDetails/{id}")]
        public ActionResult MembersDetails(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                User user = data.Users.Find(id);
                UserInfo userInfo = data.UserInfoes.Where(u => u.UserID == id).FirstOrDefault();
                userInfo.FirstName = user.FirstName;
                userInfo.LastName = user.LastName;
                userInfo.EmailID = user.EmailID;
                return View(userInfo);
            }
        }

        [Route("Admin/MemberNotesData/{id}")]
        public JsonResult MemberNotesData(int id)
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                List<MemberNotes> memberNotesData = new List<MemberNotes>();
                List<NotesDetail> notes = data.NotesDetails.Where(n => n.SellerID == id).ToList<NotesDetail>();

                int i = 0;
                foreach (NotesDetail note in notes)
                {
                    i++;
                    MemberNotes memberNotes = new MemberNotes();
                    memberNotes.SrNo = i;
                    memberNotes.NoteId = note.ID;
                    memberNotes.NoteTitle = note.Title;
                    memberNotes.Category = note.Category.CategoryName;
                    memberNotes.Status = note.Status;
                    DateTime DateAdded = (DateTime)note.DateAdded;
                    DateTime PublishedDate = (DateTime)note.PublishedDate;
                    string format = "dd-MM-yyyy, hh:mm";
                    memberNotes.DateAdded = DateAdded.ToString(format);
                    memberNotes.PublishedDate = PublishedDate.ToString(format);

                    try
                    {
                        memberNotes.DownloadedNotes = data.Downloads.
                            Where(n => n.Seller == id && n.NoteID == note.ID &&
                                 n.IsSellerHasAllowedDownload == true).Count();
                    }
                    catch (Exception e)
                    {
                        memberNotes.DownloadedNotes = 0;
                    }

                    try
                    {
                        memberNotes.TotalEarnings = (int)data.Downloads.
                            Where(n => n.Seller == id && n.NoteID == note.ID &&
                                 n.IsSellerHasAllowedDownload == true).Sum(n => n.PurchasedPrice);
                    }
                    catch (Exception e)
                    {
                        memberNotes.TotalEarnings = 0;
                    }

                    memberNotesData.Add(memberNotes);
                }


                return Json(memberNotesData, JsonRequestBehavior.AllowGet);
            }
        }


        /* Section 4.5 */


        /* System Configuration */
        [Route("Admin/ManageSystemConfiguration")]
        public ActionResult ManageSystemConfiguration()
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];

                if (data.SystemConfigurations.Where(s => s.key.Equals("SupportEmail")).Any())
                {
                    ViewBag.supportEmail = data.SystemConfigurations.Where(s => s.key.Equals("SupportEmail")).FirstOrDefault().Value;
                }
                else
                {
                    ViewBag.supportEmail = null;
                }


                if (data.SystemConfigurations.Where(s => s.key.Equals("SupportPhone")).Any())
                {
                    ViewBag.SupportPhone = data.SystemConfigurations.Where(s => s.key.Equals("SupportPhone")).FirstOrDefault().Value;
                }
                else
                {
                    ViewBag.SupportPhone = null;
                }

                if (data.SystemConfigurations.Where(s => s.key.Equals("EmailAddress")).Any())
                {
                    ViewBag.EmailAddress = data.SystemConfigurations.Where(s => s.key.Equals("EmailAddress")).FirstOrDefault().Value;
                }
                else
                {
                    ViewBag.EmailAddress = null;
                }


                if (data.SystemConfigurations.Where(s => s.key.Equals("Facebook")).Any())
                {
                    ViewBag.Facebook = data.SystemConfigurations.Where(s => s.key.Equals("Facebook")).FirstOrDefault().Value;
                }
                else
                {
                    ViewBag.Facebook = null;
                }

                if (data.SystemConfigurations.Where(s => s.key.Equals("Twitter")).Any())
                {
                    ViewBag.Twitter = data.SystemConfigurations.Where(s => s.key.Equals("Twitter")).FirstOrDefault().Value;
                }
                else
                {
                    ViewBag.Twitter = null;
                }

                if (data.SystemConfigurations.Where(s => s.key.Equals("Linkedin")).Any())
                {
                    ViewBag.Linkedin = data.SystemConfigurations.Where(s => s.key.Equals("Linkedin")).FirstOrDefault().Value;
                }
                else
                {
                    ViewBag.Linkedin = null;
                }

                if (data.SystemConfigurations.Where(s => s.key.Equals("NotesPreview")).Any())
                {
                    ViewBag.NotesPreview = data.SystemConfigurations.Where(s => s.key.Equals("NotesPreview")).FirstOrDefault().Value;
                }
                else
                {
                    ViewBag.NotesPreview = null;
                }

                if (data.SystemConfigurations.Where(s => s.key.Equals("ProfilePicture")).Any())
                {
                    ViewBag.ProfilePicture = data.SystemConfigurations.Where(s => s.key.Equals("ProfilePicture")).FirstOrDefault().Value;
                }
                else
                {
                    ViewBag.ProfilePicture = null;
                }

                return View();
            }
        }

        [HttpPost]
        [Route("Admin/SaveSystemConfiguration")]
        public ActionResult SaveSystemConfiguration(SystemConfiguration systemConfiguration)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userID = (int)Session["userID"];

                /* For Support email */
                SystemConfiguration supportEmail = null;

                if (data.SystemConfigurations.Where(s => s.key.Equals("SupportEmail")).Any())
                {
                    supportEmail = data.SystemConfigurations.Where(x => x.key.Equals("SupportEmail")).FirstOrDefault();
                    supportEmail.Value = systemConfiguration.SupportEmail;
                    supportEmail.ModifiedBy = userID;
                    supportEmail.ModifiedDate = (DateTime)System.DateTime.Now;
                    supportEmail.IsActive = true;
                    data.SaveChanges();
                }
                else
                {
                    if (systemConfiguration.SupportEmail != null)
                    {
                        supportEmail = new SystemConfiguration();
                        supportEmail.key = "SupportEmail";
                        supportEmail.Value = systemConfiguration.SupportEmail;
                        supportEmail.CreatedBy = userID;
                        supportEmail.CreatedDate = (DateTime)System.DateTime.Now;
                        supportEmail.IsActive = true;
                        data.SystemConfigurations.Add(supportEmail);
                        data.SaveChanges();
                    }
                }

                /* For Support phone */
                SystemConfiguration supportPhone = null;

                if (data.SystemConfigurations.Where(s => s.key.Equals("SupportPhone")).Any())
                {
                    supportPhone = data.SystemConfigurations.Where(x => x.key.Equals("SupportPhone")).FirstOrDefault();
                    supportPhone.Value = systemConfiguration.SupportPhone;
                    supportPhone.ModifiedBy = userID;
                    supportPhone.ModifiedDate = (DateTime)System.DateTime.Now;
                    supportPhone.IsActive = true;
                    data.SaveChanges();
                }
                else
                {
                    if (systemConfiguration.SupportPhone != null)
                    {
                        supportPhone = new SystemConfiguration();
                        supportPhone.key = "SupportPhone";
                        supportPhone.Value = systemConfiguration.SupportPhone;
                        supportPhone.CreatedBy = userID;
                        supportPhone.CreatedDate = (DateTime)System.DateTime.Now;
                        supportPhone.IsActive = true;
                        data.SystemConfigurations.Add(supportPhone);
                        data.SaveChanges();
                    }
                }

                /* For email adress */
                SystemConfiguration emailAddress = null;

                if (data.SystemConfigurations.Where(s => s.key.Equals("EmailAddress")).Any())
                {
                    emailAddress = data.SystemConfigurations.Where(x => x.key.Equals("EmailAddress")).FirstOrDefault();
                    emailAddress.Value = systemConfiguration.EmailAddress;
                    emailAddress.ModifiedBy = userID;
                    emailAddress.ModifiedDate = (DateTime)System.DateTime.Now;
                    emailAddress.IsActive = true;
                    data.SaveChanges();
                }
                else
                {
                    if (systemConfiguration.EmailAddress != null)
                    {
                        emailAddress = new SystemConfiguration();
                        emailAddress.key = "EmailAddress";
                        emailAddress.Value = systemConfiguration.EmailAddress;
                        emailAddress.CreatedBy = userID;
                        emailAddress.CreatedDate = (DateTime)System.DateTime.Now;
                        emailAddress.IsActive = true;
                        data.SystemConfigurations.Add(emailAddress);
                        data.SaveChanges();
                    }
                }

                /* For Facebook url */
                SystemConfiguration facebook = null;

                if (data.SystemConfigurations.Where(s => s.key.Equals("Facebook")).Any())
                {
                    facebook = data.SystemConfigurations.Where(x => x.key.Equals("Facebook")).FirstOrDefault();
                    facebook.Value = systemConfiguration.Facebook;
                    facebook.ModifiedBy = userID;
                    facebook.ModifiedDate = (DateTime)System.DateTime.Now;
                    facebook.IsActive = true;
                    data.SaveChanges();
                }
                else
                {
                    if (systemConfiguration.Facebook != null)
                    {
                        facebook = new SystemConfiguration();
                        facebook.key = "Facebook";
                        facebook.Value = systemConfiguration.Facebook;
                        facebook.CreatedBy = userID;
                        facebook.CreatedDate = (DateTime)System.DateTime.Now;
                        facebook.IsActive = true;
                        data.SystemConfigurations.Add(facebook);
                        data.SaveChanges();
                    }
                }

                /* For Twitter url */
                SystemConfiguration twitter = null;

                if (data.SystemConfigurations.Where(s => s.key.Equals("Twitter")).Any())
                {
                    twitter = data.SystemConfigurations.Where(x => x.key.Equals("Twitter")).FirstOrDefault();
                    twitter.Value = systemConfiguration.Twitter;
                    twitter.ModifiedBy = userID;
                    twitter.ModifiedDate = (DateTime)System.DateTime.Now;
                    twitter.IsActive = true;
                    data.SaveChanges();
                }
                else
                {
                    if (systemConfiguration.Twitter != null)
                    {
                        twitter = new SystemConfiguration();
                        twitter.key = "Twitter";
                        twitter.Value = systemConfiguration.Twitter;
                        twitter.CreatedBy = userID;
                        twitter.CreatedDate = (DateTime)System.DateTime.Now;
                        twitter.IsActive = true;
                        data.SystemConfigurations.Add(twitter);
                        data.SaveChanges();
                    }
                }

                /* For Twitter url */
                SystemConfiguration linkedin = null;

                if (data.SystemConfigurations.Where(s => s.key.Equals("Linkedin")).Any())
                {
                    linkedin = data.SystemConfigurations.Where(x => x.key.Equals("Linkedin")).FirstOrDefault();
                    linkedin.Value = systemConfiguration.Linkedin;
                    linkedin.ModifiedBy = userID;
                    linkedin.ModifiedDate = (DateTime)System.DateTime.Now;
                    linkedin.IsActive = true;
                    data.SaveChanges();
                }
                else
                {
                    if (systemConfiguration.Linkedin != null)
                    {
                        linkedin = new SystemConfiguration();
                        linkedin.key = "Linkedin";
                        linkedin.Value = systemConfiguration.Linkedin;
                        linkedin.CreatedBy = userID;
                        linkedin.CreatedDate = (DateTime)System.DateTime.Now;
                        linkedin.IsActive = true;
                        data.SystemConfigurations.Add(linkedin);
                        data.SaveChanges();
                    }
                }


                /* For notes preview */
                SystemConfiguration notesPreview = null;
                if (data.SystemConfigurations.Where(s => s.key.Equals("NotesPreview")).Any())
                {
                    try
                    {
                        String NpFileName = Path.GetFileName(systemConfiguration.file1.FileName);
                        string NpPath = Path.Combine(Server.MapPath("~/Uploads"), NpFileName);
                        systemConfiguration.file1.SaveAs(NpPath);
                        notesPreview = data.SystemConfigurations.Where(s => s.key.Equals("NotesPreview")).FirstOrDefault();
                        notesPreview.Value = NpPath;
                        notesPreview.ModifiedDate = (DateTime)System.DateTime.Now;
                        notesPreview.ModifiedBy = userID;
                        notesPreview.IsActive = true;
                        data.SaveChanges();
                    }
                    catch (Exception e)
                    {
                        System.Diagnostics.Debug.WriteLine(e);
                    }
                }
                else
                {
                    try
                    {
                        String NpFileName = Path.GetFileName(systemConfiguration.file1.FileName);
                        string NpPath = Path.Combine(Server.MapPath("~/Uploads"), NpFileName);
                        systemConfiguration.file1.SaveAs(NpPath);
                        notesPreview = new SystemConfiguration();
                        notesPreview.key = "NotesPreview";
                        notesPreview.Value = NpPath;
                        notesPreview.CreatedDate = (DateTime)System.DateTime.Now;
                        notesPreview.CreatedBy = userID;
                        notesPreview.IsActive = true;
                        data.SystemConfigurations.Add(notesPreview);
                        data.SaveChanges();
                    }
                    catch (Exception e)
                    {
                        System.Diagnostics.Debug.WriteLine(e);
                    }
                }


                /* For profile picture */
                SystemConfiguration profilePicture = null;
                if (data.SystemConfigurations.Where(s => s.key.Equals("ProfilePicture")).Any())
                {
                    try
                    {
                        String PpFileName = Path.GetFileName(systemConfiguration.file2.FileName);
                        string PpPath = Path.Combine(Server.MapPath("~/Uploads"), PpFileName);
                        systemConfiguration.file2.SaveAs(PpPath);
                        profilePicture = data.SystemConfigurations.Where(s => s.key.Equals("ProfilePicture")).FirstOrDefault();
                        profilePicture.Value = PpPath;
                        profilePicture.ModifiedDate = (DateTime)System.DateTime.Now;
                        profilePicture.ModifiedBy = userID;
                        profilePicture.IsActive = true;
                        data.SaveChanges();
                    }
                    catch (Exception e)
                    {
                        System.Diagnostics.Debug.WriteLine(e);
                    }
                }
                else
                {
                    try
                    {
                        String PpFileName = Path.GetFileName(systemConfiguration.file2.FileName);
                        string PpPath = Path.Combine(Server.MapPath("~/Uploads"), PpFileName);
                        systemConfiguration.file2.SaveAs(PpPath);
                        profilePicture = new SystemConfiguration();
                        profilePicture.key = "ProfilePicture";
                        profilePicture.Value = PpPath;
                        profilePicture.CreatedDate = (DateTime)System.DateTime.Now;
                        profilePicture.CreatedBy = userID;
                        profilePicture.IsActive = true;
                        data.SystemConfigurations.Add(profilePicture);
                        data.SaveChanges();
                    }
                    catch (Exception e)
                    {
                        System.Diagnostics.Debug.WriteLine(e);
                    }
                }

                data.SaveChanges();
                return RedirectToAction("ManageSystemConfiguration", "Admin");
            }
        }

        [Route("Admin/ManageAdministrator")]
        public ActionResult ManageAdministrator()
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

        [Route("Admin/ManageAdministratorData")]
        public JsonResult ManageAdministratorDataSagar()
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                List<AdministratorHelp> adminData = new List<AdministratorHelp>();
                List<User> admins = data.Users.Where(m => m.RoleID == 2).ToList<User>();
                int i = 0;
                foreach (User user in admins)
                {
                    i++;
                    AdministratorHelp admin = new AdministratorHelp();
                    admin.SrNo = i;
                    admin.UserId = user.UserID;
                    admin.FirstName = user.FirstName;
                    admin.LastName = user.LastName;
                    admin.Email = user.EmailID;
                    admin.PhoneNumber = data.UserInfoes.Find(user.UserID).PhoneNumber;
                    DateTime d = (DateTime)user.DateAdded;
                    string format = "dd-MM-yyyy, hh-mm";
                    admin.DateAdded = d.ToString(format);
                    admin.IsActive = user.IsActive ? "Yes" : "No";

                    adminData.Add(admin);
                }
                return Json(adminData, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult AddAdministrator()
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
        [Route("Admin/SaveAdministrator")]
        public ActionResult SaveAdministrator(UserInfo userInfo)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userID = (int)Session["userID"];
                userInfo.AddedBy = userID;
                userInfo.DateAdded = (DateTime)System.DateTime.Now;

                User user = null;

                if (userInfo.UserID != 0)
                {
                    user = data.Users.Find(userInfo.UserID);

                }
                else
                {
                    user = new User();
                }

                user.FirstName = userInfo.FirstName;
                user.LastName = userInfo.LastName;
                user.EmailID = userInfo.EmailID;
                user.Password = "Admin@1234";
                user.DateAdded = userInfo.DateAdded;
                user.AddedBy = userInfo.AddedBy;
                user.IsActive = true;
                user.RoleID = 2;

                /*Entity Violetion errors*/
                user.ConfirmPassword = user.Password;
                user.NewPassword = user.Password;
                user.ConfirmNewPassword = user.Password;

                userInfo.AddressLine1 = "";
                userInfo.AddressLine2 = "";
                userInfo.City = "";
                userInfo.State = "";
                userInfo.ZipCode = "";
                userInfo.Country = "";

                /* Default profile photo for admin */
                userInfo.ProfilePicture = "D:\\Tatva Soft\\Training\\Project\\ASP\\NotesMarketplace\\NotesMarketplace\\Uploads\\170170107121_Sagar.jpg";

                if (userInfo.UserID != 0)
                {
                    data.Entry(user).State = System.Data.Entity.EntityState.Modified;
                    data.Entry(userInfo).State = System.Data.Entity.EntityState.Modified;
                }
                else
                {
                    data.Users.Add(user);
                    userInfo.UserID = user.UserID;
                    data.UserInfoes.Add(userInfo);
                }
                data.SaveChanges();


                return RedirectToAction("ManageAdministrator", "Admin");
            }
        }

        [Route("UpdateAdministrator/{id}")]
        public ActionResult UpdateAdministrator(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                UserInfo userInfo = data.UserInfoes.Where(u => u.UserID == id).FirstOrDefault();
                User user = data.Users.Find(id);

                userInfo.FirstName = user.FirstName;
                userInfo.LastName = user.LastName;
                userInfo.EmailID = user.EmailID;

                return View("AddAdministrator", userInfo);
            }
        }

        [Route("Admin/DeleteAdministrator/{id}")]
        public ActionResult DeleteAdministrator(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userID = (int)Session["userId"];

                User user = data.Users.Find(id);
                user.IsActive = false;
                user.ModifiedBy = userID;
                user.DateModified = (DateTime)System.DateTime.Now;

                /*Entity Violetion errors*/
                user.ConfirmPassword = user.Password;
                user.NewPassword = user.Password;
                user.ConfirmNewPassword = user.Password;


                data.SaveChanges();
                return RedirectToAction("ManageAdministrator", "Admin");
            }
        }


        [Route("Admin/AddCategory")]
        public ActionResult AddCategory()
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

        [Route("Admin/SaveCategory")]
        public ActionResult SaveCategory(Category category)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userID = (int)Session["userId"];

                if (category.CategoryID != 0)
                {
                    category.ModifiedBy = userID;
                    category.DateModified = (DateTime)System.DateTime.Now;
                    data.Entry(category).State = System.Data.Entity.EntityState.Modified;
                }
                else
                {
                    category.AddedBy = userID;
                    category.DateAdded = (DateTime)System.DateTime.Now;
                    category.IsActive = true;
                    data.Categories.Add(category);
                }
                data.SaveChanges();
                return RedirectToAction("ManageCategory", "Admin");
            }
        }

        [Route("Admin/ManageCategory")]
        public ActionResult ManageCategory()
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

        [Route("Admin/ManageCategoryData")]
        public JsonResult ManageCategoryData()
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                List<ManageHelp> CategoryData = new List<ManageHelp>();
                List<Category> categories = data.Categories.ToList<Category>();

                int i = 0;

                foreach (Category category in categories)
                {
                    i++;
                    ManageHelp categoryData = new ManageHelp();
                    categoryData.SrNo = i;
                    categoryData.Id = category.CategoryID;
                    categoryData.Name = category.CategoryName;
                    categoryData.Description = category.Description;
                    DateTime d = (DateTime)category.DateAdded;
                    string format = "dd-MM-yyyy, hh:mm";
                    categoryData.DateAdded = d.ToString(format);
                    categoryData.AddedBy = data.Users.Find(category.AddedBy).FirstName + " " + data.Users.Find(category.AddedBy).LastName;
                    categoryData.IsActive = category.IsActive ? "Yes" : "No";

                    CategoryData.Add(categoryData);
                }

                return Json(CategoryData, JsonRequestBehavior.AllowGet);
            }
        }

        [Route("UpdateCategory/{id}")]
        public ActionResult UpdateCategory(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                Category category = data.Categories.Find(id);
                return View("AddCategory", category);
            }
        }

        [Route("Admin/DeleteCategory/{id}")]
        public ActionResult DeleteCategory(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                Category category = data.Categories.Find(id);
                category.IsActive = false;
                data.SaveChanges();
                return RedirectToAction("ManageCategory", "Admin");
            }
        }


        [Route("Admin/AddType")]
        public ActionResult AddType()
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

        [Route("Admin/SaveType")]
        public ActionResult SaveType(Type type)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userID = (int)Session["userId"];

                if (type.TypeID != 0)
                {
                    type.ModifiedBy = userID;
                    type.DateModified = (DateTime)System.DateTime.Now;
                    data.Entry(type).State = System.Data.Entity.EntityState.Modified;
                }
                else
                {
                    type.AddedBy = userID;
                    type.DateAdded = (DateTime)System.DateTime.Now;
                    type.IsActive = true;
                    data.Types.Add(type);
                }
                data.SaveChanges();
                return RedirectToAction("ManageType", "Admin");
            }
        }


        [Route("Admin/ManageType")]
        public ActionResult ManageType()
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

        [Route("Admin/ManageTypeData")]
        public JsonResult ManageTypeData()
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                List<ManageHelp> TypeData = new List<ManageHelp>();
                List<Type> types = data.Types.ToList<Type>();

                int i = 0;

                foreach (Type type in types)
                {
                    i++;
                    ManageHelp typeData = new ManageHelp();
                    typeData.SrNo = i;
                    typeData.Id = type.TypeID;
                    typeData.Name = type.TypeName;
                    typeData.Description = type.Description;
                    DateTime d = (DateTime)type.DateAdded;
                    string format = "dd-MM-yyyy, hh:mm";
                    typeData.DateAdded = d.ToString(format);
                    typeData.AddedBy = data.Users.Find(type.AddedBy).FirstName + " " + data.Users.Find(type.AddedBy).LastName;
                    typeData.IsActive = type.IsActive ? "Yes" : "No";

                    TypeData.Add(typeData);
                }

                return Json(TypeData, JsonRequestBehavior.AllowGet);
            }
        }

        [Route("UpdateType/{id}")]
        public ActionResult UpdateType(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                Type type = data.Types.Find(id);
                return View("AddType", type);
            }
        }

        [Route("Admin/DeleteType/{id}")]
        public ActionResult DeleteType(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                Type type = data.Types.Find(id);
                type.IsActive = false;
                data.SaveChanges();
                return RedirectToAction("ManageType", "Admin");
            }
        }

        [Route("Admin/AddCountry")]
        public ActionResult AddCountry()
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

        
        [Route("Admin/SaveCountry")]
        public ActionResult SaveCountry(Country country)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userID = (int)Session["userId"];

                if (country.CountryID != 0)
                {
                    country.ModifiedBy = userID;
                    country.DateModified = (DateTime)System.DateTime.Now;
                    data.Entry(country).State = System.Data.Entity.EntityState.Modified;
                }
                else
                {
                    country.AddedBy = userID;
                    country.DateAdded = (DateTime)System.DateTime.Now;
                    country.IsActive = true;
                    data.Countries.Add(country);
                }
                data.SaveChanges();
                return RedirectToAction("ManageCountry", "Admin");
            }
        }


        [Route("Admin/ManageCountry")]
        public ActionResult ManageCountry()
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

        [Route("Admin/ManageCountryData")]
        public JsonResult ManageCountryData()
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                List<ManageHelp> CountryData = new List<ManageHelp>();
                List<Country> countries = data.Countries.ToList<Country>();

                int i = 0;

                foreach (Country country in countries)
                {
                    i++;
                    ManageHelp countryData = new ManageHelp();
                    countryData.SrNo = i;
                    countryData.Id = country.CountryID;
                    countryData.Name = country.CountryName;
                    countryData.Description = country.CountryCode;
                    DateTime d = (DateTime)country.DateAdded;
                    string format = "dd-MM-yyyy, hh:mm";
                    countryData.DateAdded = d.ToString(format);
                    countryData.AddedBy = data.Users.Find(country.AddedBy).FirstName + " " + data.Users.Find(country.AddedBy).LastName;
                    countryData.IsActive = country.IsActive ? "Yes" : "No";

                    CountryData.Add(countryData);
                }

                return Json(CountryData, JsonRequestBehavior.AllowGet);
            }
        }

        [Route("UpdateCountry/{id}")]
        public ActionResult UpdateCountry(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                Country country = data.Countries.Find(id);
                return View("AddCountry", country);
            }
        }

        [Route("Admin/DeleteCountry/{id}")]
        public ActionResult DeleteCountry(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                Country country = data.Countries.Find(id);
                country.IsActive = false;
                data.SaveChanges();
                return RedirectToAction("ManageCountry", "Admin");
            }
        }


        [Route("Admin/SpamReports")]
        public ActionResult SpamReports()
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

        [Route("Admin/SpamReportsData")]
        public JsonResult SpamReportsData()
        {
            if (Session["userId"] == null)
            {
                return Json("User Not logged in");
            }
            else
            {
                int userId = (int)Session["userID"];
                List<SpamReportsHelp> spamReportsData = new List<SpamReportsHelp>();
                List<SpamReport> spamReports = data.SpamReports.ToList<SpamReport>();

                int i = 0;
                foreach (SpamReport spamReport in spamReports)
                {
                    i++;
                    SpamReportsHelp report = new SpamReportsHelp();
                    report.SrNo = i;
                    report.NoteId = spamReport.NoteID;
                    report.SpamReportId = spamReport.SpamReportID;
                    report.ReportedBy = data.Users.Find(spamReport.ReportedByUserID).FirstName + " " + data.Users.Find(spamReport.ReportedByUserID).LastName;
                    NotesDetail notesDetail = data.NotesDetails.Find(spamReport.NoteID);
                    report.NoteTitle = notesDetail.Title;
                    report.NoteCategory = notesDetail.Category.CategoryName;
                    DateTime d = (DateTime)System.DateTime.Now;
                    string format = "dd-MM-yyyy, hh:mm";
                    report.DateAdded = d.ToString(format);
                    report.Remark = spamReport.Remarks;

                    spamReportsData.Add(report);
                }

                return Json(spamReportsData, JsonRequestBehavior.AllowGet);
            }
        }

        [Route("Admin/DeleteSpamReport/{id}")]
        public ActionResult DeleteSpamReport(int id)
        {
            if (Session["userId"] == null)
            {
                return RedirectToAction("Login", "Auth");
            }
            else
            {
                int userId = (int)Session["userID"];
                SpamReport spamReport = data.SpamReports.Find(id);
                data.SpamReports.Remove(spamReport);
                data.SaveChanges();
                return RedirectToAction("SpamReports", "Admin");
            }
        }


        /* Section 4.7 */
        /* Logged in user profile */
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
                    user.EmailID = u.EmailID;
                }
                else
                {
                    user = new UserInfo();
                }

                return View(user);
            }
        }

        /* Save Or Update Profile */
        [HttpPost]
        [Route("User/SaveAdminProfile")]
        public ActionResult SaveAdminProfile(UserInfo userInfo)
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
                userData.AddressLine1 = "";
                userData.AddressLine2 = "";
                userData.City = "";
                userData.State = "";
                userData.ZipCode = "";
                userData.Country = "";

                /*Date added and Added By*/
                userData.DateAdded = (DateTime)System.DateTime.Now;
                userData.AddedBy = userId;
                data.UserInfoes.Add(userData);
                if (userData.ID != 0)
                {
                    data.Entry(userData).State = System.Data.Entity.EntityState.Modified;
                }
                data.SaveChanges();

                return RedirectToAction("Dashboard", "Admin");
            }
        }

        /* Change Password */
        [Route("Admin/ChangePassword")]
        public ActionResult ChangePassword()
        {
            return RedirectToAction("ChangePassword", "Auth");
        }

        /* Logout */
        [Route("Admin/Logout")]
        public ActionResult Logout()
        {
            return RedirectToAction("Logout","Auth");
        }





    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class MembersHelp
    {
        public int SrNo { get; set; }
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string JoiningDate { get; set; }

        public int UnderReviewNotes { get; set; }
        public int PublishedNotes { get; set; }
        public int DownloadedNotes { get; set; }
        public int TotalExpenses { get; set; }
        public int TotalEarnings { get; set; }


    }
}
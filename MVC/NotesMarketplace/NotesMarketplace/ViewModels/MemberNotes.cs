using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class MemberNotes
    {
        public int SrNo { get; set; }
        public int NoteId { get; set; }

        public string NoteTitle { get; set; }
        public string Category { get; set; }
        public string Status { get; set; }

        public int DownloadedNotes { get; set; }
        public int TotalEarnings { get; set; }

        public string DateAdded { get; set; }
        public string PublishedDate { get; set; }

    }
}
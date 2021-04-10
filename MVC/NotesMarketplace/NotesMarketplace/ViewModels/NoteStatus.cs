using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class NoteStatus
    {
        public int SrNo { get; set; }
        public int UserID { get; set; }
        public int UserID2 { get; set; }
        public int NoteID { get; set; }

        public string NoteTitle { get; set; }

        public string NoteCategory { get; set; }

        public string SellType { get; set; }

        public int Price { get; set; }

        public string Seller { get; set; }

        public string Buyer { get; set; }

        public string GeneralDateTime { get; set; }

        public string ActionedBy { get; set; }

        public int NumberOfDownloads { get; set; }

        public string Status { get; set; }

        public string Remarks { get; set; }


    }
}
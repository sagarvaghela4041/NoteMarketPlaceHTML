using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class NotesHelp
    {
        public int SrNo { get; set; }
        public int id { get; set; }

        public string NoteTitle { get; set; }
        public string Category { get; set; }
        public string Seller { get; set; }
        public string Buyer { get; set; }
        public string SellType { get; set; }
        public int Price { get; set; }
        public string DownloadDateTime { get; set; }


        public string Remarks { get; set; }
        
        public int downloadId { get; set; }

    }
}
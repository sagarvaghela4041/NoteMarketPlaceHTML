using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class BuyerRequest
    {
        public int id { get; set; }
        public string NoteTitle { get; set; }

        public string NoteCategory { get; set; }

        public string Buyer { get; set; }

        public string PhoneNo { get; set; }

        public string SellType { get; set; }

        public int Price { get; set; }

        public string DonwloadedTime { get; set; }

        

    }
}
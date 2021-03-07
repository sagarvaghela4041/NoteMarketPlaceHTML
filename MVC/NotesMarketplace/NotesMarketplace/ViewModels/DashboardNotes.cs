using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class DashboardNotes
    {
        public int id { get; set; }
        public string AddedDate { get; set; }

        public string Title { get; set; }

        public string Category { get; set; }

        public string Status { get; set; }

        public string SellType { get; set; }

        public int Price { get; set; }

    }
}
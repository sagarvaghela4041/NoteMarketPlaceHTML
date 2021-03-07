using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class Dashboard
    {
        public int NumberOfSoldNotes { get; set; }

        public int MoneyEarned { get; set; }

        public int MyDownloads { get; set; }

        public int MyRejectedNotes { get; set; }

        public int BuyerRequests { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class SpamReportsHelp
    {
        public int SrNo { get; set; }
        public int NoteId { get; set; }
        public int SpamReportId { get; set; }
        public string ReportedBy { get; set; }
        public string NoteTitle { get; set; }
        public string NoteCategory { get; set; }
        public string DateAdded { get; set; }
        public string Remark { get; set; }
    }
}
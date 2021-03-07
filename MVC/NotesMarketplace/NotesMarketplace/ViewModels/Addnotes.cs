using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class Addnotes
    {
        public NotesDetail notesDetail { get; set; }

        public string submitButton { get; set; }
        public HttpPostedFileBase displayPicture { get; set; }

        public HttpPostedFileBase notes { get; set; }

        public HttpPostedFileBase notePreview { get; set; }


    }
}
﻿
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.ViewModels
{
    public class ManageHelp
    {
        public int SrNo { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string DateAdded { get; set; }
        public string AddedBy { get; set; }
        public string IsActive { get; set; }

    }
}
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApplication.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class SystemConfig
    {
        public int system_id { get; set; }
        public string Support_Email_Address { get; set; }
        public string Support_Phone_Number { get; set; }
        public string EmailForNotify { get; set; }
        public string Default_User_Profile_Picture { get; set; }
        public string Default_Note_Profile_Picture { get; set; }
        public string FB_URL { get; set; }
        public string LinkedIn_URL { get; set; }
        public string Twitter_URL { get; set; }
        public System.DateTime Created_Date { get; set; }
        public Nullable<int> Created_By { get; set; }
        public Nullable<System.DateTime> Modified_Date { get; set; }
        public Nullable<int> Modified_By { get; set; }
        public bool IsActive { get; set; }

        public string Password { get; set; }
    }
}

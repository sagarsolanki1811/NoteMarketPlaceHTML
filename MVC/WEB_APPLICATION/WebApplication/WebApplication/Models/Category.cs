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
    
    public partial class Category
    {
        public int category_id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public System.DateTime Created_Date { get; set; }
        public Nullable<int> Created_By { get; set; }
        public Nullable<System.DateTime> Modified_Date { get; set; }
        public Nullable<int> Modified_By { get; set; }
        public Nullable<System.DateTime> Deactivated_Date { get; set; }
        public Nullable<int> Deactivated_By { get; set; }
        public bool IsActive { get; set; }
    }
}

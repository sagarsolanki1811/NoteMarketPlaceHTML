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
    using System.ComponentModel.DataAnnotations;
    using System.Web;

    public partial class NoteDetail
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public NoteDetail()
        {
            this.BuyerReqs = new HashSet<BuyerReq>();
            this.Reviews = new HashSet<Review>();
            this.Spams = new HashSet<Spam>();
        }
    
        public int note_id { get; set; }
        public int user_id { get; set; }

        [Display(Name = "Title *")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please Enter Your Note Title")]
        public string File_Name { get; set; }

        [Display(Name = "Upload Notes *")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please Upload Your Note")]
        public string File_Path { get; set; }

        [Display(Name = "Category *")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please Enter Your Note Category")]
        public string Category { get; set; }

        public string Display_Picture { get; set; }

        [Display(Name = "Type *")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please Select Your Note Type")]
        public string Type { get; set; }

        public Nullable<int> No_Of_Pages { get; set; }

        [Display(Name = "Description *")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please Enter Your Note Description")]
        public string Description { get; set; }

        [Display(Name = "Country *")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please Select Your Country")]
        public string Country { get; set; }

        public string Institute_Name { get; set; }
        public string Course_Name { get; set; }
        public string Course_Code { get; set; }
        public string Professor { get; set; }

        [Display(Name = "Sell For *")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please Select Your Note is Free Or Paid")]
        public bool IsPaid { get; set; }

        [Display(Name = "Sell Price *")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please Enter Your Note's Selling Price")]
        public decimal Sell_Price { get; set; }

        public string Note_Preview { get; set; }
        public Nullable<int> Action_By { get; set; }
        public System.DateTime Created_Date { get; set; }
        public Nullable<System.DateTime> Modified_Date { get; set; }
        public Nullable<System.DateTime> Published_Date { get; set; }
        public string Status { get; set; }
        public long No_Of_Download { get; set; }
        public double Earning_Amount { get; set; }

        public HttpPostedFileBase Display_Pic { get; set; }
        public HttpPostedFileBase Up_Note { get; set; }
        public HttpPostedFileBase Up_Preview { get; set; }

        public string Paid { get; set; }
        public string Free { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BuyerReq> BuyerReqs { get; set; }
        public virtual User User { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Review> Reviews { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Spam> Spams { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ataal.DAL.Data.Models
{
    public class Technical
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string name { get; set; }

        [Required]                                 // found in userIdentity +password
        [Phone]
        public string phone { get; set; }

        [EmailAddress]
        public string Email { get; set; }
        //**********************************************************************************

      public byte []?  Photo { get; set; }         // it will be in the parent class 


        [Required]
        public int Rate { get; set; }

        [Required]
        public string brief { get; set; }

       
        [StringLength(100, ErrorMessage = "Address cannot exceed 100 characters")]
        public string? Address { get; set; }

        [Required]
        public ICollection<Section> Sections { get; set; }  // the sections which choosed by him to see its problems

        public ICollection<Problem>? Problems_Solved { get; set; } // the problems which solved by him
        public ICollection<Review>? Reviews { get; set; } // reviews from customers for him

        public ICollection<Report>? Reports { get; set; }// Reports from customers for him

        public ICollection<Customer>? Blocked_Customers { get; set; }//customers  who blocked by technical
     
    }
}

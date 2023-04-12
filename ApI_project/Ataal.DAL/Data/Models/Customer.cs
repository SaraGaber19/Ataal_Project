using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ataal.DAL.Data.Models
{
      public class Customer
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string name { get; set; }

    
        [Phone]
        public string? phone { get; set; }

        [Required]
        [EmailAddress]
        public string Email { get; set; }

        public byte[]? Photo { get; set; }

        [StringLength(100, ErrorMessage = "Address cannot exceed 100 characters")]
        public string? Address { get; set; }

        public ICollection<Technical>? Blocked_Technicals { get; set; }//technicals who blocked by customer

        public ICollection<Problem>? Problems { get; set; } // users problems

        /// password in user identity

    }
}

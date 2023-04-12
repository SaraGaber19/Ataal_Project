using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ataal.DAL.Data.Models
{
   public class Admin
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string name { get; set; }

        [Required]                               // found in userIdentity +password
        [EmailAddress]
        public string Email { get; set; }

      // password in user identity
    }
}

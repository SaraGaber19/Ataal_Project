using Ataal.DAL.Data.Models;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ataal.DAL.Data.Identity
{
    public class AppUser: IdentityUser
    {
        [Key]
        public int UserId { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]                  
        [EmailAddress]
        public string Email { get; set; }

        public string PasswordHash { get; set; }

        public Admin? Admin { get; set; }
        public Technical? Technical { get; set; }

        public Customer? Customer { get; set; }
    }
}

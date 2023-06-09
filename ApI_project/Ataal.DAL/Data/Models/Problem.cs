﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ataal.DAL.Data.Models
{
  public class Problem
    {
        [Key]
        public int Problem_ID { get; set; }

        [Required]
        [StringLength(20, ErrorMessage = "Description cannot exceed 20 characters")]
        public string Problem_Title { get; set; }

        [Required]
        [StringLength(300, ErrorMessage = "Description cannot exceed 300 characters")]
        public string Description { get; set; }

        public bool Solved { get; set; } = false;

        [ForeignKey("Section")]
        public int Section_ID { get; set; }
        public Section Section { get; set; }

       

        [ForeignKey("Technical")]
        public int? Technical_ID { get; set; }            
        public Technical? Technical { get; set; }


        [ForeignKey("Customer")]
        public int Customer_ID { get; set; }

        public Customer Customer { get; set; }
        

        public ICollection<Problems_Photo>? Problems_photos { get; set; }
       public ICollection<KeyWords>? KeyWords { get; set; }
    }
}

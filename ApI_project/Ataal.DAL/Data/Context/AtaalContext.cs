using Ataal.DAL.Data.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using static System.Collections.Specialized.BitVector32;
using Section = Ataal.DAL.Data.Models.Section;

namespace Ataal.DAL.Data.Context
{
    public class AtaalContext : DbContext
    {
        public AtaalContext(DbContextOptions<AtaalContext> options) : base(options)
        {

        }


        // IdentityDbContext<User>
        // create this class and complate the identity 
        // User is the main class which inherte from  useridentity ,
        // and it should in relation  with admin and customer and technical 

        public DbSet<KeyWords> KeyWords => Set<KeyWords>();
        public DbSet<Problem> Problems => Set<Problem>();

        public DbSet<Report> Reports => Set<Report>();
        public DbSet<Review> Reviews => Set<Review>();
        public DbSet<Section> Sections => Set<Section>();







    }
}

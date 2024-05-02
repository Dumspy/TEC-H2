using DatingApp.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace DatingApp.Data;

public class MainDBContext : DbContext
{
    public MainDBContext(DbContextOptions<MainDBContext> options) : base(options)
    {
    }

    public DbSet<User?> Users { get; set; }
    public DbSet<UserProfile> UserProfiles { get; set; }
    public DbSet<Message> Messages { get; set; }
}
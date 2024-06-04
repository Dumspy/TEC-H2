using DatingApp.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace DatingApp.Data;

public class MainDBContext : DbContext
{
    public MainDBContext(DbContextOptions<MainDBContext> options) : base(options)
    {
    }
    
    protected override void OnModelCreating(ModelBuilder builder)
    {
        builder.UseIdentityColumns();
        
        builder.Entity<Message>()
            .Property(e => e.SentAt)
            .HasColumnType("timestamp");
    }

    public DbSet<User> Users { get; set; } = null!;
    public DbSet<UserProfile> UserProfiles { get; set; } = null!;
    public DbSet<Message> Messages { get; set; } = null!;
    public DbSet<Like> Likes { get; set; } = null!;
}
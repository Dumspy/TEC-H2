using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using DatingApp.Data.Enums;

namespace DatingApp.Data.Models;

public class UserProfile
{
    [Key]
    public int Id { get; set; }
    public Genders Gender { get; set; }
    public int Height { get; set; }
    public int Weight { get; set; }
    
    [ForeignKey("User")]
    public int UserId { get; set; }
    public User User { get; set; } = null!;
}
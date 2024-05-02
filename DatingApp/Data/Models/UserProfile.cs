using System.ComponentModel.DataAnnotations;
using DatingApp.Data.Enums;

namespace DatingApp.Data.Models;

public class UserProfile
{
    [Key]
    public int Id { get; set; }
    public Genders Gender { get; set; }
    public int Height { get; set; }
    public int Weight { get; set; }
    public User User { get; set; }
}
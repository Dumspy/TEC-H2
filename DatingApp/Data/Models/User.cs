using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DatingApp.Data.Models;

public class User
{
    [Key]
    public int Id { get; set; }
    [MinLength(8)]
    public string Password { get; set; }
    [Required]
    [EmailAddress]
    public string Email { get; set; }
    
    [InverseProperty("User")]
    public UserProfile Profile { get; set; } = null!;
}
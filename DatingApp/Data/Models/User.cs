using System.ComponentModel.DataAnnotations;

namespace DatingApp.Data.Models;

public class User
{
    [Key]
    public int Id { get; set; }
    public string Password { get; set; }
    [Required]
    [EmailAddress]
    public string Email { get; set; }
    
    public UserProfile Profile { get; set; } = null!;
    
    public User(){}
    
    public User(int id)
    {
        Id = id;
    }
}
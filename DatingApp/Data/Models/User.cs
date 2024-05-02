using System.ComponentModel.DataAnnotations;

namespace DatingApp.Data.Models;

public class User
{
    [Key]
    public int Id { get; set; }
    public string Password { get; set; }
    public string Email { get; set; }
}
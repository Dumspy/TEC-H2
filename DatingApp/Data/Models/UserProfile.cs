using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using DatingApp.Data.Enums;

namespace DatingApp.Data.Models;

public class UserProfile
{
    [Key]
    public int Id { get; set; }
    [Required]
    public string FirstName { get; set; }
    [Required]
    public string? LastName { get; set; }
    public Genders Gender { get; set; }
    public int Height { get; set; }
    public int Weight { get; set; }
    public int ZipCode { get; set; }
    
    [Required]
    [MinAge(18)]
    [Column(TypeName = "timestamp")]
    public DateTime DateOfBirth { get; set; } = DateTime.Now;
    
    [ForeignKey("User")]
    public int UserId { get; set; }
    public User User { get; set; } = null!;
    
    
    [InverseProperty("Liker")]
    public ICollection<Like> Likers { get; set; }
    [InverseProperty("Likee")]
    public ICollection<Like> Likees { get; set; }
}
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DatingApp.Data.Models;

[Index(nameof(LikerId), nameof(LikeeId), IsUnique = true)]
public class Like
{
    public int Id { get; set; }
    
    [ForeignKey("User")]
    public int LikerId { get; set; }
    public User Liker { get; set; } = null!;
    
    [ForeignKey("User")]
    public int LikeeId { get; set; }
    public User Likee { get; set; } = null!;
    
    public int Status { get; set; }
}
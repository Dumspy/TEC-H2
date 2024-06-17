using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DatingApp.Data.Models;

[Index(nameof(LikerId), nameof(LikeeId), IsUnique = true)]
public class Like
{
    public int Id { get; set; }
    
    [ForeignKey("Liker")]
    public int LikerId { get; set; }
    public UserProfile Liker { get; set; } = null!;
    
    [ForeignKey("Likee")]
    public int LikeeId { get; set; }
    public UserProfile Likee { get; set; } = null!;
}
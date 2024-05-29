using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DatingApp.Data.Models;

public class Message
{
    [Key]
    public int Id { get; set; }
    
    public User Sender { get; set; } = null!;
    public User Receiver { get; set; } = null!;
    
    [Required]
    public string Content { get; set; }
    
    [Column(TypeName = "timestamp")]
    public DateTime SentAt { get; set; }
    
    public bool IsRead { get; set; }
}
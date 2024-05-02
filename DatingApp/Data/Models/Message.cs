using System.ComponentModel.DataAnnotations;

namespace DatingApp.Data.Models;

public class Message
{
    [Key]
    public int Id { get; set; }
    
    public User Sender { get; set; }
    public User Receiver { get; set; }
    
    public string Content { get; set; }
    public DateTime SentAt { get; set; }
    
    public bool IsRead { get; set; }
}
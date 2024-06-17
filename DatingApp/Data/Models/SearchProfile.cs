using System.ComponentModel.DataAnnotations;
using DatingApp.Data.Enums;

namespace DatingApp.Data.Models;

public class SearchProfile
{
    public string FirstName { get; set; }
    
    public string LastName { get; set; }

    public Genders Gender { get; set; }

    public int Height { get; set; }

    public int Weight { get; set; }

    public int ZipCode { get; set; }

    [Range(18, 150, ErrorMessage = "Age must be between 18 and 150.")]
    public int? MinAge { get; set; } = 18;

    [Range(18, 150, ErrorMessage = "Age must be between 18 and 150.")]
    public int? MaxAge { get; set; } = 150;
    
    public bool LikesYou { get; set; }
}
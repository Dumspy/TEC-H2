using DatingApp.Data.Models;

namespace DatingApp.Services;

public class AuthService
{
    public User LoginUser { get; set; } = new User();

    public User? CurrentUser = null;    
    public bool IsLoggedIn = false;
}
using DatingApp.Data.Models;

namespace DatingApp.Services;

public class AuthService
{
    public User? LoginUser { get; set; } = new User();

    public User? CurrentUser = null;    
    
    private bool _isLoggedIn = false;
    public bool IsLoggedIn
    {
        get => _isLoggedIn;
        set
        {
            _isLoggedIn = value;
            OnStateChange?.Invoke(this, EventArgs.Empty);
        }
    }
    
    public void Logout()
    {
        if (CurrentUser == null || !IsLoggedIn)
        {
            return;
        }
        
        CurrentUser = null;
        IsLoggedIn = false;
    }
    
    public event EventHandler OnStateChange;
}
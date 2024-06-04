using DatingApp.Data.Models;
using Microsoft.AspNetCore.Components;

namespace DatingApp.Services;

public class AuthService
{
    public User? LoginUser { get; set; } = new User();

    public User? CurrentUser = null;    
    
    public string RedirectUrl = "/";
    public event EventHandler OnStateChange;
    
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

    private NavigationManager NavigationManager { get; }
    public AuthService(NavigationManager navigationManager)
    {
        NavigationManager = navigationManager;
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
    
    public bool Login(string password)
    {
        if (LoginUser == null)
        {
            return false;
        }

        if (LoginUser.Password != password) return false;
        CurrentUser = LoginUser;
        IsLoggedIn = true;
        
        NavigationManager.NavigateTo(RedirectUrl);
        RedirectUrl = "/";
            
        return true;

    }
}
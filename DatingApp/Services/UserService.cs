using DatingApp.Data;
using DatingApp.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace DatingApp.Services;

public class UserService
{
    private IDbContextFactory<MainDBContext> _dbContextFactory;
    
    public UserService(IDbContextFactory<MainDBContext> dbContextFactory)
    {
        _dbContextFactory = dbContextFactory;
    }
    
    public User? CreateUser(User? user)
    {
        using(var context = _dbContextFactory.CreateDbContext())
        {
            context.Users.Add(user);
            context.SaveChanges();
            
            return context.Users.FirstOrDefault(u => u.Email == user.Email);
        }
    }
    
    public User? GetUserByEmail(string email)
    {
        using(var context = _dbContextFactory.CreateDbContext())
        {
            return context.Users.FirstOrDefault(u => u.Email == email);
        }
    }
}
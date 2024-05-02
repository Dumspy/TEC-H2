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
    
    public void CreateUser(User user)
    {
        using(var context = _dbContextFactory.CreateDbContext())
        {
            context.Users.Add(user);
            context.SaveChanges();
        }
    }
}
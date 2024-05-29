using DatingApp.Components.Pages;
using DatingApp.Data;
using DatingApp.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace DatingApp.Services;

public class ProfileService
{
    private IDbContextFactory<MainDBContext> _dbContextFactory;
    
    public ProfileService(IDbContextFactory<MainDBContext> dbContextFactory)
    {
        _dbContextFactory = dbContextFactory;
    }
    
    public UserProfile? GetProfileByUserId(int userId)
    {
        using var context = _dbContextFactory.CreateDbContext();
        return context.UserProfiles.FirstOrDefault(p => p.User.Id == userId);
    }

    public UserProfile? GetProfileById(int profileId)
    {
        using var context = _dbContextFactory.CreateDbContext();
        return context.UserProfiles.FirstOrDefault(p => p.Id == profileId);
    }
}
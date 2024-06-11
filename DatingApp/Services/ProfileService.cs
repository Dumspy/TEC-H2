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
        return context.UserProfiles.FirstOrDefault(p => p.UserId == userId);
    }

    public UserProfile? GetProfileById(int profileId)
    {
        using var context = _dbContextFactory.CreateDbContext();
        return context.UserProfiles.FirstOrDefault(p => p.Id == profileId);
    }
    
    public UserProfile? UpdateProfile(UserProfile? profile)
    {
        using var context = _dbContextFactory.CreateDbContext();
        context.UserProfiles.Update(profile);
        context.SaveChanges();
        
        return context.UserProfiles.FirstOrDefault(p => p.Id == profile.Id);
    }
    
    public UserProfile? CreateProfile(int userId)
    {
        using var context = _dbContextFactory.CreateDbContext();
        var profile = new UserProfile { UserId = userId, FirstName = "", LastName = ""};
        context.UserProfiles.Add(profile);
        context.SaveChanges();
        
        return context.UserProfiles.FirstOrDefault(p => p.UserId == userId);
    }
    
    public void DeleteProfile(int profileId)
    {
        using var context = _dbContextFactory.CreateDbContext();
        var profile = context.UserProfiles.FirstOrDefault(p => p.Id == profileId);
        context.UserProfiles.Remove(profile);
        context.SaveChanges();
    }
}
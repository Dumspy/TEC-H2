using DatingApp.Data;
using DatingApp.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace DatingApp.Services;

public class SearchService
{
    private IDbContextFactory<MainDBContext> _dbContextFactory;
    
    public SearchService(IDbContextFactory<MainDBContext> dbContextFactory)
    {
        _dbContextFactory = dbContextFactory;
    }
    
    public async Task<List<UserProfile>> SearchProfile(SearchProfile searchProfile, int searcherUserId)
    {
        await using var context = await _dbContextFactory.CreateDbContextAsync();
        
        var ownProfile = context.UserProfiles.Include(x => x.Likers).FirstOrDefault(x => x.UserId == searcherUserId);
        
        var query = context.UserProfiles.AsQueryable();
        query.Include(x => x.Likees);
        query = query.Where(x => x.UserId != ownProfile.Id);

        if (!string.IsNullOrEmpty(searchProfile.FirstName))
            query = query.Where(x => x.FirstName.Contains(searchProfile.FirstName));

        if (!string.IsNullOrEmpty(searchProfile.LastName))
            query = query.Where(x => x.LastName.Contains(searchProfile.LastName));
        
        query = query.Where(x => x.Gender == searchProfile.Gender);

        if (searchProfile.Height > 0)
            query = query.Where(x => x.Height >= searchProfile.Height);

        if (searchProfile.Weight > 0)
            query = query.Where(x => x.Weight <= searchProfile.Weight);

        if (searchProfile.ZipCode > 0)
            query = query.Where(x => x.ZipCode == searchProfile.ZipCode);

        if (searchProfile.MinAge.HasValue)
        {
            var minDateOfBirth = DateTime.Today.AddYears(-searchProfile.MinAge.Value);
            query = query.Where(x => x.DateOfBirth <= minDateOfBirth);
        }

        if (searchProfile.MaxAge.HasValue)
        {
            var maxDateOfBirth = DateTime.Today.AddYears(-searchProfile.MaxAge.Value);
            query = query.Where(x => x.DateOfBirth >= maxDateOfBirth);
        }
        
        if (searchProfile.LikesYou) 
        {
            query = query.Where(userProfile => userProfile.Likers.Any(like => like.LikeeId == ownProfile.Id));
        }

        
        return await query.ToListAsync();
    }
}
using DatingApp.Data;
using DatingApp.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace DatingApp.Services;

public class LikeService
{
    private IDbContextFactory<MainDBContext> _dbContextFactory;
    
    public LikeService(IDbContextFactory<MainDBContext> dbContextFactory)
    {
        _dbContextFactory = dbContextFactory;
    }

    public void LikeUser(int likerId, int likeeId)
    {
        using (var context = _dbContextFactory.CreateDbContext())
        {
            var like = new Like
            {
                LikerId = likerId,
                LikeeId = likeeId
            };

            context.Likes.Add(like);
            context.SaveChanges();
        }
    }
    
    public void UnlikeUser(int likerId, int likeeId)
    {
        using (var context = _dbContextFactory.CreateDbContext())
        {
            var like = context.Likes.FirstOrDefault(l => l.LikerId == likerId && l.LikeeId == likeeId);

            if (like != null)
            {
                context.Likes.Remove(like);
                context.SaveChanges();
            }
        }
    }
    
    public bool HasLiked(int likerId, int likeeId)
    {
        using (var context = _dbContextFactory.CreateDbContext())
        {
            return context.Likes.Any(l => l.LikerId == likerId && l.LikeeId == likeeId);
        }
    }
}
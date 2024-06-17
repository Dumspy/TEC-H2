using DatingApp.Components;
using DatingApp.Data;
using DatingApp.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddScoped<AuthService>();

builder.Services.AddSingleton<UserService>();
builder.Services.AddSingleton<ProfileService>();
builder.Services.AddSingleton<SearchService>();
builder.Services.AddSingleton<PostcodeService>();
builder.Services.AddSingleton<LikeService>();

builder.Services.AddDbContextFactory<MainDBContext>(optionsBuilder => optionsBuilder.UseNpgsql($"Host=localhost:5555;Database=dating_app;Username=root;Password=password"));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
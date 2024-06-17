using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DatingApp.Migrations
{
    /// <inheritdoc />
    public partial class Addedinverserpropertytouserprofile : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Likes_Users_LikeeId",
                table: "Likes");

            migrationBuilder.DropForeignKey(
                name: "FK_Likes_Users_LikerId",
                table: "Likes");

            migrationBuilder.AddForeignKey(
                name: "FK_Likes_UserProfiles_LikeeId",
                table: "Likes",
                column: "LikeeId",
                principalTable: "UserProfiles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Likes_UserProfiles_LikerId",
                table: "Likes",
                column: "LikerId",
                principalTable: "UserProfiles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Likes_UserProfiles_LikeeId",
                table: "Likes");

            migrationBuilder.DropForeignKey(
                name: "FK_Likes_UserProfiles_LikerId",
                table: "Likes");

            migrationBuilder.AddForeignKey(
                name: "FK_Likes_Users_LikeeId",
                table: "Likes",
                column: "LikeeId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Likes_Users_LikerId",
                table: "Likes",
                column: "LikerId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}

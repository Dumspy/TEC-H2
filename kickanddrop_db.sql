ALTER DATABASE [testDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE [testDB]
GO
ALTER DATABASE [testDB] SET MULTI_USER

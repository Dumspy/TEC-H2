USE [master]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'filmDB')
BEGIN
  ALTER DATABASE [filmDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE [filmDB];
END;
GO

/****** Object:  Database [filmDB]    Script Date: 29-04-2024 08:13:24 ******/
CREATE DATABASE [filmDB]
 CONTAINMENT = NONE
 ON  PRIMARY
( NAME = N'filmDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\filmDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'filmDB2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\filmDB2.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON
( NAME = N'filmDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\filmDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [filmDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [filmDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [filmDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [filmDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [filmDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [filmDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [filmDB] SET ARITHABORT OFF
GO
ALTER DATABASE [filmDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [filmDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [filmDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [filmDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [filmDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [filmDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [filmDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [filmDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [filmDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [filmDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [filmDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [filmDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [filmDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [filmDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [filmDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [filmDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [filmDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [filmDB] SET RECOVERY FULL
GO
ALTER DATABASE [filmDB] SET  MULTI_USER
GO
ALTER DATABASE [filmDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [filmDB] SET DB_CHAINING OFF
GO
ALTER DATABASE [filmDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF )
GO
ALTER DATABASE [filmDB] SET TARGET_RECOVERY_TIME = 60 SECONDS
GO
ALTER DATABASE [filmDB] SET DELAYED_DURABILITY = DISABLED
GO
ALTER DATABASE [filmDB] SET ACCELERATED_DATABASE_RECOVERY = OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'filmDB', N'ON'
GO
ALTER DATABASE [filmDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [filmDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
ALTER DATABASE [filmDB] SET  READ_WRITE
GO

-- Create tables
use [filmDB]
GO

CREATE TABLE Genre (
  ID INT IDENTITY(1, 1) PRIMARY KEY,
  GenreNavn nvarchar(255) NOT NULL,
  Beskrivelse nvarchar(255),
);
GO

CREATE TABLE Film (
  ID INT IDENTITY(1, 1) PRIMARY KEY,
  Titel nvarchar(255) NOT NULL,
  Instruktør nvarchar(255),
  Spilletid INT CHECK (Spilletid BETWEEN 0 AND 180), -- Enforce spilletid range
  Dato date,
  FilmGerne INT FOREIGN KEY REFERENCES Genre(ID)
);
GO

CREATE TABLE Skuespiller (
  ID INT IDENTITY(1, 1) PRIMARY KEY,
  Navn nvarchar(255) NOT NULL,
  Portræt nvarchar(255),
);
GO

CREATE TABLE FilmSkuespiller (
  FilmID INT FOREIGN KEY REFERENCES Film(ID),
  SkuespillerID INT FOREIGN KEY REFERENCES Skuespiller(ID),
  PRIMARY KEY (FilmID, SkuespillerID)
);
GO

-- Setup backup
USE [msdb]
GO

/****** Object:  Job [filmDB Backup.filmDB Full backup]    Script Date: 29-04-2024 08:31:11 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 29-04-2024 08:31:11 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'filmDB Backup.filmDB Full backup',
		@enabled=1,
		@notify_level_eventlog=2,
		@notify_level_email=0,
		@notify_level_netsend=0,
		@notify_level_page=0,
		@delete_level=0,
		@description=N'No description available.',
		@category_name=N'Database Maintenance',
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [filmDB Full backup]    Script Date: 29-04-2024 08:31:11 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'filmDB Full backup',
		@step_id=1,
		@cmdexec_success_code=0,
		@on_success_action=1,
		@on_success_step_id=0,
		@on_fail_action=2,
		@on_fail_step_id=0,
		@retry_attempts=0,
		@retry_interval=0,
		@os_run_priority=0, @subsystem=N'SSIS',
		@command=N'/Server "$(ESCAPE_NONE(SRVR))" /SQL "Maintenance Plans\filmDB Backup" /set "\Package\filmDB Full backup.Disable;false"',
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'filmDB Backup.filmDB Full backup',
		@enabled=1,
		@freq_type=4,
		@freq_interval=1,
		@freq_subday_type=1,
		@freq_subday_interval=0,
		@freq_relative_interval=0,
		@freq_recurrence_factor=0,
		@active_start_date=20240429,
		@active_end_date=99991231,
		@active_start_time=20000,
		@active_end_time=235959,
		@schedule_uid=N'774dc287-d188-47ab-852e-b79924adcc21'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [filmDB Backup.filmDB Diff backup]    Script Date: 29-04-2024 08:31:39 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 29-04-2024 08:31:39 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'filmDB Backup.filmDB Diff backup',
		@enabled=1,
		@notify_level_eventlog=2,
		@notify_level_email=0,
		@notify_level_netsend=0,
		@notify_level_page=0,
		@delete_level=0,
		@description=N'No description available.',
		@category_name=N'Database Maintenance',
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [filmDB Diff backup]    Script Date: 29-04-2024 08:31:39 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'filmDB Diff backup',
		@step_id=1,
		@cmdexec_success_code=0,
		@on_success_action=1,
		@on_success_step_id=0,
		@on_fail_action=2,
		@on_fail_step_id=0,
		@retry_attempts=0,
		@retry_interval=0,
		@os_run_priority=0, @subsystem=N'SSIS',
		@command=N'/Server "$(ESCAPE_NONE(SRVR))" /SQL "Maintenance Plans\filmDB Backup" /set "\Package\filmDB Diff backup.Disable;false"',
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'filmDB Backup.filmDB Diff backup',
		@enabled=1,
		@freq_type=4,
		@freq_interval=1,
		@freq_subday_type=4,
		@freq_subday_interval=30,
		@freq_relative_interval=0,
		@freq_recurrence_factor=0,
		@active_start_date=20240429,
		@active_end_date=99991231,
		@active_start_time=0,
		@active_end_time=235959,
		@schedule_uid=N'f62d2c67-55f9-461e-adac-dce2bc3615e4'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [filmDB Backup.filmDB Log backup]    Script Date: 29-04-2024 08:31:49 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 29-04-2024 08:31:49 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'filmDB Backup.filmDB Log backup',
		@enabled=1,
		@notify_level_eventlog=2,
		@notify_level_email=0,
		@notify_level_netsend=0,
		@notify_level_page=0,
		@delete_level=0,
		@description=N'No description available.',
		@category_name=N'Database Maintenance',
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [filmDB Log backup]    Script Date: 29-04-2024 08:31:49 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'filmDB Log backup',
		@step_id=1,
		@cmdexec_success_code=0,
		@on_success_action=1,
		@on_success_step_id=0,
		@on_fail_action=2,
		@on_fail_step_id=0,
		@retry_attempts=0,
		@retry_interval=0,
		@os_run_priority=0, @subsystem=N'SSIS',
		@command=N'/Server "$(ESCAPE_NONE(SRVR))" /SQL "Maintenance Plans\filmDB Backup" /set "\Package\filmDB Log backup.Disable;false"',
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'filmDB Backup.filmDB Log backup',
		@enabled=1,
		@freq_type=4,
		@freq_interval=1,
		@freq_subday_type=4,
		@freq_subday_interval=10,
		@freq_relative_interval=0,
		@freq_recurrence_factor=0,
		@active_start_date=20240429,
		@active_end_date=99991231,
		@active_start_time=0,
		@active_end_time=235959,
		@schedule_uid=N'5861f376-2798-4f31-802d-83e66a82b9e0'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

-- Create users
USE [master]
GO
IF EXISTS (SELECT * FROM sys.logins WHERE name = N'FilmProvider')
BEGIN
  DROP LOGIN FilmProvider;
END
GO
CREATE LOGIN [FilmProvider] WITH PASSWORD=N'Password123', DEFAULT_DATABASE=[filmDB], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [filmDB]
GO
CREATE USER [FilmProvider] FOR LOGIN [FilmProvider] WITH DEFAULT_SCHEMA=[dbo]
GO
GRANT INSERT ON [Film] TO [FilmProvider];
GO


USE [master]
GO
IF EXISTS (SELECT * FROM sys.logins WHERE name = N'FilmManager')
BEGIN
  DROP LOGIN FilmManager;
END
GO
CREATE LOGIN [FilmManager] WITH PASSWORD=N'Password123', DEFAULT_DATABASE=[filmDB], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [filmDB]
GO
CREATE USER [FilmManager] FOR LOGIN [FilmManager] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE db_datareader ADD MEMBER FilmManager;
ALTER ROLE db_datawriter ADD MEMBER FilmManager;
go

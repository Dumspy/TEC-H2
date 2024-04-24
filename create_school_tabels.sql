USE [master]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'skoleDB')
BEGIN
  ALTER DATABASE [skoleDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE [skoleDB];
END;
GO

CREATE DATABASE [skoleDB]
    CONTAINMENT = NONE
    ON  PRIMARY
( NAME = N'skoleDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\skoleDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
    FILEGROUP [KlasseGroup]
( NAME = N'KlasseFile1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\KlasseFile.ndf1' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'KlasseFile2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\KlasseFile.ndf2' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
    FILEGROUP [PostNrByGroup]
( NAME = N'PostNrByFile1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\PostNrByFile1.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'PostNrByFile2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\PostNrByFile2.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
    FILEGROUP [ElevGroup]
( NAME = N'ElevFile1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\ElevFile1.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'ElevFile2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\ElevFile2.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
    FILEGROUP [LaererGroup]
( NAME = N'LaererFile1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\LaererFile1.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'LaererFile2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\LaererFile2.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
    FILEGROUP [UnderviserGroup]
( NAME = N'UnderviserFile1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\UnderviserFile1.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
( NAME = N'UnderviserFile2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\UnderviserFile2.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
    LOG ON
( NAME = N'skoleDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DBFELIX\MSSQL\DATA\skoleDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
    WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [skoleDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [skoleDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [skoleDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [skoleDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [skoleDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [skoleDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [skoleDB] SET ARITHABORT OFF
GO
ALTER DATABASE [skoleDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [skoleDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [skoleDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [skoleDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [skoleDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [skoleDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [skoleDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [skoleDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [skoleDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [skoleDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [skoleDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [skoleDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [skoleDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [skoleDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [skoleDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [skoleDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [skoleDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [skoleDB] SET RECOVERY FULL
GO
ALTER DATABASE [skoleDB] SET  MULTI_USER
GO
ALTER DATABASE [skoleDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [skoleDB] SET DB_CHAINING OFF
GO
ALTER DATABASE [skoleDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF )
GO
ALTER DATABASE [skoleDB] SET TARGET_RECOVERY_TIME = 60 SECONDS
GO
ALTER DATABASE [skoleDB] SET DELAYED_DURABILITY = DISABLED
GO
ALTER DATABASE [skoleDB] SET ACCELERATED_DATABASE_RECOVERY = OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'skoleDB', N'ON'
GO
ALTER DATABASE [skoleDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [skoleDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

USE [skoleDB]
GO

-- Create table Klasse
CREATE TABLE Klasse (
    klasseid INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    klassenavn NVARCHAR(50) NOT NULL UNIQUE
) ON [KlasseGroup];

-- Create table PostNrBy
CREATE TABLE PostNrBy (
    postnr INT PRIMARY KEY
    CONSTRAINT chk_postnr CHECK (postnr BETWEEN 1000 AND 9999),
    bynavn NVARCHAR(255) NOT NULL
) ON [PostNrByGroup];

-- Create table Elev
CREATE TABLE Elev (
    elevid INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    fornavn NVARCHAR(50) NOT NULL,
    efternavn NVARCHAR(75) NOT NULL,
    adresse NVARCHAR(255) NOT NULL,
    postnr INT NOT NULL,
    klasseid INT NOT NULL,
    FOREIGN KEY (postnr) REFERENCES PostNrBy(postnr),
    FOREIGN KEY (klasseid) REFERENCES Klasse(klasseid)
) ON [ElevGroup];

-- Create table Laerer
CREATE TABLE Laerer (
    laererid INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    fornavn NVARCHAR(50) NOT NULL,
    efternavn NVARCHAR(75) NOT NULL,
    adresse NVARCHAR(255) NOT NULL,
    postnr INT NOT NULL,
    FOREIGN KEY (postnr) REFERENCES PostNrBy(postnr),
) ON [LaererGroup];

-- Create table Underviser
CREATE TABLE Underviser (
    fag NVARCHAR(50) NOT NULL,
    laererid INT NOT NULL,
    klasseid INT NOT NULL,
    FOREIGN KEY (laererid) REFERENCES Laerer(laererid),
    FOREIGN KEY (klasseid) REFERENCES Klasse(klasseid),
    PRIMARY KEY (laererid, klasseid, fag)
) ON [LaererGroup];

-- Mock Data
INSERT INTO Klasse (klassenavn)
VALUES ('1.A'),
       ('2.B'),
       ('3.C');

INSERT INTO PostNrBy (postnr, bynavn)
VALUES (2000, 'Århus'),
        (3000, 'Helsingør'),
        (4000, 'Roskilde');

INSERT INTO Elev (fornavn, efternavn, adresse, postnr, klasseid)
VALUES ('Hans', 'Jensen', 'Strandvej 1', 2000, 1),
        ('Mia', 'Hansen', 'Bjerggade 5', 3000, 2),
        ('Peter', 'Pedersen', 'Skovvej 10', 4000, 3);

INSERT INTO Laerer (fornavn, efternavn, adresse, postnr)
VALUES ('Mette', 'Nielsen', 'Landevej 20', 2000),
        ('Thomas', 'Schmidt', 'Byvej 30', 3000),
        ('Birgitte', 'Christensen', 'Hovedgaden 40', 4000);

    INSERT INTO Underviser (fag, laererid, klasseid)
    VALUES ('Dansk', 1, 1),
            ('Matematik', 2, 2),
            ('Engelsk', 3, 3),
            ('Historie', 1, 2),
            ('Fysik', 2, 1),
            ('Biologi', 3, 3);

-- Show data is present
-- -- Check Klasse table
SELECT * FROM Klasse;

-- Check a few columns from PostNrBy
SELECT postnr, bynavn FROM PostNrBy;

-- Check Elev table with some filtering (e.g., showing students from Klasse 2.B)
SELECT * FROM Elev WHERE klasseid = (SELECT klasseid FROM Klasse WHERE klassenavn = '2.B');

-- Check Laerer table
SELECT * FROM Laerer;

-- Check Underviser table with subject and teacher name
SELECT u.fag, l.fornavn, l.efternavn
FROM Underviser u
INNER JOIN Laerer l ON u.laererid = l.laererid;

USE [master]
GO
/****** Object:  Database [DVLD]    Script Date: 7/29/2026 3:16:12 PM ******/
CREATE DATABASE [DVLD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DVLD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DVLD.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DVLD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DVLD_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DVLD] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DVLD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DVLD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DVLD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DVLD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DVLD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DVLD] SET ARITHABORT OFF 
GO
ALTER DATABASE [DVLD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DVLD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DVLD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DVLD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DVLD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DVLD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DVLD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DVLD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DVLD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DVLD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DVLD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DVLD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DVLD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DVLD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DVLD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DVLD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DVLD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DVLD] SET RECOVERY FULL 
GO
ALTER DATABASE [DVLD] SET  MULTI_USER 
GO
ALTER DATABASE [DVLD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DVLD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DVLD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DVLD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DVLD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DVLD] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DVLD', N'ON'
GO
ALTER DATABASE [DVLD] SET QUERY_STORE = ON
GO
ALTER DATABASE [DVLD] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DVLD]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/29/2026 3:16:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[PersonID] [int] NOT NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[People]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[PersonID] [int] IDENTITY(1,1) NOT NULL,
	[NationalNo] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[SecondName] [nvarchar](20) NOT NULL,
	[ThirdName] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[NationalityCountryID] [int] NULL,
	[ImagePath] [nvarchar](250) NULL,
 CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[UsersView]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[UsersView] as 
select U.UserID, U.PersonID, (P.firstname + ' ' + P.Secondname + ' ' + P.Thirdname + ' ' + P.Lastname) as fullname, U.Username,U.Password, U.IsActive
from Users U inner join People P
on U.PersonID = P.PersonID;
GO
/****** Object:  Table [dbo].[DetainedLicenses]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetainedLicenses](
	[DetainID] [int] IDENTITY(1,1) NOT NULL,
	[LicenseID] [int] NOT NULL,
	[DetainDate] [smalldatetime] NOT NULL,
	[FineFees] [decimal](18, 2) NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
	[IsReleased] [bit] NOT NULL,
	[ReleaseDate] [smalldatetime] NULL,
	[ReleasedByUserID] [int] NULL,
	[ReleaseApplicationID] [int] NULL,
 CONSTRAINT [PK_DetainedLicenses] PRIMARY KEY CLUSTERED 
(
	[DetainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Licenses]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Licenses](
	[LicenseID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[DriverID] [int] NOT NULL,
	[LicenseClass] [int] NOT NULL,
	[IssueDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[Notes] [nvarchar](500) NULL,
	[PaidFees] [decimal](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IssueReason] [tinyint] NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
 CONSTRAINT [PK_Licenses] PRIMARY KEY CLUSTERED 
(
	[LicenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Drivers]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drivers](
	[DriverID] [int] IDENTITY(1,1) NOT NULL,
	[PersonID] [int] NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Drivers_1] PRIMARY KEY CLUSTERED 
(
	[DriverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DetainedLicenses_View]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DetainedLicenses_View]
AS
SELECT        dbo.DetainedLicenses.DetainID, dbo.DetainedLicenses.LicenseID, dbo.DetainedLicenses.DetainDate, dbo.DetainedLicenses.IsReleased, dbo.DetainedLicenses.FineFees, dbo.DetainedLicenses.ReleaseDate, 
                         dbo.People.NationalNo, dbo.People.FirstName + ' ' + dbo.People.SecondName + ' ' + ISNULL(dbo.People.ThirdName, ' ') + ' ' + dbo.People.LastName AS FullName, dbo.DetainedLicenses.ReleaseApplicationID
FROM            dbo.People INNER JOIN
                         dbo.Drivers ON dbo.People.PersonID = dbo.Drivers.PersonID INNER JOIN
                         dbo.Licenses ON dbo.Drivers.DriverID = dbo.Licenses.DriverID RIGHT OUTER JOIN
                         dbo.DetainedLicenses ON dbo.Licenses.LicenseID = dbo.DetainedLicenses.LicenseID
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicantPersonID] [int] NOT NULL,
	[ApplicationDate] [datetime] NOT NULL,
	[ApplicationTypeID] [int] NOT NULL,
	[ApplicationStatus] [tinyint] NOT NULL,
	[LastStatusDate] [datetime] NOT NULL,
	[PaidFees] [decimal](18, 2) NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocalDrivingLicenseApplications]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalDrivingLicenseApplications](
	[LocalDrivingLicenseApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[LicenseClassID] [int] NOT NULL,
 CONSTRAINT [PK_DrivingLicsenseApplications] PRIMARY KEY CLUSTERED 
(
	[LocalDrivingLicenseApplicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LocalDrivingLicenseFullApplications_View]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LocalDrivingLicenseFullApplications_View]
AS
SELECT        dbo.Applications.ApplicationID, dbo.Applications.ApplicantPersonID, dbo.Applications.ApplicationDate, dbo.Applications.ApplicationTypeID, dbo.Applications.ApplicationStatus, dbo.Applications.LastStatusDate, 
                         dbo.Applications.PaidFees, dbo.Applications.CreatedByUserID, dbo.LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID, dbo.LocalDrivingLicenseApplications.LicenseClassID
FROM            dbo.Applications INNER JOIN
                         dbo.LocalDrivingLicenseApplications ON dbo.Applications.ApplicationID = dbo.LocalDrivingLicenseApplications.ApplicationID
GO
/****** Object:  Table [dbo].[TestAppointments]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestAppointments](
	[TestAppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[TestTypeID] [int] NOT NULL,
	[LocalDrivingLicenseApplicationID] [int] NOT NULL,
	[AppointmentDate] [smalldatetime] NOT NULL,
	[PaidFees] [decimal](18, 2) NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
	[IsLocked] [bit] NOT NULL,
	[RetakeTestApplicationID] [int] NULL,
 CONSTRAINT [PK_TestAppointments] PRIMARY KEY CLUSTERED 
(
	[TestAppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tests]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tests](
	[TestID] [int] IDENTITY(1,1) NOT NULL,
	[TestAppointmentID] [int] NOT NULL,
	[TestResult] [bit] NOT NULL,
	[Notes] [nvarchar](500) NULL,
	[CreatedByUserID] [int] NOT NULL,
 CONSTRAINT [PK_Tests] PRIMARY KEY CLUSTERED 
(
	[TestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LicenseClasses]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LicenseClasses](
	[LicenseClassID] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [nvarchar](50) NOT NULL,
	[ClassDescription] [nvarchar](500) NOT NULL,
	[MinimumAllowedAge] [smallint] NOT NULL,
	[DefaultValidityLength] [smallint] NOT NULL,
	[ClassFees] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_LicenseClasses] PRIMARY KEY CLUSTERED 
(
	[LicenseClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LocalDrivingLicenseApplications_View]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[LocalDrivingLicenseApplications_View]
AS
SELECT 
    LDLA.LocalDrivingLicenseApplicationID, 
    LC.ClassName, 
    P.NationalNo, 
    -- استخدام CONCAT_WS للدمج التلقائي وتجنب مشاكل القيم الفارغة NULL
    CONCAT_WS(' ', P.FirstName, P.SecondName, P.ThirdName, P.LastName) AS FullName, 
    A.ApplicationDate,
    
    -- حساب عدد الفحوصات المقبولة باستخدام LEFT JOIN و COUNT بدلاً من Subquery
    COUNT(T.TestID) AS PassedTestCount, 
    
    -- تحويل الحالة باستخدام CASE
    CASE A.ApplicationStatus 
        WHEN 1 THEN 'New' 
        WHEN 2 THEN 'Cancelled' 
        WHEN 3 THEN 'Completed' 
    END AS Status

FROM dbo.LocalDrivingLicenseApplications AS LDLA
INNER JOIN dbo.Applications AS A 
    ON LDLA.ApplicationID = A.ApplicationID
INNER JOIN dbo.LicenseClasses AS LC 
    ON LDLA.LicenseClassID = LC.LicenseClassID
INNER JOIN dbo.People AS P 
    ON A.ApplicantPersonID = P.PersonID

-- ربط جدول المواعيد والاختبارات مباشرة في الاستعلام الرئيسي
LEFT JOIN dbo.TestAppointments AS TA 
    ON LDLA.LocalDrivingLicenseApplicationID = TA.LocalDrivingLicenseApplicationID
LEFT JOIN dbo.Tests AS T 
    ON TA.TestAppointmentID = T.TestAppointmentID 
   AND T.TestResult = 1

GROUP BY 
    LDLA.LocalDrivingLicenseApplicationID, 
    LC.ClassName, 
    P.NationalNo, 
    P.FirstName, P.SecondName, P.ThirdName, P.LastName,
    A.ApplicationDate,
    A.ApplicationStatus;
GO
/****** Object:  Table [dbo].[TestTypes]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTypes](
	[TestTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TestTypeTitle] [nvarchar](100) NOT NULL,
	[TestTypeDescription] [nvarchar](500) NOT NULL,
	[TestTypeFees] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_TestTypes] PRIMARY KEY CLUSTERED 
(
	[TestTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TestAppointments_View]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TestAppointments_View]
AS
SELECT        dbo.TestAppointments.TestAppointmentID, dbo.TestAppointments.LocalDrivingLicenseApplicationID, dbo.TestTypes.TestTypeTitle, dbo.LicenseClasses.ClassName, dbo.TestAppointments.AppointmentDate, 
                         dbo.TestAppointments.PaidFees, dbo.People.FirstName + ' ' + dbo.People.SecondName + ' ' + ISNULL(dbo.People.ThirdName, '') + ' ' + dbo.People.LastName AS FullName, dbo.TestAppointments.IsLocked
FROM            dbo.TestAppointments INNER JOIN
                         dbo.TestTypes ON dbo.TestAppointments.TestTypeID = dbo.TestTypes.TestTypeID INNER JOIN
                         dbo.LocalDrivingLicenseApplications ON dbo.TestAppointments.LocalDrivingLicenseApplicationID = dbo.LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID INNER JOIN
                         dbo.Applications ON dbo.LocalDrivingLicenseApplications.ApplicationID = dbo.Applications.ApplicationID INNER JOIN
                         dbo.People ON dbo.Applications.ApplicantPersonID = dbo.People.PersonID INNER JOIN
                         dbo.LicenseClasses ON dbo.LocalDrivingLicenseApplications.LicenseClassID = dbo.LicenseClasses.LicenseClassID
GO
/****** Object:  View [dbo].[Drivers_View]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Drivers_View]
AS
SELECT        dbo.Drivers.DriverID, dbo.Drivers.PersonID, dbo.People.NationalNo, dbo.People.FirstName + ' ' + dbo.People.SecondName + ' ' + ISNULL(dbo.People.ThirdName, '') + ' ' + dbo.People.LastName AS FullName, 
                         dbo.Drivers.CreatedDate,
                             (SELECT        COUNT(LicenseID) AS NumberOfActiveLicenses
                               FROM            dbo.Licenses
                               WHERE        (IsActive = 1) AND (DriverID = dbo.Drivers.DriverID)) AS NumberOfActiveLicenses
FROM            dbo.Drivers INNER JOIN
                         dbo.People ON dbo.Drivers.PersonID = dbo.People.PersonID
GO
/****** Object:  Table [dbo].[ApplicationTypes]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationTypes](
	[ApplicationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationTypeTitle] [nvarchar](150) NOT NULL,
	[ApplicationFees] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_ApplicationTypes] PRIMARY KEY CLUSTERED 
(
	[ApplicationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Countrie__10D160BFDBD6933F] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InternationalLicenses]    Script Date: 7/29/2026 3:16:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InternationalLicenses](
	[InternationalLicenseID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[DriverID] [int] NOT NULL,
	[IssuedUsingLocalLicenseID] [int] NOT NULL,
	[IssueDate] [smalldatetime] NOT NULL,
	[ExpirationDate] [smalldatetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
 CONSTRAINT [PK_InternationalLicenses] PRIMARY KEY CLUSTERED 
(
	[InternationalLicenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Applications] ON 

INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (110, 1, CAST(N'2023-10-07T10:46:17.370' AS DateTime), 1, 3, CAST(N'2023-10-07T11:05:08.973' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (111, 1, CAST(N'2023-10-07T10:59:57.793' AS DateTime), 7, 3, CAST(N'2023-10-07T10:59:57.793' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (112, 1, CAST(N'2023-10-07T11:03:54.203' AS DateTime), 7, 3, CAST(N'2023-10-07T11:03:54.203' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (113, 1025, CAST(N'2023-10-07T11:07:05.810' AS DateTime), 1, 3, CAST(N'2023-10-07T11:08:12.973' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (114, 1025, CAST(N'2023-10-07T11:08:39.550' AS DateTime), 6, 3, CAST(N'2023-10-07T11:08:39.550' AS DateTime), CAST(50.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (115, 1025, CAST(N'2023-10-07T11:16:55.240' AS DateTime), 1, 1, CAST(N'2023-10-07T11:16:55.240' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (116, 1025, CAST(N'2023-10-07T11:17:19.480' AS DateTime), 7, 3, CAST(N'2023-10-07T11:17:19.480' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (117, 1025, CAST(N'2023-10-07T11:31:43.170' AS DateTime), 7, 3, CAST(N'2023-10-07T11:31:43.170' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (118, 1025, CAST(N'2023-10-07T11:39:05.807' AS DateTime), 7, 3, CAST(N'2023-10-07T11:39:05.807' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (119, 1029, CAST(N'2023-10-09T21:22:40.437' AS DateTime), 1, 2, CAST(N'2023-10-09T21:25:49.577' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (121, 1029, CAST(N'2023-10-09T21:26:21.627' AS DateTime), 1, 3, CAST(N'2023-10-09T21:54:15.067' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (123, 1029, CAST(N'2023-10-09T21:48:05.250' AS DateTime), 7, 3, CAST(N'2023-10-09T21:48:05.250' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (124, 1029, CAST(N'2023-10-09T21:52:45.667' AS DateTime), 7, 3, CAST(N'2023-10-09T21:52:45.667' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (125, 1029, CAST(N'2023-10-09T21:53:10.573' AS DateTime), 7, 3, CAST(N'2023-10-09T21:53:10.573' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (126, 1029, CAST(N'2023-10-09T22:26:05.903' AS DateTime), 6, 3, CAST(N'2023-10-09T22:26:05.903' AS DateTime), CAST(51.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (127, 1029, CAST(N'2023-10-10T08:43:53.223' AS DateTime), 2, 3, CAST(N'2023-10-10T08:43:53.223' AS DateTime), CAST(7.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (128, 1029, CAST(N'2023-10-10T09:02:34.023' AS DateTime), 4, 3, CAST(N'2023-10-10T09:02:34.023' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (129, 1029, CAST(N'2023-10-10T09:05:13.233' AS DateTime), 3, 3, CAST(N'2023-10-10T09:05:13.233' AS DateTime), CAST(10.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (130, 1029, CAST(N'2023-10-10T09:19:58.013' AS DateTime), 5, 3, CAST(N'2023-10-10T09:19:58.013' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (131, 1029, CAST(N'2023-10-10T09:23:02.750' AS DateTime), 5, 3, CAST(N'2023-10-10T09:23:02.750' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (132, 1025, CAST(N'2025-11-03T07:16:40.417' AS DateTime), 1, 1, CAST(N'2025-11-03T07:16:40.417' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (135, 1029, CAST(N'2025-11-04T10:28:55.427' AS DateTime), 1, 1, CAST(N'2025-11-04T10:28:55.427' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1132, 1030, CAST(N'2025-12-22T22:01:42.733' AS DateTime), 1, 3, CAST(N'2025-12-22T22:08:58.753' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1133, 1030, CAST(N'2025-12-22T22:06:46.913' AS DateTime), 7, 3, CAST(N'2025-12-22T22:06:46.913' AS DateTime), CAST(5.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1134, 1030, CAST(N'2025-12-22T22:13:50.287' AS DateTime), 3, 3, CAST(N'2025-12-22T22:13:50.287' AS DateTime), CAST(10.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1135, 1030, CAST(N'2025-12-22T22:17:53.810' AS DateTime), 5, 3, CAST(N'2025-12-22T22:17:53.810' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1136, 1, CAST(N'2026-07-25T12:29:51.043' AS DateTime), 1, 1, CAST(N'2026-07-25T12:29:51.600' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1137, 1, CAST(N'2026-07-25T12:30:56.527' AS DateTime), 1, 1, CAST(N'2026-07-25T12:30:56.527' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1138, 1, CAST(N'2026-07-25T12:31:30.107' AS DateTime), 1, 1, CAST(N'2026-07-25T12:31:30.107' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1139, 1, CAST(N'2026-07-25T12:33:55.797' AS DateTime), 1, 1, CAST(N'2026-07-25T12:33:55.797' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1140, 1, CAST(N'2026-07-25T12:34:10.663' AS DateTime), 1, 1, CAST(N'2026-07-25T12:34:10.663' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1141, 1, CAST(N'2026-07-25T12:36:28.550' AS DateTime), 1, 1, CAST(N'2026-07-25T12:36:28.550' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1142, 1, CAST(N'2026-07-25T12:37:22.020' AS DateTime), 1, 1, CAST(N'2026-07-25T12:37:22.020' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1143, 1, CAST(N'2026-07-25T13:16:02.993' AS DateTime), 1, 1, CAST(N'2026-07-25T13:16:02.993' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1144, 1, CAST(N'2026-07-25T13:17:29.080' AS DateTime), 1, 1, CAST(N'2026-07-25T13:17:29.080' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1145, 1, CAST(N'2026-07-25T13:18:53.767' AS DateTime), 1, 1, CAST(N'2026-07-25T13:18:53.767' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1146, 1200, CAST(N'2026-07-25T13:20:22.413' AS DateTime), 1, 1, CAST(N'2026-07-25T13:20:22.413' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1147, 1220, CAST(N'2026-07-25T13:22:14.980' AS DateTime), 1, 1, CAST(N'2026-07-25T13:22:17.290' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1148, 1234, CAST(N'2026-07-25T13:35:26.577' AS DateTime), 1, 1, CAST(N'2026-07-25T13:35:27.073' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1149, 1332, CAST(N'2026-07-27T10:40:59.507' AS DateTime), 1, 1, CAST(N'2026-07-27T10:40:59.507' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Applications] ([ApplicationID], [ApplicantPersonID], [ApplicationDate], [ApplicationTypeID], [ApplicationStatus], [LastStatusDate], [PaidFees], [CreatedByUserID]) VALUES (1150, 1296, CAST(N'2026-07-27T11:44:17.527' AS DateTime), 1, 1, CAST(N'2026-07-27T11:44:23.383' AS DateTime), CAST(15.00 AS Decimal(18, 2)), 15)
SET IDENTITY_INSERT [dbo].[Applications] OFF
GO
SET IDENTITY_INSERT [dbo].[ApplicationTypes] ON 

INSERT [dbo].[ApplicationTypes] ([ApplicationTypeID], [ApplicationTypeTitle], [ApplicationFees]) VALUES (1, N'New Local Driving License Service', CAST(15.00 AS Decimal(18, 2)))
INSERT [dbo].[ApplicationTypes] ([ApplicationTypeID], [ApplicationTypeTitle], [ApplicationFees]) VALUES (2, N'Renew Driving License Service', CAST(7.00 AS Decimal(18, 2)))
INSERT [dbo].[ApplicationTypes] ([ApplicationTypeID], [ApplicationTypeTitle], [ApplicationFees]) VALUES (3, N'Replacement for a Lost Driving License', CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[ApplicationTypes] ([ApplicationTypeID], [ApplicationTypeTitle], [ApplicationFees]) VALUES (4, N'Replacement for a Damaged Driving License', CAST(5.00 AS Decimal(18, 2)))
INSERT [dbo].[ApplicationTypes] ([ApplicationTypeID], [ApplicationTypeTitle], [ApplicationFees]) VALUES (5, N'Release Detained Driving Licsense', CAST(15.00 AS Decimal(18, 2)))
INSERT [dbo].[ApplicationTypes] ([ApplicationTypeID], [ApplicationTypeTitle], [ApplicationFees]) VALUES (6, N'New International License', CAST(51.00 AS Decimal(18, 2)))
INSERT [dbo].[ApplicationTypes] ([ApplicationTypeID], [ApplicationTypeTitle], [ApplicationFees]) VALUES (7, N'Retake Test', CAST(5.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[ApplicationTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (1, N'Afghanistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (2, N'Albania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (3, N'Algeria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (4, N'Andorra')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (5, N'Angola')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (6, N'Antigua and Barbuda')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (7, N'Argentina')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (8, N'Armenia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (9, N'Austria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (10, N'Azerbaijan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (11, N'Bahrain')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (12, N'Bangladesh')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (13, N'Barbados')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (14, N'Belarus')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (15, N'Belgium')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (16, N'Belize')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (17, N'Benin')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (18, N'Bhutan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (19, N'Bolivia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (20, N'Bosnia and Herzegovina')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (21, N'Botswana')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (22, N'Brazil')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (23, N'Brunei')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (24, N'Bulgaria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (25, N'Burkina Faso')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (26, N'Burundi')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (27, N'Cabo Verde')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (28, N'Cambodia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (29, N'Cameroon')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (30, N'Canada')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (31, N'Central African Republic')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (32, N'Chad')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (33, N'Channel Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (34, N'Chile')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (35, N'China')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (36, N'Colombia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (37, N'Comoros')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (38, N'Congo')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (39, N'Costa Rica')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (40, N'Côte d''Ivoire')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (41, N'Croatia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (42, N'Cuba')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (43, N'Cyprus')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (44, N'Czech Republic')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (45, N'Denmark')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (46, N'Djibouti')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (47, N'Dominica')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (48, N'Dominican Republic')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (49, N'DR Congo')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (50, N'Ecuador')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (51, N'Egypt')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (52, N'El Salvador')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (53, N'Equatorial Guinea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (54, N'Eritrea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (55, N'Estonia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (56, N'Eswatini')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (57, N'Ethiopia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (58, N'Faeroe Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (59, N'Finland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (60, N'France')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (61, N'French Guiana')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (62, N'Gabon')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (63, N'Gambia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (64, N'Georgia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (65, N'Germany')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (66, N'Ghana')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (67, N'Gibraltar')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (68, N'Greece')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (69, N'Grenada')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (70, N'Guatemala')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (71, N'Guinea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (72, N'Guinea-Bissau')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (73, N'Guyana')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (74, N'Haiti')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (75, N'Holy See')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (76, N'Honduras')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (77, N'Hong Kong')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (78, N'Hungary')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (79, N'Iceland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (80, N'India')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (81, N'Indonesia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (82, N'Iran')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (83, N'Iraq')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (84, N'Ireland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (85, N'Isle of Man')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (86, N'Israel')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (87, N'Italy')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (88, N'Jamaica')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (89, N'Japan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (90, N'Jordan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (91, N'Kazakhstan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (92, N'Kenya')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (93, N'Kuwait')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (94, N'Kyrgyzstan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (95, N'Laos')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (96, N'Latvia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (97, N'Lebanon')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (98, N'Lesotho')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (99, N'Liberia')
GO
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (100, N'Libya')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (101, N'Liechtenstein')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (102, N'Lithuania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (103, N'Luxembourg')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (104, N'Macao')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (105, N'Madagascar')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (106, N'Malawi')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (107, N'Malaysia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (108, N'Maldives')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (109, N'Mali')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (110, N'Malta')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (111, N'Mauritania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (112, N'Mauritius')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (113, N'Mayotte')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (114, N'Mexico')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (115, N'Moldova')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (116, N'Monaco')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (117, N'Mongolia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (118, N'Montenegro')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (119, N'Morocco')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (120, N'Mozambique')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (121, N'Myanmar')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (122, N'Namibia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (123, N'Nepal')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (124, N'Netherlands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (125, N'Nicaragua')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (126, N'Niger')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (127, N'Nigeria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (128, N'North Korea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (129, N'North Macedonia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (130, N'Norway')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (131, N'Oman')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (132, N'Pakistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (133, N'Panama')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (134, N'Paraguay')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (135, N'Peru')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (136, N'Philippines')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (137, N'Poland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (138, N'Portugal')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (139, N'Qatar')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (140, N'Réunion')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (141, N'Romania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (142, N'Russia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (143, N'Rwanda')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (144, N'Saint Helena')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (145, N'Saint Kitts and Nevis')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (146, N'Saint Lucia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (147, N'Saint Vincent and the Grenadines')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (148, N'San Marino')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (149, N'Sao Tome & Principe')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (150, N'Saudi Arabia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (151, N'Senegal')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (152, N'Serbia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (153, N'Seychelles')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (154, N'Sierra Leone')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (155, N'Singapore')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (156, N'Slovakia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (157, N'Slovenia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (158, N'Somalia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (159, N'South Africa')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (160, N'South Korea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (161, N'South Sudan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (162, N'Spain')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (163, N'Sri Lanka')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (164, N'State of Palestine')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (165, N'Sudan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (166, N'Suriname')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (167, N'Sweden')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (168, N'Switzerland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (169, N'Syria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (170, N'Taiwan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (171, N'Tajikistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (172, N'Tanzania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (173, N'Thailand')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (174, N'The Bahamas')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (175, N'Timor-Leste')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (176, N'Togo')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (177, N'Trinidad and Tobago')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (178, N'Tunisia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (179, N'Turkey')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (180, N'Turkmenistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (181, N'Uganda')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (182, N'Ukraine')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (183, N'United Arab Emirates')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (184, N'United Kingdom')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (185, N'United States')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (186, N'Uruguay')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (187, N'Uzbekistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (188, N'Venezuela')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (189, N'Vietnam')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (190, N'Western Sahara')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (191, N'Yemen')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (192, N'Zambia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (193, N'Zimbabwe')
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[DetainedLicenses] ON 

INSERT [dbo].[DetainedLicenses] ([DetainID], [LicenseID], [DetainDate], [FineFees], [CreatedByUserID], [IsReleased], [ReleaseDate], [ReleasedByUserID], [ReleaseApplicationID]) VALUES (12, 27, CAST(N'2023-10-10T09:17:00' AS SmallDateTime), CAST(150.00 AS Decimal(18, 2)), 1, 1, CAST(N'2023-10-10T09:20:00' AS SmallDateTime), NULL, 130)
INSERT [dbo].[DetainedLicenses] ([DetainID], [LicenseID], [DetainDate], [FineFees], [CreatedByUserID], [IsReleased], [ReleaseDate], [ReleasedByUserID], [ReleaseApplicationID]) VALUES (13, 27, CAST(N'2023-10-10T09:22:00' AS SmallDateTime), CAST(200.00 AS Decimal(18, 2)), 1, 1, CAST(N'2023-10-10T09:23:00' AS SmallDateTime), NULL, 131)
INSERT [dbo].[DetainedLicenses] ([DetainID], [LicenseID], [DetainDate], [FineFees], [CreatedByUserID], [IsReleased], [ReleaseDate], [ReleasedByUserID], [ReleaseApplicationID]) VALUES (14, 27, CAST(N'2023-10-10T09:23:00' AS SmallDateTime), CAST(300.00 AS Decimal(18, 2)), 1, 0, NULL, NULL, NULL)
INSERT [dbo].[DetainedLicenses] ([DetainID], [LicenseID], [DetainDate], [FineFees], [CreatedByUserID], [IsReleased], [ReleaseDate], [ReleasedByUserID], [ReleaseApplicationID]) VALUES (15, 29, CAST(N'2025-12-22T22:17:00' AS SmallDateTime), CAST(20.00 AS Decimal(18, 2)), 1, 1, CAST(N'2025-12-22T22:18:00' AS SmallDateTime), NULL, 1135)
SET IDENTITY_INSERT [dbo].[DetainedLicenses] OFF
GO
SET IDENTITY_INSERT [dbo].[Drivers] ON 

INSERT [dbo].[Drivers] ([DriverID], [PersonID], [CreatedByUserID], [CreatedDate]) VALUES (8, 1, 1, CAST(N'2023-09-24T03:26:00' AS SmallDateTime))
INSERT [dbo].[Drivers] ([DriverID], [PersonID], [CreatedByUserID], [CreatedDate]) VALUES (9, 1025, 1, CAST(N'2023-09-24T13:53:00' AS SmallDateTime))
INSERT [dbo].[Drivers] ([DriverID], [PersonID], [CreatedByUserID], [CreatedDate]) VALUES (10, 1023, 1, CAST(N'2023-10-01T19:27:00' AS SmallDateTime))
INSERT [dbo].[Drivers] ([DriverID], [PersonID], [CreatedByUserID], [CreatedDate]) VALUES (11, 1029, 1, CAST(N'2023-10-09T21:54:00' AS SmallDateTime))
INSERT [dbo].[Drivers] ([DriverID], [PersonID], [CreatedByUserID], [CreatedDate]) VALUES (12, 1030, 1, CAST(N'2025-12-22T22:09:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[Drivers] OFF
GO
SET IDENTITY_INSERT [dbo].[InternationalLicenses] ON 

INSERT [dbo].[InternationalLicenses] ([InternationalLicenseID], [ApplicationID], [DriverID], [IssuedUsingLocalLicenseID], [IssueDate], [ExpirationDate], [IsActive], [CreatedByUserID]) VALUES (16, 114, 9, 24, CAST(N'2023-10-07T11:09:00' AS SmallDateTime), CAST(N'2024-10-07T11:09:00' AS SmallDateTime), 1, 1)
INSERT [dbo].[InternationalLicenses] ([InternationalLicenseID], [ApplicationID], [DriverID], [IssuedUsingLocalLicenseID], [IssueDate], [ExpirationDate], [IsActive], [CreatedByUserID]) VALUES (17, 126, 11, 25, CAST(N'2023-10-09T22:26:00' AS SmallDateTime), CAST(N'2024-10-09T22:26:00' AS SmallDateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[InternationalLicenses] OFF
GO
SET IDENTITY_INSERT [dbo].[LicenseClasses] ON 

INSERT [dbo].[LicenseClasses] ([LicenseClassID], [ClassName], [ClassDescription], [MinimumAllowedAge], [DefaultValidityLength], [ClassFees]) VALUES (1, N'Class 1 - Small Motorcycle', N'It allows the driver to drive small motorcycles, It is suitable for motorcycles with small capacity and limited power.', 18, 5, CAST(15.00 AS Decimal(18, 2)))
INSERT [dbo].[LicenseClasses] ([LicenseClassID], [ClassName], [ClassDescription], [MinimumAllowedAge], [DefaultValidityLength], [ClassFees]) VALUES (2, N'Class 2 - Heavy Motorcycle License', N'Heavy Motorcycle License (Large Motorcycle License)', 21, 5, CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[LicenseClasses] ([LicenseClassID], [ClassName], [ClassDescription], [MinimumAllowedAge], [DefaultValidityLength], [ClassFees]) VALUES (3, N'Class 3 - Ordinary driving license', N'Ordinary driving license (car licence)', 18, 10, CAST(20.00 AS Decimal(18, 2)))
INSERT [dbo].[LicenseClasses] ([LicenseClassID], [ClassName], [ClassDescription], [MinimumAllowedAge], [DefaultValidityLength], [ClassFees]) VALUES (4, N'Class 4 - Commercial', N'Commercial driving license (taxi/limousine)', 21, 10, CAST(200.00 AS Decimal(18, 2)))
INSERT [dbo].[LicenseClasses] ([LicenseClassID], [ClassName], [ClassDescription], [MinimumAllowedAge], [DefaultValidityLength], [ClassFees]) VALUES (5, N'Class 5 - Agricultural', N'Agricultural and work vehicles used in farming or construction, (tractors / tillage machinery)', 21, 10, CAST(50.00 AS Decimal(18, 2)))
INSERT [dbo].[LicenseClasses] ([LicenseClassID], [ClassName], [ClassDescription], [MinimumAllowedAge], [DefaultValidityLength], [ClassFees]) VALUES (6, N'Class 6 - Small and medium bus', N'Small and medium bus license', 21, 10, CAST(250.00 AS Decimal(18, 2)))
INSERT [dbo].[LicenseClasses] ([LicenseClassID], [ClassName], [ClassDescription], [MinimumAllowedAge], [DefaultValidityLength], [ClassFees]) VALUES (7, N'Class 7 - Truck and heavy vehicle', N'Truck and heavy vehicle license', 21, 10, CAST(300.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[LicenseClasses] OFF
GO
SET IDENTITY_INSERT [dbo].[Licenses] ON 

INSERT [dbo].[Licenses] ([LicenseID], [ApplicationID], [DriverID], [LicenseClass], [IssueDate], [ExpirationDate], [Notes], [PaidFees], [IsActive], [IssueReason], [CreatedByUserID]) VALUES (23, 110, 8, 1, CAST(N'2023-10-07T11:05:08.970' AS DateTime), CAST(N'2028-10-07T11:05:08.970' AS DateTime), NULL, CAST(15.00 AS Decimal(18, 2)), 1, 1, 1)
INSERT [dbo].[Licenses] ([LicenseID], [ApplicationID], [DriverID], [LicenseClass], [IssueDate], [ExpirationDate], [Notes], [PaidFees], [IsActive], [IssueReason], [CreatedByUserID]) VALUES (24, 113, 9, 3, CAST(N'2023-10-07T11:08:12.973' AS DateTime), CAST(N'2033-10-07T11:08:12.973' AS DateTime), NULL, CAST(20.00 AS Decimal(18, 2)), 1, 1, 1)
INSERT [dbo].[Licenses] ([LicenseID], [ApplicationID], [DriverID], [LicenseClass], [IssueDate], [ExpirationDate], [Notes], [PaidFees], [IsActive], [IssueReason], [CreatedByUserID]) VALUES (25, 121, 11, 3, CAST(N'2021-10-09T21:54:15.063' AS DateTime), CAST(N'2022-10-09T21:54:15.063' AS DateTime), NULL, CAST(20.00 AS Decimal(18, 2)), 0, 1, 1)
INSERT [dbo].[Licenses] ([LicenseID], [ApplicationID], [DriverID], [LicenseClass], [IssueDate], [ExpirationDate], [Notes], [PaidFees], [IsActive], [IssueReason], [CreatedByUserID]) VALUES (26, 127, 11, 3, CAST(N'2023-10-10T08:43:53.227' AS DateTime), CAST(N'2033-10-10T08:43:53.227' AS DateTime), NULL, CAST(20.00 AS Decimal(18, 2)), 0, 2, 1)
INSERT [dbo].[Licenses] ([LicenseID], [ApplicationID], [DriverID], [LicenseClass], [IssueDate], [ExpirationDate], [Notes], [PaidFees], [IsActive], [IssueReason], [CreatedByUserID]) VALUES (27, 128, 11, 3, CAST(N'2023-10-10T09:02:34.040' AS DateTime), CAST(N'2033-10-10T08:43:53.227' AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), 0, 3, 1)
INSERT [dbo].[Licenses] ([LicenseID], [ApplicationID], [DriverID], [LicenseClass], [IssueDate], [ExpirationDate], [Notes], [PaidFees], [IsActive], [IssueReason], [CreatedByUserID]) VALUES (28, 129, 11, 3, CAST(N'2023-10-10T09:05:13.243' AS DateTime), CAST(N'2033-10-10T08:43:53.227' AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), 1, 4, 1)
INSERT [dbo].[Licenses] ([LicenseID], [ApplicationID], [DriverID], [LicenseClass], [IssueDate], [ExpirationDate], [Notes], [PaidFees], [IsActive], [IssueReason], [CreatedByUserID]) VALUES (29, 1132, 12, 3, CAST(N'2025-12-22T22:08:58.737' AS DateTime), CAST(N'2035-12-22T22:08:58.737' AS DateTime), NULL, CAST(20.00 AS Decimal(18, 2)), 0, 1, 1)
INSERT [dbo].[Licenses] ([LicenseID], [ApplicationID], [DriverID], [LicenseClass], [IssueDate], [ExpirationDate], [Notes], [PaidFees], [IsActive], [IssueReason], [CreatedByUserID]) VALUES (30, 1134, 12, 3, CAST(N'2025-12-22T22:13:50.300' AS DateTime), CAST(N'2035-12-22T22:08:58.737' AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), 1, 4, 1)
SET IDENTITY_INSERT [dbo].[Licenses] OFF
GO
SET IDENTITY_INSERT [dbo].[LocalDrivingLicenseApplications] ON 

INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (36, 110, 1)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (37, 113, 3)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (38, 115, 2)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (39, 119, 3)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (41, 121, 3)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (43, 132, 6)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (44, 135, 4)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1043, 1132, 3)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1044, 110, 1)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1045, 110, 1)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1046, 110, 3)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1047, 110, 4)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1048, 110, 1)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1049, 110, 1)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1050, 110, 3)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1051, 110, 2)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1052, 110, 3)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1053, 110, 3)
INSERT [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID], [ApplicationID], [LicenseClassID]) VALUES (1054, 110, 3)
SET IDENTITY_INSERT [dbo].[LocalDrivingLicenseApplications] OFF
GO
SET IDENTITY_INSERT [dbo].[People] ON 

INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1, N'N1', N'Mohammed1', N'Saqer', N'Mussa', N'Abu-Hadhoud', CAST(N'1977-11-06T00:00:00.000' AS DateTime), 0, N'Amman Jubaiha1', N'999876', N'Msaqer@gmail.com', 3, N'C:\DVLD-Project-Personal-Image\c780e4ff-7e2b-45b9-84a4-57a442e99578.png')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1023, N'N2', N'Ahmed', N'Mohammed', N'Saqer', N'Abu-Hadhoud', CAST(N'2005-06-01T20:13:44.000' AS DateTime), 0, N'Amman 20091-Street', N'07992992', N'Omar@g.com', 3, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1024, N'N3', N'Hamzeh', N'Mohammed', N'Saqer', N'Abu-Hadhoud', CAST(N'2005-09-23T21:05:06.873' AS DateTime), 0, N'Amman', N'234566', N'H@H.com', 3, N'')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1025, N'n4', N'Khalid', N'ALi', N'Maher', N'hamed', CAST(N'2005-09-24T13:32:14.183' AS DateTime), 0, N'Amman - Uni street 8938', N'566543', N'Kh@k.com', 3, N'C:\DVLD-Project-Personal-Image\3becea91-4509-4c72-851e-a8214a0a859e.png')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1027, N'uu', N'u', N'uu', N'uu', N'uu', CAST(N'2005-10-09T14:14:07.923' AS DateTime), 0, N'ggg', N'dfgdfg', N'', 3, N'')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1028, N'N5', N'salima', N'Khalil', N'Sami', N'Ahmed', CAST(N'2005-10-09T19:30:28.893' AS DateTime), 1, N'Amman 83883', N'234234', N'', 3, N'')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1029, N'N10', N'Mahmoud', N'Omar', N'Ali', N'Almajed', CAST(N'2005-10-09T21:07:38.747' AS DateTime), 0, N'Amman - 209928 -1', N'0729928822', N'M@Gmail.com', 3, N'')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1030, N'12334', N'Salah', N'ahmed', NULL, N'Boukermouche', CAST(N'2007-12-22T21:54:18.000' AS DateTime), 0, N'babasaad', N'5454544', N'salah@gmail.com', 3, N'C:\DVLD-People-Images\41ad1240-72ab-41a0-bc29-073585c077b0.jpg')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1031, N'869358234954579770', N'Yolande', N'Abbot', N'Brendis', N'Haulkham', CAST(N'1924-03-07T00:00:00.000' AS DateTime), 1, N'022 Loeprich Drive', N'606-281-9807', N'bhaulkham0@cmu.edu', 16, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1032, N'793171630610974843', N'Tynan', N'Joleen', N'Priscilla', N'Crosbie', CAST(N'1912-04-19T00:00:00.000' AS DateTime), 0, N'399 Pleasure Avenue', N'649-688-8769', N'pcrosbie1@baidu.com', 164, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1033, N'969403321011366701', N'Ira', N'Kissie', N'Padraig', N'Whayman', CAST(N'1998-05-20T00:00:00.000' AS DateTime), 0, N'9 Elka Street', N'358-141-9471', N'pwhayman2@simplemachines.org', 63, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1034, N'879333479178920280', N'Dita', N'Celinda', N'Wandis', N'Diano', CAST(N'1907-02-23T00:00:00.000' AS DateTime), 0, N'0465 Thompson Terrace', N'421-719-0579', N'wdiano3@mlb.com', 178, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1035, N'433783212980987554', N'Tomkin', N'Gustavo', N'Christal', N'Matfin', CAST(N'1937-08-10T00:00:00.000' AS DateTime), 0, N'7391 Hanson Avenue', N'929-322-9290', N'cmatfin4@statcounter.com', 76, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1036, N'105162330651898603', N'Allsun', N'Vassili', N'Bette', N'Jentin', CAST(N'1921-10-15T00:00:00.000' AS DateTime), 0, N'4 New Castle Pass', N'541-517-4318', N'bjentin5@bloglines.com', 61, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1037, N'456454912447692263', N'Stan', N'Pavlov', N'Englebert', N'Sherr', CAST(N'1955-04-23T00:00:00.000' AS DateTime), 0, N'48 Anthes Pass', N'350-858-5343', N'esherr6@hatena.ne.jp', 144, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1038, N'408762265529687528', N'Wayland', N'Arlen', N'Glenn', N'Brigham', CAST(N'1974-01-03T00:00:00.000' AS DateTime), 0, N'1287 Heath Pass', N'522-534-1211', N'gbrigham7@tumblr.com', 128, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1039, N'930879852969719205', N'Lesley', N'Saul', N'Dal', N'Streeton', CAST(N'2003-01-08T00:00:00.000' AS DateTime), 0, N'74 Mandrake Hill', N'104-684-3060', N'dstreeton8@icio.us', 101, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1040, N'687461284328660787', N'Kathryne', N'Farrand', N'Hastings', N'Douch', CAST(N'1934-12-02T00:00:00.000' AS DateTime), 1, N'51 Stang Parkway', N'240-137-1800', N'hdouch9@bravesites.com', 16, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1041, N'909621264418333551', N'Konstanze', N'Ervin', N'Lorne', N'Schriren', CAST(N'2006-12-05T00:00:00.000' AS DateTime), 0, N'575 Merchant Place', N'725-340-8062', N'lschrirena@uol.com.br', 105, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1042, N'293254747901334163', N'Dannel', N'Briggs', N'Yancy', N'Kinnen', CAST(N'1903-05-25T00:00:00.000' AS DateTime), 0, N'25555 Ohio Hill', N'929-481-7320', N'ykinnenb@51.la', 150, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1043, N'777367402611202333', N'Faina', N'Dodie', N'Roxana', N'Gimert', CAST(N'1912-10-04T00:00:00.000' AS DateTime), 1, N'13263 Logan Terrace', N'932-654-0590', N'rgimertc@home.pl', 24, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1044, N'301936179373385086', N'Brigida', N'Zaneta', N'Bambie', N'McIlhone', CAST(N'1990-11-15T00:00:00.000' AS DateTime), 1, N'77029 Holmberg Terrace', N'927-950-3418', N'bmcilhoned@washingtonpost.com', 80, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1045, N'177405505031926617', N'Michael', N'Kathryne', N'Suzann', N'Sorbie', CAST(N'1983-12-24T00:00:00.000' AS DateTime), 1, N'8881 Fairfield Pass', N'134-722-6560', N'ssorbiee@meetup.com', 19, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1046, N'210017900576484623', N'Gae', N'Kelley', N'Gabe', N'Ceney', CAST(N'1905-04-06T00:00:00.000' AS DateTime), 0, N'8 Hudson Pass', N'564-753-9850', N'gceneyf@artisteer.com', 40, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1047, N'765337598633941176', N'Dotty', N'Deonne', N'Tommie', N'De Vaar', CAST(N'1997-01-23T00:00:00.000' AS DateTime), 1, N'71 Annamark Court', N'698-626-6383', N'tdevaarg@netvibes.com', 45, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1048, N'169552144770856308', N'Christian', N'Gwyneth', N'Romy', N'Simmonite', CAST(N'1991-07-26T00:00:00.000' AS DateTime), 0, N'37955 Superior Lane', N'709-582-6561', N'rsimmonitei@businesswire.com', 122, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1049, N'533241617861043270', N'Michel', N'Costanza', N'Alvie', N'Boulds', CAST(N'2001-07-13T00:00:00.000' AS DateTime), 0, N'04003 Duke Drive', N'429-638-7366', N'abouldsk@arizona.edu', 114, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1050, N'603090293015729953', N'Arlan', N'Florry', N'Susanetta', N'Tremmil', CAST(N'2004-09-11T00:00:00.000' AS DateTime), 0, N'8134 Upham Court', N'878-651-7046', N'stremmill@amazon.co.jp', 137, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1051, N'045616146528245505', N'Dion', N'Donalt', N'Dreddy', N'Dimanche', CAST(N'1921-07-04T00:00:00.000' AS DateTime), 0, N'4 Daystar Road', N'647-587-8496', N'ddimanchem@goodreads.com', 122, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1052, N'961987409111194002', N'Lefty', N'Kippar', N'Burch', N'Simonsen', CAST(N'1996-12-01T00:00:00.000' AS DateTime), 1, N'1 Logan Park', N'473-113-9798', N'bsimonsenn@jimdo.com', 162, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1053, N'073647301221760017', N'Virgil', N'Osbourne', N'Katherina', N'Stirgess', CAST(N'1909-10-30T00:00:00.000' AS DateTime), 0, N'458 Cordelia Place', N'353-628-6750', N'kstirgesso@amazon.de', 88, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1054, N'927638672773795870', N'Rustie', N'Tiphani', N'Lanette', N'Pavinese', CAST(N'1961-03-13T00:00:00.000' AS DateTime), 0, N'257 Forest Run Plaza', N'863-674-2506', N'lpavinesep@usda.gov', 155, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1055, N'774463793896098623', N'Henri', N'Cherilyn', N'Yorke', N'Bosson', CAST(N'1922-01-22T00:00:00.000' AS DateTime), 1, N'767 Fieldstone Terrace', N'132-525-8451', N'ybossonq@e-recht24.de', 25, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1056, N'267370511402836907', N'Elissa', N'Bennie', N'Wolfgang', N'Dart', CAST(N'1951-08-13T00:00:00.000' AS DateTime), 0, N'464 Hayes Hill', N'397-392-3451', N'wdartr@phpbb.com', 21, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1057, N'489438289614319293', N'Sam', N'Vittorio', N'Wallie', N'Mullender', CAST(N'2001-08-18T00:00:00.000' AS DateTime), 1, N'39805 Clarendon Terrace', N'753-607-1469', N'wmullenders@e-recht24.de', 141, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1058, N'800385452466596371', N'Merv', N'Carmine', N'Wye', N'Pidduck', CAST(N'1972-05-25T00:00:00.000' AS DateTime), 0, N'66 Maryland Court', N'653-110-8060', N'wpidduckt@prlog.org', 170, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1059, N'125729381837275716', N'Dorise', N'Tommy', N'Wolfie', N'Yitzhok', CAST(N'1999-04-10T00:00:00.000' AS DateTime), 1, N'67 Waywood Circle', N'641-535-8276', N'wyitzhoku@tuttocitta.it', 150, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1060, N'743073765544146107', N'Sherwood', N'Chariot', N'Lauren', N'McCorkell', CAST(N'1952-10-26T00:00:00.000' AS DateTime), 0, N'0 Shelley Avenue', N'816-209-0682', N'lmccorkellv@un.org', 39, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1061, N'914595198526227101', N'Helaina', N'Junina', N'Faythe', N'Brunone', CAST(N'1968-05-30T00:00:00.000' AS DateTime), 1, N'6 Portage Alley', N'753-139-5021', N'fbrunonew@miitbeian.gov.cn', 73, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1062, N'685549667879231562', N'Al', N'Jeanne', N'Saxe', N'Blacker', CAST(N'1978-01-19T00:00:00.000' AS DateTime), 0, N'282 Maryland Court', N'990-443-4614', N'sblackerx@skype.com', 61, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1063, N'030763617075077889', N'Malia', N'Sherill', N'Tiphani', N'Gohier', CAST(N'1931-04-09T00:00:00.000' AS DateTime), 1, N'85 Lillian Way', N'625-888-8563', N'tgohiery@java.com', 185, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1064, N'610730619309271886', N'Joye', N'Jan', N'Tades', N'Reames', CAST(N'1972-10-17T00:00:00.000' AS DateTime), 1, N'1 Kings Alley', N'459-517-4208', N'treamesz@prnewswire.com', 52, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1065, N'416275231749523229', N'Hewie', N'Blythe', N'Aurie', N'Empleton', CAST(N'1982-11-27T00:00:00.000' AS DateTime), 0, N'23209 Forest Run Parkway', N'576-439-7787', N'aempleton10@cnn.com', 118, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1066, N'405622365162655149', N'Christa', N'Jacquie', N'Glenda', N'Nozzolinii', CAST(N'1958-03-18T00:00:00.000' AS DateTime), 0, N'3 Dwight Street', N'358-229-0946', N'gnozzolinii11@homestead.com', 135, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1067, N'068118147575912080', N'Guinna', N'Sabine', N'Reilly', N'Georgel', CAST(N'1966-01-20T00:00:00.000' AS DateTime), 1, N'84 Magdeline Crossing', N'281-468-2061', N'rgeorgel12@issuu.com', 51, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1068, N'240383583301226451', N'Vincenty', N'Corbett', N'Nehemiah', N'Paulet', CAST(N'1931-12-13T00:00:00.000' AS DateTime), 1, N'54 Esker Avenue', N'745-753-0906', N'npaulet13@topsy.com', 62, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1069, N'222980055989207682', N'Gillie', N'Joelly', N'Layton', N'Stalley', CAST(N'2000-10-26T00:00:00.000' AS DateTime), 1, N'408 Huxley Crossing', N'440-884-3717', N'lstalley14@slideshare.net', 180, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1070, N'627067864804035666', N'Dianna', N'Pet', N'Dyana', N'Windybank', CAST(N'1983-06-05T00:00:00.000' AS DateTime), 1, N'7326 Old Gate Terrace', N'742-705-5458', N'dwindybank15@list-manage.com', 182, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1071, N'939341592265423391', N'Kordula', N'Annabella', N'Nealson', N'Frid', CAST(N'1984-04-05T00:00:00.000' AS DateTime), 1, N'91319 Hintze Circle', N'936-179-7671', N'nfrid16@digg.com', 101, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1072, N'195923243445577418', N'Wyatt', N'Phyllis', N'Rickey', N'McGerraghty', CAST(N'1918-04-30T00:00:00.000' AS DateTime), 0, N'07537 Holy Cross Trail', N'652-191-2433', N'rmcgerraghty17@si.edu', 63, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1073, N'098503286662600216', N'Nathalia', N'Jesus', N'Bryana', N'Elwin', CAST(N'1906-05-29T00:00:00.000' AS DateTime), 1, N'434 Walton Pass', N'208-768-9137', N'belwin18@virginia.edu', 139, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1074, N'096920723697060216', N'Debra', N'Holly', N'Drake', N'Daggett', CAST(N'1977-03-05T00:00:00.000' AS DateTime), 0, N'2800 Buena Vista Point', N'920-529-2835', N'ddaggett19@newyorker.com', 14, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1075, N'225596829652743045', N'Daron', N'Nicola', N'Warren', N'Hutchence', CAST(N'1911-02-28T00:00:00.000' AS DateTime), 0, N'892 Continental Road', N'971-447-2639', N'whutchence1a@google.co.uk', 103, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1076, N'608544139398913199', N'Stevie', N'Casie', N'Aindrea', N'Garden', CAST(N'1948-06-23T00:00:00.000' AS DateTime), 1, N'97707 Rigney Point', N'782-565-8150', N'agarden1b@webmd.com', 134, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1077, N'936196137629538413', N'Astrix', N'Yoshi', N'Deonne', N'Mumbey', CAST(N'1986-11-11T00:00:00.000' AS DateTime), 0, N'50138 Loftsgordon Avenue', N'601-934-8905', N'dmumbey1c@stumbleupon.com', 138, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1078, N'181221576812916151', N'Lorilee', N'Denys', N'Ilise', N'Gilchriest', CAST(N'1900-10-31T00:00:00.000' AS DateTime), 0, N'07189 Carpenter Hill', N'121-476-6462', N'igilchriest1d@theatlantic.com', 152, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1079, N'803595020017339173', N'Mavis', N'Merilee', N'Stanislaus', N'Greenan', CAST(N'1932-04-17T00:00:00.000' AS DateTime), 0, N'1344 Ryan Park', N'289-150-4929', N'sgreenan1e@globo.com', 62, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1080, N'603733202976796713', N'Riannon', N'Erena', N'Baudoin', N'Whitcomb', CAST(N'1933-10-29T00:00:00.000' AS DateTime), 1, N'557 Mosinee Terrace', N'855-859-1716', N'bwhitcomb1f@answers.com', 124, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1081, N'777208163127851166', N'Sheffie', N'Buffy', N'Devora', N'Chue', CAST(N'1928-04-25T00:00:00.000' AS DateTime), 0, N'598 Del Sol Avenue', N'305-968-9269', N'dchue1g@merriam-webster.com', 25, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1082, N'334566368443621153', N'Dickmanson', N'Bancroft', N'Alaija', N'Mingardo', CAST(N'1929-09-03T00:00:00.000' AS DateTime), 1, N'76 Anderson Road', N'515-947-7176', N'amingardo1h@youtu.be', 1, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1083, N'490537144120369054', N'Ursuline', N'Herby', N'Elfie', N'Kielty', CAST(N'1935-03-04T00:00:00.000' AS DateTime), 1, N'251 Fairfield Alley', N'829-971-2229', N'ekielty1i@wisc.edu', 72, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1084, N'933054034075130827', N'Jasper', N'Vidovik', N'Guenna', N'Ivery', CAST(N'1980-04-01T00:00:00.000' AS DateTime), 0, N'40711 Londonderry Hill', N'277-973-3859', N'givery1j@vkontakte.ru', 93, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1085, N'069698222659920142', N'Athene', N'Renault', N'Louisa', N'Domeney', CAST(N'1986-12-18T00:00:00.000' AS DateTime), 0, N'6 Valley Edge Center', N'854-509-5302', N'ldomeney1k@foxnews.com', 58, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1086, N'152471154469173965', N'Hilary', N'Teresa', N'Mariann', N'Boshier', CAST(N'1949-01-15T00:00:00.000' AS DateTime), 1, N'80 Little Fleur Junction', N'202-616-7864', N'mboshier1l@amazon.co.uk', 50, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1087, N'928410733266994903', N'Vonny', N'Nowell', N'Antonino', N'Gommowe', CAST(N'1939-04-30T00:00:00.000' AS DateTime), 0, N'5218 Holy Cross Court', N'902-847-0265', N'agommowe1m@nhs.uk', 100, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1088, N'844045691091480106', N'Trula', N'Maribel', N'Haily', N'McAteer', CAST(N'1994-11-18T00:00:00.000' AS DateTime), 1, N'7 Gerald Lane', N'145-439-6060', N'hmcateer1n@ox.ac.uk', 138, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1089, N'171962252782160091', N'Gerardo', N'Dione', N'Osmund', N'Remmers', CAST(N'1907-05-09T00:00:00.000' AS DateTime), 0, N'62 Evergreen Park', N'840-672-6817', N'oremmers1o@trellian.com', 160, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1090, N'446712479385893255', N'Garrett', N'Benedetto', N'Jud', N'Pezey', CAST(N'1909-07-29T00:00:00.000' AS DateTime), 0, N'56711 Sutteridge Park', N'446-105-5828', N'jpezey1p@ocn.ne.jp', 142, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1091, N'817402311157730616', N'Kailey', N'Isa', N'Lorilyn', N'Espine', CAST(N'1987-03-20T00:00:00.000' AS DateTime), 1, N'477 Ridgeview Park', N'303-505-6252', N'lespine1q@bravesites.com', 4, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1092, N'610781303614302835', N'Leopold', N'Alix', N'Blinnie', N'McGilbon', CAST(N'2006-08-29T00:00:00.000' AS DateTime), 0, N'17105 Parkside Center', N'837-577-8315', N'bmcgilbon1r@altervista.org', 32, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1093, N'409147945967771442', N'Ricki', N'Dayna', N'Gerhardine', N'Meeks', CAST(N'1928-12-01T00:00:00.000' AS DateTime), 1, N'9 Fair Oaks Court', N'754-478-6341', N'gmeeks1s@answers.com', 193, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1094, N'898292497175258678', N'Candy', N'Jerry', N'Travers', N'Jolliss', CAST(N'2001-02-08T00:00:00.000' AS DateTime), 0, N'573 Delladonna Park', N'684-908-9716', N'tjolliss1t@devhub.com', 110, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1095, N'582254015010672539', N'Kassandra', N'Everard', N'Cesya', N'Howey', CAST(N'2005-10-07T00:00:00.000' AS DateTime), 0, N'955 Portage Center', N'610-129-2417', N'chowey1u@google.com.br', 32, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1096, N'583800891138242683', N'Gusella', N'Junette', N'Billi', N'Ballsdon', CAST(N'1934-08-16T00:00:00.000' AS DateTime), 1, N'356 Parkside Alley', N'312-417-1470', N'bballsdon1v@oaic.gov.au', 131, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1097, N'932369254930468444', N'Deni', N'Aylmar', N'Jerry', N'Dunniom', CAST(N'1953-08-22T00:00:00.000' AS DateTime), 0, N'17173 Corry Park', N'617-550-5851', N'jdunniom1w@github.com', 57, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1098, N'800127923457622783', N'Silvio', N'Erroll', N'Karylin', N'Konerding', CAST(N'1934-07-23T00:00:00.000' AS DateTime), 0, N'78669 Jana Hill', N'817-255-5078', N'kkonerding1x@tripod.com', 22, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1099, N'493777065750208862', N'Shannen', N'Bertrando', N'Clementine', N'Morston', CAST(N'1948-06-05T00:00:00.000' AS DateTime), 0, N'39029 Corben Lane', N'881-561-0590', N'cmorston1y@imdb.com', 190, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1101, N'133829399821515798', N'Lauralee', N'Simonette', N'Alexis', N'Cuming', CAST(N'1900-10-14T00:00:00.000' AS DateTime), 1, N'51408 Warrior Point', N'852-867-4987', N'acuming20@pagesperso-orange.fr', 126, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1102, N'669550421555509897', N'Evvy', N'Alon', N'Katrinka', N'Grolle', CAST(N'1929-11-03T00:00:00.000' AS DateTime), 0, N'2 Manufacturers Alley', N'282-398-0549', N'kgrolle21@fc2.com', 149, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1103, N'489771321593986673', N'Cris', N'Brett', N'Corabel', N'Philipsson', CAST(N'1979-01-16T00:00:00.000' AS DateTime), 0, N'90668 Orin Trail', N'969-318-4482', N'cphilipsson22@ft.com', 84, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1104, N'977474017129271317', N'Sephira', N'Marcia', N'Perle', N'Durtnel', CAST(N'1966-11-06T00:00:00.000' AS DateTime), 0, N'909 Hanover Drive', N'240-461-7212', N'pdurtnel23@usatoday.com', 8, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1105, N'794375921097948270', N'Josy', N'Johnathon', N'Cooper', N'Godlee', CAST(N'1933-09-08T00:00:00.000' AS DateTime), 1, N'72570 Talisman Alley', N'204-922-9819', N'cgodlee24@homestead.com', 77, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1106, N'174259609631502127', N'Chad', N'Norina', N'Davina', N'Heeney', CAST(N'1958-07-28T00:00:00.000' AS DateTime), 1, N'0877 Grasskamp Hill', N'647-191-2749', N'dheeney25@flavors.me', 77, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1107, N'618400085213516944', N'Berkley', N'Jany', N'Augustus', N'Pitkin', CAST(N'1997-04-14T00:00:00.000' AS DateTime), 1, N'06 Eliot Road', N'986-214-6237', N'apitkin26@about.me', 176, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1108, N'439959327482439870', N'Cob', N'Jandy', N'Eberto', N'Shelley', CAST(N'1978-12-05T00:00:00.000' AS DateTime), 1, N'860 Sullivan Plaza', N'370-436-1216', N'eshelley27@tuttocitta.it', 165, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1109, N'203239452063976625', N'Thea', N'Glynis', N'Sunny', N'Kenninghan', CAST(N'1931-12-26T00:00:00.000' AS DateTime), 1, N'68257 Banding Drive', N'422-378-1437', N'skenninghan28@xinhuanet.com', 62, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1110, N'573408834574459801', N'Tamiko', N'Bron', N'Wildon', N'Ruby', CAST(N'1903-08-15T00:00:00.000' AS DateTime), 1, N'5196 Lindbergh Junction', N'309-690-5894', N'wruby29@fc2.com', 93, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1111, N'928512702684276822', N'Granthem', N'Wake', N'Elsi', N'Dinnington', CAST(N'1904-06-21T00:00:00.000' AS DateTime), 1, N'15 Bluejay Crossing', N'724-771-5961', N'edinnington2a@stanford.edu', 33, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1112, N'976881371879695771', N'Frasier', N'Siegfried', N'Bill', N'Marian', CAST(N'1904-01-31T00:00:00.000' AS DateTime), 0, N'51668 Ronald Regan Terrace', N'377-454-2089', N'bmarian2b@icio.us', 86, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1113, N'550117309805183953', N'Adena', N'Teressa', N'Kristoffer', N'Bellham', CAST(N'1987-03-22T00:00:00.000' AS DateTime), 1, N'4 Michigan Junction', N'673-589-1025', N'kbellham2c@i2i.jp', 106, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1114, N'588088535872004377', N'Wiley', N'Eugenia', N'Athene', N'Grissett', CAST(N'1941-02-27T00:00:00.000' AS DateTime), 0, N'8978 Southridge Pass', N'868-174-1621', N'agrissett2d@meetup.com', 70, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1115, N'094026037022646941', N'Fletch', N'Ringo', N'Meir', N'Cotman', CAST(N'1991-03-13T00:00:00.000' AS DateTime), 1, N'561 Dakota Terrace', N'311-785-4772', N'mcotman2e@tumblr.com', 85, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1116, N'469078338519063719', N'Leslie', N'Van', N'Aubrey', N'Borlease', CAST(N'1920-06-24T00:00:00.000' AS DateTime), 1, N'1 Graceland Drive', N'887-862-5805', N'aborlease2f@salon.com', 126, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1117, N'806053347067343997', N'Conny', N'Mercy', N'Killie', N'Golden of Ireland', CAST(N'1993-03-20T00:00:00.000' AS DateTime), 0, N'983 Ridgeway Drive', N'505-693-9219', N'kgoldenofireland2g@wix.com', 166, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1118, N'937542124675801483', N'Demetre', N'Iggie', N'Kareem', N'Legges', CAST(N'1966-01-07T00:00:00.000' AS DateTime), 0, N'94 Arizona Trail', N'728-882-6003', N'klegges2h@fotki.com', 106, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1119, N'703168048089046831', N'Heindrick', N'Orland', N'Justis', N'Myring', CAST(N'1966-11-14T00:00:00.000' AS DateTime), 1, N'4 Sugar Parkway', N'522-193-0207', N'jmyring2i@woothemes.com', 81, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1120, N'220227577539817254', N'Ysabel', N'Luciano', N'Guenevere', N'Saturley', CAST(N'1963-01-27T00:00:00.000' AS DateTime), 1, N'350 Grover Place', N'981-976-7751', N'gsaturley2j@prweb.com', 5, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1121, N'201498415093629344', N'Breena', N'Zulema', N'Tresa', N'Zannotti', CAST(N'1906-05-27T00:00:00.000' AS DateTime), 0, N'22 Swallow Trail', N'788-975-6017', N'tzannotti2k@baidu.com', 88, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1122, N'944309583176892233', N'Kristy', N'Ignacio', N'Cathi', N'Leah', CAST(N'1926-06-02T00:00:00.000' AS DateTime), 0, N'42304 Starling Center', N'826-409-2214', N'cleah2l@odnoklassniki.ru', 99, NULL)
GO
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1123, N'890575442070834454', N'Pacorro', N'Marshal', N'Bathsheba', N'Prichard', CAST(N'1988-03-04T00:00:00.000' AS DateTime), 0, N'3565 Paget Alley', N'409-973-3829', N'bprichard2m@bloglovin.com', 59, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1124, N'816425239863976395', N'Alyda', N'Alexandrina', N'Jerrie', N'Gibbins', CAST(N'1991-01-19T00:00:00.000' AS DateTime), 0, N'51 Northridge Junction', N'647-591-4332', N'jgibbins2n@devhub.com', 124, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1125, N'705427009712724085', N'Courtnay', N'Gerianne', N'Petronilla', N'O''Dyvoy', CAST(N'1991-11-26T00:00:00.000' AS DateTime), 1, N'5387 Clemons Trail', N'914-473-5717', N'podyvoy2o@cnbc.com', 19, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1126, N'059029621371442697', N'Trescha', N'Gertrud', N'Lanny', N'Haymes', CAST(N'1983-05-17T00:00:00.000' AS DateTime), 0, N'0 Fairview Court', N'441-726-0754', N'lhaymes2p@samsung.com', 76, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1127, N'923397054125658013', N'Joella', N'Zelda', N'Suzie', N'Pilfold', CAST(N'1990-09-03T00:00:00.000' AS DateTime), 1, N'414 Fair Oaks Court', N'968-302-3463', N'spilfold2q@i2i.jp', 103, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1128, N'450486769539442056', N'Arron', N'Nil', N'Bartlet', N'Desouza', CAST(N'1954-12-27T00:00:00.000' AS DateTime), 0, N'0 Merchant Terrace', N'153-587-3322', N'bdesouza2r@wisc.edu', 45, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1129, N'738025952167699313', N'Fey', N'Nicholle', N'Melina', N'Pedrol', CAST(N'1949-01-03T00:00:00.000' AS DateTime), 1, N'013 Shelley Terrace', N'273-397-7913', N'mpedrol2s@exblog.jp', 153, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1130, N'630253881459490075', N'Thom', N'Ethelda', N'Norina', N'Bewshaw', CAST(N'1996-09-02T00:00:00.000' AS DateTime), 1, N'1469 Doe Crossing Terrace', N'964-520-7836', N'nbewshaw2t@apache.org', 124, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1131, N'299598719917982475', N'Brynn', N'Reginald', N'Ginny', N'Pohls', CAST(N'1956-11-13T00:00:00.000' AS DateTime), 1, N'8 Graceland Park', N'522-632-1734', N'gpohls2u@istockphoto.com', 31, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1132, N'611141698794063130', N'Kelcy', N'Will', N'Edin', N'Tysall', CAST(N'1925-12-22T00:00:00.000' AS DateTime), 1, N'45 Alpine Court', N'449-381-0013', N'etysall2v@ask.com', 16, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1133, N'820624725735256233', N'Wallache', N'Melvin', N'Isaak', N'La Vigne', CAST(N'1965-11-04T00:00:00.000' AS DateTime), 1, N'60 Elka Alley', N'721-726-3676', N'ilavigne2w@theglobeandmail.com', 122, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1134, N'671236796904489722', N'Bartolemo', N'Melonie', N'Hans', N'Rylstone', CAST(N'1923-10-22T00:00:00.000' AS DateTime), 1, N'2 Jenifer Pass', N'681-766-4131', N'hrylstone2x@cnn.com', 74, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1135, N'465851116188076168', N'Mikaela', N'Alfie', N'Roderich', N'Matterface', CAST(N'1927-10-17T00:00:00.000' AS DateTime), 0, N'23319 Fulton Park', N'564-112-7973', N'rmatterface2y@pen.io', 69, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1136, N'624995576209511136', N'Sidonia', N'Bren', N'Emelen', N'Ughelli', CAST(N'1942-12-03T00:00:00.000' AS DateTime), 1, N'913 Russell Plaza', N'511-926-9347', N'eughelli2z@wufoo.com', 32, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1137, N'027577878386620657', N'Bendick', N'Zachariah', N'Luciano', N'Benardet', CAST(N'1953-02-05T00:00:00.000' AS DateTime), 0, N'191 Weeping Birch Trail', N'355-369-2675', N'lbenardet30@yale.edu', 60, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1138, N'505785819778492265', N'Evita', N'Evelina', N'Jess', N'Smorthit', CAST(N'1949-05-04T00:00:00.000' AS DateTime), 0, N'172 Fairview Plaza', N'161-803-5524', N'jsmorthit31@apple.com', 18, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1139, N'955413323312092671', N'Allie', N'Verne', N'Bert', N'Ingrem', CAST(N'1907-05-01T00:00:00.000' AS DateTime), 0, N'0 Holmberg Crossing', N'157-311-2743', N'bingrem32@msn.com', 49, N'C:\DVLD-Project-Images\4d7e26ab-f007-42fd-8434-8a478bbd8e97.jpg')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1140, N'807477728623084030', N'Gordon', N'Lorenza', N'Raine', N'Linning', CAST(N'1927-06-20T00:00:00.000' AS DateTime), 1, N'02650 Briar Crest Way', N'102-394-2924', N'rlinning33@pcworld.com', 170, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1141, N'976232371446758316', N'Tobiah', N'Ina', N'Fidelia', N'Parram', CAST(N'1949-07-15T00:00:00.000' AS DateTime), 1, N'94 Mallory Plaza', N'889-209-7752', N'fparram34@amazonaws.com', 55, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1142, N'286380951734733840', N'Lyndsay', N'Lydie', N'Stefan', N'Gayton', CAST(N'1906-12-11T00:00:00.000' AS DateTime), 0, N'712 Corscot Crossing', N'993-322-4683', N'sgayton35@cdbaby.com', 137, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1143, N'426621701786753960', N'Corrie', N'Dulce', N'Barney', N'Shrimptone', CAST(N'1983-12-27T00:00:00.000' AS DateTime), 0, N'18628 Lakeland Pass', N'959-449-8407', N'bshrimptone36@oracle.com', 189, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1144, N'882652088629556715', N'Lind', N'Lira', N'Humfrid', N'Calley', CAST(N'1957-09-18T00:00:00.000' AS DateTime), 0, N'03374 Mallard Place', N'293-843-0062', N'hcalley37@simplemachines.org', 57, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1145, N'963799459951422201', N'Noni', N'Angeli', N'Angel', N'Garza', CAST(N'1935-12-18T00:00:00.000' AS DateTime), 0, N'86846 Moulton Alley', N'889-425-1285', N'agarza38@nydailynews.com', 162, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1146, N'341322499937240757', N'Mikkel', N'Cynthia', N'Georgette', N'Hurlin', CAST(N'1965-03-06T00:00:00.000' AS DateTime), 0, N'073 Towne Center', N'822-257-5404', N'ghurlin39@indiegogo.com', 111, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1147, N'332989403989646615', N'Tammy', N'Netta', N'Eugine', N'Piperley', CAST(N'1971-05-08T00:00:00.000' AS DateTime), 0, N'50148 Columbus Drive', N'674-291-2929', N'epiperley3a@mtv.com', 49, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1148, N'935929147068668891', N'Brendon', N'Franny', N'Cristen', N'O''Hickee', CAST(N'1919-06-28T00:00:00.000' AS DateTime), 0, N'40558 Spenser Circle', N'683-785-5531', N'cohickee3b@ask.com', 88, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1149, N'577460427620440727', N'Sergei', N'Waylon', N'Hayden', N'Standring', CAST(N'1992-07-10T00:00:00.000' AS DateTime), 1, N'4517 Burrows Street', N'532-598-7969', N'hstandring3c@histats.com', 162, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1150, N'268523330231911147', N'Walker', N'Gallard', N'Waiter', N'Comizzoli', CAST(N'1994-01-24T00:00:00.000' AS DateTime), 1, N'0878 Buell Court', N'280-962-4860', N'wcomizzoli3d@smh.com.au', 69, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1151, N'265065182645029087', N'Hunter', N'Neille', N'Elene', N'May', CAST(N'1927-11-08T00:00:00.000' AS DateTime), 0, N'4119 Harbort Junction', N'558-528-7948', N'emay3e@dyndns.org', 143, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1152, N'239449397910420350', N'Ramsey', N'Aurelia', N'Augustine', N'Bonick', CAST(N'1990-06-06T00:00:00.000' AS DateTime), 1, N'006 Killdeer Place', N'829-747-5765', N'abonick3f@va.gov', 168, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1153, N'051039080816278179', N'Abbe', N'Freida', N'Lilla', N'Seaman', CAST(N'1980-04-03T00:00:00.000' AS DateTime), 1, N'748 Pleasure Plaza', N'865-973-1672', N'lseaman3g@shinystat.com', 20, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1154, N'207892838555544788', N'Prudi', N'Lisetta', N'Cleve', N'Schafer', CAST(N'1942-11-30T00:00:00.000' AS DateTime), 0, N'9 Johnson Park', N'740-127-4957', N'cschafer3h@tmall.com', 159, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1155, N'536148460732288371', N'Marcella', N'Stillmann', N'Billye', N'Hartell', CAST(N'1987-01-16T00:00:00.000' AS DateTime), 1, N'709 Beilfuss Court', N'764-513-2448', N'bhartell3i@dyndns.org', 133, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1156, N'296448078566844209', N'Franchot', N'Ginelle', N'Leontine', N'Viccars', CAST(N'1955-10-21T00:00:00.000' AS DateTime), 0, N'7 Kipling Plaza', N'757-788-5245', N'lviccars3j@furl.net', 101, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1157, N'378305391447153611', N'Yehudi', N'Madella', N'Katya', N'Persich', CAST(N'1900-09-28T00:00:00.000' AS DateTime), 1, N'39 Manufacturers Plaza', N'571-393-6887', N'kpersich3k@homestead.com', 190, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1158, N'946408518727734873', N'Yolande', N'Marlee', N'Candy', N'Fairlaw', CAST(N'1949-11-28T00:00:00.000' AS DateTime), 0, N'3318 Hoffman Road', N'718-110-4542', N'cfairlaw3l@ucoz.com', 89, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1159, N'634774172453392443', N'Emmy', N'Clarita', N'Marchelle', N'Josselson', CAST(N'1928-01-16T00:00:00.000' AS DateTime), 0, N'37 Judy Hill', N'914-182-3787', N'mjosselson3m@csmonitor.com', 31, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1160, N'749207195408479404', N'Forrester', N'Cleve', N'Greggory', N'MacAlpin', CAST(N'1934-04-09T00:00:00.000' AS DateTime), 1, N'8 Hanover Center', N'426-569-6741', N'gmacalpin3n@soundcloud.com', 6, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1161, N'997705004095422973', N'Cherrita', N'Barth', N'Isabelle', N'Nias', CAST(N'1949-03-24T00:00:00.000' AS DateTime), 0, N'1 Stoughton Court', N'638-833-4023', N'inias3o@mac.com', 5, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1162, N'033502547257840992', N'Elysia', N'Felic', N'Dulciana', N'McLauchlin', CAST(N'1993-07-08T00:00:00.000' AS DateTime), 1, N'1 Grim Pass', N'852-898-0193', N'dmclauchlin3p@pinterest.com', 182, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1163, N'840897868238629007', N'Thadeus', N'Dannie', N'Sanders', N'Janc', CAST(N'1960-12-12T00:00:00.000' AS DateTime), 1, N'281 4th Court', N'289-298-3293', N'sjanc3q@de.vu', 39, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1164, N'402163256759341480', N'Brianne', N'Clemmie', N'Conni', N'Arrandale', CAST(N'1904-08-16T00:00:00.000' AS DateTime), 1, N'3812 Darwin Court', N'842-792-6662', N'carrandale3r@furl.net', 1, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1165, N'674118188104246760', N'Ilene', N'Tim', N'Salomo', N'Ovitts', CAST(N'1923-05-19T00:00:00.000' AS DateTime), 1, N'7 Eggendart Hill', N'904-308-3608', N'sovitts3s@so-net.ne.jp', 39, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1166, N'111081409683427485', N'Thain', N'Gilly', N'Olympia', N'Kneaphsey', CAST(N'1945-02-28T00:00:00.000' AS DateTime), 0, N'95 Schurz Alley', N'656-944-8978', N'okneaphsey3t@weather.com', 53, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1167, N'380445563039142746', N'Helenka', N'Erda', N'Elisha', N'Riedel', CAST(N'1920-06-05T00:00:00.000' AS DateTime), 0, N'4 Scoville Center', N'615-677-2071', N'eriedel3u@google.ca', 172, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1168, N'697174560430126407', N'Melisse', N'Kirsten', N'Salomo', N'Nendick', CAST(N'1919-08-14T00:00:00.000' AS DateTime), 1, N'727 Swallow Alley', N'343-900-4109', N'snendick3v@howstuffworks.com', 28, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1169, N'159782294852028731', N'Blake', N'Norbert', N'Daron', N'Kennet', CAST(N'1963-02-26T00:00:00.000' AS DateTime), 0, N'16 Holy Cross Alley', N'620-600-9246', N'dkennet3w@g.co', 80, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1170, N'440597636476498260', N'Essy', N'Merrilee', N'Annalise', N'McCarrison', CAST(N'1957-05-15T00:00:00.000' AS DateTime), 1, N'71213 Jana Court', N'779-543-6455', N'amccarrison3x@discuz.net', 171, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1171, N'826143977226730844', N'Berenice', N'Evania', N'Kerwinn', N'Street', CAST(N'1992-02-12T00:00:00.000' AS DateTime), 0, N'4 Lake View Way', N'106-746-7459', N'kstreet3y@dedecms.com', 20, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1172, N'938537471162529249', N'Cecelia', N'Morton', N'Roldan', N'Poschel', CAST(N'1980-06-22T00:00:00.000' AS DateTime), 0, N'0093 Meadow Valley Drive', N'780-885-6050', N'rposchel3z@gov.uk', 118, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1173, N'930481223805889010', N'Karalee', N'Sonnie', N'Lelah', N'Luety', CAST(N'1952-07-18T00:00:00.000' AS DateTime), 1, N'26184 Merchant Plaza', N'167-192-0679', N'lluety40@theatlantic.com', 163, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1174, N'338063615595002332', N'Kristoffer', N'Weidar', N'Jeanette', N'Ragg', CAST(N'1904-10-16T00:00:00.000' AS DateTime), 0, N'8615 Towne Parkway', N'380-144-7395', N'jragg41@geocities.com', 157, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1175, N'648160103177461666', N'Kevin', N'Kessiah', N'Maggi', N'Cunradi', CAST(N'1952-07-27T00:00:00.000' AS DateTime), 1, N'7012 Barnett Point', N'464-327-6585', N'mcunradi42@seattletimes.com', 141, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1176, N'792509044200442935', N'Dorian', N'Jacenta', N'Murielle', N'Petricek', CAST(N'2001-11-21T00:00:00.000' AS DateTime), 0, N'041 John Wall Lane', N'532-158-1059', N'mpetricek43@chron.com', 28, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1177, N'883012292247674841', N'Ellynn', N'Reider', N'Karoline', N'Emmins', CAST(N'1955-01-28T00:00:00.000' AS DateTime), 1, N'32 Doe Crossing Place', N'120-692-2950', N'kemmins44@wordpress.com', 116, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1178, N'660689409111725716', N'Raffaello', N'Derby', N'Jeno', N'Spaight', CAST(N'1923-04-23T00:00:00.000' AS DateTime), 1, N'70 Esch Avenue', N'532-716-4236', N'jspaight45@t.co', 74, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1179, N'064947226741872867', N'Karoline', N'Oren', N'Andras', N'Lyste', CAST(N'1940-06-19T00:00:00.000' AS DateTime), 0, N'807 Mallard Place', N'352-764-8219', N'alyste46@jimdo.com', 152, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1180, N'121897516040934993', N'Gaile', N'Kathleen', N'Herschel', N'Melin', CAST(N'1967-03-07T00:00:00.000' AS DateTime), 0, N'6 Redwing Point', N'596-606-0092', N'hmelin47@amazon.de', 188, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1181, N'352226380687636229', N'Cathe', N'Reba', N'Aliza', N'Clery', CAST(N'1919-02-14T00:00:00.000' AS DateTime), 0, N'9425 Comanche Trail', N'284-296-0743', N'aclery48@nymag.com', 26, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1182, N'826960066915149990', N'Morley', N'Valentijn', N'Adrienne', N'Corah', CAST(N'1949-09-07T00:00:00.000' AS DateTime), 1, N'49 Pearson Pass', N'179-810-4971', N'acorah49@nba.com', 179, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1183, N'825302963697969099', N'Miguela', N'Itch', N'Poul', N'Cutts', CAST(N'1999-04-20T00:00:00.000' AS DateTime), 1, N'76 Havey Terrace', N'920-144-6638', N'pcutts4a@jiathis.com', 90, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1184, N'032070014378551442', N'Adolphe', N'Ag', N'Christiana', N'Markel', CAST(N'1991-10-05T00:00:00.000' AS DateTime), 1, N'80 Dixon Junction', N'741-521-5034', N'cmarkel4b@diigo.com', 26, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1185, N'548654341253100813', N'Meris', N'Tonye', N'Aymer', N'Berr', CAST(N'1909-11-24T00:00:00.000' AS DateTime), 1, N'3 Duke Plaza', N'653-493-5308', N'aberr4c@pinterest.com', 148, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1186, N'040284411701900833', N'Magda', N'Rosalinda', N'Roshelle', N'Ilyuchyov', CAST(N'1950-09-17T00:00:00.000' AS DateTime), 1, N'33147 Sage Terrace', N'570-419-4848', N'rilyuchyov4d@webeden.co.uk', 81, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1187, N'767808492398807584', N'Anders', N'Stan', N'Adolpho', N'Langcastle', CAST(N'1988-05-09T00:00:00.000' AS DateTime), 0, N'3480 Arizona Parkway', N'972-994-5917', N'alangcastle4e@disqus.com', 189, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1188, N'000658294845302382', N'Maybelle', N'Jermayne', N'Garey', N'Fulkes', CAST(N'1976-03-12T00:00:00.000' AS DateTime), 1, N'099 Mandrake Trail', N'181-765-2016', N'gfulkes4f@reuters.com', 26, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1189, N'899464118395633369', N'Jasmin', N'Ravid', N'Carolin', N'Hannigan', CAST(N'1998-10-30T00:00:00.000' AS DateTime), 1, N'649 Green Ridge Trail', N'386-716-2216', N'channigan4g@google.com', 155, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1190, N'818197717479201937', N'Wilona', N'Lauryn', N'Ethelred', N'Scholar', CAST(N'2002-12-21T00:00:00.000' AS DateTime), 1, N'715 Vernon Drive', N'527-507-6060', N'escholar4h@craigslist.org', 90, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1191, N'035432706673320928', N'Austen', N'Edgardo', N'Patricia', N'Swinford', CAST(N'1925-12-27T00:00:00.000' AS DateTime), 1, N'47 Bellgrove Junction', N'441-604-7719', N'pswinford4i@diigo.com', 73, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1192, N'600420917633507426', N'Meryl', N'Dewitt', N'Creighton', N'Bewlie', CAST(N'2004-02-10T00:00:00.000' AS DateTime), 1, N'6 Del Sol Alley', N'714-305-5921', N'cbewlie4j@skype.com', 59, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1193, N'635837591956241273', N'Giana', N'Dinny', N'Celestine', N'Hathaway', CAST(N'1940-08-20T00:00:00.000' AS DateTime), 1, N'6738 Fremont Crossing', N'411-804-1585', N'chathaway4k@netvibes.com', 101, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1194, N'588051934466891239', N'Spenser', N'Nyssa', N'Suki', N'Godwyn', CAST(N'1956-02-26T00:00:00.000' AS DateTime), 0, N'56743 Express Lane', N'233-829-1883', N'sgodwyn4l@dagondesign.com', 118, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1195, N'509538776296608598', N'Holli', N'Culver', N'Mike', N'Tumpane', CAST(N'1969-07-26T00:00:00.000' AS DateTime), 1, N'91538 Buell Court', N'580-859-6112', N'mtumpane4m@china.com.cn', 91, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1196, N'381154327220160599', N'Reinald', N'Land', N'Fabiano', N'Pepler', CAST(N'1941-06-16T00:00:00.000' AS DateTime), 1, N'3 Judy Way', N'149-925-9736', N'fpepler4n@homestead.com', 60, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1197, N'077291450457960726', N'Fulton', N'Marylee', N'Ambrosio', N'Mulcock', CAST(N'1992-08-10T00:00:00.000' AS DateTime), 1, N'02 American Parkway', N'460-477-4163', N'amulcock4o@mozilla.org', 89, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1198, N'192074881606510450', N'Amory', N'Rem', N'Marris', N'Beadell', CAST(N'1951-10-13T00:00:00.000' AS DateTime), 0, N'24379 Texas Crossing', N'926-310-7921', N'mbeadell4p@merriam-webster.com', 128, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1199, N'503816308008880380', N'Tanitansy', N'Palmer', N'Timothea', N'Cleynaert', CAST(N'1946-02-02T00:00:00.000' AS DateTime), 0, N'13415 Sloan Circle', N'985-932-0385', N'tcleynaert4q@bigcartel.com', 129, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1200, N'894169044513135578', N'Lib', N'Enrika', N'Abbey', N'Czajkowski', CAST(N'1998-08-01T00:00:00.000' AS DateTime), 0, N'8968 Sherman Center', N'908-320-7422', N'aczajkowski4r@buzzfeed.com', 62, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1201, N'390399738241993696', N'Florie', N'Teodoro', N'Lowe', N'Gerardot', CAST(N'1998-08-06T00:00:00.000' AS DateTime), 0, N'76558 Sugar Pass', N'990-498-9587', N'lgerardot4s@cornell.edu', 123, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1202, N'917474861058159096', N'Lela', N'Conny', N'Janek', N'Gellier', CAST(N'1983-12-30T00:00:00.000' AS DateTime), 1, N'3 David Street', N'312-736-6179', N'jgellier4t@drupal.org', 91, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1203, N'863845790664701691', N'Hank', N'Cassey', N'Ebenezer', N'Larkins', CAST(N'1958-07-06T00:00:00.000' AS DateTime), 1, N'5 Lakewood Crossing', N'491-486-4503', N'elarkins4u@answers.com', 168, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1204, N'058279521798804872', N'Nettie', N'Lenore', N'Taite', N'Chatterton', CAST(N'1950-02-01T00:00:00.000' AS DateTime), 0, N'10 Mifflin Plaza', N'514-117-5241', N'tchatterton4v@pcworld.com', 126, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1205, N'378472266880106089', N'Ambros', N'Constantia', N'Cassy', N'Vasiljevic', CAST(N'1910-03-20T00:00:00.000' AS DateTime), 0, N'1 Lunder Terrace', N'188-264-1613', N'cvasiljevic4w@edublogs.org', 125, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1206, N'363742643473114793', N'Elsa', N'Jae', N'Bronson', N'Trowill', CAST(N'1989-01-11T00:00:00.000' AS DateTime), 1, N'728 Old Gate Avenue', N'614-547-2521', N'btrowill4x@livejournal.com', 76, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1207, N'409201422757316863', N'Sherie', N'Elias', N'Adelaida', N'Whicher', CAST(N'1920-01-29T00:00:00.000' AS DateTime), 1, N'596 Mendota Center', N'300-394-8553', N'awhicher4z@blinklist.com', 7, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1208, N'324861243416272424', N'Al', N'Ash', N'Trudi', N'Hugonet', CAST(N'1987-08-31T00:00:00.000' AS DateTime), 1, N'63550 Mallory Park', N'858-760-8555', N'thugonet50@nytimes.com', 144, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1209, N'260651434576632684', N'Woodie', N'Halette', N'Dasha', N'Janjusevic', CAST(N'1917-04-13T00:00:00.000' AS DateTime), 1, N'4 Marcy Plaza', N'300-589-3048', N'djanjusevic51@dyndns.org', 57, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1210, N'012349530762475915', N'Ephraim', N'Nikita', N'Alikee', N'Nestle', CAST(N'1942-09-05T00:00:00.000' AS DateTime), 0, N'72451 Del Sol Circle', N'993-839-6557', N'anestle52@yelp.com', 39, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1211, N'775626930147892445', N'Quentin', N'Luise', N'Carina', N'Joscelyn', CAST(N'1965-09-24T00:00:00.000' AS DateTime), 1, N'3 Nova Circle', N'399-389-6447', N'cjoscelyn53@webmd.com', 172, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1212, N'074106934711551138', N'Arlette', N'Phaidra', N'Glynnis', N'Strangeway', CAST(N'1979-03-30T00:00:00.000' AS DateTime), 0, N'5240 Sutteridge Trail', N'924-301-5758', N'gstrangeway54@tripadvisor.com', 174, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1213, N'842512946503496680', N'Alfredo', N'Genny', N'Sheilakathryn', N'Mackin', CAST(N'1921-10-07T00:00:00.000' AS DateTime), 1, N'2 Bunker Hill Plaza', N'317-251-3481', N'smackin55@engadget.com', 99, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1214, N'960847431371435246', N'Abbey', N'Stormy', N'Dael', N'Danzey', CAST(N'2000-04-13T00:00:00.000' AS DateTime), 1, N'0 Carioca Plaza', N'482-164-6281', N'ddanzey56@comcast.net', 47, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1215, N'972633296095927522', N'Roxana', N'Donny', N'Neal', N'Messenbird', CAST(N'1961-07-22T00:00:00.000' AS DateTime), 0, N'29 West Lane', N'890-685-4111', N'nmessenbird57@umich.edu', 114, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1216, N'042778849802806021', N'Rafi', N'Raffarty', N'Inessa', N'Boots', CAST(N'1915-10-10T00:00:00.000' AS DateTime), 0, N'908 Reinke Hill', N'658-351-0041', N'iboots58@independent.co.uk', 116, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1217, N'401523238439204806', N'Ari', N'Selma', N'Daffie', N'Hinckes', CAST(N'1980-09-22T00:00:00.000' AS DateTime), 0, N'46091 Trailsway Park', N'673-293-1415', N'dhinckes59@pinterest.com', 33, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1218, N'725040756741519697', N'Amelia', N'Johann', N'Boyd', N'Colbron', CAST(N'1909-09-08T00:00:00.000' AS DateTime), 0, N'45432 Oxford Avenue', N'312-152-2556', N'bcolbron5a@oakley.com', 163, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1219, N'802468531892723863', N'Arturo', N'Julie', N'Clywd', N'Noddles', CAST(N'2005-11-28T00:00:00.000' AS DateTime), 1, N'7 Ludington Hill', N'981-116-2577', N'cnoddles5b@reddit.com', 28, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1220, N'037482146010047576', N'Arch', N'Gayle', N'Lee', N'Gallardo', CAST(N'1917-01-28T00:00:00.000' AS DateTime), 0, N'2 Di Loreto Park', N'897-654-3362', N'lgallardo5c@comsenz.com', 120, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1221, N'956034723337096905', N'Verena', N'Franny', N'Dulcine', N'Dake', CAST(N'1992-04-24T00:00:00.000' AS DateTime), 1, N'8 Swallow Alley', N'428-438-1772', N'ddake5d@google.es', 145, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1222, N'612734294191791343', N'Kennith', N'Ronica', N'Donna', N'Duffit', CAST(N'1960-06-19T00:00:00.000' AS DateTime), 1, N'276 Kenwood Junction', N'762-583-5696', N'dduffit5e@jigsy.com', 87, NULL)
GO
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1223, N'378874643443213802', N'Angelico', N'Elvyn', N'Andriette', N'Bruhke', CAST(N'1943-01-08T00:00:00.000' AS DateTime), 1, N'73 Londonderry Circle', N'461-724-3250', N'abruhke5f@netlog.com', 45, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1224, N'360633774734974815', N'Shawn', N'Robinet', N'Fionnula', N'Manthroppe', CAST(N'1984-06-21T00:00:00.000' AS DateTime), 1, N'29 Canary Street', N'532-914-9378', N'fmanthroppe5g@virginia.edu', 100, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1225, N'731318294267692002', N'Dasi', N'Gaelan', N'Lexie', N'Dumsday', CAST(N'1984-01-01T00:00:00.000' AS DateTime), 0, N'49 Shoshone Court', N'642-103-5268', N'ldumsday5h@liveinternet.ru', 4, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1226, N'160863033084869203', N'Linet', N'Ezequiel', N'Alexandros', N'Gammage', CAST(N'1919-11-20T00:00:00.000' AS DateTime), 0, N'39161 Thierer Place', N'176-420-9044', N'agammage5i@hugedomains.com', 102, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1227, N'311629773675138516', N'Phip', N'Fielding', N'Parnell', N'Bordman', CAST(N'1993-03-30T00:00:00.000' AS DateTime), 0, N'6 Carberry Road', N'916-838-6551', N'pbordman5j@youtu.be', 54, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1228, N'732370713472256201', N'Delmer', N'Alana', N'Bear', N'Dudin', CAST(N'1933-07-03T00:00:00.000' AS DateTime), 1, N'42 Brown Terrace', N'260-653-6019', N'bdudin5k@fda.gov', 125, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1229, N'474788106032131403', N'Beatrisa', N'Auberta', N'Nell', N'Gurry', CAST(N'1965-04-18T00:00:00.000' AS DateTime), 0, N'547 Hayes Court', N'850-675-7984', N'ngurry5l@spotify.com', 52, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1230, N'965715753951242381', N'Vincenty', N'Lynnell', N'Averyl', N'MacKeller', CAST(N'1938-09-17T00:00:00.000' AS DateTime), 0, N'77770 Basil Pass', N'723-577-8959', N'amackeller5m@people.com.cn', 94, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1231, N'593725697776021586', N'Kelvin', N'Hyacinthie', N'Cornie', N'Blazdell', CAST(N'2004-10-09T00:00:00.000' AS DateTime), 1, N'35144 Mifflin Park', N'212-234-0954', N'cblazdell5n@pinterest.com', 169, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1232, N'183587622341857291', N'Cherida', N'Alexina', N'Odo', N'Weeds', CAST(N'1957-01-25T00:00:00.000' AS DateTime), 0, N'3076 Stang Junction', N'645-595-2082', N'oweeds5o@typepad.com', 36, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1233, N'434177338049120628', N'Thomasa', N'Jocelin', N'Alverta', N'Frye', CAST(N'1994-06-03T00:00:00.000' AS DateTime), 0, N'2958 Myrtle Park', N'682-362-6560', N'afrye5p@independent.co.uk', 141, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1234, N'892330900143089580', N'Adelheid', N'Gordon', N'Derby', N'MacNish', CAST(N'1980-04-07T00:00:00.000' AS DateTime), 0, N'208 Dahle Junction', N'363-240-9086', N'dmacnish5q@nytimes.com', 181, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1235, N'805294336409382179', N'Clea', N'Lock', N'Cassie', N'Henrie', CAST(N'1977-12-12T00:00:00.000' AS DateTime), 0, N'3 Dovetail Street', N'399-986-7956', N'chenrie5r@instagram.com', 169, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1236, N'420246582010553145', N'Brigg', N'Richy', N'Flo', N'Petroselli', CAST(N'1901-03-13T00:00:00.000' AS DateTime), 0, N'82 Dovetail Place', N'743-713-3361', N'fpetroselli5s@sourceforge.net', 78, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1237, N'541835267186896148', N'Fran', N'Rudyard', N'Evelyn', N'Warton', CAST(N'1914-12-27T00:00:00.000' AS DateTime), 1, N'04854 Northport Junction', N'483-996-5106', N'ewarton5t@networkadvertising.org', 106, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1238, N'325014613919487053', N'Fulvia', N'Alec', N'Saree', N'Kilday', CAST(N'1902-06-06T00:00:00.000' AS DateTime), 1, N'68607 West Alley', N'926-662-8390', N'skilday5u@usa.gov', 147, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1239, N'861565220926405918', N'Locke', N'Ethelin', N'Annie', N'Timbs', CAST(N'1996-10-25T00:00:00.000' AS DateTime), 1, N'505 Michigan Park', N'643-245-6427', N'atimbs5v@pen.io', 11, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1240, N'046723627327715632', N'Almeda', N'Stewart', N'Shirlene', N'Reye', CAST(N'1957-03-02T00:00:00.000' AS DateTime), 0, N'0 Grim Plaza', N'460-108-8351', N'sreye5w@live.com', 178, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1241, N'913610481263688422', N'Obidiah', N'Kerstin', N'Rozalin', N'Fulmen', CAST(N'1988-02-25T00:00:00.000' AS DateTime), 0, N'7639 Hanover Pass', N'646-329-0510', N'rfulmen5x@sogou.com', 152, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1242, N'628724874071249050', N'Ame', N'Donni', N'Etty', N'Littefair', CAST(N'1972-09-20T00:00:00.000' AS DateTime), 1, N'107 Eggendart Street', N'800-731-4686', N'elittefair5y@fastcompany.com', 105, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1243, N'576805983296006267', N'Karalee', N'Phyllis', N'Asher', N'Deighan', CAST(N'1981-07-11T00:00:00.000' AS DateTime), 1, N'9 Annamark Avenue', N'379-652-2477', N'adeighan5z@wix.com', 52, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1244, N'038390568982667630', N'Trudy', N'Kathrine', N'Raffaello', N'Marrable', CAST(N'1933-03-01T00:00:00.000' AS DateTime), 0, N'829 Homewood Court', N'475-865-1946', N'rmarrable60@sun.com', 189, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1245, N'381092998537882530', N'Claudia', N'Blane', N'Colleen', N'Eddis', CAST(N'1927-11-28T00:00:00.000' AS DateTime), 0, N'692 Chive Lane', N'418-292-8658', N'ceddis61@elegantthemes.com', 93, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1246, N'490868306035618821', N'Melisenda', N'Oralla', N'Shelly', N'Mousdall', CAST(N'1965-08-27T00:00:00.000' AS DateTime), 0, N'633 Meadow Ridge Avenue', N'311-261-4714', N'smousdall62@dot.gov', 104, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1247, N'678470283795109239', N'Alphard', N'Kaleb', N'Tye', N'Freeth', CAST(N'1957-07-18T00:00:00.000' AS DateTime), 0, N'415 Hauk Parkway', N'608-121-5969', N'tfreeth63@a8.net', 123, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1248, N'640708685962609696', N'Angelique', N'Ynez', N'Benedetta', N'Jertz', CAST(N'1939-03-04T00:00:00.000' AS DateTime), 1, N'0282 Tomscot Crossing', N'152-371-2681', N'bjertz64@buzzfeed.com', 57, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1249, N'571314924516364415', N'Eric', N'Vincents', N'Bria', N'Gilchrist', CAST(N'1926-04-06T00:00:00.000' AS DateTime), 1, N'769 Anthes Crossing', N'632-439-9694', N'bgilchrist65@google.ca', 47, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1250, N'863825168281082456', N'Ofilia', N'Paton', N'Annabel', N'Paprotny', CAST(N'1974-10-05T00:00:00.000' AS DateTime), 0, N'5 Ridge Oak Place', N'697-858-4389', N'apaprotny66@princeton.edu', 108, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1251, N'628525116918812371', N'Jonah', N'Cary', N'Ruthie', N'Sudy', CAST(N'1995-02-19T00:00:00.000' AS DateTime), 0, N'8 Oakridge Drive', N'264-683-5579', N'rsudy67@foxnews.com', 156, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1252, N'515121643135484225', N'Gard', N'Isidro', N'Minna', N'Coomer', CAST(N'1956-04-17T00:00:00.000' AS DateTime), 1, N'16 Morrow Park', N'617-603-4135', N'mcoomer68@scribd.com', 100, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1253, N'168300480069627080', N'Verine', N'Ced', N'Marielle', N'Tickle', CAST(N'1974-09-28T00:00:00.000' AS DateTime), 0, N'731 Doe Crossing Park', N'899-425-0730', N'mtickle69@networksolutions.com', 153, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1254, N'164643885927110999', N'Lorens', N'Madalena', N'Brnaby', N'Hambatch', CAST(N'1934-05-31T00:00:00.000' AS DateTime), 1, N'66353 Manley Alley', N'409-325-7181', N'bhambatch6a@homestead.com', 154, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1255, N'608367185965367740', N'Elfie', N'Jinny', N'Marv', N'Rehn', CAST(N'2003-12-06T00:00:00.000' AS DateTime), 1, N'72 Haas Park', N'395-141-9807', N'mrehn6b@live.com', 109, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1256, N'967250517116126390', N'Jonis', N'Coletta', N'Anny', N'Huxter', CAST(N'1934-08-15T00:00:00.000' AS DateTime), 0, N'36 Warner Terrace', N'631-956-8876', N'ahuxter6c@blog.com', 182, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1257, N'485746812826548888', N'Ezechiel', N'Kacey', N'Galven', N'Petricek', CAST(N'1937-11-27T00:00:00.000' AS DateTime), 0, N'12 Bunker Hill Point', N'687-997-9443', N'gpetricek6d@people.com.cn', 149, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1258, N'023048777562205312', N'Tomaso', N'Miguelita', N'Karlan', N'Grainge', CAST(N'1922-07-15T00:00:00.000' AS DateTime), 1, N'27 Carey Center', N'788-604-3646', N'kgrainge6e@goo.gl', 188, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1259, N'462873707344007330', N'Ula', N'Cyb', N'Maegan', N'Borrie', CAST(N'1931-07-26T00:00:00.000' AS DateTime), 0, N'1 Memorial Hill', N'343-549-2343', N'mborrie6f@google.co.jp', 54, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1260, N'801795406968355214', N'Helsa', N'Wendi', N'Alvera', N'McCafferky', CAST(N'1974-09-08T00:00:00.000' AS DateTime), 0, N'4 Hudson Avenue', N'513-810-6266', N'amccafferky6g@google.ru', 158, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1261, N'767202182113545304', N'Bennie', N'Simon', N'Oran', N'Webborn', CAST(N'1993-07-30T00:00:00.000' AS DateTime), 0, N'75695 5th Parkway', N'489-535-7653', N'owebborn6h@about.com', 16, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1262, N'582610155048468224', N'Nicky', N'Irina', N'Viviene', N'Kleinplac', CAST(N'1927-09-11T00:00:00.000' AS DateTime), 0, N'5892 Schmedeman Court', N'558-726-5439', N'vkleinplac6i@wordpress.org', 80, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1263, N'933585450590794127', N'Raphaela', N'Maryann', N'Brittan', N'Legerton', CAST(N'1941-10-03T00:00:00.000' AS DateTime), 1, N'2055 Hauk Lane', N'119-781-3083', N'blegerton6j@google.nl', 104, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1264, N'980604460956599301', N'Hiram', N'Sybilla', N'Ansell', N'Johnsson', CAST(N'1921-12-27T00:00:00.000' AS DateTime), 1, N'2 Homewood Court', N'474-679-3420', N'ajohnsson6k@squidoo.com', 110, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1265, N'779825754758397742', N'Jacynth', N'Shalom', N'Colline', N'Chapiro', CAST(N'1940-01-01T00:00:00.000' AS DateTime), 0, N'26058 Vernon Park', N'522-895-7860', N'cchapiro6l@yellowbook.com', 131, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1266, N'516440372697587539', N'Ravi', N'Arlyn', N'Stacia', N'Curnick', CAST(N'1915-02-10T00:00:00.000' AS DateTime), 1, N'91943 Old Gate Plaza', N'796-399-3712', N'scurnick6m@addtoany.com', 34, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1267, N'383160969297193949', N'Wilmette', N'Chelsae', N'Shanie', N'MacTrustey', CAST(N'1924-03-14T00:00:00.000' AS DateTime), 1, N'45521 Magdeline Plaza', N'613-729-1882', N'smactrustey6n@cpanel.net', 189, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1268, N'912893011935075011', N'Mac', N'Hildegaard', N'Nial', N'Pentlow', CAST(N'1957-10-31T00:00:00.000' AS DateTime), 1, N'738 Riverside Park', N'132-988-6834', N'npentlow6o@google.pl', 77, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1269, N'424353098735076763', N'Blayne', N'Shelagh', N'Gussy', N'Sayburn', CAST(N'1915-09-21T00:00:00.000' AS DateTime), 0, N'02 Caliangt Court', N'124-936-2276', N'gsayburn6p@oakley.com', 185, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1270, N'856547685363094970', N'Lorens', N'Johannes', N'Rube', N'O''Sculley', CAST(N'1944-07-09T00:00:00.000' AS DateTime), 0, N'2 Leroy Place', N'185-343-6222', N'rosculley6q@joomla.org', 79, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1271, N'607644682913191917', N'Moreen', N'Tallulah', N'Buckie', N'Bartocci', CAST(N'1912-08-26T00:00:00.000' AS DateTime), 1, N'249 Dapin Way', N'992-495-4688', N'bbartocci6r@skyrock.com', 29, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1272, N'466923039123105202', N'Florie', N'Rikki', N'Rhea', N'Blonden', CAST(N'1986-09-21T00:00:00.000' AS DateTime), 0, N'9353 Eliot Point', N'777-899-6845', N'rblonden6s@printfriendly.com', 166, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1273, N'973615958067204052', N'Harald', N'Tito', N'Pedro', N'Darkins', CAST(N'1935-12-17T00:00:00.000' AS DateTime), 0, N'00 Dayton Alley', N'716-203-9178', N'pdarkins6t@so-net.ne.jp', 75, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1274, N'753402101326776263', N'Rawley', N'Emmie', N'Moyra', N'Keaveney', CAST(N'2003-05-23T00:00:00.000' AS DateTime), 0, N'93593 Northridge Plaza', N'746-723-0763', N'mkeaveney6u@cnbc.com', 184, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1275, N'557669683194811861', N'Mayor', N'Killy', N'Shelli', N'Gabriel', CAST(N'1973-10-07T00:00:00.000' AS DateTime), 1, N'7475 Summer Ridge Trail', N'315-476-2230', N'sgabriel6v@imgur.com', 131, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1276, N'904494643773701145', N'Rozalie', N'Lorelle', N'Olly', N'Cecchetelli', CAST(N'2003-12-05T00:00:00.000' AS DateTime), 1, N'55 Susan Alley', N'469-949-0139', N'ocecchetelli6w@harvard.edu', 70, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1277, N'824054186081074634', N'Winfred', N'Etheline', N'Abbie', N'Raulstone', CAST(N'1974-12-02T00:00:00.000' AS DateTime), 0, N'12319 4th Court', N'384-708-8548', N'araulstone6x@mayoclinic.com', 90, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1278, N'483470445904222091', N'Michal', N'Everett', N'Vale', N'Manser', CAST(N'1932-01-15T00:00:00.000' AS DateTime), 1, N'3390 Laurel Court', N'197-768-7563', N'vmanser6y@state.tx.us', 37, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1279, N'264063660158897209', N'Leese', N'Zulema', N'Bartholomeus', N'Keller', CAST(N'1981-01-31T00:00:00.000' AS DateTime), 1, N'012 Londonderry Center', N'605-559-8579', N'bkeller6z@berkeley.edu', 70, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1280, N'371297471822862305', N'Gerick', N'Ingamar', N'Dotti', N'Schimek', CAST(N'1973-06-23T00:00:00.000' AS DateTime), 1, N'233 Katie Place', N'476-724-0390', N'dschimek70@ning.com', 191, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1281, N'484377732961199061', N'Kameko', N'Britta', N'Dave', N'Beare', CAST(N'1966-04-02T00:00:00.000' AS DateTime), 0, N'77 Schlimgen Pass', N'661-469-2982', N'dbeare72@cloudflare.com', 168, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1282, N'623463404771691395', N'Sandye', N'Mateo', N'Shepherd', N'Laverenz', CAST(N'2001-01-24T00:00:00.000' AS DateTime), 0, N'65 Express Way', N'239-436-6753', N'slaverenz73@fotki.com', 60, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1283, N'322038445660481777', N'Kelley', N'Cyndie', N'Deeyn', N'McConigal', CAST(N'1939-04-24T00:00:00.000' AS DateTime), 0, N'09 Bobwhite Alley', N'837-457-4529', N'dmcconigal74@scribd.com', 97, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1284, N'190189669370302376', N'Valerye', N'Tiffanie', N'Coraline', N'Bexon', CAST(N'1918-09-29T00:00:00.000' AS DateTime), 1, N'0 Spohn Park', N'941-472-8205', N'cbexon75@github.io', 165, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1285, N'302563695161361793', N'Robinette', N'Chelsie', N'Mela', N'Klagges', CAST(N'1971-10-21T00:00:00.000' AS DateTime), 1, N'0 Little Fleur Point', N'355-668-4983', N'mklagges76@statcounter.com', 158, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1286, N'957677050380944772', N'Theo', N'Filippo', N'Tully', N'Sircomb', CAST(N'1935-08-22T00:00:00.000' AS DateTime), 1, N'432 Park Meadow Crossing', N'955-485-3562', N'tsircomb77@oracle.com', 77, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1287, N'835269327597034341', N'Zara', N'Jackson', N'Berte', N'Stiddard', CAST(N'1905-06-16T00:00:00.000' AS DateTime), 1, N'997 Granby Way', N'950-430-2245', N'bstiddard78@google.co.jp', 106, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1288, N'264203985690573960', N'Kurt', N'Alic', N'Marne', N'Wilstead', CAST(N'1993-03-30T00:00:00.000' AS DateTime), 0, N'1056 Vernon Alley', N'990-822-6142', N'mwilstead79@nih.gov', 63, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1289, N'869527015181793994', N'Reynold', N'Anselma', N'Elmer', N'Tunnah', CAST(N'1912-05-28T00:00:00.000' AS DateTime), 0, N'6036 Anthes Crossing', N'608-902-9911', N'etunnah7a@cnet.com', 43, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1290, N'723964258298138134', N'Timofei', N'Janet', N'Herta', N'Buxcey', CAST(N'1925-06-19T00:00:00.000' AS DateTime), 1, N'0740 Drewry Parkway', N'921-806-8432', N'hbuxcey7b@elpais.com', 65, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1291, N'966062875081012665', N'Shellie', N'Etty', N'Townie', N'Scowen', CAST(N'2005-01-06T00:00:00.000' AS DateTime), 1, N'4123 Ridgeway Drive', N'954-322-8472', N'tscowen7c@reverbnation.com', 65, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1292, N'466115458842421546', N'Angel', N'Zonda', N'Corbett', N'Randal', CAST(N'1953-02-14T00:00:00.000' AS DateTime), 0, N'81 Laurel Place', N'539-988-5405', N'crandal7d@europa.eu', 55, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1293, N'290772355669782869', N'Skipp', N'Lethia', N'Lincoln', N'Hedylstone', CAST(N'1989-02-09T00:00:00.000' AS DateTime), 0, N'5354 Heath Court', N'317-565-9857', N'lhedylstone7e@usnews.com', 103, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1294, N'180172452061468310', N'Patrizius', N'Garald', N'Jeannie', N'MacMaykin', CAST(N'1942-03-21T00:00:00.000' AS DateTime), 1, N'772 Warrior Court', N'428-477-6563', N'jmacmaykin7f@ox.ac.uk', 173, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1295, N'515780751392120562', N'Glenna', N'Kev', N'Elvira', N'Souttar', CAST(N'1984-01-14T00:00:00.000' AS DateTime), 0, N'9 Knutson Road', N'420-342-1187', N'esouttar7g@1688.com', 84, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1296, N'080094334068319722', N'Carmen', N'Eulalie', N'Demeter', N'Ashenhurst', CAST(N'1926-08-14T00:00:00.000' AS DateTime), 1, N'62717 Prairieview Circle', N'471-436-3007', N'dashenhurst7h@vistaprint.com', 123, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1297, N'133488143601382477', N'Nevin', N'Shauna', N'Eleni', N'Cleary', CAST(N'2000-12-26T00:00:00.000' AS DateTime), 0, N'31258 School Drive', N'197-553-3185', N'ecleary7i@infoseek.co.jp', 36, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1298, N'570986384093723714', N'Paulina', N'Robinette', N'Lorine', N'Wey', CAST(N'1957-05-13T00:00:00.000' AS DateTime), 1, N'456 Mccormick Court', N'613-690-1918', N'lwey7j@vinaora.com', 4, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1299, N'869728698553776436', N'Drud', N'Chastity', N'Kirby', N'Berzons', CAST(N'1933-07-13T00:00:00.000' AS DateTime), 0, N'25359 Starling Street', N'398-553-7625', N'kberzons7k@mysql.com', 78, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1300, N'726755101176573586', N'Dolf', N'Anthony', N'Austin', N'Smieton', CAST(N'1973-11-03T00:00:00.000' AS DateTime), 1, N'7673 Anhalt Crossing', N'252-820-9218', N'asmieton7l@google.fr', 22, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1301, N'686205176722098133', N'Cathy', N'Peirce', N'Tremaine', N'Boullin', CAST(N'1951-06-19T00:00:00.000' AS DateTime), 1, N'230 Brown Way', N'831-606-6253', N'tboullin7m@cpanel.net', 170, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1302, N'919176542178623106', N'Milena', N'Lay', N'Brigham', N'Beamand', CAST(N'1979-12-03T00:00:00.000' AS DateTime), 1, N'33335 Fulton Terrace', N'315-740-6765', N'bbeamand7n@wikimedia.org', 61, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1303, N'093730986010111824', N'Heidie', N'Miller', N'Berthe', N'Mugleston', CAST(N'1979-06-10T00:00:00.000' AS DateTime), 1, N'66799 Shoshone Place', N'363-181-3258', N'bmugleston7o@sciencedaily.com', 103, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1304, N'236411936698364904', N'Aprilette', N'Walsh', N'Charlton', N'Reicherz', CAST(N'1933-10-08T00:00:00.000' AS DateTime), 0, N'09 Summit Way', N'332-516-6319', N'creicherz7p@example.com', 150, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1305, N'876685026737965941', N'Nerty', N'Lissy', N'Shannon', N'Fewings', CAST(N'1986-01-01T00:00:00.000' AS DateTime), 1, N'62577 Norway Maple Place', N'418-894-7836', N'sfewings7q@nature.com', 168, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1306, N'016514452078881236', N'Somerset', N'Joela', N'Thalia', N'Creed', CAST(N'1949-02-09T00:00:00.000' AS DateTime), 0, N'910 Sundown Plaza', N'378-196-5009', N'tcreed7r@prweb.com', 71, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1307, N'755986552483578631', N'Niven', N'Annabella', N'Jeanie', N'Ferrarini', CAST(N'1908-03-18T00:00:00.000' AS DateTime), 1, N'559 Northview Plaza', N'291-465-5868', N'jferrarini7s@ebay.com', 115, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1308, N'277776778810478423', N'Sheela', N'Barth', N'Carver', N'Abethell', CAST(N'1945-12-04T00:00:00.000' AS DateTime), 1, N'30 Dryden Circle', N'828-305-5165', N'cabethell7t@skyrock.com', 33, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1309, N'015719908968606574', N'Devina', N'Adolphus', N'Oswald', N'Kennet', CAST(N'1979-03-07T00:00:00.000' AS DateTime), 0, N'609 Farmco Alley', N'818-571-9844', N'okennet7u@ox.ac.uk', 12, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1310, N'305002863843428936', N'Melisent', N'Judi', N'Ameline', N'Coatman', CAST(N'1918-03-14T00:00:00.000' AS DateTime), 1, N'8 6th Circle', N'978-934-9273', N'acoatman7v@opera.com', 132, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1311, N'852227663007106080', N'Edgard', N'Lou', N'Trina', N'Rabley', CAST(N'1987-12-10T00:00:00.000' AS DateTime), 0, N'386 Hoard Drive', N'415-252-0676', N'trabley7w@pagesperso-orange.fr', 116, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1312, N'523723931104142101', N'Margaux', N'Meridith', N'Danielle', N'Jakubowsky', CAST(N'1943-07-08T00:00:00.000' AS DateTime), 1, N'208 Havey Drive', N'590-448-2728', N'djakubowsky7x@addtoany.com', 120, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1313, N'508607617265127294', N'Egbert', N'Twila', N'Eddi', N'Collisson', CAST(N'1908-06-04T00:00:00.000' AS DateTime), 1, N'81 Barby Point', N'156-986-8925', N'ecollisson7y@prnewswire.com', 50, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1314, N'622445036273663505', N'Huntley', N'Patience', N'Hendrika', N'Cuxon', CAST(N'1968-03-25T00:00:00.000' AS DateTime), 1, N'23 Northwestern Lane', N'534-257-6186', N'hcuxon7z@facebook.com', 48, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1315, N'190089767148236614', N'Thalia', N'Jerrylee', N'Lindi', N'Tomczykiewicz', CAST(N'1998-03-31T00:00:00.000' AS DateTime), 1, N'7722 Packers Terrace', N'570-423-7385', N'ltomczykiewicz80@wikia.com', 84, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1316, N'969066387079175434', N'Kameko', N'Rollins', N'Fedora', N'Leaf', CAST(N'1905-02-19T00:00:00.000' AS DateTime), 1, N'83 Monterey Point', N'457-524-2633', N'fleaf81@discovery.com', 168, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1317, N'964690484238608849', N'Ray', N'Lethia', N'Mic', N'Neumann', CAST(N'1908-08-07T00:00:00.000' AS DateTime), 1, N'3897 Crest Line Terrace', N'764-719-0481', N'mneumann82@blogspot.com', 108, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1318, N'825676030049788287', N'Clarinda', N'Lynelle', N'Talyah', N'MacMeanma', CAST(N'1996-07-26T00:00:00.000' AS DateTime), 0, N'925 Towne Crossing', N'141-128-0782', N'tmacmeanma83@reddit.com', 126, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1319, N'185465306003705231', N'Sebastien', N'Estella', N'Lauraine', N'Eilhertsen', CAST(N'1998-02-05T00:00:00.000' AS DateTime), 0, N'118 Forest Junction', N'589-518-4991', N'leilhertsen84@statcounter.com', 130, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1320, N'870981665077919053', N'Nedi', N'Ollie', N'Calhoun', N'Feacham', CAST(N'1995-02-12T00:00:00.000' AS DateTime), 0, N'9 Garrison Pass', N'409-926-1071', N'cfeacham85@phoca.cz', 7, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1321, N'695064974021295228', N'Charline', N'Diarmid', N'Linell', N'Humbell', CAST(N'1996-08-02T00:00:00.000' AS DateTime), 1, N'81 Bultman Trail', N'927-227-9488', N'lhumbell86@1688.com', 20, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1322, N'747590457840469585', N'Gayelord', N'Lois', N'Sari', N'Ferrie', CAST(N'1981-12-22T00:00:00.000' AS DateTime), 0, N'353 Saint Paul Terrace', N'772-874-4125', N'sferrie87@geocities.jp', 167, NULL)
GO
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1323, N'593443389831193116', N'Libbie', N'Carena', N'Doug', N'Gobeaux', CAST(N'1921-03-25T00:00:00.000' AS DateTime), 0, N'07164 Algoma Circle', N'660-750-5551', N'dgobeaux88@un.org', 187, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1324, N'130171347865281956', N'Lonnie', N'Drusi', N'Gwendolyn', N'Veltman', CAST(N'1951-12-25T00:00:00.000' AS DateTime), 1, N'3614 Elmside Center', N'762-760-1646', N'gveltman89@usgs.gov', 136, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1325, N'137922902631372134', N'Jeromy', N'Deny', N'Kahaleel', N'McFarland', CAST(N'2001-12-11T00:00:00.000' AS DateTime), 1, N'56 Dapin Terrace', N'591-893-7428', N'kmcfarland8a@kickstarter.com', 181, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1326, N'822783421081245229', N'Kitty', N'Loretta', N'Ella', N'Prose', CAST(N'1979-02-26T00:00:00.000' AS DateTime), 1, N'54109 Bonner Center', N'212-232-0570', N'eprose8b@ucoz.com', 95, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1327, N'123456789987654321', N'Trump', N'erick', N'jayce', N'trump', CAST(N'2008-07-08T13:16:37.450' AS DateTime), 0, N'NeyYork- Timesquare', N'9999912999', N'Trump@gmail.com', 185, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1328, N'403950945594093245', N'amar', N'klayn', N'moriti', N'slapi', CAST(N'2008-07-08T13:38:38.567' AS DateTime), 0, N'Mississippi- Kansas', N'5849549854', N'Amar@gmail.com', 3, N'C:\DVLD-Project-Images\23574fcc-4b63-4c56-9402-8e238ca962a1.png')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1329, N'125478965418976541', N'sali', N'Swift', N'Amber', N'Trump', CAST(N'2008-07-11T11:46:59.017' AS DateTime), 0, N'California- AlaskanValley', N'546465316366', N'Taylor@gmail.com', 3, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1330, N'3294056291439564312', N'Frieda', N'altman', N'tim', N'cook', CAST(N'2008-07-13T14:20:27.927' AS DateTime), 0, N'dksmdskcm', N'32984934883', N'Frieda@gmail.com', 3, N'C:\DVLD-Project-Images\a7ea1c29-d194-4860-a322-3f06c17f7ecf.png')
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1331, N'3394851029348543021', N'Abdelg', N'boukerm', N'', N'dddd', CAST(N'2008-07-18T11:07:42.047' AS DateTime), 0, N'babasaad', N'389843895499', N'', 3, NULL)
INSERT [dbo].[People] ([PersonID], [NationalNo], [FirstName], [SecondName], [ThirdName], [LastName], [DateOfBirth], [Gender], [Address], [Phone], [Email], [NationalityCountryID], [ImagePath]) VALUES (1332, N'3394851029348543021', N'Abdelg', N'boukerm', N'', N'dddd', CAST(N'2008-07-18T11:07:42.047' AS DateTime), 0, N'babasaad', N'389843895499', N'', 3, NULL)
SET IDENTITY_INSERT [dbo].[People] OFF
GO
SET IDENTITY_INSERT [dbo].[TestAppointments] ON 

INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (108, 1, 36, CAST(N'2023-10-07T10:46:00' AS SmallDateTime), CAST(10.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (109, 1, 36, CAST(N'2023-10-20T11:00:00' AS SmallDateTime), CAST(10.00 AS Decimal(18, 2)), 1, 1, 111)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (110, 2, 36, CAST(N'2023-10-07T11:01:00' AS SmallDateTime), CAST(20.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (111, 2, 36, CAST(N'2023-10-07T11:04:00' AS SmallDateTime), CAST(20.00 AS Decimal(18, 2)), 1, 1, 112)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (112, 3, 36, CAST(N'2023-10-07T11:05:00' AS SmallDateTime), CAST(30.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (113, 1, 37, CAST(N'2023-10-07T11:07:00' AS SmallDateTime), CAST(10.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (114, 2, 37, CAST(N'2023-10-07T11:08:00' AS SmallDateTime), CAST(20.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (115, 3, 37, CAST(N'2023-10-07T11:08:00' AS SmallDateTime), CAST(30.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (116, 1, 38, CAST(N'2023-10-07T11:17:00' AS SmallDateTime), CAST(10.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (117, 1, 38, CAST(N'2023-10-07T11:17:00' AS SmallDateTime), CAST(10.00 AS Decimal(18, 2)), 1, 1, 116)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (118, 2, 38, CAST(N'2023-10-07T11:31:00' AS SmallDateTime), CAST(20.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (119, 2, 38, CAST(N'2023-10-07T11:32:00' AS SmallDateTime), CAST(20.00 AS Decimal(18, 2)), 1, 1, 117)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (120, 3, 38, CAST(N'2023-10-07T11:39:00' AS SmallDateTime), CAST(30.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (121, 3, 38, CAST(N'2023-10-07T11:39:00' AS SmallDateTime), CAST(30.00 AS Decimal(18, 2)), 1, 0, 118)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (122, 1, 41, CAST(N'2023-10-10T21:44:00' AS SmallDateTime), CAST(10.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (123, 1, 41, CAST(N'2023-10-09T21:48:00' AS SmallDateTime), CAST(10.00 AS Decimal(18, 2)), 1, 1, 123)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (124, 2, 41, CAST(N'2023-10-19T21:51:00' AS SmallDateTime), CAST(20.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (125, 3, 41, CAST(N'2023-10-20T21:52:00' AS SmallDateTime), CAST(35.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (126, 3, 41, CAST(N'2023-10-09T21:52:00' AS SmallDateTime), CAST(35.00 AS Decimal(18, 2)), 1, 1, 124)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (127, 3, 41, CAST(N'2023-10-21T21:53:00' AS SmallDateTime), CAST(35.00 AS Decimal(18, 2)), 1, 1, 125)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (128, 1, 1043, CAST(N'2025-12-26T22:04:00' AS SmallDateTime), CAST(10.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (129, 2, 1043, CAST(N'2025-12-22T22:06:00' AS SmallDateTime), CAST(20.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (130, 2, 1043, CAST(N'2025-12-22T22:07:00' AS SmallDateTime), CAST(20.00 AS Decimal(18, 2)), 1, 1, 1133)
INSERT [dbo].[TestAppointments] ([TestAppointmentID], [TestTypeID], [LocalDrivingLicenseApplicationID], [AppointmentDate], [PaidFees], [CreatedByUserID], [IsLocked], [RetakeTestApplicationID]) VALUES (131, 3, 1043, CAST(N'2025-12-22T22:08:00' AS SmallDateTime), CAST(35.00 AS Decimal(18, 2)), 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[TestAppointments] OFF
GO
SET IDENTITY_INSERT [dbo].[Tests] ON 

INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (64, 108, 0, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (65, 109, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (66, 110, 0, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (67, 111, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (68, 112, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (69, 113, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (70, 114, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (71, 115, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (72, 116, 0, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (73, 117, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (74, 118, 0, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (75, 119, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (76, 120, 0, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (77, 122, 0, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (78, 123, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (79, 124, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (80, 125, 0, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (81, 126, 0, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (82, 127, 1, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (83, 128, 1, N'a', 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (84, 129, 0, NULL, 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (85, 130, 1, N'sss', 1)
INSERT [dbo].[Tests] ([TestID], [TestAppointmentID], [TestResult], [Notes], [CreatedByUserID]) VALUES (86, 131, 1, N'ss', 1)
SET IDENTITY_INSERT [dbo].[Tests] OFF
GO
SET IDENTITY_INSERT [dbo].[TestTypes] ON 

INSERT [dbo].[TestTypes] ([TestTypeID], [TestTypeTitle], [TestTypeDescription], [TestTypeFees]) VALUES (1, N'Vision Test', N'This assesses the applicant''s visual acuity to ensure they have sufficient vision to drive in Safe', CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[TestTypes] ([TestTypeID], [TestTypeTitle], [TestTypeDescription], [TestTypeFees]) VALUES (2, N'Written (Theory) Test', N'This test assesses the applicant''s knowledge of traffic rules, road signs, and driving regulations. It typically consists of multiple-choice questions, and the applicant must select the correct answer(s). The written test aims to ensure that the applicant understands the rules of the road and can apply them in various driving scenarios.', CAST(20.00 AS Decimal(18, 2)))
INSERT [dbo].[TestTypes] ([TestTypeID], [TestTypeTitle], [TestTypeDescription], [TestTypeFees]) VALUES (3, N'Practical (Street) Test', N'This test evaluates the applicant''s driving skills and ability to operate a motor vehicle safely on public roads. A licensed examiner accompanies the applicant in the vehicle and observes their driving performance.', CAST(35.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[TestTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [PersonID], [UserName], [Password], [IsActive]) VALUES (1, 1, N'Msaqer77', N'1234', 1)
INSERT [dbo].[Users] ([UserID], [PersonID], [UserName], [Password], [IsActive]) VALUES (15, 1025, N'user4', N'2345', 1)
INSERT [dbo].[Users] ([UserID], [PersonID], [UserName], [Password], [IsActive]) VALUES (17, 1023, N'Omar1', N'3456', 0)
INSERT [dbo].[Users] ([UserID], [PersonID], [UserName], [Password], [IsActive]) VALUES (18, 1024, N'User5', N'4567', 1)
INSERT [dbo].[Users] ([UserID], [PersonID], [UserName], [Password], [IsActive]) VALUES (19, 1029, N'User15', N'1990', 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_ApplicationStatus]  DEFAULT ((1)) FOR [ApplicationStatus]
GO
ALTER TABLE [dbo].[ApplicationTypes] ADD  CONSTRAINT [DF_ApplicationTypes_Fees]  DEFAULT ((0)) FOR [ApplicationFees]
GO
ALTER TABLE [dbo].[DetainedLicenses] ADD  CONSTRAINT [DF_DetainedLicenses_IsReleased]  DEFAULT ((0)) FOR [IsReleased]
GO
ALTER TABLE [dbo].[LicenseClasses] ADD  CONSTRAINT [DF_LicenseClasses_Age]  DEFAULT ((18)) FOR [MinimumAllowedAge]
GO
ALTER TABLE [dbo].[LicenseClasses] ADD  CONSTRAINT [DF_LicenseClasses_DefaultPeriodLength]  DEFAULT ((1)) FOR [DefaultValidityLength]
GO
ALTER TABLE [dbo].[LicenseClasses] ADD  CONSTRAINT [DF_LicenseClasses_ClassFees]  DEFAULT ((0)) FOR [ClassFees]
GO
ALTER TABLE [dbo].[Licenses] ADD  CONSTRAINT [DF_Licenses_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Licenses] ADD  CONSTRAINT [DF_Licenses_IssueReason]  DEFAULT ((1)) FOR [IssueReason]
GO
ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_Gendor]  DEFAULT ((0)) FOR [Gender]
GO
ALTER TABLE [dbo].[TestAppointments] ADD  CONSTRAINT [DF_TestAppointments_AppointmentLocked]  DEFAULT ((0)) FOR [IsLocked]
GO
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_ApplicationTypes] FOREIGN KEY([ApplicationTypeID])
REFERENCES [dbo].[ApplicationTypes] ([ApplicationTypeID])
GO
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_ApplicationTypes]
GO
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_People] FOREIGN KEY([ApplicantPersonID])
REFERENCES [dbo].[People] ([PersonID])
GO
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_People]
GO
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_Users] FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_Users]
GO
ALTER TABLE [dbo].[DetainedLicenses]  WITH CHECK ADD  CONSTRAINT [FK_DetainedLicenses_Applications] FOREIGN KEY([ReleaseApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[DetainedLicenses] CHECK CONSTRAINT [FK_DetainedLicenses_Applications]
GO
ALTER TABLE [dbo].[DetainedLicenses]  WITH CHECK ADD  CONSTRAINT [FK_DetainedLicenses_Licenses] FOREIGN KEY([LicenseID])
REFERENCES [dbo].[Licenses] ([LicenseID])
GO
ALTER TABLE [dbo].[DetainedLicenses] CHECK CONSTRAINT [FK_DetainedLicenses_Licenses]
GO
ALTER TABLE [dbo].[DetainedLicenses]  WITH CHECK ADD  CONSTRAINT [FK_DetainedLicenses_Users] FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[DetainedLicenses] CHECK CONSTRAINT [FK_DetainedLicenses_Users]
GO
ALTER TABLE [dbo].[DetainedLicenses]  WITH CHECK ADD  CONSTRAINT [FK_DetainedLicenses_Users1] FOREIGN KEY([ReleasedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[DetainedLicenses] CHECK CONSTRAINT [FK_DetainedLicenses_Users1]
GO
ALTER TABLE [dbo].[Drivers]  WITH CHECK ADD  CONSTRAINT [FK_Drivers_People] FOREIGN KEY([PersonID])
REFERENCES [dbo].[People] ([PersonID])
GO
ALTER TABLE [dbo].[Drivers] CHECK CONSTRAINT [FK_Drivers_People]
GO
ALTER TABLE [dbo].[Drivers]  WITH CHECK ADD  CONSTRAINT [FK_Drivers_Users] FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Drivers] CHECK CONSTRAINT [FK_Drivers_Users]
GO
ALTER TABLE [dbo].[InternationalLicenses]  WITH CHECK ADD  CONSTRAINT [FK_InternationalLicenses_Applications] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[InternationalLicenses] CHECK CONSTRAINT [FK_InternationalLicenses_Applications]
GO
ALTER TABLE [dbo].[InternationalLicenses]  WITH CHECK ADD  CONSTRAINT [FK_InternationalLicenses_Drivers] FOREIGN KEY([DriverID])
REFERENCES [dbo].[Drivers] ([DriverID])
GO
ALTER TABLE [dbo].[InternationalLicenses] CHECK CONSTRAINT [FK_InternationalLicenses_Drivers]
GO
ALTER TABLE [dbo].[InternationalLicenses]  WITH CHECK ADD  CONSTRAINT [FK_InternationalLicenses_Licenses] FOREIGN KEY([IssuedUsingLocalLicenseID])
REFERENCES [dbo].[Licenses] ([LicenseID])
GO
ALTER TABLE [dbo].[InternationalLicenses] CHECK CONSTRAINT [FK_InternationalLicenses_Licenses]
GO
ALTER TABLE [dbo].[InternationalLicenses]  WITH CHECK ADD  CONSTRAINT [FK_InternationalLicenses_Users] FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[InternationalLicenses] CHECK CONSTRAINT [FK_InternationalLicenses_Users]
GO
ALTER TABLE [dbo].[Licenses]  WITH CHECK ADD  CONSTRAINT [FK_Licenses_Applications] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[Licenses] CHECK CONSTRAINT [FK_Licenses_Applications]
GO
ALTER TABLE [dbo].[Licenses]  WITH CHECK ADD  CONSTRAINT [FK_Licenses_Drivers] FOREIGN KEY([DriverID])
REFERENCES [dbo].[Drivers] ([DriverID])
GO
ALTER TABLE [dbo].[Licenses] CHECK CONSTRAINT [FK_Licenses_Drivers]
GO
ALTER TABLE [dbo].[Licenses]  WITH CHECK ADD  CONSTRAINT [FK_Licenses_LicenseClasses] FOREIGN KEY([LicenseClass])
REFERENCES [dbo].[LicenseClasses] ([LicenseClassID])
GO
ALTER TABLE [dbo].[Licenses] CHECK CONSTRAINT [FK_Licenses_LicenseClasses]
GO
ALTER TABLE [dbo].[Licenses]  WITH CHECK ADD  CONSTRAINT [FK_Licenses_Users] FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Licenses] CHECK CONSTRAINT [FK_Licenses_Users]
GO
ALTER TABLE [dbo].[LocalDrivingLicenseApplications]  WITH CHECK ADD  CONSTRAINT [FK_DrivingLicsenseApplications_Applications] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[LocalDrivingLicenseApplications] CHECK CONSTRAINT [FK_DrivingLicsenseApplications_Applications]
GO
ALTER TABLE [dbo].[LocalDrivingLicenseApplications]  WITH CHECK ADD  CONSTRAINT [FK_DrivingLicsenseApplications_LicenseClasses] FOREIGN KEY([LicenseClassID])
REFERENCES [dbo].[LicenseClasses] ([LicenseClassID])
GO
ALTER TABLE [dbo].[LocalDrivingLicenseApplications] CHECK CONSTRAINT [FK_DrivingLicsenseApplications_LicenseClasses]
GO
ALTER TABLE [dbo].[People]  WITH CHECK ADD  CONSTRAINT [FK_People_Countries1] FOREIGN KEY([NationalityCountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO
ALTER TABLE [dbo].[People] CHECK CONSTRAINT [FK_People_Countries1]
GO
ALTER TABLE [dbo].[TestAppointments]  WITH CHECK ADD  CONSTRAINT [FK_TestAppointments_Applications] FOREIGN KEY([RetakeTestApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[TestAppointments] CHECK CONSTRAINT [FK_TestAppointments_Applications]
GO
ALTER TABLE [dbo].[TestAppointments]  WITH CHECK ADD  CONSTRAINT [FK_TestAppointments_LocalDrivingLicenseApplications] FOREIGN KEY([LocalDrivingLicenseApplicationID])
REFERENCES [dbo].[LocalDrivingLicenseApplications] ([LocalDrivingLicenseApplicationID])
GO
ALTER TABLE [dbo].[TestAppointments] CHECK CONSTRAINT [FK_TestAppointments_LocalDrivingLicenseApplications]
GO
ALTER TABLE [dbo].[TestAppointments]  WITH CHECK ADD  CONSTRAINT [FK_TestAppointments_TestTypes] FOREIGN KEY([TestTypeID])
REFERENCES [dbo].[TestTypes] ([TestTypeID])
GO
ALTER TABLE [dbo].[TestAppointments] CHECK CONSTRAINT [FK_TestAppointments_TestTypes]
GO
ALTER TABLE [dbo].[TestAppointments]  WITH CHECK ADD  CONSTRAINT [FK_TestAppointments_Users] FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[TestAppointments] CHECK CONSTRAINT [FK_TestAppointments_Users]
GO
ALTER TABLE [dbo].[Tests]  WITH CHECK ADD  CONSTRAINT [FK_Tests_TestAppointments] FOREIGN KEY([TestAppointmentID])
REFERENCES [dbo].[TestAppointments] ([TestAppointmentID])
GO
ALTER TABLE [dbo].[Tests] CHECK CONSTRAINT [FK_Tests_TestAppointments]
GO
ALTER TABLE [dbo].[Tests]  WITH CHECK ADD  CONSTRAINT [FK_Tests_Users] FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Tests] CHECK CONSTRAINT [FK_Tests_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_People] FOREIGN KEY([PersonID])
REFERENCES [dbo].[People] ([PersonID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_People]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewApplication]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddNewApplication]
	@ApplicantPersonID int,
	@ApplicationDate datetime,
	@ApplicationtypeID int,
	@ApplicationStatus tinyint,
	@LastStatusDate datetime,
	@PaidFees float,
	@CreatedByUserID int,
	@ApplicationID int output

as 
begin
	insert into Applications (ApplicantPersonID, ApplicationDate, ApplicationTypeID, ApplicationStatus, LastStatusDate, PaidFees, CreatedByUserID)
                             Values (@ApplicantPersonID, @ApplicationDate, @ApplicationTypeID, @ApplicationStatus, @LastStatusDate, @PaidFees, @CreatedByUserID)
						     set @ApplicationID = SCOPE_IDENTITY();
end


select * from Applications
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewDetainedLicense]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddNewDetainedLicense]
	@LicenseID int,
	@DetainDate datetime,
	@FineFees decimal(18,2),
	@CreatedByUserID int,
	@DetainID int output
as
begin
	INSERT INTO dbo.DetainedLicenses (LicenseID, DetainDate, FineFees, CreatedByUserID, IsReleased)
           VALUES
                (@LicenseID, @DetainDate, @FineFees, @CreatedByUserID, 0)
                set @DetainID = SCOPE_IDENTITY();
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewDriver]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddNewDriver]
	@PersonID int,
	@CreatedByUserID int,
	@CreatedDate datetime,
	@DriverID int output

as
begin
	Insert Into Drivers (PersonID,CreatedByUserID,CreatedDate)
                            Values (@PersonID,@CreatedByUserID,@CreatedDate);
       set @DriverID = SCOPE_IDENTITY();                   
                          
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewInternationalLicense]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddNewInternationalLicense]
	@ApplicationID int,
	@DriverID int,
	@IssuedUsingLocalLicenseID int,
	@IssueDate datetime,
    @ExpirationDate datetime,
    @IsActive bit,
    @CreatedByUserID int,
	@InternationalLicenseID int output
as
begin
	      Update InternationalLicenses 
      set IsActive=0
      where DriverID=@DriverID;

    INSERT INTO InternationalLicenses
      (
       ApplicationID,
       DriverID,
       IssuedUsingLocalLicenseID,
       IssueDate,
       ExpirationDate,
       IsActive,
       CreatedByUserID)
VALUES
      (@ApplicationID,
       @DriverID,
       @IssuedUsingLocalLicenseID,
       @IssueDate,
       @ExpirationDate,
       @IsActive,
       @CreatedByUserID);
   set @InternationalLicenseID = SCOPE_IDENTITY();
	
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewLicense]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddNewLicense]
	@DriverID int,
	@ApplicationID int,
	@LicenseClass int,
	@IssueDate datetime,
	@ExpirationDate datetime,
	@Notes nvarchar(500),
	@PaidFees decimal(18,2),
	@IsActive bit,
	@IssueReason nvarchar(300),
	@CreatedByUserID int,
	@LicenseID int output

as
begin
	      INSERT INTO Licenses
				  (ApplicationID,
				   DriverID,
				   LicenseClass,
				   IssueDate,
				   ExpirationDate,
				   Notes,
				   PaidFees,
				   IsActive,IssueReason,
				   CreatedByUserID)
			VALUES
				  (
				  @ApplicationID,
				  @DriverID,
				  @LicenseClass,
				  @IssueDate,
				  @ExpirationDate,
				  @Notes,
				  @PaidFees,
				  @IsActive,
				  @IssueReason, 
				  @CreatedByUserID);
			   set @LicenseID = SCOPE_IDENTITY();
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewLocalDriving]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_AddNewLocalDriving]
	@ApplicationID int,
	@LicenseClassID int,
	@LocalDrivingLicenseApplicationID int output
as
begin
	insert into LocalDrivingLicenseApplications(ApplicationID, LicenseClassID) 
	Values(@ApplicationID, @LicenseClassID)
	set @LocalDrivingLicenseApplicationID = SCOPE_IDENTITY();
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewPerson]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_AddNewPerson]
	@NationalNo nvarchar(20),
	@Firstname nvarchar(40),
	@Secondname nvarchar(40),
	@Thirdname nvarchar(40),
	@Lastname nvarchar(40),
	@DateOfBirth datetime,
	@Gender tinyint,
	@Address nvarchar(500),
	@Phone nvarchar(20),
	@Email nvarchar(50),
	@NationalityCountryID int,
	@ImagePath nvarchar(250),
	@PersonID int output

as
begin

	Insert into People(NationalNo, Firstname, Secondname, thirdname, lastname, dateofbirth, gender,
	address, phone, Email, NationalityCountryID, ImagePath)
	Values 
	(
    @NationalNo,
	@Firstname,
	@Secondname,
	@Thirdname,
	@Lastname,
	@DateOfBirth,
	@Gender,
	@Address,
	@Phone,
	@Email,
	@NationalityCountryID,
	@ImagePath
	)
	set @PersonID = SCOPE_IDENTITY();
	
end;
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewTest]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddNewTest]
	@TestAppointmentID int,
	@TestResult bit,
	@Notes nvarchar(300),
	@CreatedByUserID int,
	@TestID int output
as
begin
	Insert Into Tests (TestAppointmentID,TestResult,
                                                Notes,   CreatedByUserID)
                            Values (@TestAppointmentID,@TestResult,
                                                @Notes,   @CreatedByUserID);
                            
                                UPDATE TestAppointments 
                                SET IsLocked=1 where TestAppointmentID = @TestAppointmentID;

                                set @TestID = SCOPE_IDENTITY();
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewTestAppointment]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddNewTestAppointment]
	@TestTypeID int,
	@LocalDrivingLicenseApplicationID int,
	@AppointmentDate datetime,
	@PaidFees float,
	@UserID int,
	@IsLocked bit,
	@RetakeTestAppointmentID int,
	@TestAppointmentID int output
as
begin
	insert into TestAppointment (TestTypeID, LocalDrivingLicenseApplicationID, AppointmentDate, PaidFees, UserID, IsLocked, RetakeTestAppointmentID)
                                         Values (@TestTypeID, @LocalDrivingLicenseApplicationID, @AppointmentDate, @PaidFees, @UserID, @IsLocked, @RetakeTestAppointmentID)
    set @TestAppointmentID = SCOPE_IDENTITY();
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewUser]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[SP_AddNewUser]
	@PersonID int,
	@Username nvarchar(30),
	@Password nvarchar(250),
	@isActive tinyint,
	@UserID int output

as
begin
	insert into Users(PersonID, Username, Password, IsActive)
	values (@PersonID, @Username, @Password, @IsActive)

	set @UserID = SCOPE_IDENTITY();
end









GO
/****** Object:  StoredProcedure [dbo].[SP_DeactivateLicense]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_DeactivateLicense]
	@LicenseID int
	

as
begin
	      UPDATE Licenses
                           SET 
                              IsActive = 0
                             
                         WHERE LicenseID=@LicenseID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteApplication]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_DeleteApplication]
	@ApplicationID int

as 
begin
	Delete Applications Where ApplicationID = @ApplicationID;
end


GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteLocalDriving]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_DeleteLocalDriving]
	@LocaDrivingLicenseApplicationID int
as
begin
	Delete from LocalDrivingLicenseApplications where LocalDrivingLicenseApplicationID = @LocaDrivingLicenseApplicationID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePerson]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_DeletePerson]
	@PersonID int
as
begin
	delete from People Where PersonID = @PersonID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteUser]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_DeleteUser]
	@UserID int

as
begin
	Delete From Users Where UserID = @UserID;
end

















GO
/****** Object:  StoredProcedure [dbo].[SP_DoesAttendTestType]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_DoesAttendTestType]
	@LocalDrivingLicenseApplicationID int,
	@TestTypeID int
as 
begin
	SELECT top 1 Found=1
                            FROM LocalDrivingLicenseApplications INNER JOIN
                                 TestAppointments ON LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID = TestAppointments.LocalDrivingLicenseApplicationID INNER JOIN
                                 Tests ON TestAppointments.TestAppointmentID = Tests.TestAppointmentID
                            WHERE
                            (LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID = @LocalDrivingLicenseApplicationID) 
                            AND(TestAppointments.TestTypeID = @TestTypeID)
                            ORDER BY TestAppointments.TestAppointmentID desc
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DoesTestPassed]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_DoesTestPassed]
	@LocalDrivingLicenseID int,
	@TestTypeID int
as
begin
	SELECT top 1 TestResult
                            FROM LocalDrivingLicenseApplications INNER JOIN
                                 TestAppointments ON LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID = TestAppointments.LocalDrivingLicenseApplicationID INNER JOIN
                                 Tests ON TestAppointments.TestAppointmentID = Tests.TestAppointmentID
                            WHERE
                            (LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID = @LocalDrivingLicenseID)  
                            AND(TestAppointments.TestTypeID = @TestTypeID)
                            ORDER BY TestAppointments.TestAppointmentID desc;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_FindApplicationByID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_FindApplicationByID]
	@ApplicationID int

as 
begin
	Select * from Applications Where ApplicationID = @ApplicationID;
end


GO
/****** Object:  StoredProcedure [dbo].[SP_FindApplicationType]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_FindApplicationType]
	@ApplicationTypeID int
as
begin
	select * from ApplicationTypes Where ApplicationTypeID = @ApplicationTypeID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_FindLicenseClassesByClassname]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_FindLicenseClassesByClassname]
	@Classname nvarchar(150)
as
begin
	select * from LicenseClasses where ClassName = @Classname;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_FindLicenseClassesByID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_FindLicenseClassesByID]
	@LicenseClassID int
as
begin
	select * from LicenseClasses where LicenseClassID = @LicenseClassID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_FindNationalNo]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[SP_FindNationalNo]
		@Nationalno nvarchar(60)
as
begin
	if exists (select 1 from people where NationalNo = @Nationalno)
		begin
			select 1;
		end
	else
		begin
			select 0;
		end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_FindPersonByNationalNo]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_FindPersonByNationalNo]
	@NationalNo nvarchar(20)

as
begin 
	select * from People
	where NationalNo = @NationalNo;


end;
GO
/****** Object:  StoredProcedure [dbo].[SP_FindPersonByPersonID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_FindPersonByPersonID]
	@PersonID int

as
begin 
	select * from People
	where PersonID = @PersonID;


end;


GO
/****** Object:  StoredProcedure [dbo].[SP_FindTestTypes]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_FindTestTypes]
	@TestTypeID int
as
begin
	select * from TestTypes Where TestTypeID = @TestTypeID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_FindUserByPersonID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SP_FindUserByPersonID]
	@PersonID int

as
begin
	select * from UsersView Where PersonID = @PersonID;
end















GO
/****** Object:  StoredProcedure [dbo].[SP_FindUserByUserID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[SP_FindUserByUserID]
	@UserID int

as
begin
	select * from UsersView Where UserID = @UserID;
end















GO
/****** Object:  StoredProcedure [dbo].[SP_FindUserByUsername]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_FindUserByUsername]
	@Username nvarchar(100)
as
begin
	select * from Users Where UserName = @Username
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetActiveApplication]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetActiveApplication]
	@ApplicantPersonID int,
	@ApplicationTypeID int

as 
begin
	select ActiveApplicationID= ApplicationID from Applications 
                             where ApplicantPersonID =@ApplicantPersonID and ApplicationTypeID = @ApplicationTypeID 
                             and ApplicationStatus = 1
end


GO
/****** Object:  StoredProcedure [dbo].[SP_GetActiveApplicationIDForLicenseClass]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetActiveApplicationIDForLicenseClass]
	@ApplicantPersonID int,
	@ApplicationTypeID int,
	@LicenseClassID int
as
begin
	SELECT ActiveApplicationID=App.ApplicationID  
                            From
                            Applications App INNER JOIN
                            LocalDrivingLicenseApplications LDLA ON App.ApplicationID = LDLA.ApplicationID
                            WHERE ApplicantPersonID = @ApplicantPersonID 
                            and ApplicationTypeID=@ApplicationTypeID 
							and LDLA.LicenseClassID = @LicenseClassID
                            and ApplicationStatus=1
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetActiveInternationalLicenseIDByDriverID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetActiveInternationalLicenseIDByDriverID]
	@DriverID int

as
begin
	    SELECT Top 1 InternationalLicenseID
		FROM InternationalLicenses 
		where DriverID=@DriverID and GetDate() between IssueDate and ExpirationDate 
		order by ExpirationDate Desc;
	
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetActiveLicenseIDByPersonID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetActiveLicenseIDByPersonID]
	@PersonID int,
	@LicenseClass int
	

as
begin
	      SELECT        Licenses.LicenseID
                            FROM Licenses INNER JOIN
                                                     Drivers ON Licenses.DriverID = Drivers.DriverID
                            WHERE  
                             
                             Licenses.LicenseClass = @LicenseClass 
                              AND Drivers.PersonID = @PersonID
                              And IsActive=1;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllApplications]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAllApplications]
as
begin
	select * from Applications
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllApplicationTypes]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAllApplicationTypes]
as
begin
	select * from ApplicationTypes
end


GO
/****** Object:  StoredProcedure [dbo].[SP_getallcountries]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_getallcountries]

as
begin
select * from countries
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllDetainedLicense]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAllDetainedLicense]
	
as
begin
	select * from detainedLicenses_View order by IsReleased ,DetainID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllDrivers]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAllDrivers]

as
begin
	SELECT * FROM Drivers_View order by FullName
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllInternationalLicenses]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAllInternationalLicenses]

as
begin
	SELECT    InternationalLicenseID, ApplicationID,DriverID,
            IssuedUsingLocalLicenseID , IssueDate, 
            ExpirationDate, IsActive
from InternationalLicenses 
    order by IsActive, ExpirationDate desc   
	
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllLicenses]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAllLicenses]

as
begin
	  SELECT * FROM Licenses
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllLocalDrivingLicenseApplication]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAllLocalDrivingLicenseApplication]

as
begin
	select * from LocalDrivingLicenseApplications_View order by ApplicationDate desc;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllPeople]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[SP_GetAllPeople]

as
begin

	select PersonID, NationalNo, Firstname, SecondName, Thirdname, Lastname, DateOfBirth, Gender, Address, Phone, Email,
	CountryName as Nationality , ImagePath
	from People
	inner join
	countries on People.NationalityCountryID = Countries.CountryID

end;



GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllTestAppointment]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAllTestAppointment]
	@TestTypeID int,
	@LocalDrivingLicenseApplicationID int
as
begin
	select * from TestAppointments_View
end




GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllTests]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAllTests]

as
begin
	SELECT * FROM Tests order by TestID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetallTestypes]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetallTestypes]
as
begin
	select * from TestTypes;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllUsers]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_GetAllUsers]

as
begin
	select * from UsersView
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetApplicationTestAppointmentPerTestType]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetApplicationTestAppointmentPerTestType]
	@TestTypeID int,
	@LocalDrivingLicenseApplicationID int
as
begin
	Select TestAppointments.TestAppointmentID, TestAppointments.AppointmentDate, TestAppointments.PaidFees, TestAppointments.IsLocked
                              from TestAppointments 
                              Where (TestTypeID = @TestTypeID) and (LocalDrivingLicenseApplicationID = @LocalDrivingLicenseApplicationID)
                              Order by TestAppointmentID Desc
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCountryByID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetCountryByID]
	@CountryID int
as
begin
	select * from Countries where CountryID = @CountryID
end


GO
/****** Object:  StoredProcedure [dbo].[SP_GetCountryByName]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_GetCountryByName]
	@Countryname nvarchar(40)
as
begin
	select * from Countries where CountryName = @Countryname
end


GO
/****** Object:  StoredProcedure [dbo].[SP_GetDetainedLicenseByLicenseID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetDetainedLicenseByLicenseID]
	@LicenseID int
as
begin
	SELECT top 1 * FROM DetainedLicenses WHERE LicenseID = @LicenseID order by DetainID desc
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDetainedLicenseID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetDetainedLicenseID]
	@DetainID int
as
begin
	SELECT * FROM DetainedLicenses WHERE DetainID = @DetainID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDriverInfoByDriverID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_GetDriverInfoByDriverID]
	@DriverID int
as
begin
	SELECT * FROM Drivers WHERE DriverID = @DriverID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDriverInfoByPersonID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetDriverInfoByPersonID]
	@PersonID int
as
begin
	SELECT * FROM Drivers WHERE PersonID = @PersonID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDriverInternationalLicenses]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetDriverInternationalLicenses]
	@DriverID int
as
begin
	SELECT    InternationalLicenseID, ApplicationID,
            IssuedUsingLocalLicenseID , IssueDate, 
            ExpirationDate, IsActive
from InternationalLicenses where DriverID=@DriverID
    order by ExpirationDate desc
	
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDriverLicenses]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetDriverLicenses]
	@DriverID int
as
begin
	 SELECT     
                           Licenses.LicenseID,
                           ApplicationID,
		                   LicenseClasses.ClassName, Licenses.IssueDate, 
		                   Licenses.ExpirationDate, Licenses.IsActive
                           FROM Licenses INNER JOIN
                                LicenseClasses ON Licenses.LicenseClass = LicenseClasses.LicenseClassID
                            where DriverID=@DriverID
                            Order By IsActive Desc, ExpirationDate Desc
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetInternationalLicenseInfoByID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetInternationalLicenseInfoByID]
	@INternationalLicenseID int

as
begin
	SELECT * FROM InternationalLicenses WHERE InternationalLicenseID = @InternationalLicenseID                                        
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetLastTestAppointment]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetLastTestAppointment]
	@TestTypeID int,
	@LocalDrivingLicenseApplicationID int
as
begin
	SELECT TOP 1 * FROM TestAppointments 
                             where TestTypeID = @TestTypeID
                             and LocalDrivingLicenseApplicationID = @LocalDrivingLicenseApplicationID
                             order by TestAppointmentID desc
end




GO
/****** Object:  StoredProcedure [dbo].[SP_GetLastTestByPersonAndTestTypeAndLicenseClass]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetLastTestByPersonAndTestTypeAndLicenseClass]
	@PersonID int,
	@LicenseClassID int,
	@TestTypeID int
as
begin
	SELECT  top 1 Tests.TestID, 
                Tests.TestAppointmentID, Tests.TestResult, 
			    Tests.Notes, Tests.CreatedByUserID, Applications.ApplicantPersonID
                FROM            LocalDrivingLicenseApplications INNER JOIN
                                         Tests INNER JOIN
                                         TestAppointments ON Tests.TestAppointmentID = TestAppointments.TestAppointmentID ON LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID = TestAppointments.LocalDrivingLicenseApplicationID INNER JOIN
                                         Applications ON LocalDrivingLicenseApplications.ApplicationID = Applications.ApplicationID
                WHERE        (Applications.ApplicantPersonID = @PersonID) 
                        AND (LocalDrivingLicenseApplications.LicenseClassID = @LicenseClassID)
                        AND ( TestAppointments.TestTypeID=@TestTypeID)
                ORDER BY Tests.TestAppointmentID DESC
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetLicenseInfoByID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetLicenseInfoByID]
	@LicenseID int

as
begin
	   SELECT * FROM Licenses WHERE LicenseID = @LicenseID
	
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetLocalDrivingLicesneInfoByApplicationID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetLocalDrivingLicesneInfoByApplicationID]
	@ApplicationID int
as
begin
	select * from LocalDrivingLicenseApplications where ApplicationID = @ApplicationID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetLocalDrivingLicesneInfoByID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetLocalDrivingLicesneInfoByID]
	@LocalDrivingLicenseID int
as
begin
	select * from LocalDrivingLicenseApplications Where LocalDrivingLicenseApplicationID = @LocalDrivingLicenseID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPassedTestCount]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetPassedTestCount]
	@LocalDrivingLicenseApplicationID int
as
begin
	SELECT PassedTestCount = count(TestTypeID)
                         FROM Tests INNER JOIN
                         TestAppointments ON Tests.TestAppointmentID = TestAppointments.TestAppointmentID
						 where LocalDrivingLicenseApplicationID =@LocalDrivingLicenseApplicationID and TestResult=1
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTestAppointmentInfoByID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetTestAppointmentInfoByID]
	@TestAppointmentID int
as
begin
	select * from TestAppointments where TestAppointmentID = @TestAppointmentID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTestID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetTestID]
	@TestAppointmentID int
as
begin
	Select TestID from Tests Where TestAppointmentID = @TestAppointmentID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTestInfoByID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetTestInfoByID]
	@TestID int
as
begin
	      SELECT * FROM Tests WHERE TestID = @TestID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_IsLicenseDetained]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_IsLicenseDetained]
	@LicenseID int
	
as
begin
	select IsDetained=1 
                            from detainedLicenses 
                            where 
                            LicenseID=@LicenseID 
                            and IsReleased=0;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_IsPersonExistByNationalNo]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_IsPersonExistByNationalNo]
	@NationalNo nvarchar(200)

as
begin
	if exists (select 1 from People Where NationalNo = @NationalNo)
		begin
			select 1;
		end
	else
		begin
			select 0;
		end
end












GO
/****** Object:  StoredProcedure [dbo].[SP_IsPersonIDExist]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_IsPersonIDExist]
	@PersonID int

as
begin
	if exists (select 1 from People Where PersonID = @PersonID)
		begin
			select 1;
		end
	else
		begin
			select 0;
		end
end












GO
/****** Object:  StoredProcedure [dbo].[SP_IsThereAnActiveScheduledTest]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_IsThereAnActiveScheduledTest]
	@LocalDrivingLicenseApplicationID int,
	@TestTypeID int
as 
begin
	SELECT top 1 Found=1
                            FROM LocalDrivingLicenseApplications INNER JOIN
                                 TestAppointments ON LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID = TestAppointments.LocalDrivingLicenseApplicationID 
                            WHERE
                            (LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID = @LocalDrivingLicenseApplicationID)  
                            AND(TestAppointments.TestTypeID = @TestTypeID) and isLocked=0
                            ORDER BY TestAppointments.TestAppointmentID desc;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_IsUserExists]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_IsUserExists]
	@UserID int
as
begin
	if exists (select 1 from Users Where UserID = @UserID)
		begin
			select 1;
		end
	else
		begin
			select 0;
		end
end















GO
/****** Object:  StoredProcedure [dbo].[SP_IsUserExistsByPersonID]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_IsUserExistsByPersonID]
	@PersonID int

as
begin
	if exists (select 1 from Users Where PersonID = @PersonID)
		begin
			select 1;
		end
	else
		begin
			select 0;
		end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_IsUserExistsByUsername]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_IsUserExistsByUsername]
	@Username nvarchar(100)
as
begin
	if exists (select 1 from users where UserName = @Username)
	begin
		select 1
	end
else
	begin
		select 0
	end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ReleaseDetainLicense]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_ReleaseDetainLicense]
	@DetainID int,
	@ReleaseDate datetime,
	@ReleaseApplicationID int
as
begin
	UPDATE dbo.DetainedLicenses
                              SET IsReleased = 1, 
                              ReleaseDate = @ReleaseDate, 
                              ReleaseApplicationID = @ReleaseApplicationID   
                              WHERE DetainID=@DetainID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_TotalTrialPerTest]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_TotalTrialPerTest]
	@LocalDrivingLicenseApplicationID int,
	@TestTypeID int
as 
begin
	SELECT TotalTrialsPerTest = count(TestID)
                            FROM LocalDrivingLicenseApplications INNER JOIN
                                 TestAppointments ON LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID = TestAppointments.LocalDrivingLicenseApplicationID INNER JOIN
                                 Tests ON TestAppointments.TestAppointmentID = Tests.TestAppointmentID
                            WHERE
                            (LocalDrivingLicenseApplications.LocalDrivingLicenseApplicationID = @LocalDrivingLicenseApplicationID) 
                            AND(TestAppointments.TestTypeID = @TestTypeID)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateApplication]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateApplication]
	@ApplicantPersonID int,
	@ApplicationDate datetime,
	@ApplicationtypeID int,
	@ApplicationStatus tinyint,
	@LastStatusDate datetime,
	@PaidFees float,
	@CreatedByUserID int,
	@ApplicationID int

as 
begin
	Update Applications
                             Set ApplicantPersonID = @ApplicantPersonID,
                                 ApplicationDate = @ApplicationDate, 
                                 ApplicationTypeID = @ApplicationTypeID,
                                 ApplicationStatus = @ApplicationStatus, 
                                 LastStatusDate = @LastStatusDate, 
                                 PaidFees = @PaidFees, 
                                 CreatedByUserID = @CreatedByUserID
                                 Where ApplicationID = @ApplicationID;
end


GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateApplicationTypes]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateApplicationTypes]
	@ApplicationTypeID int,
	@ApplicationTypeTitle nvarchar(350),
	@ApplicationFees smallmoney
as
begin
	update ApplicationTypes
	set
		ApplicationTypeTitle = @ApplicationTypeTitle,
		ApplicationFees = @ApplicationFees
	where ApplicationTypeID = @ApplicationTypeID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateDetainedLicense]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateDetainedLicense]
	@LicenseID int,
	@DetainDate datetime,
	@FineFees decimal(18,2),
	@CreatedByUserID int,
	@DetainID int output
as
begin
	UPDATE dbo.DetainedLicenses
                              SET LicenseID = @LicenseID, 
                              DetainDate = @DetainDate, 
                              FineFees = @FineFees,
                              CreatedByUserID = @CreatedByUserID
                              WHERE DetainID=@DetainID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateDriver]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateDriver]
	@PersonID int,
	@CreatedByUserID int,
	@DriverID int

as
begin
	Update  Drivers  
                            set PersonID = @PersonID,
                                CreatedByUserID = @CreatedByUserID
                                where DriverID = @DriverID                  
                          
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateInternationalLicense]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateInternationalLicense]
	@ApplicationID int,
	@DriverID int,
	@IssuedUsingLocalLicenseID int,
	@IssueDate datetime,
    @ExpirationDate datetime,
    @IsActive bit,
    @CreatedByUserID int,
	@InternationalLicenseID int 
as
begin
	   UPDATE InternationalLicenses
                           SET 
                              ApplicationID=@ApplicationID,
                              DriverID = @DriverID,
                              IssuedUsingLocalLicenseID = @IssuedUsingLocalLicenseID,
                              IssueDate = @IssueDate,
                              ExpirationDate = @ExpirationDate,
                              IsActive = @IsActive,
                              CreatedByUserID = @CreatedByUserID
                         WHERE InternationalLicenseID=@InternationalLicenseID
	
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateLicense]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateLicense]
	@DriverID int,
	@ApplicationID int,
	@LicenseClass int,
	@IssueDate datetime,
	@ExpirationDate datetime,
	@Notes nvarchar(500),
	@PaidFees decimal(18,2),
	@IsActive bit,
	@IssueReason nvarchar(300),
	@CreatedByUserID int,
	@LicenseID int

as
begin
	      UPDATE Licenses
                           SET ApplicationID=@ApplicationID,
							  DriverID = @DriverID,
                              LicenseClass = @LicenseClass,
                              IssueDate = @IssueDate,
                              ExpirationDate = @ExpirationDate,
                              Notes = @Notes,
                              PaidFees = @PaidFees,
                              IsActive = @IsActive,IssueReason=@IssueReason,
                              CreatedByUserID = @CreatedByUserID
                         WHERE LicenseID=@LicenseID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateLocalDriving]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateLocalDriving]
	@ApplicationID int,
	@LicenseClassID  int,
	@LocaDrivingLicenseApplicationID int
as
begin
	update LocalDrivingLicenseApplications
	set
	ApplicationID = @ApplicationID,
	LicenseClassID = @LicenseClassID
	where LocalDrivingLicenseApplicationID = @LocaDrivingLicenseApplicationID;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePerson]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_UpdatePerson]
	@PersonID int,
	@NationalNo nvarchar(20),
	@Firstname nvarchar(40),
	@Secondname nvarchar(40),
	@thirdname nvarchar(40),
	@Lastname nvarchar(40),
	@DateOfBirth datetime,
	@Gender tinyint,
	@Address nvarchar(500),
	@Phone nvarchar(20),
	@Email nvarchar(50),
	@NationalityCountryID int,
	@ImagePath nvarchar(250)
as
begin
	Update People
	set NationalNo = @NationalNo,
	Firstname =@Firstname,
	Secondname = @Secondname,
	thirdname = @thirdname,
	lastname = @Lastname,
	dateofbirth = @DateOfBirth,
	gender = @Gender,
	address = @Address,
	phone = @Phone,
	Email = @Email,
	NationalityCountryID = @NationalityCountryID,
	ImagePath = @ImagePath
	Where PersonID = @PersonID;

end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateStatus]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateStatus]
	@ApplicationStatus smallint,
	@LastStatusDate datetime,
	@ApplicationID int
as
begin
	update Applications
	set 
		ApplicationStatus = @ApplicationStatus,
		LastStatusDate = @LastStatusDate
	where ApplicationID = @ApplicationID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateTest]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateTest]
	@TestAppointmentID int,
	@TestResult bit,
	@Notes nvarchar(300),
	@CreatedByUserID int,
	@TestID int
as
begin
	Update  Tests  
                            set TestAppointmentID = @TestAppointmentID,
                                TestResult=@TestResult,
                                Notes = @Notes,
                                CreatedByUserID=@CreatedByUserID
                                where TestID = @TestID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateTestAppointment]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateTestAppointment]
	@TestTypeID int,
	@LocalDrivingLicenseApplicationID int,
	@AppointmentDate datetime,
	@PaidFees float,
	@UserID int,
	@IsLocked bit,
	@RetakeTestAppointmentID int,
	@TestAppointmentID int output
as
begin
	Update TestAppointments 
                             Set 
                             TestTypeID = @TestTypeID,
                             LocalDrivingLicenseApplicationID = @LocalDrivingLicenseApplicationID,
                             AppointmentDate = @AppointmentDate,
                             PaidFees = @PaidFees,
                             CreatedByUserID = @UserID,
                             IsLocked = @IsLocked,
                             RetakeTestApplicationID = @RetakeTestAppointmentID
                             Where TestAppointmentID = @TestAppointmentID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateTestType]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateTestType]
	@TestTypeTitle nvarchar(70),
	@TestTypeDescription nvarchar(250),
	@TestTypeFees float,
	@TestTypeID int
as
begin
	Update TestTypes
                              Set TestTypeTitle = @TestTypeTitle,
                                  TestTypeDescription = @TestTypeDescription,
                                  TestTypeFees = @TestTypeFees
                              Where TestTypeID = @TestTypeID
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateUsers]    Script Date: 7/29/2026 3:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_UpdateUsers]
	@UserID int,
	@PersonID int,
	@Username nvarchar(40),
	@Password nvarchar(250),
	@IsActive tinyint

as
begin
	Update Users
	set 
		PersonID = @PersonID,
		Username = @Username,
		Password = @Password,
		IsActive = @IsActive
		Where UserID = @UserID
end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1-New 2-Cancelled 3-Completed' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Applications', @level2type=N'COLUMN',@level2name=N'ApplicationStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Minmum age allowed to apply for this license' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LicenseClasses', @level2type=N'COLUMN',@level2name=N'MinimumAllowedAge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'How many years the licesnse will be valid.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LicenseClasses', @level2type=N'COLUMN',@level2name=N'DefaultValidityLength'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1-FirstTime, 2-Renew, 3-Replacement for Damaged, 4- Replacement for Lost.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Licenses', @level2type=N'COLUMN',@level2name=N'IssueReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 Male , 1 Femail' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'People', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 - Fail 1-Pass' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tests', @level2type=N'COLUMN',@level2name=N'TestResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "People"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Drivers"
            Begin Extent = 
               Top = 39
               Left = 429
               Bottom = 169
               Right = 606
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Licenses"
            Begin Extent = 
               Top = 24
               Left = 701
               Bottom = 154
               Right = 878
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "DetainedLicenses"
            Begin Extent = 
               Top = 5
               Left = 907
               Bottom = 135
               Right = 1107
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DetainedLicenses_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DetainedLicenses_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Drivers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "People"
            Begin Extent = 
               Top = 6
               Left = 253
               Bottom = 136
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Drivers_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Drivers_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "LocalDrivingLicenseApplications"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 309
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Applications"
            Begin Extent = 
               Top = 6
               Left = 347
               Bottom = 136
               Right = 534
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LicenseClasses"
            Begin Extent = 
               Top = 196
               Left = 343
               Bottom = 326
               Right = 549
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "People"
            Begin Extent = 
               Top = 6
               Left = 816
               Bottom = 136
               Right = 1017
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LocalDrivingLicenseApplications_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LocalDrivingLicenseApplications_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Applications"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LocalDrivingLicenseApplications"
            Begin Extent = 
               Top = 6
               Left = 263
               Bottom = 119
               Right = 529
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LocalDrivingLicenseFullApplications_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LocalDrivingLicenseFullApplications_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TestAppointments"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 304
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "TestTypes"
            Begin Extent = 
               Top = 6
               Left = 342
               Bottom = 136
               Right = 537
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LocalDrivingLicenseApplications"
            Begin Extent = 
               Top = 6
               Left = 575
               Bottom = 119
               Right = 841
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Applications"
            Begin Extent = 
               Top = 6
               Left = 879
               Bottom = 136
               Right = 1066
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "People"
            Begin Extent = 
               Top = 6
               Left = 1104
               Bottom = 136
               Right = 1305
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LicenseClasses"
            Begin Extent = 
               Top = 6
               Left = 1343
               Bottom = 136
               Right = 1549
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TestAppointments_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TestAppointments_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TestAppointments_View'
GO
USE [master]
GO
ALTER DATABASE [DVLD] SET  READ_WRITE 
GO

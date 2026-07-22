USE [master]
GO
/****** Object:  Database [DVLD]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  Table [dbo].[People]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  View [dbo].[UsersView]    Script Date: 7/22/2026 9:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[UsersView] as 
select U.UserID, U.PersonID, (P.firstname + ' ' + P.Secondname + ' ' + P.Thirdname + ' ' + P.Lastname) as fullname, U.Username,U.Password, U.IsActive
from Users U inner join People P
on U.PersonID = P.PersonID;
GO
/****** Object:  Table [dbo].[DetainedLicenses]    Script Date: 7/22/2026 9:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetainedLicenses](
	[DetainID] [int] IDENTITY(1,1) NOT NULL,
	[LicenseID] [int] NOT NULL,
	[DetainDate] [smalldatetime] NOT NULL,
	[FineFees] [smallmoney] NOT NULL,
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
/****** Object:  Table [dbo].[Licenses]    Script Date: 7/22/2026 9:47:30 PM ******/
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
	[PaidFees] [smallmoney] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IssueReason] [tinyint] NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
 CONSTRAINT [PK_Licenses] PRIMARY KEY CLUSTERED 
(
	[LicenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Drivers]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  View [dbo].[DetainedLicenses_View]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  Table [dbo].[Applications]    Script Date: 7/22/2026 9:47:30 PM ******/
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
	[PaidFees] [smallmoney] NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocalDrivingLicenseApplications]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  View [dbo].[LocalDrivingLicenseFullApplications_View]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  Table [dbo].[TestAppointments]    Script Date: 7/22/2026 9:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestAppointments](
	[TestAppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[TestTypeID] [int] NOT NULL,
	[LocalDrivingLicenseApplicationID] [int] NOT NULL,
	[AppointmentDate] [smalldatetime] NOT NULL,
	[PaidFees] [smallmoney] NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
	[IsLocked] [bit] NOT NULL,
	[RetakeTestApplicationID] [int] NULL,
 CONSTRAINT [PK_TestAppointments] PRIMARY KEY CLUSTERED 
(
	[TestAppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tests]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  Table [dbo].[LicenseClasses]    Script Date: 7/22/2026 9:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LicenseClasses](
	[LicenseClassID] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [nvarchar](50) NOT NULL,
	[ClassDescription] [nvarchar](500) NOT NULL,
	[MinimumAllowedAge] [tinyint] NOT NULL,
	[DefaultValidityLength] [tinyint] NOT NULL,
	[ClassFees] [smallmoney] NOT NULL,
 CONSTRAINT [PK_LicenseClasses] PRIMARY KEY CLUSTERED 
(
	[LicenseClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LocalDrivingLicenseApplications_View]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  Table [dbo].[TestTypes]    Script Date: 7/22/2026 9:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTypes](
	[TestTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TestTypeTitle] [nvarchar](100) NOT NULL,
	[TestTypeDescription] [nvarchar](500) NOT NULL,
	[TestTypeFees] [smallmoney] NOT NULL,
 CONSTRAINT [PK_TestTypes] PRIMARY KEY CLUSTERED 
(
	[TestTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TestAppointments_View]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  View [dbo].[Drivers_View]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  Table [dbo].[ApplicationTypes]    Script Date: 7/22/2026 9:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationTypes](
	[ApplicationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationTypeTitle] [nvarchar](150) NOT NULL,
	[ApplicationFees] [smallmoney] NOT NULL,
 CONSTRAINT [PK_ApplicationTypes] PRIMARY KEY CLUSTERED 
(
	[ApplicationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  Table [dbo].[InternationalLicenses]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[FindUserByUserID]    Script Date: 7/22/2026 9:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[FindUserByUserID]
	@UserID int

as
begin
	select * from UsersView Where UserID = @UserID;
end















GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewApplication]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AddNewLocalDriving]    Script Date: 7/22/2026 9:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddNewLocalDriving]
	@ApplicationID int,
	@LicenseClassID  int,
	@LocaDrivingLicenseApplicationID int output
as
begin
	insert into LocalDrivingLicenseApplications(ApplicationID, LicenseClassID) 
	Values(@ApplicationID, @LicenseClassID)
	set @LocaDrivingLicenseApplicationID = SCOPE_IDENTITY();
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewPerson]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AddNewTestAppointment]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AddNewUser]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeleteApplication]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeleteLocalDriving]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeletePerson]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeleteUser]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DoesAttendTestType]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DoesTestPassed]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_FindApplicationByID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_FindApplicationType]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_FindLicenseClassesByClassname]    Script Date: 7/22/2026 9:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_FindLicenseClassesByClassname]
	@Classname int
as
begin
	select * from LicenseClasses where ClassName = @Classname;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_FindLicenseClassesByID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_FindNationalNo]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_FindPersonByNationalNo]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_FindPersonByPersonID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_FindTestTypes]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_FindUserByPersonID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_FindUserByUsername]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetActiveApplication]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetActiveApplicationIDForLicenseClass]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllApplications]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllApplicationTypes]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_getallcountries]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllLocalDrivingLicenseApplication]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllPeople]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllTestAppointment]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetallTestypes]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllUsers]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetApplicationTestAppointmentPerTestType]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetCountryByID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetCountryByName]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetLastTestAppointment]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetLocalDrivingLicesneInfoByApplicationID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetLocalDrivingLicesneInfoByID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetTestAppointmentInfoByID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetTestID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_IsPersonExistByNationalNo]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_IsPersonIDExist]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_IsThereAnActiveScheduledTest]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_IsUserExists]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_IsUserExistsByPersonID]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_IsUserExistsByUsername]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_TotalTrialPerTest]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateApplication]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateApplicationTypes]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateLocalDriving]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdatePerson]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateStatus]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateTestAppointment]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateTestType]    Script Date: 7/22/2026 9:47:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateUsers]    Script Date: 7/22/2026 9:47:30 PM ******/
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

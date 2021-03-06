USE [master]
GO
/****** Object:  Database [NotesMarketplace]    Script Date: 10-04-2021 05:10:01 PM ******/
CREATE DATABASE [NotesMarketplace]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NotesMarketplace', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\NotesMarketplace.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NotesMarketplace_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\NotesMarketplace_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [NotesMarketplace] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NotesMarketplace].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ARITHABORT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NotesMarketplace] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NotesMarketplace] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NotesMarketplace] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NotesMarketplace] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NotesMarketplace] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NotesMarketplace] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NotesMarketplace] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NotesMarketplace] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NotesMarketplace] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NotesMarketplace] SET RECOVERY FULL 
GO
ALTER DATABASE [NotesMarketplace] SET  MULTI_USER 
GO
ALTER DATABASE [NotesMarketplace] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NotesMarketplace] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NotesMarketplace] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NotesMarketplace] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NotesMarketplace] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NotesMarketplace', N'ON'
GO
ALTER DATABASE [NotesMarketplace] SET QUERY_STORE = OFF
GO
USE [NotesMarketplace]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 10-04-2021 05:10:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](100) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[DateAdded] [datetime] NULL,
	[AddedBy] [int] NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](100) NOT NULL,
	[CountryCode] [varchar](10) NOT NULL,
	[DateAdded] [datetime] NULL,
	[AddedBy] [int] NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Downloads]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Downloads](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NoteID] [int] NOT NULL,
	[Seller] [int] NOT NULL,
	[Downloader] [int] NOT NULL,
	[IsSellerHasAllowedDownload] [bit] NOT NULL,
	[AttachmentPath] [varchar](max) NULL,
	[IsAttachmentDownloaded] [bit] NOT NULL,
	[AttachmentDownloadedDate] [datetime] NULL,
	[IsPaid] [bit] NOT NULL,
	[PurchasedPrice] [int] NULL,
	[NoteTitle] [varchar](100) NOT NULL,
	[NoteCategory] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_Downloads] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotesAttachments]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotesAttachments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NoteID] [int] NOT NULL,
	[FileName] [varchar](100) NOT NULL,
	[FilePath] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_NotesAttachments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotesDetails]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotesDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SellerID] [int] NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[DisplayPicture] [varchar](max) NULL,
	[NotePreview] [varchar](max) NULL,
	[CategoryID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[NumberOfPages] [int] NULL,
	[IsPaid] [bit] NOT NULL,
	[Price] [int] NOT NULL,
	[PublishedDate] [datetime] NOT NULL,
	[ActionedBy] [int] NOT NULL,
	[AdminRemarks] [varchar](max) NULL,
	[Status] [varchar](100) NULL,
	[UniversityName] [varchar](200) NULL,
	[CountryID] [int] NULL,
	[Course] [varchar](100) NULL,
	[CourseCode] [varchar](100) NULL,
	[Professor] [varchar](100) NULL,
	[DateAdded] [datetime] NULL,
	[AddedBy] [int] NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_NotesDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReferenceData]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferenceData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [varchar](100) NOT NULL,
	[Datavalue] [varchar](100) NOT NULL,
	[RefCategory] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ReferenceData] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[AgainstDownloadsID] [int] NOT NULL,
	[ReviewedByUserID] [int] NOT NULL,
	[ReviewedNoteID] [int] NOT NULL,
	[Ratings] [int] NOT NULL,
	[Comments] [varchar](max) NOT NULL,
	[DateReviewed] [datetime] NOT NULL,
	[ReviewedBy] [int] NOT NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpamReports]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpamReports](
	[SpamReportID] [int] IDENTITY(1,1) NOT NULL,
	[NoteID] [int] NOT NULL,
	[ReportedByUserID] [int] NOT NULL,
	[AgainstDownloadID] [int] NOT NULL,
	[DateReported] [datetime] NULL,
	[Remarks] [varchar](100) NOT NULL,
	[AddedBy] [int] NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_SpamReports] PRIMARY KEY CLUSTERED 
(
	[SpamReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemConfigurations]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfigurations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[key] [varchar](100) NOT NULL,
	[Value] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_SystemConfigurations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Types]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Types](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [varchar](100) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[DateAdded] [datetime] NULL,
	[AddedBy] [int] NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Types] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[SecondaryEmailID] [varchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[Gender] [varchar](20) NULL,
	[CountryCode] [varchar](5) NULL,
	[PhoneNumber] [varchar](20) NULL,
	[ProfilePicture] [varchar](max) NULL,
	[AddressLine1] [varchar](100) NOT NULL,
	[AddressLine2] [varchar](100) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[ZipCode] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[University] [varchar](100) NULL,
	[College] [varchar](100) NULL,
	[DateAdded] [datetime] NULL,
	[AddedBy] [int] NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[RoleDescription] [varchar](max) NULL,
	[DateAdded] [datetime] NULL,
	[AddedBy] [int] NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10-04-2021 05:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(0,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[EmailID] [varchar](100) NOT NULL,
	[Password] [varchar](24) NOT NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[DateAdded] [datetime] NULL,
	[AddedBy] [int] NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (1, N'Cat1', N'Cat1', CAST(N'2021-04-09T00:00:00.000' AS DateTime), 5, NULL, NULL, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (2, N'Cat2', N'Cat2', CAST(N'2021-04-09T00:00:00.000' AS DateTime), 5, NULL, NULL, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (4, N'Cat3', N'Cat3', CAST(N'2021-04-09T00:00:00.000' AS DateTime), 5, CAST(N'2021-04-09T11:20:46.867' AS DateTime), 5, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (5, N'Cat4', N'Cat4', CAST(N'2021-04-09T00:00:00.000' AS DateTime), 5, CAST(N'2021-04-09T11:22:38.663' AS DateTime), 5, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (6, N'Cat5', N'Cat5', CAST(N'2021-04-09T11:20:00.000' AS DateTime), 5, CAST(N'2021-04-09T11:20:14.597' AS DateTime), 5, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (7, N'Cat6', N'Cat6', CAST(N'2021-04-09T11:22:20.000' AS DateTime), 5, CAST(N'2021-04-09T11:22:30.970' AS DateTime), 5, 0)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([CountryID], [CountryName], [CountryCode], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (1, N'Country1', N'123', CAST(N'2021-04-09T00:00:00.000' AS DateTime), 5, CAST(N'2021-04-09T18:15:11.840' AS DateTime), 5, 1)
INSERT [dbo].[Countries] ([CountryID], [CountryName], [CountryCode], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (2, N'Country2', N'1238', CAST(N'2021-04-09T00:00:00.000' AS DateTime), 5, CAST(N'2021-04-09T18:15:44.940' AS DateTime), 5, 1)
INSERT [dbo].[Countries] ([CountryID], [CountryName], [CountryCode], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (3, N'Country3', N'1234', CAST(N'2021-04-09T00:00:00.000' AS DateTime), 5, CAST(N'2021-04-09T18:15:29.150' AS DateTime), 5, 1)
INSERT [dbo].[Countries] ([CountryID], [CountryName], [CountryCode], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (4, N'Country4', N'159', CAST(N'2021-04-09T18:14:26.000' AS DateTime), 5, CAST(N'2021-04-09T18:15:39.173' AS DateTime), 5, 0)
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[Downloads] ON 

INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, 2, 0, 1, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 1, CAST(N'2021-02-02T00:00:00.000' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (3, 2, 0, 1, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 1, CAST(N'2021-02-02T00:00:00.000' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (4, 2, 0, 1, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-04T00:00:00.000' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, 2, 0, 0, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 1, CAST(N'2021-03-07T21:44:22.447' AS DateTime), 0, 0, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, 2, 0, 1, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-07T21:44:22.000' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, 2, 0, 1, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-07T21:44:22.000' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T09:16:57.580' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (9, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T09:25:30.507' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, 19, 0, 0, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Screenshot (2).png', 1, CAST(N'2021-03-26T09:34:51.303' AS DateTime), 0, 0, N'Title2', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (11, 19, 0, 0, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Screenshot (2).png', 1, CAST(N'2021-03-26T09:46:27.687' AS DateTime), 0, 0, N'Title2', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (12, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T09:50:14.340' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (13, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T09:50:37.797' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (14, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T09:52:40.423' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (15, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T09:55:50.277' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (16, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T09:56:17.040' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (17, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T09:58:20.833' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (18, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T09:59:01.903' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (19, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:01:12.153' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (20, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:01:57.870' AS DateTime), 0, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (21, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:12:57.373' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (22, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:13:25.253' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (23, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:17:09.127' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (24, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:18:37.967' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (25, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:19:27.617' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (26, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:20:25.363' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (27, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:24:14.260' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (28, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:27:54.887' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (29, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:30:19.060' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (30, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:34:49.663' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (31, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:36:09.373' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (32, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:37:26.970' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (33, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:44:25.087' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (34, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:45:56.903' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (35, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:46:50.020' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (36, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:47:20.653' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (37, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:49:19.330' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (38, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:58:07.920' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (39, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:58:11.650' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (40, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T10:58:26.543' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (41, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:25:13.513' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (42, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:25:49.850' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (43, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:26:08.743' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (44, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:26:56.507' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (45, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:27:44.193' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (46, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:34:53.523' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (47, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:34:53.573' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (48, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:35:26.900' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (49, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:51:09.087' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (50, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T11:59:59.057' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (51, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T12:04:37.203' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (52, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T12:04:50.110' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (53, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T13:25:44.777' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (54, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T13:26:57.440' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (55, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T13:27:53.157' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (56, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T13:29:40.307' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (57, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T13:33:32.797' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (58, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T13:42:26.613' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (59, 2, 0, 0, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T13:45:39.740' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (60, 19, 0, 0, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Screenshot (2).png', 1, CAST(N'2021-03-26T13:56:07.133' AS DateTime), 0, 0, N'Title2', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (61, 14, 0, 0, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Changed Domain.png', 1, CAST(N'2021-03-26T13:56:35.787' AS DateTime), 0, 0, N'Title1', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (62, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T14:22:46.157' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (63, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T14:23:59.457' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (64, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T14:29:11.957' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (65, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T14:29:31.473' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (66, 16, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', 0, CAST(N'2021-03-26T14:40:57.523' AS DateTime), 1, 100, N'New', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (67, 17, 0, 0, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', 1, CAST(N'2021-03-26T14:42:09.070' AS DateTime), 0, 0, N'asas', N'Cat2', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (68, 2, 0, 0, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T17:21:54.063' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (69, 2, 0, 0, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-03-26T17:51:53.783' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (70, 12, 0, 5, 1, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Changed Domain.png', 1, CAST(N'2021-04-03T14:39:03.060' AS DateTime), 0, 0, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (71, 2, 0, 5, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-04-03T15:39:26.630' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (72, 2, 0, 5, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-04-03T15:41:18.300' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
INSERT [dbo].[Downloads] ([ID], [NoteID], [Seller], [Downloader], [IsSellerHasAllowedDownload], [AttachmentPath], [IsAttachmentDownloaded], [AttachmentDownloadedDate], [IsPaid], [PurchasedPrice], [NoteTitle], [NoteCategory], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (73, 2, 0, 5, 0, N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', 0, CAST(N'2021-04-08T10:56:43.637' AS DateTime), 1, 100, N'Sagar', N'Cat1', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Downloads] OFF
GO
SET IDENTITY_INSERT [dbo].[NotesAttachments] ON 

INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 2, N'Abc.txt', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Abc.txt', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 11, N'Changed Domain.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Changed Domain.png', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 12, N'Changed Domain.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Changed Domain.png', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 13, N'170170107121_Sagar.pdf', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.pdf', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 14, N'Changed Domain.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Changed Domain.png', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 15, N'Changed Domain.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Changed Domain.png', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, 16, N'SagarVaghela.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, 17, N'SagarVaghela.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, 18, N'SagarVaghela.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, 18, N'SagarVaghela.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 18, N'SagarVaghela.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 19, N'Screenshot (2).png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Screenshot (2).png', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesAttachments] ([ID], [NoteID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 10, N'Screenshot (2).png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Screenshot (2).png', NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[NotesAttachments] OFF
GO
SET IDENTITY_INSERT [dbo].[NotesDetails] ON 

INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (2, 0, N'Sagar', N'Sample', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\1.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\AR.html', 1, 1, 20, 1, 100, CAST(N'2021-03-02T17:51:21.490' AS DateTime), 1, N'Abc', N'Published', N'GTU', 1, N'CE', N'123', N'ABC', CAST(N'2020-03-04T00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (3, 0, N'Sagar', N'Sample', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\1.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\AR.html', 1, 1, 20, 0, 0, CAST(N'2021-03-04T00:00:00.000' AS DateTime), 1, NULL, N'Draft', N'GTU', 1, N'CE', N'123', N'ABC', CAST(N'2020-03-04T00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (4, 0, N'Sagar', N'Sample', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\1.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\AR.html', 1, 1, 20, 0, 0, CAST(N'2021-04-03T11:07:18.020' AS DateTime), 1, NULL, N'Removed', N'GTU', 1, N'CE', N'123', N'ABC', CAST(N'2020-03-04T00:00:00.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (5, 0, N'Sagar', N'Sample', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\1.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\AR.html', 1, 1, 20, 0, 0, CAST(N'2021-03-04T00:00:00.000' AS DateTime), 1, NULL, N'InReview', N'GTU', 1, N'CE', N'123', N'ABC', CAST(N'2020-03-04T00:00:00.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (9, 0, N'Sagar', N'Sample', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\1.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\AR.html', 1, 1, 20, 0, 0, CAST(N'2021-03-04T00:00:00.000' AS DateTime), 1, N'This is test.', N'Removed', N'GTU', 1, N'CE', N'123', N'ABC', CAST(N'2020-03-04T00:00:00.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (10, 0, N'Sagar', N'Sample', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\1.png', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\AR.html', 1, 1, 20, 0, 0, CAST(N'2021-03-04T00:00:00.000' AS DateTime), 1, N'Dsdasdas', N'Published', N'GTU', 1, N'CE', N'123', N'ABC', CAST(N'2020-03-04T00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (11, 0, N'Sagar', N'chgs', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', 1, 1, 20, 1, 100, CAST(N'2021-03-07T16:29:52.613' AS DateTime), 0, NULL, N'Draft', N'GTU', 1, N'CE', N'123', N'ABC', CAST(N'2020-03-04T00:00:00.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (12, 0, N'Sagar', N'czxczx', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', 1, 1, 2, 0, 0, CAST(N'2021-03-07T16:35:07.760' AS DateTime), 0, NULL, N'Submitted', N'Abc', 1, N'CE', N'123', N'ABC', CAST(N'2021-03-07T16:35:07.760' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (13, 0, N'Title1', N'v', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', 1, 1, 2, 0, 0, CAST(N'2021-03-10T11:36:00.130' AS DateTime), 0, NULL, N'Draft', N'GTU', 1, N'XY', N'123', N'ABC', CAST(N'2021-03-10T11:36:00.130' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (14, 0, N'Title1', N'dfgdg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', 1, 1, 20, 1, 100, CAST(N'2021-03-10T12:09:11.747' AS DateTime), 0, N'Abc', N'Rejected', N'Abc', 1, N'CE', N'123', N'ABC', CAST(N'2021-03-10T12:09:11.747' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (15, 0, N'Title1', N'hjj', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Teams Username Password Updated.txt', 4, 3, 2, 0, 0, CAST(N'2021-03-10T12:13:47.720' AS DateTime), 0, N'FJab', N'Rejected', N'Abc', 3, N'CE', N'123', N'Z', CAST(N'2021-03-10T12:13:47.720' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (16, 0, N'New', N'Adasdas', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', 2, 1, 20, 0, 100, CAST(N'2021-04-10T16:30:27.420' AS DateTime), 0, NULL, N'Draft', N'GTU', 1, N'CE', N'123', N'ABC', CAST(N'2021-04-10T16:30:27.420' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (17, 0, N'asas', N'vxcvxcv', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', 2, 3, 20, 0, 0, CAST(N'2021-03-25T10:05:07.683' AS DateTime), 0, NULL, N'Draft', N'GTU', 2, N'dfsdf', N'1', N'Z', CAST(N'2021-03-25T10:05:07.683' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (18, 0, N'asas', N'vxcvxcv', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', 2, 3, 20, 0, 0, CAST(N'2021-03-25T16:49:16.767' AS DateTime), 0, NULL, N'Draft', N'GTU', 3, N'dfsdf', N'1', N'Z', CAST(N'2021-03-25T16:49:16.767' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([ID], [SellerID], [Title], [Description], [DisplayPicture], [NotePreview], [CategoryID], [TypeID], [NumberOfPages], [IsPaid], [Price], [PublishedDate], [ActionedBy], [AdminRemarks], [Status], [UniversityName], [CountryID], [Course], [CourseCode], [Professor], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (19, 0, N'Title2', N'dfsdf', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\profile.jpg', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\Screenshot (3).png', 1, 1, 2, 0, 0, CAST(N'2021-03-25T21:30:04.167' AS DateTime), 0, NULL, N'Draft', N'GTU', 3, N'dfsdf', N'123', N'Z', CAST(N'2021-03-25T21:30:04.167' AS DateTime), NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[NotesDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 

INSERT [dbo].[Reviews] ([ReviewID], [AgainstDownloadsID], [ReviewedByUserID], [ReviewedNoteID], [Ratings], [Comments], [DateReviewed], [ReviewedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (1, 1, 1, 2, 5, N'ABC', CAST(N'2021-03-02T00:00:00.000' AS DateTime), 1, NULL, NULL, 1)
INSERT [dbo].[Reviews] ([ReviewID], [AgainstDownloadsID], [ReviewedByUserID], [ReviewedNoteID], [Ratings], [Comments], [DateReviewed], [ReviewedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (2, 1, 1, 2, 4, N'DEF', CAST(N'2021-03-02T00:00:00.000' AS DateTime), 1, NULL, NULL, 1)
INSERT [dbo].[Reviews] ([ReviewID], [AgainstDownloadsID], [ReviewedByUserID], [ReviewedNoteID], [Ratings], [Comments], [DateReviewed], [ReviewedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (3, 1, 1, 2, 3, N'GHI', CAST(N'2021-03-02T00:00:00.000' AS DateTime), 1, NULL, NULL, 1)
INSERT [dbo].[Reviews] ([ReviewID], [AgainstDownloadsID], [ReviewedByUserID], [ReviewedNoteID], [Ratings], [Comments], [DateReviewed], [ReviewedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (4, 5, 0, 2, 5, N'demo', CAST(N'2021-03-15T11:59:42.390' AS DateTime), 0, NULL, NULL, 1)
INSERT [dbo].[Reviews] ([ReviewID], [AgainstDownloadsID], [ReviewedByUserID], [ReviewedNoteID], [Ratings], [Comments], [DateReviewed], [ReviewedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (5, 5, 0, 2, 5, N'', CAST(N'2021-03-15T14:58:17.023' AS DateTime), 0, NULL, NULL, 1)
INSERT [dbo].[Reviews] ([ReviewID], [AgainstDownloadsID], [ReviewedByUserID], [ReviewedNoteID], [Ratings], [Comments], [DateReviewed], [ReviewedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (6, 5, 0, 3, 5, N'Test', CAST(N'2021-03-15T14:58:17.000' AS DateTime), 0, NULL, NULL, 1)
INSERT [dbo].[Reviews] ([ReviewID], [AgainstDownloadsID], [ReviewedByUserID], [ReviewedNoteID], [Ratings], [Comments], [DateReviewed], [ReviewedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (12, 5, 0, 3, 0, N'Test', CAST(N'2021-03-15T14:58:17.000' AS DateTime), 0, NULL, NULL, 1)
INSERT [dbo].[Reviews] ([ReviewID], [AgainstDownloadsID], [ReviewedByUserID], [ReviewedNoteID], [Ratings], [Comments], [DateReviewed], [ReviewedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (13, 69, 0, 2, 5, N'Good', CAST(N'2021-03-26T18:57:03.893' AS DateTime), 0, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[SpamReports] ON 

INSERT [dbo].[SpamReports] ([SpamReportID], [NoteID], [ReportedByUserID], [AgainstDownloadID], [DateReported], [Remarks], [AddedBy], [DateModified], [ModifiedBy]) VALUES (6, 2, 0, 5, CAST(N'2021-03-15T15:30:58.637' AS DateTime), N'sdsdfs', 0, NULL, NULL)
INSERT [dbo].[SpamReports] ([SpamReportID], [NoteID], [ReportedByUserID], [AgainstDownloadID], [DateReported], [Remarks], [AddedBy], [DateModified], [ModifiedBy]) VALUES (7, 2, 0, 5, CAST(N'2021-03-15T15:46:06.517' AS DateTime), N'Another Test.', 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SpamReports] OFF
GO
SET IDENTITY_INSERT [dbo].[SystemConfigurations] ON 

INSERT [dbo].[SystemConfigurations] ([ID], [key], [Value], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'SupportEmail', N'SagarVaghela@gmail.com', CAST(N'2021-04-10T12:04:32.963' AS DateTime), 5, CAST(N'2021-04-10T14:27:41.287' AS DateTime), 5, 1)
INSERT [dbo].[SystemConfigurations] ([ID], [key], [Value], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, N'SupportPhone', N'1234567890', CAST(N'2021-04-10T14:10:48.547' AS DateTime), 5, CAST(N'2021-04-10T14:27:41.590' AS DateTime), 5, 1)
INSERT [dbo].[SystemConfigurations] ([ID], [key], [Value], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, N'EmailAddress', N'sagarnew1@gmail.com', CAST(N'2021-04-10T14:20:05.373' AS DateTime), 5, CAST(N'2021-04-10T14:27:41.597' AS DateTime), 5, 1)
INSERT [dbo].[SystemConfigurations] ([ID], [key], [Value], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, N'NotesPreview', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', CAST(N'2021-04-10T14:20:05.463' AS DateTime), 5, CAST(N'2021-04-10T14:27:41.620' AS DateTime), 5, 1)
INSERT [dbo].[SystemConfigurations] ([ID], [key], [Value], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, N'Facebook', N'facebook.com/sagarvaghela', CAST(N'2021-04-10T14:23:17.680' AS DateTime), 5, CAST(N'2021-04-10T14:27:41.600' AS DateTime), 5, 1)
INSERT [dbo].[SystemConfigurations] ([ID], [key], [Value], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, N'ProfilePicture', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', CAST(N'2021-04-10T14:23:21.703' AS DateTime), 5, CAST(N'2021-04-10T14:27:41.627' AS DateTime), 5, 1)
INSERT [dbo].[SystemConfigurations] ([ID], [key], [Value], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, N'Twitter', N'twitter.com/sagarvaghela', CAST(N'2021-04-10T14:23:46.320' AS DateTime), 5, CAST(N'2021-04-10T14:27:41.603' AS DateTime), 5, 1)
INSERT [dbo].[SystemConfigurations] ([ID], [key], [Value], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, N'Linkedin', N'linkedin.com/sagarvaghela', CAST(N'2021-04-10T14:23:46.340' AS DateTime), 5, CAST(N'2021-04-10T14:27:41.610' AS DateTime), 5, 1)
SET IDENTITY_INSERT [dbo].[SystemConfigurations] OFF
GO
SET IDENTITY_INSERT [dbo].[Types] ON 

INSERT [dbo].[Types] ([TypeID], [TypeName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (1, N'Type1', N'Type1', CAST(N'2021-04-09T13:15:06.000' AS DateTime), 5, NULL, NULL, 1)
INSERT [dbo].[Types] ([TypeID], [TypeName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (3, N'Type2', N'Type2', CAST(N'2021-04-09T13:15:06.000' AS DateTime), 5, NULL, NULL, 1)
INSERT [dbo].[Types] ([TypeID], [TypeName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (5, N'Type3', N'Type3', CAST(N'2021-04-09T13:15:06.000' AS DateTime), 5, NULL, NULL, 1)
INSERT [dbo].[Types] ([TypeID], [TypeName], [Description], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (6, N'Type4', N'Type4', CAST(N'2021-04-09T13:15:06.000' AS DateTime), 5, CAST(N'2021-04-09T13:18:51.323' AS DateTime), 5, 0)
SET IDENTITY_INSERT [dbo].[Types] OFF
GO
SET IDENTITY_INSERT [dbo].[UserInfo] ON 

INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (1, 1, N'abc@gmail.com', CAST(N'2020-02-11' AS Date), N'female', N'91', N'123456789', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\reviewer-1.png', N'a', N'b', N'c', N'd', N'1', N'Country1', N'a', N'b', NULL, NULL, NULL, NULL)
INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (2, 0, N'sagar@gmail.com', CAST(N'1999-10-21' AS Date), N'male', N'91', N'1234567890', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'Paldi ahmedabad', N'gcg', N'Ahmedabad', N'cch', N'380007', N'2', N'f', N'vg', CAST(N'2021-03-12T11:55:39.117' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (5, 2, N'sagarvaghela4041@gmail.com', CAST(N'2021-03-12' AS Date), N'male', N'91', N'1234567890', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\SagarVaghela.jpg', N'A', N'B', N'C', N'A', N'12', N'2', N'f', N'vg', CAST(N'2021-03-27T11:59:20.837' AS DateTime), 2, NULL, NULL)
INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (6, 5, N'sagarvaghela4041@gmail.com', NULL, NULL, NULL, N'12345678914', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'', N'', N'', N'', N'', N'', NULL, NULL, CAST(N'2021-04-10T11:08:30.267' AS DateTime), 5, NULL, NULL)
INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (7, 7, NULL, NULL, NULL, NULL, N'1234567890', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'', N'', N'', N'', N'', N'', NULL, NULL, CAST(N'2021-04-08T19:26:35.523' AS DateTime), 5, NULL, NULL)
INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (8, 8, NULL, NULL, NULL, NULL, N'1234567891', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'', N'', N'', N'', N'', N'', NULL, NULL, CAST(N'2021-04-08T19:55:46.530' AS DateTime), 5, NULL, NULL)
INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (9, 9, NULL, NULL, NULL, NULL, N'1234567890', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'', N'', N'', N'', N'', N'', NULL, NULL, CAST(N'2021-04-08T19:58:13.060' AS DateTime), 5, NULL, NULL)
INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (10, 10, NULL, NULL, NULL, NULL, N'1234567891', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'', N'', N'', N'', N'', N'', NULL, NULL, CAST(N'2021-04-09T09:52:05.843' AS DateTime), 5, NULL, NULL)
INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (11, 11, NULL, NULL, NULL, NULL, N'12345647891', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'', N'', N'', N'', N'', N'', NULL, NULL, CAST(N'2021-04-09T09:52:52.577' AS DateTime), 5, NULL, NULL)
INSERT [dbo].[UserInfo] ([ID], [UserID], [SecondaryEmailID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [Country], [University], [College], [DateAdded], [AddedBy], [DateModified], [ModifiedBy]) VALUES (12, 12, NULL, NULL, NULL, NULL, N'1234567890', N'D:\Tatva Soft\Training\Project\ASP\NotesMarketplace\NotesMarketplace\Uploads\170170107121_Sagar.jpg', N'', N'', N'', N'', N'', N'', NULL, NULL, CAST(N'2021-04-10T15:50:17.763' AS DateTime), 5, NULL, NULL)
SET IDENTITY_INSERT [dbo].[UserInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

INSERT [dbo].[UserRoles] ([RoleID], [RoleName], [RoleDescription], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (1, N'SuperAdmin', N'SuperAdmin', CAST(N'2021-02-22T00:00:00.000' AS DateTime), 1, NULL, NULL, 1)
INSERT [dbo].[UserRoles] ([RoleID], [RoleName], [RoleDescription], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (2, N'Admin', N'Admin', CAST(N'2021-02-22T00:00:00.000' AS DateTime), 1, NULL, NULL, 1)
INSERT [dbo].[UserRoles] ([RoleID], [RoleName], [RoleDescription], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (3, N'User', N'User', CAST(N'2021-02-22T00:00:00.000' AS DateTime), 1, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (0, 3, N'sagar', N'sagar', N'sagarvaghela4041@gmail.com', N'Sagar@211099', 1, CAST(N'2021-04-03T00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (1, 3, N'userone', N'userone', N'user1@gmail.com', N'Sagar@211099', 0, CAST(N'2021-04-03T00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (2, 3, N'userthree', N'userthree', N'sagarvaghela4041@gmail.com', N'Sagar@2110992', 1, CAST(N'2021-04-03T00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (3, 3, N'Sagar', N'Vaghela', N'sagarvaghela4041@gmail.com', N'Sagar@2110993', 1, CAST(N'2021-04-03T00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (4, 3, N'Sagar', N'Vaghela', N'sagarvaghela4041@gmail.com', N'Sagar@211099', 1, CAST(N'2021-04-03T00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (5, 1, N'sagar', N'sagar', N'sagarvaghela4041@gmail.com', N'Admin@211099', 1, CAST(N'2021-04-03T00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (7, 2, N'Adminone', N'Adminone', N'adminone@gmail.com', N'Admin@1234', 1, CAST(N'2021-04-08T19:26:35.523' AS DateTime), 5, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (8, 2, N'Adminone', N'Adminone', N'adminone@gmail.com', N'Admin@1234', 0, CAST(N'2021-04-08T19:55:46.530' AS DateTime), 5, CAST(N'2021-04-09T10:12:47.873' AS DateTime), 5, 0)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (9, 2, N'admintwo', N'admintwo', N'admintwo@gmail.com', N'Admin@1234', 0, CAST(N'2021-04-08T19:58:13.060' AS DateTime), 5, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (10, 2, N'adminthree', N'adminthree', N'adminthree@gmail.com', N'Admin@1234', 0, CAST(N'2021-04-09T09:52:05.843' AS DateTime), 5, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (11, 2, N'adminfour', N'adminfour', N'adminfour@gmail.com', N'Admin@1234', 0, CAST(N'2021-04-09T09:52:52.577' AS DateTime), 5, NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [FirstName], [LastName], [EmailID], [Password], [IsEmailVerified], [DateAdded], [AddedBy], [DateModified], [ModifiedBy], [IsActive]) VALUES (12, 2, N'adminfive', N'adminfive', N'adminfive@gmail.com', N'Admin@1234', 1, CAST(N'2021-04-10T15:50:17.763' AS DateTime), 5, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Downloads]  WITH CHECK ADD  CONSTRAINT [FK_Downloads_NotesDetails] FOREIGN KEY([NoteID])
REFERENCES [dbo].[NotesDetails] ([ID])
GO
ALTER TABLE [dbo].[Downloads] CHECK CONSTRAINT [FK_Downloads_NotesDetails]
GO
ALTER TABLE [dbo].[Downloads]  WITH CHECK ADD  CONSTRAINT [FK_Downloads_Users] FOREIGN KEY([Seller])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Downloads] CHECK CONSTRAINT [FK_Downloads_Users]
GO
ALTER TABLE [dbo].[Downloads]  WITH CHECK ADD  CONSTRAINT [FK_Downloads_Users1] FOREIGN KEY([Downloader])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Downloads] CHECK CONSTRAINT [FK_Downloads_Users1]
GO
ALTER TABLE [dbo].[NotesAttachments]  WITH CHECK ADD  CONSTRAINT [FK_NotesAttachments_NotesDetails] FOREIGN KEY([NoteID])
REFERENCES [dbo].[NotesDetails] ([ID])
GO
ALTER TABLE [dbo].[NotesAttachments] CHECK CONSTRAINT [FK_NotesAttachments_NotesDetails]
GO
ALTER TABLE [dbo].[NotesDetails]  WITH CHECK ADD  CONSTRAINT [FK_NotesDetails_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[NotesDetails] CHECK CONSTRAINT [FK_NotesDetails_Categories]
GO
ALTER TABLE [dbo].[NotesDetails]  WITH CHECK ADD  CONSTRAINT [FK_NotesDetails_Countries] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO
ALTER TABLE [dbo].[NotesDetails] CHECK CONSTRAINT [FK_NotesDetails_Countries]
GO
ALTER TABLE [dbo].[NotesDetails]  WITH CHECK ADD  CONSTRAINT [FK_NotesDetails_Types] FOREIGN KEY([TypeID])
REFERENCES [dbo].[Types] ([TypeID])
GO
ALTER TABLE [dbo].[NotesDetails] CHECK CONSTRAINT [FK_NotesDetails_Types]
GO
ALTER TABLE [dbo].[NotesDetails]  WITH CHECK ADD  CONSTRAINT [FK_NotesDetails_Users] FOREIGN KEY([SellerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[NotesDetails] CHECK CONSTRAINT [FK_NotesDetails_Users]
GO
ALTER TABLE [dbo].[NotesDetails]  WITH CHECK ADD  CONSTRAINT [FK_NotesDetails_Users1] FOREIGN KEY([ActionedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[NotesDetails] CHECK CONSTRAINT [FK_NotesDetails_Users1]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Downloads] FOREIGN KEY([AgainstDownloadsID])
REFERENCES [dbo].[Downloads] ([ID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Downloads]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_NotesDetails] FOREIGN KEY([ReviewedNoteID])
REFERENCES [dbo].[NotesDetails] ([ID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_NotesDetails]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Users] FOREIGN KEY([ReviewedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Users]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Users1] FOREIGN KEY([ReviewedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Users1]
GO
ALTER TABLE [dbo].[SpamReports]  WITH CHECK ADD  CONSTRAINT [FK_SpamReports_Downloads] FOREIGN KEY([AgainstDownloadID])
REFERENCES [dbo].[Downloads] ([ID])
GO
ALTER TABLE [dbo].[SpamReports] CHECK CONSTRAINT [FK_SpamReports_Downloads]
GO
ALTER TABLE [dbo].[SpamReports]  WITH CHECK ADD  CONSTRAINT [FK_SpamReports_NotesDetails] FOREIGN KEY([NoteID])
REFERENCES [dbo].[NotesDetails] ([ID])
GO
ALTER TABLE [dbo].[SpamReports] CHECK CONSTRAINT [FK_SpamReports_NotesDetails]
GO
ALTER TABLE [dbo].[SpamReports]  WITH CHECK ADD  CONSTRAINT [FK_SpamReports_Users] FOREIGN KEY([ReportedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[SpamReports] CHECK CONSTRAINT [FK_SpamReports_Users]
GO
ALTER TABLE [dbo].[UserInfo]  WITH CHECK ADD  CONSTRAINT [FK_UserInfo_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserInfo] CHECK CONSTRAINT [FK_UserInfo_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[UserRoles] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserRoles]
GO
USE [master]
GO
ALTER DATABASE [NotesMarketplace] SET  READ_WRITE 
GO

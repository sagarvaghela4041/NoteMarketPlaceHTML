USE [master]
GO
/****** Object:  Database [NotesMarketplace]    Script Date: 11-02-2021 05:28:05 PM ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Countries]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Downloads]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Downloads](
	[ID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[NotesAttachments]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotesAttachments](
	[ID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[NotesDetails]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotesDetails](
	[ID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[ReferenceData]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferenceData](
	[ID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Reviews]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[SpamReports]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpamReports](
	[SpamReportID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[SystemConfigurations]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfigurations](
	[ID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Types]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Types](
	[TypeID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[UserInfo]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[ID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[RoleID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Users]    Script Date: 11-02-2021 05:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] NOT NULL,
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ReferenceData]    Script Date: 11-02-2021 05:28:07 PM ******/
ALTER TABLE [dbo].[ReferenceData] ADD  CONSTRAINT [IX_ReferenceData] UNIQUE NONCLUSTERED 
(
	[RefCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE [dbo].[NotesDetails]  WITH CHECK ADD  CONSTRAINT [FK_NotesDetails_ReferenceData] FOREIGN KEY([Status])
REFERENCES [dbo].[ReferenceData] ([RefCategory])
GO
ALTER TABLE [dbo].[NotesDetails] CHECK CONSTRAINT [FK_NotesDetails_ReferenceData]
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

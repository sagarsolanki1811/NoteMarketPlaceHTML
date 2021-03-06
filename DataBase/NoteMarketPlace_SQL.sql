USE [master]
GO
/****** Object:  Database [TatvaDB]    Script Date: 08-Mar-21 10:17:37 AM ******/
CREATE DATABASE [TatvaDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TatvaDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\TatvaDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TatvaDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\TatvaDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TatvaDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TatvaDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TatvaDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TatvaDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TatvaDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TatvaDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TatvaDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TatvaDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TatvaDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TatvaDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TatvaDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TatvaDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TatvaDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TatvaDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TatvaDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TatvaDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TatvaDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TatvaDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TatvaDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TatvaDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TatvaDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TatvaDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TatvaDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TatvaDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TatvaDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TatvaDB] SET  MULTI_USER 
GO
ALTER DATABASE [TatvaDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TatvaDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TatvaDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TatvaDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TatvaDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TatvaDB] SET QUERY_STORE = OFF
GO
USE [TatvaDB]
GO
/****** Object:  User [Sagar_Tatva]    Script Date: 08-Mar-21 10:17:38 AM ******/
CREATE USER [Sagar_Tatva] FOR LOGIN [Sagar_Tatva] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[admin_id] [int] IDENTITY(1,1) NOT NULL,
	[Fname] [varchar](max) NOT NULL,
	[Lname] [varchar](max) NOT NULL,
	[Email] [varchar](max) NOT NULL,
	[Secondary_Email] [varchar](max) NULL,
	[Password] [varchar](max) NOT NULL,
	[Confirm_Password] [varchar](max) NOT NULL,
	[Phone_Number] [varchar](max) NOT NULL,
	[Phone_Number_Country_Code] [varchar](max) NOT NULL,
	[Profile_Picture] [nvarchar](max) NOT NULL,
	[Created_Date] [datetime2](7) NOT NULL,
	[Created_By] [int] NULL,
	[Modified_Date] [datetime2](7) NULL,
	[Modified_By] [int] NULL,
	[Deactivated_Date] [datetime2](7) NULL,
	[Deactivated_By] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BuyerReq]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BuyerReq](
	[buyer_req_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[note_id] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[Req_Created_Date] [datetime2](7) NULL,
	[Req_Solved_Date] [datetime2](7) NULL,
 CONSTRAINT [PK_BuyerReq] PRIMARY KEY CLUSTERED 
(
	[buyer_req_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Created_Date] [datetime2](7) NOT NULL,
	[Created_By] [int] NULL,
	[Modified_Date] [datetime2](7) NULL,
	[Modified_By] [int] NULL,
	[Deactivated_Date] [datetime2](7) NULL,
	[Deactivated_By] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactUs]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactUs](
	[contact_id] [int] IDENTITY(1,1) NOT NULL,
	[Full_name] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Subject] [nvarchar](max) NOT NULL,
	[Comments_Questions] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ContactUs] PRIMARY KEY CLUSTERED 
(
	[contact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Country_Code] [varchar](max) NOT NULL,
	[Created_Date] [datetime2](7) NOT NULL,
	[Created_By] [int] NULL,
	[Modified_Date] [datetime2](7) NULL,
	[Modified_By] [int] NULL,
	[Deactivated_Date] [datetime2](7) NULL,
	[Deactivated_By] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteDetails]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteDetails](
	[note_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[File_Name] [varchar](max) NOT NULL,
	[File_Path] [nvarchar](max) NOT NULL,
	[Category] [varchar](max) NOT NULL,
	[Display_Picture] [nvarchar](max) NULL,
	[Type] [varchar](max) NOT NULL,
	[No_Of_Pages] [int] NULL,
	[Description] [varchar](max) NOT NULL,
	[Country] [varchar](max) NOT NULL,
	[Institute_Name] [varchar](max) NULL,
	[Course_Name] [varchar](max) NULL,
	[Course_Code] [varchar](max) NULL,
	[Professor] [varchar](max) NULL,
	[IsPaid] [bit] NOT NULL,
	[Sell_Price] [decimal](18, 2) NOT NULL,
	[Note_Preview] [nvarchar](max) NOT NULL,
	[Action_By] [int] NULL,
	[Created_Date] [datetime2](7) NOT NULL,
	[Modified_Date] [datetime2](7) NULL,
	[Published_Date] [datetime2](7) NULL,
	[Status] [varchar](max) NOT NULL,
	[No_Of_Download] [bigint] NOT NULL,
	[Earning_Amount] [float] NOT NULL,
 CONSTRAINT [PK_NoteDetails] PRIMARY KEY CLUSTERED 
(
	[note_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteType]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteType](
	[type_id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Created_Date] [datetime2](7) NOT NULL,
	[Created_By] [int] NULL,
	[Modified_Date] [datetime2](7) NULL,
	[Modified_By] [int] NULL,
	[Deactivated_Date] [datetime2](7) NULL,
	[Deactivated_By] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[note_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[Rating] [decimal](18, 1) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[Created_Date] [datetime2](7) NOT NULL,
	[Deactivated_Date] [datetime2](7) NULL,
	[Deactivated_By] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Spam]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Spam](
	[spam_id] [int] IDENTITY(1,1) NOT NULL,
	[note_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[Remark] [varchar](max) NOT NULL,
	[Created_Date] [datetime2](7) NOT NULL,
	[Deactivated_Date] [datetime2](7) NULL,
	[Deactivated_By] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Spam] PRIMARY KEY CLUSTERED 
(
	[spam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemConfig]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfig](
	[system_id] [int] IDENTITY(1,1) NOT NULL,
	[Support_Email_Address] [varchar](max) NOT NULL,
	[Support_Phone_Number] [varchar](max) NOT NULL,
	[EmailForNotify] [varchar](max) NOT NULL,
	[Default_User_Profile_Picture] [nvarchar](max) NOT NULL,
	[Default_Note_Profile_Picture] [nvarchar](max) NOT NULL,
	[FB_URL] [nvarchar](max) NOT NULL,
	[LinkedIn_URL] [nvarchar](max) NOT NULL,
	[Twitter_URL] [nvarchar](max) NOT NULL,
	[Created_Date] [datetime2](7) NOT NULL,
	[Created_By] [int] NULL,
	[Modified_Date] [datetime2](7) NULL,
	[Modified_By] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_SystemConfig] PRIMARY KEY CLUSTERED 
(
	[system_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 08-Mar-21 10:17:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[Fname] [varchar](max) NOT NULL,
	[Lname] [varchar](max) NOT NULL,
	[Email] [varchar](max) NOT NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[Password] [varchar](max) NULL,
	[Confirm_Password] [varchar](max) NULL,
	[DOB] [date] NULL,
	[Gender] [varchar](max) NULL,
	[Phone_Number] [varchar](max) NULL,
	[Phone_Number_Country_Code] [varchar](max) NULL,
	[Profile_Picture] [varchar](max) NULL,
	[Address_1] [varchar](max) NULL,
	[Address_2] [varchar](max) NULL,
	[ZipCode] [varchar](max) NULL,
	[City] [varchar](max) NULL,
	[State] [varchar](max) NULL,
	[Country] [varchar](max) NULL,
	[College] [varchar](max) NULL,
	[University] [varchar](max) NULL,
	[Created_Date] [datetime2](7) NOT NULL,
	[Created_By] [int] NULL,
	[Modified_Date] [datetime2](7) NULL,
	[Modified_By] [int] NULL,
	[Deactivated_Date] [datetime2](7) NULL,
	[Deactivated_By] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[Activation_Code] [uniqueidentifier] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([admin_id], [Fname], [Lname], [Email], [Secondary_Email], [Password], [Confirm_Password], [Phone_Number], [Phone_Number_Country_Code], [Profile_Picture], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (3, N'admin', N'admin', N'admin@gmail.com', N'temp@gmail.com', N'12345', N'12345', N'1234567890', N'+91', N'rnhjn', CAST(N'2021-02-13T00:00:00.0000000' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[BuyerReq] ON 

INSERT [dbo].[BuyerReq] ([buyer_req_id], [user_id], [note_id], [Status], [Req_Created_Date], [Req_Solved_Date]) VALUES (2, 59, 10, 0, NULL, NULL)
INSERT [dbo].[BuyerReq] ([buyer_req_id], [user_id], [note_id], [Status], [Req_Created_Date], [Req_Solved_Date]) VALUES (3, 63, 3, 1, CAST(N'2021-03-01T18:49:24.8000000' AS DateTime2), NULL)
INSERT [dbo].[BuyerReq] ([buyer_req_id], [user_id], [note_id], [Status], [Req_Created_Date], [Req_Solved_Date]) VALUES (4, 65, 4, 0, CAST(N'2021-03-01T18:49:39.1100000' AS DateTime2), NULL)
INSERT [dbo].[BuyerReq] ([buyer_req_id], [user_id], [note_id], [Status], [Req_Created_Date], [Req_Solved_Date]) VALUES (5, 66, 3, 0, CAST(N'2021-03-01T22:28:23.6300000' AS DateTime2), NULL)
INSERT [dbo].[BuyerReq] ([buyer_req_id], [user_id], [note_id], [Status], [Req_Created_Date], [Req_Solved_Date]) VALUES (6, 64, 16, 1, CAST(N'2021-03-03T14:15:17.3233333' AS DateTime2), NULL)
INSERT [dbo].[BuyerReq] ([buyer_req_id], [user_id], [note_id], [Status], [Req_Created_Date], [Req_Solved_Date]) VALUES (7, 66, 16, 1, CAST(N'2021-03-05T09:08:57.5433012' AS DateTime2), NULL)
INSERT [dbo].[BuyerReq] ([buyer_req_id], [user_id], [note_id], [Status], [Req_Created_Date], [Req_Solved_Date]) VALUES (9, 59, 4, 0, CAST(N'2021-03-07T14:43:20.4920433' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[BuyerReq] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([category_id], [Name], [Description], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (1, N'IT', N'it', CAST(N'2021-02-27T20:20:23.2700000' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Category] ([category_id], [Name], [Description], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (2, N'Computer', N'computer', CAST(N'2021-02-27T20:20:33.0600000' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Category] ([category_id], [Name], [Description], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (3, N'CIVIL', N'civil', CAST(N'2021-02-27T20:20:48.1166667' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Category] ([category_id], [Name], [Description], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (4, N'EC', N'ec', CAST(N'2021-02-27T20:20:54.1700000' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Category] ([category_id], [Name], [Description], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (5, N'Chemical', N'chemical', CAST(N'2021-02-27T20:21:11.5266667' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([country_id], [Name], [Country_Code], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (1, N'india', N'+91', CAST(N'2021-02-17T13:03:18.8966667' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Country] ([country_id], [Name], [Country_Code], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (2, N'pakistan', N'+789', CAST(N'2021-02-17T13:06:35.8500000' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Country] ([country_id], [Name], [Country_Code], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (3, N'ujakistan', N'+77', CAST(N'2021-02-17T13:07:04.1166667' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteDetails] ON 

INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (3, 59, N'file', N'/Members/59/3/GOOGLE DIGITAL MARKETING.pdf', N'IT', N'/Members/59/3/CORONA CERTI.jpg', N'Story Book', 220, N'njgf', N'india', N' jkn', N'jnlb', N'000', N'iim', 0, CAST(0.00 AS Decimal(18, 2)), N'/Members/59/3/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T09:54:56.8861786' AS DateTime2), NULL, CAST(N'2021-03-04T09:54:56.8861786' AS DateTime2), N'Published', 2, 100)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (4, 63, N'java', N'/Members/63/4/GOOGLE DIGITAL MARKETING.pdf', N'Computer', N'/Members/63/4/CORONA CERTI.jpg', N'Story Book', 2, N'java book', N'india', N'vgec', N'Engineering', N'000', N'jashvant sir', 0, CAST(2000.00 AS Decimal(18, 2)), N'/Members/63/4/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T11:13:16.5215234' AS DateTime2), NULL, NULL, N'Deleted', 0, 0)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (5, 63, N'c++', N'/Members/63/5/GOOGLE DIGITAL MARKETING.pdf', N'CIVIL', N'/Members/63/5/CORONA CERTI.jpg', N'Motivation Book', 33, N'C++ book', N'india', N'vgec', N'Engineering', N'000', N'vania sir', 0, CAST(4000.00 AS Decimal(18, 2)), N'/Members/63/5/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T11:15:52.8079897' AS DateTime2), NULL, NULL, N'Draft', 7, 1000)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (7, 64, N'mongo', N'/Members/64/7/GOOGLE DIGITAL MARKETING.pdf', N'Computer', N'/Members/64/7/CORONA CERTI.jpg', N'Motivation Book', 8, N'mongodb course', N'pakistan', N'GEC', N'Election', N'789', N'bhagvan bhai', 0, CAST(0.00 AS Decimal(18, 2)), N'/Members/64/7/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T13:17:01.2345201' AS DateTime2), NULL, NULL, N'Submitted', 0, 0)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (8, 65, N'fitness', N'/Members/65/8/GOOGLE DIGITAL MARKETING.pdf', N'CIVIL', N'/Members/65/8/CORONA CERTI.jpg', N'Motivation Book', 5, N'about health', N'india', N'vgec', N'Engineering', N'bui', N'akshay kumar ', 0, CAST(0.00 AS Decimal(18, 2)), N'/Members/65/8/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T15:44:07.7684531' AS DateTime2), NULL, NULL, N'InReview', 1, 0)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (9, 65, N'fitness', N'/Members/65/9/GOOGLE DIGITAL MARKETING.pdf', N'CIVIL', N'/Members/65/9/CORONA CERTI.jpg', N'Motivation Book', 5, N'about health', N'india', N'vgec', N'Engineering', N'bui', N'akshay kumar ', 0, CAST(0.00 AS Decimal(18, 2)), N'/Members/65/9/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T15:45:40.1234783' AS DateTime2), NULL, NULL, N'Draft', 0, 0)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (10, 65, N'fitness', N'/Members/65/10/GOOGLE DIGITAL MARKETING.pdf', N'EC', N'/Members/65/10/CORONA CERTI.jpg', N'Motivation Book', 8, N'motivational', N'india', N'vgec', N'bku', N'j', N'akshay kumar ', 0, CAST(0.00 AS Decimal(18, 2)), N'/Members/65/10/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T15:48:02.5932062' AS DateTime2), NULL, NULL, N'Draft', 5, 50)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (11, 65, N'fitness', N'/Members/65/11/GOOGLE DIGITAL MARKETING.pdf', N'CIVIL', N'/Members/65/11/CORONA CERTI.jpg', N'Motivation Book', 8, N'description', N'pakistan', N'GEC', N'jnlb', N'j', N'jashvant sir', 0, CAST(4500.00 AS Decimal(18, 2)), N'/Members/65/11/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T16:02:03.8973788' AS DateTime2), NULL, NULL, N'Draft', 0, 0)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (12, 65, N'design', N'/Members/65/12/GOOGLE DIGITAL MARKETING.pdf', N'Computer', N'/Members/65/12/CORONA CERTI.jpg', N'Motivation Book', 8, N'motivation book', N'india', N'vgec', N'Engineering', N'000', N'kbnbliu', 0, CAST(2200.00 AS Decimal(18, 2)), N'/Members/65/12/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T16:08:08.4347439' AS DateTime2), NULL, NULL, N'Draft', 0, 0)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (13, 65, N'fitness', N'/Members/65/13/GOOGLE DIGITAL MARKETING.pdf', N'Computer', N'/Members/65/13/CORONA CERTI.jpg', N'HandWritten', 55, N'motivation', N'pakistan', N'bhj', N'Engineering', NULL, N'akshay kumar ', 0, CAST(0.00 AS Decimal(18, 2)), N'/Members/65/13/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T16:14:02.7498647' AS DateTime2), NULL, NULL, N'Draft', 4, 1600)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (14, 66, N'tempnote', N'/Members/66/14/GOOGLE DIGITAL MARKETING.pdf', N'Computer', N'/Members/66/14/CORONA CERTI.jpg', N'Story Book', 5, N'descipriom nathi', N'india', N'vgec', N'Engineering', N'789', N'jashvant sir', 1, CAST(1500.00 AS Decimal(18, 2)), N'/Members/66/14/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T18:21:53.6717880' AS DateTime2), NULL, NULL, N'Draft', 0, 0)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (15, 66, N'tempnote', N'/Members/66/15/GOOGLE DIGITAL MARKETING.pdf', N'IT', N'/Members/66/15/CORONA CERTI.jpg', N'Story Book', 5, N'descipriom nathi', N'india', N'vgec', N'Engineering', N'789', N'jashvant sir', 1, CAST(1500.00 AS Decimal(18, 2)), N'/Members/66/15/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-01T18:22:55.7265775' AS DateTime2), NULL, NULL, N'Draft', 0, 0)
INSERT [dbo].[NoteDetails] ([note_id], [user_id], [File_Name], [File_Path], [Category], [Display_Picture], [Type], [No_Of_Pages], [Description], [Country], [Institute_Name], [Course_Name], [Course_Code], [Professor], [IsPaid], [Sell_Price], [Note_Preview], [Action_By], [Created_Date], [Modified_Date], [Published_Date], [Status], [No_Of_Download], [Earning_Amount]) VALUES (16, 59, N'new file', N'/Members/59/16/GOOGLE DIGITAL MARKETING.pdf', N'CIVIL', N'/Members/59/16/CORONA CERTI.jpg', N'Motivation Book', 100, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', N'pakistan', N'http', N'null', N'222', N'apoon potte', 1, CAST(200.00 AS Decimal(18, 2)), N'/Members/59/16/MOHIT RATHI WORDPRESS.pdf', NULL, CAST(N'2021-03-03T14:13:50.8833333' AS DateTime2), NULL, CAST(N'2021-03-04T09:54:56.8861786' AS DateTime2), N'Published', 7, 20)
SET IDENTITY_INSERT [dbo].[NoteDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteType] ON 

INSERT [dbo].[NoteType] ([type_id], [Name], [Description], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (2, N'HandWritten', N'notes that written by some person', CAST(N'2021-02-27T20:11:49.7633333' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NoteType] ([type_id], [Name], [Description], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (3, N'Story Book', N'note with story', CAST(N'2021-02-27T20:17:37.4433333' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NoteType] ([type_id], [Name], [Description], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (4, N'Motivation Book', N'book those gives motivation', CAST(N'2021-02-27T20:18:00.8166667' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NoteType] ([type_id], [Name], [Description], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (5, N'University Books', N'books of GTU', CAST(N'2021-02-27T20:18:21.0700000' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[NoteType] OFF
GO
SET IDENTITY_INSERT [dbo].[Review] ON 

INSERT [dbo].[Review] ([review_id], [note_id], [user_id], [Rating], [Comment], [Created_Date], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (1, 3, 64, CAST(3.0 AS Decimal(18, 1)), N'This Note Is very good. i never seen this kind of descriptive details in my life . appreaciated.', CAST(N'2021-03-04T10:47:13.8066667' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Review] ([review_id], [note_id], [user_id], [Rating], [Comment], [Created_Date], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (2, 16, 64, CAST(4.5 AS Decimal(18, 1)), N'awesome book by my friend. great stuff. amazong animation. other text are just for checking the length of the text is going to right or not.', CAST(N'2021-03-04T10:48:36.0033333' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Review] ([review_id], [note_id], [user_id], [Rating], [Comment], [Created_Date], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (4, 3, 65, CAST(3.0 AS Decimal(18, 1)), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', CAST(N'2021-03-04T10:49:37.0466667' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Review] ([review_id], [note_id], [user_id], [Rating], [Comment], [Created_Date], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (5, 3, 66, CAST(3.5 AS Decimal(18, 1)), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', CAST(N'2021-03-04T10:50:17.0833333' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Review] ([review_id], [note_id], [user_id], [Rating], [Comment], [Created_Date], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (6, 7, 59, CAST(4.5 AS Decimal(18, 1)), N'awesome', CAST(N'2021-03-04T15:05:16.1700000' AS DateTime2), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Review] OFF
GO
SET IDENTITY_INSERT [dbo].[Spam] ON 

INSERT [dbo].[Spam] ([spam_id], [note_id], [user_id], [Remark], [Created_Date], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (1, 3, 64, N'I like but now not.', CAST(N'2021-03-04T10:57:21.4300000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Spam] ([spam_id], [note_id], [user_id], [Remark], [Created_Date], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (2, 3, 65, N'same answer', CAST(N'2021-03-04T10:57:34.9200000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Spam] ([spam_id], [note_id], [user_id], [Remark], [Created_Date], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (3, 3, 66, N'same answer', CAST(N'2021-03-04T10:57:45.0533333' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Spam] ([spam_id], [note_id], [user_id], [Remark], [Created_Date], [Deactivated_Date], [Deactivated_By], [IsActive]) VALUES (4, 16, 66, N'same answer', CAST(N'2021-03-04T15:06:03.5433333' AS DateTime2), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Spam] OFF
GO
SET IDENTITY_INSERT [dbo].[SystemConfig] ON 

INSERT [dbo].[SystemConfig] ([system_id], [Support_Email_Address], [Support_Phone_Number], [EmailForNotify], [Default_User_Profile_Picture], [Default_Note_Profile_Picture], [FB_URL], [LinkedIn_URL], [Twitter_URL], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [IsActive]) VALUES (1, N'sagarsolanki1811@gmail.com', N'1234567890', N'sagarsolanki749@gmail.com', N'/Members/59/Screenshot (30).png', N'/Members/59/Capture.PNG', N'www.facebook.com', N'www.linkedin.com', N'www.twitter.com', CAST(N'2021-02-26T21:37:23.0000000' AS DateTime2), NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[SystemConfig] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([user_id], [Fname], [Lname], [Email], [IsEmailVerified], [Password], [Confirm_Password], [DOB], [Gender], [Phone_Number], [Phone_Number_Country_Code], [Profile_Picture], [Address_1], [Address_2], [ZipCode], [City], [State], [Country], [College], [University], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive], [Activation_Code]) VALUES (59, N'Sagqr', N'Solanki', N'sagarsolanki749@gmail.com', 1, N'123123123', N'123123123', NULL, NULL, NULL, NULL, N'/Members/59/DP_WIN_20200327_16_24_13_Pro.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2021-02-15T12:48:54.8091330' AS DateTime2), NULL, CAST(N'2021-03-04T18:54:02.1441309' AS DateTime2), NULL, NULL, NULL, 1, N'efa47248-26b7-4e86-8534-99b438a8a09f')
INSERT [dbo].[User] ([user_id], [Fname], [Lname], [Email], [IsEmailVerified], [Password], [Confirm_Password], [DOB], [Gender], [Phone_Number], [Phone_Number_Country_Code], [Profile_Picture], [Address_1], [Address_2], [ZipCode], [City], [State], [Country], [College], [University], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive], [Activation_Code]) VALUES (63, N'golu', N'patel', N'golu@gmail.com', 1, N'123123123', N'123123123', NULL, NULL, N'123456789', N'+91', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2021-03-01T10:48:56.3819373' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1, N'b2e035c9-5fb7-42df-ba74-a2ffa685c33f')
INSERT [dbo].[User] ([user_id], [Fname], [Lname], [Email], [IsEmailVerified], [Password], [Confirm_Password], [DOB], [Gender], [Phone_Number], [Phone_Number_Country_Code], [Profile_Picture], [Address_1], [Address_2], [ZipCode], [City], [State], [Country], [College], [University], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive], [Activation_Code]) VALUES (64, N'final', N'patel', N'final@gmail.com', 1, N'123123123', N'123123123', NULL, NULL, NULL, NULL, N'/Members/59/Screenshot (145).png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2021-03-01T10:50:59.4264443' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1, N'f0757f25-da4e-4ab4-8e19-a7b3a7071ad7')
INSERT [dbo].[User] ([user_id], [Fname], [Lname], [Email], [IsEmailVerified], [Password], [Confirm_Password], [DOB], [Gender], [Phone_Number], [Phone_Number_Country_Code], [Profile_Picture], [Address_1], [Address_2], [ZipCode], [City], [State], [Country], [College], [University], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive], [Activation_Code]) VALUES (65, N'akshay', N'kumar', N'akshay@gmail.com', 1, N'123123123', N'123123123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2021-03-01T10:51:59.6309330' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1, N'28ff1638-a614-4735-8331-d6773d165aa5')
INSERT [dbo].[User] ([user_id], [Fname], [Lname], [Email], [IsEmailVerified], [Password], [Confirm_Password], [DOB], [Gender], [Phone_Number], [Phone_Number_Country_Code], [Profile_Picture], [Address_1], [Address_2], [ZipCode], [City], [State], [Country], [College], [University], [Created_Date], [Created_By], [Modified_Date], [Modified_By], [Deactivated_Date], [Deactivated_By], [IsActive], [Activation_Code]) VALUES (66, N'abhijit', N'iyer', N'abhijit@gmail.com', 1, N'123123123', N'123123123', NULL, NULL, N'9876543210', N'+91', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2021-03-01T10:52:36.1529184' AS DateTime2), NULL, NULL, NULL, NULL, NULL, 1, N'c66d3065-add5-48b7-8ffc-739a6ee05c09')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Admin] ADD  CONSTRAINT [DF_Admin_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[Admin] ADD  CONSTRAINT [DF_Admin_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[BuyerReq] ADD  CONSTRAINT [DF_BuyerReq_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[BuyerReq] ADD  CONSTRAINT [DF_BuyerReq_Req_Created_Date]  DEFAULT (getdate()) FOR [Req_Created_Date]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF_Country_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF_Country_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[NoteDetails] ADD  CONSTRAINT [DF_NoteDetails_IsPaid]  DEFAULT ((0)) FOR [IsPaid]
GO
ALTER TABLE [dbo].[NoteDetails] ADD  CONSTRAINT [DF_NoteDetails_Sell_Price]  DEFAULT ((0)) FOR [Sell_Price]
GO
ALTER TABLE [dbo].[NoteDetails] ADD  CONSTRAINT [DF_NoteDetails_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[NoteDetails] ADD  CONSTRAINT [DF_NoteDetails_Status]  DEFAULT ('Draft') FOR [Status]
GO
ALTER TABLE [dbo].[NoteDetails] ADD  CONSTRAINT [DF_NoteDetails_No_Of_Download]  DEFAULT ((0)) FOR [No_Of_Download]
GO
ALTER TABLE [dbo].[NoteDetails] ADD  CONSTRAINT [DF_NoteDetails_Earning_Amount]  DEFAULT ((0)) FOR [Earning_Amount]
GO
ALTER TABLE [dbo].[NoteType] ADD  CONSTRAINT [DF_Type_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[NoteType] ADD  CONSTRAINT [DF_Type_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Spam] ADD  CONSTRAINT [DF_Spam_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[Spam] ADD  CONSTRAINT [DF_Spam_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SystemConfig] ADD  CONSTRAINT [DF_SystemConfig_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[SystemConfig] ADD  CONSTRAINT [DF_SystemConfig_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsEmailVerified]  DEFAULT ((0)) FOR [IsEmailVerified]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[BuyerReq]  WITH CHECK ADD  CONSTRAINT [BuyerReq and NoteDetails] FOREIGN KEY([note_id])
REFERENCES [dbo].[NoteDetails] ([note_id])
GO
ALTER TABLE [dbo].[BuyerReq] CHECK CONSTRAINT [BuyerReq and NoteDetails]
GO
ALTER TABLE [dbo].[BuyerReq]  WITH CHECK ADD  CONSTRAINT [BuyerReq and User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[BuyerReq] CHECK CONSTRAINT [BuyerReq and User]
GO
ALTER TABLE [dbo].[NoteDetails]  WITH CHECK ADD  CONSTRAINT [NoteDetails and User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[NoteDetails] CHECK CONSTRAINT [NoteDetails and User]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [Review and NoteDetails] FOREIGN KEY([note_id])
REFERENCES [dbo].[NoteDetails] ([note_id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [Review and NoteDetails]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [Review and User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [Review and User]
GO
ALTER TABLE [dbo].[Spam]  WITH CHECK ADD  CONSTRAINT [Spam and NoteDetails] FOREIGN KEY([note_id])
REFERENCES [dbo].[NoteDetails] ([note_id])
GO
ALTER TABLE [dbo].[Spam] CHECK CONSTRAINT [Spam and NoteDetails]
GO
ALTER TABLE [dbo].[Spam]  WITH CHECK ADD  CONSTRAINT [Spam and User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[Spam] CHECK CONSTRAINT [Spam and User]
GO
USE [master]
GO
ALTER DATABASE [TatvaDB] SET  READ_WRITE 
GO

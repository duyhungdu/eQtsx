USE [eQtsx]
GO
/****** Object:  User [vla]    Script Date: 10/07/2014 22:47:21 ******/
CREATE USER [vla] FOR LOGIN [vla] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Role [aspnet_Membership_BasicAccess]    Script Date: 10/07/2014 22:47:22 ******/
CREATE ROLE [aspnet_Membership_BasicAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Membership_FullAccess]    Script Date: 10/07/2014 22:47:22 ******/
CREATE ROLE [aspnet_Membership_FullAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Membership_ReportingAccess]    Script Date: 10/07/2014 22:47:22 ******/
CREATE ROLE [aspnet_Membership_ReportingAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Personalization_BasicAccess]    Script Date: 10/07/2014 22:47:22 ******/
CREATE ROLE [aspnet_Personalization_BasicAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Personalization_FullAccess]    Script Date: 10/07/2014 22:47:22 ******/
CREATE ROLE [aspnet_Personalization_FullAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Personalization_ReportingAccess]    Script Date: 10/07/2014 22:47:22 ******/
CREATE ROLE [aspnet_Personalization_ReportingAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Profile_BasicAccess]    Script Date: 10/07/2014 22:47:22 ******/
CREATE ROLE [aspnet_Profile_BasicAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Profile_FullAccess]    Script Date: 10/07/2014 22:47:22 ******/
CREATE ROLE [aspnet_Profile_FullAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Profile_ReportingAccess]    Script Date: 10/07/2014 22:47:23 ******/
CREATE ROLE [aspnet_Profile_ReportingAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Roles_BasicAccess]    Script Date: 10/07/2014 22:47:23 ******/
CREATE ROLE [aspnet_Roles_BasicAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Roles_FullAccess]    Script Date: 10/07/2014 22:47:23 ******/
CREATE ROLE [aspnet_Roles_FullAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_Roles_ReportingAccess]    Script Date: 10/07/2014 22:47:23 ******/
CREATE ROLE [aspnet_Roles_ReportingAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Role [aspnet_WebEvent_FullAccess]    Script Date: 10/07/2014 22:47:23 ******/
CREATE ROLE [aspnet_WebEvent_FullAccess] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [aspnet_Membership_BasicAccess]    Script Date: 10/07/2014 22:47:23 ******/
CREATE SCHEMA [aspnet_Membership_BasicAccess] AUTHORIZATION [aspnet_Membership_BasicAccess]
GO
/****** Object:  Schema [aspnet_Membership_FullAccess]    Script Date: 10/07/2014 22:47:23 ******/
CREATE SCHEMA [aspnet_Membership_FullAccess] AUTHORIZATION [aspnet_Membership_FullAccess]
GO
/****** Object:  Schema [aspnet_Membership_ReportingAccess]    Script Date: 10/07/2014 22:47:24 ******/
CREATE SCHEMA [aspnet_Membership_ReportingAccess] AUTHORIZATION [aspnet_Membership_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Personalization_BasicAccess]    Script Date: 10/07/2014 22:47:24 ******/
CREATE SCHEMA [aspnet_Personalization_BasicAccess] AUTHORIZATION [aspnet_Personalization_BasicAccess]
GO
/****** Object:  Schema [aspnet_Personalization_FullAccess]    Script Date: 10/07/2014 22:47:24 ******/
CREATE SCHEMA [aspnet_Personalization_FullAccess] AUTHORIZATION [aspnet_Personalization_FullAccess]
GO
/****** Object:  Schema [aspnet_Personalization_ReportingAccess]    Script Date: 10/07/2014 22:47:24 ******/
CREATE SCHEMA [aspnet_Personalization_ReportingAccess] AUTHORIZATION [aspnet_Personalization_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Profile_BasicAccess]    Script Date: 10/07/2014 22:47:24 ******/
CREATE SCHEMA [aspnet_Profile_BasicAccess] AUTHORIZATION [aspnet_Profile_BasicAccess]
GO
/****** Object:  Schema [aspnet_Profile_FullAccess]    Script Date: 10/07/2014 22:47:24 ******/
CREATE SCHEMA [aspnet_Profile_FullAccess] AUTHORIZATION [aspnet_Profile_FullAccess]
GO
/****** Object:  Schema [aspnet_Profile_ReportingAccess]    Script Date: 10/07/2014 22:47:24 ******/
CREATE SCHEMA [aspnet_Profile_ReportingAccess] AUTHORIZATION [aspnet_Profile_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Roles_BasicAccess]    Script Date: 10/07/2014 22:47:25 ******/
CREATE SCHEMA [aspnet_Roles_BasicAccess] AUTHORIZATION [aspnet_Roles_BasicAccess]
GO
/****** Object:  Schema [aspnet_Roles_FullAccess]    Script Date: 10/07/2014 22:47:25 ******/
CREATE SCHEMA [aspnet_Roles_FullAccess] AUTHORIZATION [aspnet_Roles_FullAccess]
GO
/****** Object:  Schema [aspnet_Roles_ReportingAccess]    Script Date: 10/07/2014 22:47:25 ******/
CREATE SCHEMA [aspnet_Roles_ReportingAccess] AUTHORIZATION [aspnet_Roles_ReportingAccess]
GO
/****** Object:  Schema [aspnet_WebEvent_FullAccess]    Script Date: 10/07/2014 22:47:25 ******/
CREATE SCHEMA [aspnet_WebEvent_FullAccess] AUTHORIZATION [aspnet_WebEvent_FullAccess]
GO
/****** Object:  Table [dbo].[aspnet_Applications]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Applications](
	[ApplicationName] [nvarchar](256) NOT NULL,
	[LoweredApplicationName] [nvarchar](256) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[LoweredApplicationName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ApplicationName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qlnl_DonVi]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlnl_DonVi](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenDonVi] [nvarchar](250) NULL,
	[KiHieu] [nchar](10) NULL,
	[MaDonViCapTren] [int] NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlnl_DonVi] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qlnl_DonVi] ON
INSERT [dbo].[Qlnl_DonVi] ([ID], [TenDonVi], [KiHieu], [MaDonViCapTren], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, N'Công ty Công nghệ sạch', N'CNS       ', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlnl_DonVi] ([ID], [TenDonVi], [KiHieu], [MaDonViCapTren], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, N'Ban giám đốc', NULL, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlnl_DonVi] ([ID], [TenDonVi], [KiHieu], [MaDonViCapTren], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (3, N'Phòng kế hoạch', NULL, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlnl_DonVi] ([ID], [TenDonVi], [KiHieu], [MaDonViCapTren], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (4, N'Phòng sản xuất', NULL, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlnl_DonVi] ([ID], [TenDonVi], [KiHieu], [MaDonViCapTren], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (5, N'Tổ sóng', NULL, 4, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlnl_DonVi] ([ID], [TenDonVi], [KiHieu], [MaDonViCapTren], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (6, N'Tổ CB - In', NULL, 4, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlnl_DonVi] ([ID], [TenDonVi], [KiHieu], [MaDonViCapTren], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (7, N'Tổ in lưới', NULL, 4, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlnl_DonVi] ([ID], [TenDonVi], [KiHieu], [MaDonViCapTren], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (8, N'Tổ hoàn thiện', NULL, 4, NULL, NULL, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qlnl_DonVi] OFF
/****** Object:  Table [dbo].[Qldh_NhomKhachHang]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qldh_NhomKhachHang](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenNhomKhachHang] [nvarchar](250) NULL,
	[HeSoTinhTongDao] [float] NULL,
	[HeSoTinhChatDai] [float] NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qldh_NhomKhachHang] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qldh_DanhMucSong]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qldh_DanhMucSong](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenSong] [nvarchar](50) NULL,
	[HeSoTieuHao] [float] NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qldh_DanhMucSong] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qldh_LoaiSanPham]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qldh_LoaiSanPham](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSanPham] [nvarchar](250) NULL,
	[MaHieuLoaiSanPham] [nchar](10) NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qldh_LoaiHop] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qldh_LoaiSanPham] ON
INSERT [dbo].[Qldh_LoaiSanPham] ([ID], [TenLoaiSanPham], [MaHieuLoaiSanPham], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, N'Thường', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qldh_LoaiSanPham] ([ID], [TenLoaiSanPham], [MaHieuLoaiSanPham], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, N'Hộp một lắp', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qldh_LoaiSanPham] ([ID], [TenLoaiSanPham], [MaHieuLoaiSanPham], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (3, N'Hộp bế', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qldh_LoaiSanPham] ([ID], [TenLoaiSanPham], [MaHieuLoaiSanPham], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (4, N'Hộp chờm tai', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qldh_LoaiSanPham] ([ID], [TenLoaiSanPham], [MaHieuLoaiSanPham], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (5, N'Phôi tấm', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qldh_LoaiSanPham] OFF
/****** Object:  Table [dbo].[Qldh_LoaiKichThuoc]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qldh_LoaiKichThuoc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoaiKichThuoc] [nvarchar](250) NULL,
	[MaHieuKichThuoc] [nchar](10) NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qldh_LoaiKichThuoc] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qldh_LoaiKichThuoc] ON
INSERT [dbo].[Qldh_LoaiKichThuoc] ([ID], [LoaiKichThuoc], [MaHieuKichThuoc], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, N'Kích thước trong', N'KTT       ', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qldh_LoaiKichThuoc] ([ID], [LoaiKichThuoc], [MaHieuKichThuoc], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, N'Kích thước ngoài', N'KTN       ', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qldh_LoaiKichThuoc] ([ID], [LoaiKichThuoc], [MaHieuKichThuoc], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (3, N'Kích thước phủ bì', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qldh_LoaiKichThuoc] ([ID], [LoaiKichThuoc], [MaHieuKichThuoc], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (4, N'Kích thước phủ bì toàn phần', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qldh_LoaiKichThuoc] ([ID], [LoaiKichThuoc], [MaHieuKichThuoc], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (5, N'Dài rộng cao tai ngoài', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qldh_LoaiKichThuoc] ([ID], [LoaiKichThuoc], [MaHieuKichThuoc], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (6, N'Kích thước trong cao kẻ', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qldh_LoaiKichThuoc] OFF
/****** Object:  Table [dbo].[Qlvt_KhoVatTu]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_KhoVatTu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenKhoVatTu] [nvarchar](50) NULL,
	[MaKhoCapTren] [int] NULL,
	[MaHieuKho] [nchar](10) NULL,
	[DiaChi] [nvarchar](250) NULL,
	[SoDienThoai] [nchar](15) NULL,
	[NguoiPhuTrach] [nvarchar](50) NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlvt_KhoVatTu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qlvt_KhoVatTu] ON
INSERT [dbo].[Qlvt_KhoVatTu] ([ID], [TenKhoVatTu], [MaKhoCapTren], [MaHieuKho], [DiaChi], [SoDienThoai], [NguoiPhuTrach], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, N'Kho công ty Công nghệ sạch -CNS', NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qlvt_KhoVatTu] OFF
/****** Object:  Table [dbo].[Qlnl_NhatKiDangNhap]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlnl_NhatKiDangNhap](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaNguoiDung] [uniqueidentifier] NOT NULL,
	[ThoiGianDangNhap] [datetime] NOT NULL,
	[DiaChiIP] [nchar](15) NOT NULL,
	[ThoiGianKetThuc] [datetime] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
 CONSTRAINT [PK_Qlnl_NhatKiDangNhap] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qlvt_TinhChatNhapXuat]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_TinhChatNhapXuat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenTinhChatNhapXuat] [nvarchar](250) NULL,
	[PhanLoaiNhapXuat] [int] NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlvt_TinhChatNhapXuat] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Phân loại nhập xuất: 1 - Nhập, 2 - Xuất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Qlvt_TinhChatNhapXuat', @level2type=N'COLUMN',@level2name=N'PhanLoaiNhapXuat'
GO
SET IDENTITY_INSERT [dbo].[Qlvt_TinhChatNhapXuat] ON
INSERT [dbo].[Qlvt_TinhChatNhapXuat] ([ID], [TenTinhChatNhapXuat], [PhanLoaiNhapXuat], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, N'Nhập mới vật tư', 1, 1, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_TinhChatNhapXuat] ([ID], [TenTinhChatNhapXuat], [PhanLoaiNhapXuat], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, N'Nhập trả lại vật tư', 1, 1, NULL, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qlvt_TinhChatNhapXuat] OFF
/****** Object:  Table [dbo].[Qlvt_NhaCungCap]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_NhaCungCap](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenNhaCungCap] [nvarchar](250) NULL,
	[MaHieuNhaCungCap] [nchar](10) NULL,
	[DiaChi] [nvarchar](250) NULL,
	[DienThoaiLienHe] [nchar](15) NULL,
	[SoTaiKhoan] [nchar](10) NULL,
	[NganHang] [nvarchar](250) NULL,
	[Email] [nvarchar](50) NULL,
	[SoFax] [nchar](15) NULL,
	[Url] [nvarchar](50) NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlvt_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qlvt_NhaCungCap] ON
INSERT [dbo].[Qlvt_NhaCungCap] ([ID], [TenNhaCungCap], [MaHieuNhaCungCap], [DiaChi], [DienThoaiLienHe], [SoTaiKhoan], [NganHang], [Email], [SoFax], [Url], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, N'Bãi bằng', N'BB        ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_NhaCungCap] ([ID], [TenNhaCungCap], [MaHieuNhaCungCap], [DiaChi], [DienThoaiLienHe], [SoTaiKhoan], [NganHang], [Email], [SoFax], [Url], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, N'Vạn Điểm', N'1VDM1     ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_NhaCungCap] ([ID], [TenNhaCungCap], [MaHieuNhaCungCap], [DiaChi], [DienThoaiLienHe], [SoTaiKhoan], [NganHang], [Email], [SoFax], [Url], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (3, N'Việt Tiến', N'1VTN1     ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_NhaCungCap] ([ID], [TenNhaCungCap], [MaHieuNhaCungCap], [DiaChi], [DienThoaiLienHe], [SoTaiKhoan], [NganHang], [Email], [SoFax], [Url], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (4, N'Tân Thuận Thành', N'1TTT1     ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qlvt_NhaCungCap] OFF
/****** Object:  Table [dbo].[Qlvt_LoaiVatTu]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_LoaiVatTu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaHieuLoaiVatTu] [nchar](10) NULL,
	[TenLoaiVatTu] [nvarchar](250) NULL,
	[MoTa] [nvarchar](250) NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [nchar](10) NULL,
 CONSTRAINT [PK_Qlvt_LoaiVatTu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qlvt_LoaiVatTu] ON
INSERT [dbo].[Qlvt_LoaiVatTu] ([ID], [MaHieuLoaiVatTu], [TenLoaiVatTu], [MoTa], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, N'A         ', N'Giấy Thái Lan', NULL, 1, N'', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_LoaiVatTu] ([ID], [MaHieuLoaiVatTu], [TenLoaiVatTu], [MoTa], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, N'B         ', N'Giấy Việt Trì', NULL, 1, N'', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_LoaiVatTu] ([ID], [MaHieuLoaiVatTu], [TenLoaiVatTu], [MoTa], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (3, N'C         ', N'Giấy Vạn Điểm', NULL, 1, N'', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_LoaiVatTu] ([ID], [MaHieuLoaiVatTu], [TenLoaiVatTu], [MoTa], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (5, N'D         ', N'Giấy Trắng', NULL, 1, N'', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_LoaiVatTu] ([ID], [MaHieuLoaiVatTu], [TenLoaiVatTu], [MoTa], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (6, N'E         ', N'Giấy Vàng', NULL, 1, N'', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_LoaiVatTu] ([ID], [MaHieuLoaiVatTu], [TenLoaiVatTu], [MoTa], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (7, N'F         ', N'Giấy Sóng', NULL, 1, N'', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qlvt_LoaiVatTu] OFF
/****** Object:  Table [dbo].[Qlvt_NhomVatTu]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_NhomVatTu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaHieuNhomVatTu] [nchar](10) NULL,
	[TenNhomVatTu] [nvarchar](250) NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlvt_NhomVatTu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_WebEvent_Events]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[aspnet_WebEvent_Events](
	[EventId] [char](32) NOT NULL,
	[EventTimeUtc] [datetime] NOT NULL,
	[EventTime] [datetime] NOT NULL,
	[EventType] [nvarchar](256) NOT NULL,
	[EventSequence] [decimal](19, 0) NOT NULL,
	[EventOccurrence] [decimal](19, 0) NOT NULL,
	[EventCode] [int] NOT NULL,
	[EventDetailCode] [int] NOT NULL,
	[Message] [nvarchar](1024) NULL,
	[ApplicationPath] [nvarchar](256) NULL,
	[ApplicationVirtualPath] [nvarchar](256) NULL,
	[MachineName] [nvarchar](256) NOT NULL,
	[RequestUrl] [nvarchar](1024) NULL,
	[ExceptionType] [nvarchar](256) NULL,
	[Details] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Setup_RestorePermissions]    Script Date: 10/07/2014 22:47:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Setup_RestorePermissions]
    @name   sysname
AS
BEGIN
    DECLARE @object sysname
    DECLARE @protectType char(10)
    DECLARE @action varchar(60)
    DECLARE @grantee sysname
    DECLARE @cmd nvarchar(500)
    DECLARE c1 cursor FORWARD_ONLY FOR
        SELECT Object, ProtectType, [Action], Grantee FROM #aspnet_Permissions where Object = @name

    OPEN c1

    FETCH c1 INTO @object, @protectType, @action, @grantee
    WHILE (@@fetch_status = 0)
    BEGIN
        SET @cmd = @protectType + ' ' + @action + ' on ' + @object + ' TO [' + @grantee + ']'
        EXEC (@cmd)
        FETCH c1 INTO @object, @protectType, @action, @grantee
    END

    CLOSE c1
    DEALLOCATE c1
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Setup_RemoveAllRoleMembers]    Script Date: 10/07/2014 22:47:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Setup_RemoveAllRoleMembers]
    @name   sysname
AS
BEGIN
    CREATE TABLE #aspnet_RoleMembers
    (
        Group_name      sysname,
        Group_id        smallint,
        Users_in_group  sysname,
        User_id         smallint
    )

    INSERT INTO #aspnet_RoleMembers
    EXEC sp_helpuser @name

    DECLARE @user_id smallint
    DECLARE @cmd nvarchar(500)
    DECLARE c1 cursor FORWARD_ONLY FOR
        SELECT User_id FROM #aspnet_RoleMembers

    OPEN c1

    FETCH c1 INTO @user_id
    WHILE (@@fetch_status = 0)
    BEGIN
        SET @cmd = 'EXEC sp_droprolemember ' + '''' + @name + ''', ''' + USER_NAME(@user_id) + ''''
        EXEC (@cmd)
        FETCH c1 INTO @user_id
    END

    CLOSE c1
    DEALLOCATE c1
END
GO
/****** Object:  Table [dbo].[aspnet_SchemaVersions]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_SchemaVersions](
	[Feature] [nvarchar](128) NOT NULL,
	[CompatibleSchemaVersion] [nvarchar](128) NOT NULL,
	[IsCurrentVersion] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Feature] ASC,
	[CompatibleSchemaVersion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'common', N'1', 1)
INSERT [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'health monitoring', N'1', 1)
INSERT [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'membership', N'1', 1)
INSERT [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'personalization', N'1', 1)
INSERT [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'profile', N'1', 1)
INSERT [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'role manager', N'1', 1)
/****** Object:  StoredProcedure [dbo].[aspnet_WebEvent_LogEvent]    Script Date: 10/07/2014 22:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_WebEvent_LogEvent]
        @EventId         char(32),
        @EventTimeUtc    datetime,
        @EventTime       datetime,
        @EventType       nvarchar(256),
        @EventSequence   decimal(19,0),
        @EventOccurrence decimal(19,0),
        @EventCode       int,
        @EventDetailCode int,
        @Message         nvarchar(1024),
        @ApplicationPath nvarchar(256),
        @ApplicationVirtualPath nvarchar(256),
        @MachineName    nvarchar(256),
        @RequestUrl      nvarchar(1024),
        @ExceptionType   nvarchar(256),
        @Details         ntext
AS
BEGIN
    INSERT
        dbo.aspnet_WebEvent_Events
        (
            EventId,
            EventTimeUtc,
            EventTime,
            EventType,
            EventSequence,
            EventOccurrence,
            EventCode,
            EventDetailCode,
            Message,
            ApplicationPath,
            ApplicationVirtualPath,
            MachineName,
            RequestUrl,
            ExceptionType,
            Details
        )
    VALUES
    (
        @EventId,
        @EventTimeUtc,
        @EventTime,
        @EventType,
        @EventSequence,
        @EventOccurrence,
        @EventCode,
        @EventDetailCode,
        @Message,
        @ApplicationPath,
        @ApplicationVirtualPath,
        @MachineName,
        @RequestUrl,
        @ExceptionType,
        @Details
    )
END
GO
/****** Object:  View [dbo].[vw_aspnet_Applications]    Script Date: 10/07/2014 22:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_Applications]
  AS SELECT [dbo].[aspnet_Applications].[ApplicationName], [dbo].[aspnet_Applications].[LoweredApplicationName], [dbo].[aspnet_Applications].[ApplicationId], [dbo].[aspnet_Applications].[Description]
  FROM [dbo].[aspnet_Applications]
GO
/****** Object:  Table [dbo].[aspnet_Users]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Users](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[LoweredUserName] [nvarchar](256) NOT NULL,
	[MobileAlias] [nvarchar](16) NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UnRegisterSchemaVersion]    Script Date: 10/07/2014 22:47:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_UnRegisterSchemaVersion]
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128)
AS
BEGIN
    DELETE FROM dbo.aspnet_SchemaVersions
        WHERE   Feature = LOWER(@Feature) AND @CompatibleSchemaVersion = CompatibleSchemaVersion
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_CheckSchemaVersion]    Script Date: 10/07/2014 22:47:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_CheckSchemaVersion]
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128)
AS
BEGIN
    IF (EXISTS( SELECT  *
                FROM    dbo.aspnet_SchemaVersions
                WHERE   Feature = LOWER( @Feature ) AND
                        CompatibleSchemaVersion = @CompatibleSchemaVersion ))
        RETURN 0

    RETURN 1
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Applications_CreateApplication]    Script Date: 10/07/2014 22:47:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Applications_CreateApplication]
    @ApplicationName      nvarchar(256),
    @ApplicationId        uniqueidentifier OUTPUT
AS
BEGIN
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName

    IF(@ApplicationId IS NULL)
    BEGIN
        DECLARE @TranStarted   bit
        SET @TranStarted = 0

        IF( @@TRANCOUNT = 0 )
        BEGIN
	        BEGIN TRANSACTION
	        SET @TranStarted = 1
        END
        ELSE
    	    SET @TranStarted = 0

        SELECT  @ApplicationId = ApplicationId
        FROM dbo.aspnet_Applications WITH (UPDLOCK, HOLDLOCK)
        WHERE LOWER(@ApplicationName) = LoweredApplicationName

        IF(@ApplicationId IS NULL)
        BEGIN
            SELECT  @ApplicationId = NEWID()
            INSERT  dbo.aspnet_Applications (ApplicationId, ApplicationName, LoweredApplicationName)
            VALUES  (@ApplicationId, @ApplicationName, LOWER(@ApplicationName))
        END


        IF( @TranStarted = 1 )
        BEGIN
            IF(@@ERROR = 0)
            BEGIN
	        SET @TranStarted = 0
	        COMMIT TRANSACTION
            END
            ELSE
            BEGIN
                SET @TranStarted = 0
                ROLLBACK TRANSACTION
            END
        END
    END
END
GO
/****** Object:  Table [dbo].[Qlvt_VatTu]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_VatTu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaLoaiVatTu] [int] NULL,
	[TenVatTu] [nvarchar](250) NULL,
	[MaHieuVatTu] [nvarchar](50) NULL,
	[KichThuocVatTu] [float] NULL,
	[DinhLuong] [float] NULL,
	[SoLuongTon] [float] NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[NgayTon] [date] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlvt_VatTu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qlvt_VatTu] ON
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, 7, N'Giấy Hà  Bắc - sóng K170-ĐL130', N'HB.SG170130', 170, 130, 0, N'cuộn', CAST(0x05390B00 AS Date), NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, 7, N'Giấy Hà  Bắc - sóng K165-ĐL130', N'HB.SG165130', 165, 130, 0, N'cuộn', CAST(0x05390B00 AS Date), NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (3, 7, N'Giấy Hiệp Hòa - sóng K155-ĐL130', N'HIH.SG155130', 155, 130, 0, N'cuộn', CAST(0x05390B00 AS Date), NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (4, 5, N'Giấy Hoàng Phúc - mặt trắng K130-ĐL160', N'HP.TR130160', 130, 160, 0, N'cuộn', CAST(0x05390B00 AS Date), NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (5, 3, N'Giấy Vạn Điểm - Mặt K90-ĐL170', N'VD.M090170', 90, 170, 0, N'cuộn', CAST(0x05390B00 AS Date), NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (6, 3, N'Giấy Vạn Điểm - Mặt K95-ĐL170', N'VD.M095170', 95, 170, 0, N'cuộn', CAST(0x05390B00 AS Date), NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (7, 3, N'Giấy Vạn Điểm - Mặt K100-ĐL170', N'VD.M100170', 100, 170, 0, N'cuộn', CAST(0x05390B00 AS Date), NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (8, 3, N'Giấy Vạn Điểm - Mặt K105-ĐL170', N'VD.M105170', 105, 170, 0, N'cuộn', CAST(0x05390B00 AS Date), NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (9, 7, N'Giấy Việt Tường  - Sóng K125-ĐL125', N'VTU.SG125125', 125, 125, 0, N'cuộn', CAST(0x05390B00 AS Date), NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTu] ([ID], [MaLoaiVatTu], [TenVatTu], [MaHieuVatTu], [KichThuocVatTu], [DinhLuong], [SoLuongTon], [DonViTinh], [NgayTon], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (10, 7, N'Giấy Việt Tường  - Sóng K090-ĐL125', N'VTU.SG090125', 90, 125, 0, N'cuộn', NULL, NULL, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qlvt_VatTu] OFF
/****** Object:  StoredProcedure [dbo].[Qlvt_TinhChatNhapXuat_GetAll]    Script Date: 10/07/2014 22:47:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Qlvt_TinhChatNhapXuat_GetAll] 
	-- Add the parameters for the stored procedure here
	@type int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @type =1 
		SELECT * FROM Qlvt_TinhChatNhapXuat qtcnx WHERE qtcnx.PhanLoaiNhapXuat = 1
	ELSE
		SELECT * FROM Qlvt_TinhChatNhapXuat qtcnx WHERE qtcnx.PhanLoaiNhapXuat = 2
END
GO
/****** Object:  Table [dbo].[Qlvt_PhieuNhap]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_PhieuNhap](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaNhaCungCap] [int] NULL,
	[MaKhoVatTu] [int] NULL,
	[MaHieuPhieuNhap] [nchar](10) NULL,
	[MaPhieuXuat] [int] NULL,
	[MaTinhChatNhapXuat] [int] NULL,
	[NgayNhap] [date] NULL,
	[MaNguoiNhap] [uniqueidentifier] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[TinhTrang] [bit] NULL,
	[Xoa] [bit] NULL,
	[MaNguoiDuyet] [uniqueidentifier] NULL,
	[NgayDuyet] [date] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlvt_PhieuNhap] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qlvt_PhieuNhap] ON
INSERT [dbo].[Qlvt_PhieuNhap] ([ID], [MaNhaCungCap], [MaKhoVatTu], [MaHieuPhieuNhap], [MaPhieuXuat], [MaTinhChatNhapXuat], [NgayNhap], [MaNguoiNhap], [GhiChu], [TinhTrang], [Xoa], [MaNguoiDuyet], [NgayDuyet], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, 1, 1, N'PN0001    ', NULL, 1, CAST(0x02390B00 AS Date), NULL, N'dsd', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_PhieuNhap] ([ID], [MaNhaCungCap], [MaKhoVatTu], [MaHieuPhieuNhap], [MaPhieuXuat], [MaTinhChatNhapXuat], [NgayNhap], [MaNguoiNhap], [GhiChu], [TinhTrang], [Xoa], [MaNguoiDuyet], [NgayDuyet], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, 1, 1, N'1231231   ', NULL, 1, CAST(0x02390B00 AS Date), NULL, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qlvt_PhieuNhap] OFF
/****** Object:  StoredProcedure [dbo].[Qlvt_NhaCungCap_GetAll]    Script Date: 10/07/2014 22:47:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Qlvt_NhaCungCap_GetAll] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Qlvt_NhaCungCap qncc
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_Qlvt_LoaiVatTu_Select]    Script Date: 10/07/2014 22:47:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lê Như Hòa>
-- Create date: <15/09/2014>
-- Description:	<Lấy loại vật tư theo yêu cầu>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_Qlvt_LoaiVatTu_Select]
	-- Add the parameters for the stored procedure here
	@Type int = 0,	-- Dùng để phân biệt các kiểu lấy khác nhau
	@ID int = null, -- ID khóa chính
	@MaHieuLoaiVatTu nchar(10) = null --Mã hiệu loại vật tư
AS
BEGIN
	if @Type = 0 -- Lấy tất cả
		select row_number() OVER (ORDER BY MaHieuLoaiVatTu, TenLoaiVatTu) AS TT,* from Qlvt_LoaiVatTu order by MaHieuLoaiVatTu
	else if @Type = 1 -- Lấy loại vật tư đang kích hoạt
		select row_number() OVER (ORDER BY MaHieuLoaiVatTu, TenLoaiVatTu) AS TT,* from Qlvt_LoaiVatTu where KichHoat = 1 order by MaHieuLoaiVatTu 
	else if @Type = 2 -- Lấy loại vật tư theo ID
		select row_number() OVER (ORDER BY MaHieuLoaiVatTu, TenLoaiVatTu) AS TT,* from Qlvt_LoaiVatTu where ID = @ID 
	else if @Type = 3 -- Lấy loại vật tư theo mã hiệu loại vật tư
		select row_number() OVER (ORDER BY MaHieuLoaiVatTu, TenLoaiVatTu) AS TT,* from Qlvt_LoaiVatTu where MaHieuLoaiVatTu = @MaHieuLoaiVatTu 
END
GO
/****** Object:  StoredProcedure [dbo].[Qlvt_KhoVatTu_GetAll]    Script Date: 10/07/2014 22:47:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Qlvt_KhoVatTu_GetAll] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Qlvt_KhoVatTu qkvt
END
GO
/****** Object:  Table [dbo].[Qlvt_PhieuXuat]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_PhieuXuat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaDonViNhan] [int] NULL,
	[MaKhoVatTu] [int] NULL,
	[MaHieuPhieuXuat] [nchar](10) NULL,
	[MaTinhChatNhapXuat] [int] NULL,
	[NgayXuat] [date] NULL,
	[MaNguoiXuat] [uniqueidentifier] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[TinhTrang] [bit] NULL,
	[Xoa] [bit] NULL,
	[MaNguoiDuyet] [uniqueidentifier] NULL,
	[NgayDuyet] [date] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlvt_PhieuXuat] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qlsx_CongDoan]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlsx_CongDoan](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaDonViPhuTrach] [int] NULL,
	[TenCongDoan] [nvarchar](250) NULL,
	[MaHieuCongDoan] [nchar](10) NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlsx_CongDoan] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qlsx_CongDoan] ON
INSERT [dbo].[Qlsx_CongDoan] ([ID], [MaDonViPhuTrach], [TenCongDoan], [MaHieuCongDoan], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, NULL, N'Tạo sóng', N'TS        ', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlsx_CongDoan] ([ID], [MaDonViPhuTrach], [TenCongDoan], [MaHieuCongDoan], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, NULL, N'In', N'IN        ', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlsx_CongDoan] ([ID], [MaDonViPhuTrach], [TenCongDoan], [MaHieuCongDoan], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (3, NULL, N'In lưới', N'IL        ', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlsx_CongDoan] ([ID], [MaDonViPhuTrach], [TenCongDoan], [MaHieuCongDoan], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (4, NULL, N'Ghim', N'G         ', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlsx_CongDoan] ([ID], [MaDonViPhuTrach], [TenCongDoan], [MaHieuCongDoan], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (5, NULL, N'Dán', N'D         ', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlsx_CongDoan] ([ID], [MaDonViPhuTrach], [TenCongDoan], [MaHieuCongDoan], [KichHoat], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (6, NULL, N'Chạp', N'C         ', NULL, NULL, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qlsx_CongDoan] OFF
/****** Object:  Table [dbo].[Qldh_KhachHang]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qldh_KhachHang](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaHieuKhachHang] [nchar](10) NULL,
	[TenKhachHang] [nvarchar](50) NULL,
	[MaNhomKhachHang] [int] NULL,
	[DiaChi] [nvarchar](250) NULL,
	[DienThoaiLienHe] [nchar](15) NULL,
	[SoFax] [nchar](15) NULL,
	[Email] [nvarchar](50) NULL,
	[ThongTinLienHe] [nvarchar](250) NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [int] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qldh_KhachHang] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Paths]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Paths](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NOT NULL,
	[Path] [nvarchar](256) NOT NULL,
	[LoweredPath] [nvarchar](256) NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Personalization_GetApplicationId]    Script Date: 10/07/2014 22:47:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Personalization_GetApplicationId] (
    @ApplicationName NVARCHAR(256),
    @ApplicationId UNIQUEIDENTIFIER OUT)
AS
BEGIN
    SELECT @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
END
GO
/****** Object:  Table [dbo].[aspnet_Roles]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Roles](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[LoweredRoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[aspnet_RegisterSchemaVersion]    Script Date: 10/07/2014 22:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_RegisterSchemaVersion]
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128),
    @IsCurrentVersion          bit,
    @RemoveIncompatibleSchema  bit
AS
BEGIN
    IF( @RemoveIncompatibleSchema = 1 )
    BEGIN
        DELETE FROM dbo.aspnet_SchemaVersions WHERE Feature = LOWER( @Feature )
    END
    ELSE
    BEGIN
        IF( @IsCurrentVersion = 1 )
        BEGIN
            UPDATE dbo.aspnet_SchemaVersions
            SET IsCurrentVersion = 0
            WHERE Feature = LOWER( @Feature )
        END
    END

    INSERT  dbo.aspnet_SchemaVersions( Feature, CompatibleSchemaVersion, IsCurrentVersion )
    VALUES( LOWER( @Feature ), @CompatibleSchemaVersion, @IsCurrentVersion )
END
GO
/****** Object:  Table [dbo].[aspnet_PersonalizationPerUser]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_PersonalizationPerUser](
	[Id] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Profile]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Profile](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [ntext] NOT NULL,
	[PropertyValuesString] [ntext] NOT NULL,
	[PropertyValuesBinary] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Membership]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Membership](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[MobilePIN] [nvarchar](16) NULL,
	[Email] [nvarchar](256) NULL,
	[LoweredEmail] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowStart] [datetime] NOT NULL,
	[Comment] [ntext] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Paths_CreatePath]    Script Date: 10/07/2014 22:47:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Paths_CreatePath]
    @ApplicationId UNIQUEIDENTIFIER,
    @Path           NVARCHAR(256),
    @PathId         UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    BEGIN TRANSACTION
    IF (NOT EXISTS(SELECT * FROM dbo.aspnet_Paths WHERE LoweredPath = LOWER(@Path) AND ApplicationId = @ApplicationId))
    BEGIN
        INSERT dbo.aspnet_Paths (ApplicationId, Path, LoweredPath) VALUES (@ApplicationId, @Path, LOWER(@Path))
    END
    COMMIT TRANSACTION
    SELECT @PathId = PathId FROM dbo.aspnet_Paths WHERE LOWER(@Path) = LoweredPath AND ApplicationId = @ApplicationId
END
GO
/****** Object:  Table [dbo].[aspnet_PersonalizationAllUsers]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers](
	[PathId] [uniqueidentifier] NOT NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qldh_DonHang]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qldh_DonHang](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaKhachHang] [int] NULL,
	[MaHieuDonHang] [nchar](10) NULL,
	[NgayDatHang] [date] NULL,
	[NgayGiaoHang] [date] NULL,
	[TinhTrang] [int] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qldh_DonHang] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_CreateRole]    Script Date: 10/07/2014 22:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Roles_CreateRole]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
        SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF (EXISTS(SELECT RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId))
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    INSERT INTO dbo.aspnet_Roles
                (ApplicationId, RoleName, LoweredRoleName)
         VALUES (@ApplicationId, @RoleName, LOWER(@RoleName))

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        COMMIT TRANSACTION
    END

    RETURN(0)

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  Table [dbo].[Qlnl_NguonLuc]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlnl_NguonLuc](
	[ID] [int] NOT NULL,
	[NguonLuc] [nvarchar](250) NULL,
	[MucTai] [float] NULL,
	[DonViTinh] [nchar](10) NULL,
	[MaCongDoan] [int] NULL,
	[TinhTrang] [bit] NULL,
	[KichHoat] [bit] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[ManguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlnl_NguonLuc] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Qlvt_phieuNhap_GetAll]    Script Date: 10/07/2014 22:47:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Qlvt_phieuNhap_GetAll] 
	-- Add the parameters for the stored procedure here
	@key NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT qpn.*,qkvt.TenKhoVatTu,qncc.TenNhaCungCap,qtcnx.TenTinhChatNhapXuat
	  FROM Qlvt_PhieuNhap qpn
	INNER JOIN Qlvt_KhoVatTu qkvt ON qkvt.ID = qpn.MaKhoVatTu
	INNER JOIN Qlvt_NhaCungCap qncc ON qncc.ID = qpn.MaNhaCungCap
	INNER JOIN Qlvt_TinhChatNhapXuat qtcnx ON qtcnx.ID = qpn.MaTinhChatNhapXuat
	WHERE qpn.MaHieuPhieuNhap LIKE '%'+@key+'%'
	
END
GO
/****** Object:  Table [dbo].[Qlvt_VatTuXuat]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_VatTuXuat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaVatTuNhap] [int] NULL,
	[MaPhieuXuat] [int] NULL,
	[MaKhoVatTu] [int] NULL,
	[SoLuongLamPhieuXuat] [float] NULL,
	[KichThuocThucTe] [float] NULL,
	[DinhLuongThucTe] [float] NULL,
	[ChenhLechDinhLuong] [float] NULL,
	[DinhLuongTinhTru] [float] NULL,
	[KhoiLuongTru] [float] NULL,
	[TruLoi] [float] NULL,
	[TruThuaKichThuoc] [float] NULL,
	[SoLuongThucXuat] [float] NULL,
	[SoLuongChenhLechKhongTinh] [float] NULL,
	[DonViTinh] [nchar](10) NULL,
	[DonGia] [int] NULL,
	[ThanhTien] [float] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlvt_VatTuXuat] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qlvt_VatTuNhap]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlvt_VatTuNhap](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaVatTu] [int] NULL,
	[MaPhieuNhap] [int] NULL,
	[SoLuongDauCuon] [float] NULL,
	[SoLuongLamPhieuNhap] [float] NULL,
	[KichThuocThucTe] [float] NULL,
	[DinhLuongThucTe] [float] NULL,
	[ChenhLechDinhLuong] [float] NULL,
	[DinhLuongTinhTru] [float] NULL,
	[KhoiLuongTru] [float] NULL,
	[TruLoi] [float] NULL,
	[TruThuaKichThuoc] [float] NULL,
	[SoLuongThucNhap] [float] NULL,
	[SoLuongChenhLechKhongTinh] [float] NULL,
	[DonViTinh] [nchar](10) NULL,
	[DonGia] [float] NULL,
	[ThanhTien] [float] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlvt_VatTuNhap] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Qlvt_VatTuNhap] ON
INSERT [dbo].[Qlvt_VatTuNhap] ([ID], [MaVatTu], [MaPhieuNhap], [SoLuongDauCuon], [SoLuongLamPhieuNhap], [KichThuocThucTe], [DinhLuongThucTe], [ChenhLechDinhLuong], [DinhLuongTinhTru], [KhoiLuongTru], [TruLoi], [TruThuaKichThuoc], [SoLuongThucNhap], [SoLuongChenhLechKhongTinh], [DonViTinh], [DonGia], [ThanhTien], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (1, 1, NULL, 10, 10, 10, 10, 0, 0, 0, 5, 0, 10, 10, N'cuộn      ', 10000, NULL, N'sd', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTuNhap] ([ID], [MaVatTu], [MaPhieuNhap], [SoLuongDauCuon], [SoLuongLamPhieuNhap], [KichThuocThucTe], [DinhLuongThucTe], [ChenhLechDinhLuong], [DinhLuongTinhTru], [KhoiLuongTru], [TruLoi], [TruThuaKichThuoc], [SoLuongThucNhap], [SoLuongChenhLechKhongTinh], [DonViTinh], [DonGia], [ThanhTien], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 5, 0, NULL, 0, N'cuộn      ', NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Qlvt_VatTuNhap] ([ID], [MaVatTu], [MaPhieuNhap], [SoLuongDauCuon], [SoLuongLamPhieuNhap], [KichThuocThucTe], [DinhLuongThucTe], [ChenhLechDinhLuong], [DinhLuongTinhTru], [KhoiLuongTru], [TruLoi], [TruThuaKichThuoc], [SoLuongThucNhap], [SoLuongChenhLechKhongTinh], [DonViTinh], [DonGia], [ThanhTien], [GhiChu], [Xoa], [MaNguoiTao], [NgayTao], [MaNguoiThayDoi], [NgayThayDoi]) VALUES (3, 1, 2, 0, 0, 0, 0, 0, 0, 0, 5, 0, NULL, 0, N'cuộn      ', NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Qlvt_VatTuNhap] OFF
/****** Object:  StoredProcedure [dbo].[Qlvt_VatTu_GetAll]    Script Date: 10/07/2014 22:47:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Qlvt_VatTu_GetAll] 
	-- Add the parameters for the stored procedure here
	@Type INT,
	@key NVARCHAR(50),
	@ID INT,
	@MaHieu NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @Type = 0
		SELECT * FROM Qlvt_VatTu qvt WHERE qvt.TenVatTu LIKE '%'+@key+'%' OR qvt.MaHieuVatTu LIKE '%'+@key+'%'
	else IF @Type = 1
		SELECT * FROM Qlvt_VatTu qvt WHERE qvt.TenVatTu LIKE '%'+@key+'%'
	else IF @Type = 2
		SELECT * FROM Qlvt_VatTu qvt WHERE qvt.MaHieuVatTu LIKE '%'+@key+'%'
	else IF @Type = 3
		SELECT * FROM Qlvt_VatTu qvt WHERE qvt.ID = @ID
END
GO
/****** Object:  View [dbo].[vw_aspnet_Users]    Script Date: 10/07/2014 22:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_Users]
  AS SELECT [dbo].[aspnet_Users].[ApplicationId], [dbo].[aspnet_Users].[UserId], [dbo].[aspnet_Users].[UserName], [dbo].[aspnet_Users].[LoweredUserName], [dbo].[aspnet_Users].[MobileAlias], [dbo].[aspnet_Users].[IsAnonymous], [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Users]
GO
/****** Object:  View [dbo].[vw_aspnet_Roles]    Script Date: 10/07/2014 22:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_Roles]
  AS SELECT [dbo].[aspnet_Roles].[ApplicationId], [dbo].[aspnet_Roles].[RoleId], [dbo].[aspnet_Roles].[RoleName], [dbo].[aspnet_Roles].[LoweredRoleName], [dbo].[aspnet_Roles].[Description]
  FROM [dbo].[aspnet_Roles]
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Users_CreateUser]    Script Date: 10/07/2014 22:47:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Users_CreateUser]
    @ApplicationId    uniqueidentifier,
    @UserName         nvarchar(256),
    @IsUserAnonymous  bit,
    @LastActivityDate DATETIME,
    @UserId           uniqueidentifier OUTPUT
AS
BEGIN
    IF( @UserId IS NULL )
        SELECT @UserId = NEWID()
    ELSE
    BEGIN
        IF( EXISTS( SELECT UserId FROM dbo.aspnet_Users
                    WHERE @UserId = UserId ) )
            RETURN -1
    END

    INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
    VALUES (@ApplicationId, @UserId, @UserName, LOWER(@UserName), @IsUserAnonymous, @LastActivityDate)

    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_RoleExists]    Script Date: 10/07/2014 22:47:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Roles_RoleExists]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(0)
    IF (EXISTS (SELECT RoleName FROM dbo.aspnet_Roles WHERE LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId ))
        RETURN(1)
    ELSE
        RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_GetAllRoles]    Script Date: 10/07/2014 22:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Roles_GetAllRoles] (
    @ApplicationName           nvarchar(256))
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN
    SELECT RoleName
    FROM   dbo.aspnet_Roles WHERE ApplicationId = @ApplicationId
    ORDER BY RoleName
END
GO
/****** Object:  Table [dbo].[aspnet_UsersInRoles]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Qlvt_VatTu_Select]    Script Date: 10/07/2014 22:47:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lê Như Hòa>
-- Modify: <>
-- Create date: <15/09/2014>
-- Modify date: <>
-- Description:	<Lấy vật tư theo yêu cầu>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_Qlvt_VatTu_Select]
	-- Add the parameters for the stored procedure here
	@Type int = 0, -- Dùng để phân biệt các kiểu lấy khác nhau
	@MaLoaiVatTu int = null,
	@ID int = null
AS
BEGIN
	if @Type = 0 -- Lấy tất cả các vật tư
		select row_number() OVER (ORDER BY MaHieuLoaiVatTu, TenVatTu) AS TT, Qlvt_VatTu.*, Qlvt_LoaiVatTu.MaHieuLoaiVatTu, Qlvt_LoaiVatTu.TenLoaiVatTu 
		from Qlvt_VatTu join Qlvt_LoaiVatTu on Qlvt_VatTu.MaLoaiVatTu = Qlvt_LoaiVatTu.ID
		
	else if @Type = 1 -- Lấy vật tư theo mã loại vật tư
		select row_number() OVER (ORDER BY MaHieuLoaiVatTu, TenVatTu) AS TT, Qlvt_VatTu.*, Qlvt_LoaiVatTu.MaHieuLoaiVatTu, Qlvt_LoaiVatTu.TenLoaiVatTu 
		from Qlvt_VatTu join Qlvt_LoaiVatTu on Qlvt_VatTu.MaLoaiVatTu = Qlvt_LoaiVatTu.ID 
		where MaLoaiVatTu = @MaLoaiVatTu 
	else if @Type = 2 -- Lấy vật tư theo mã vật tư
		select row_number() OVER (ORDER BY MaHieuLoaiVatTu, TenVatTu) AS TT, Qlvt_VatTu.*, Qlvt_LoaiVatTu.MaHieuLoaiVatTu, Qlvt_LoaiVatTu.TenLoaiVatTu 
		from Qlvt_VatTu join Qlvt_LoaiVatTu on Qlvt_VatTu.MaLoaiVatTu = Qlvt_LoaiVatTu.ID 
		where Qlvt_VatTu.ID = @ID
END
GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_Paths]    Script Date: 10/07/2014 22:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_WebPartState_Paths]
  AS SELECT [dbo].[aspnet_Paths].[ApplicationId], [dbo].[aspnet_Paths].[PathId], [dbo].[aspnet_Paths].[Path], [dbo].[aspnet_Paths].[LoweredPath]
  FROM [dbo].[aspnet_Paths]
GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_User]    Script Date: 10/07/2014 22:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_WebPartState_User]
  AS SELECT [dbo].[aspnet_PersonalizationPerUser].[PathId], [dbo].[aspnet_PersonalizationPerUser].[UserId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationPerUser].[PageSettings]), [dbo].[aspnet_PersonalizationPerUser].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationPerUser]
GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_Shared]    Script Date: 10/07/2014 22:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_WebPartState_Shared]
  AS SELECT [dbo].[aspnet_PersonalizationAllUsers].[PathId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationAllUsers].[PageSettings]), [dbo].[aspnet_PersonalizationAllUsers].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationAllUsers]
GO
/****** Object:  View [dbo].[vw_aspnet_UsersInRoles]    Script Date: 10/07/2014 22:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
  AS SELECT [dbo].[aspnet_UsersInRoles].[UserId], [dbo].[aspnet_UsersInRoles].[RoleId]
  FROM [dbo].[aspnet_UsersInRoles]
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_RemoveUsersFromRoles]    Script Date: 10/07/2014 22:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_RemoveUsersFromRoles]
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000)
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)


	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames  table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles  table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers  table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num	  int
	DECLARE @Pos	  int
	DECLARE @NextPos  int
	DECLARE @Name	  nvarchar(256)
	DECLARE @CountAll int
	DECLARE @CountU	  int
	DECLARE @CountR	  int


	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId
	SELECT @CountR = @@ROWCOUNT

	IF (@CountR <> @Num)
	BEGIN
		SELECT TOP 1 N'', Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END


	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1


	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	SELECT @CountU = @@ROWCOUNT
	IF (@CountU <> @Num)
	BEGIN
		SELECT TOP 1 Name, N''
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT au.LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE u.UserId = au.UserId)

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(1)
	END

	SELECT  @CountAll = COUNT(*)
	FROM	dbo.aspnet_UsersInRoles ur, @tbUsers u, @tbRoles r
	WHERE   ur.UserId = u.UserId AND ur.RoleId = r.RoleId

	IF (@CountAll <> @CountU * @CountR)
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 @tbUsers tu, @tbRoles tr, dbo.aspnet_Users u, dbo.aspnet_Roles r
		WHERE		 u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND
					 tu.UserId NOT IN (SELECT ur.UserId FROM dbo.aspnet_UsersInRoles ur WHERE ur.RoleId = tr.RoleId) AND
					 tr.RoleId NOT IN (SELECT ur.RoleId FROM dbo.aspnet_UsersInRoles ur WHERE ur.UserId = tu.UserId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	DELETE FROM dbo.aspnet_UsersInRoles
	WHERE UserId IN (SELECT UserId FROM @tbUsers)
	  AND RoleId IN (SELECT RoleId FROM @tbRoles)
	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_IsUserInRole]    Script Date: 10/07/2014 22:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_IsUserInRole]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(2)
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    DECLARE @RoleId uniqueidentifier
    SELECT  @RoleId = NULL

    SELECT  @UserId = UserId
    FROM    dbo.aspnet_Users
    WHERE   LoweredUserName = LOWER(@UserName) AND ApplicationId = @ApplicationId

    IF (@UserId IS NULL)
        RETURN(2)

    SELECT  @RoleId = RoleId
    FROM    dbo.aspnet_Roles
    WHERE   LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId

    IF (@RoleId IS NULL)
        RETURN(3)

    IF (EXISTS( SELECT * FROM dbo.aspnet_UsersInRoles WHERE  UserId = @UserId AND RoleId = @RoleId))
        RETURN(1)
    ELSE
        RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_GetUsersInRoles]    Script Date: 10/07/2014 22:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetUsersInRoles]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
     DECLARE @RoleId uniqueidentifier
     SELECT  @RoleId = NULL

     SELECT  @RoleId = RoleId
     FROM    dbo.aspnet_Roles
     WHERE   LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId

     IF (@RoleId IS NULL)
         RETURN(1)

    SELECT u.UserName
    FROM   dbo.aspnet_Users u, dbo.aspnet_UsersInRoles ur
    WHERE  u.UserId = ur.UserId AND @RoleId = ur.RoleId AND u.ApplicationId = @ApplicationId
    ORDER BY u.UserName
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_GetRolesForUser]    Script Date: 10/07/2014 22:47:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetRolesForUser]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL

    SELECT  @UserId = UserId
    FROM    dbo.aspnet_Users
    WHERE   LoweredUserName = LOWER(@UserName) AND ApplicationId = @ApplicationId

    IF (@UserId IS NULL)
        RETURN(1)

    SELECT r.RoleName
    FROM   dbo.aspnet_Roles r, dbo.aspnet_UsersInRoles ur
    WHERE  r.RoleId = ur.RoleId AND r.ApplicationId = @ApplicationId AND ur.UserId = @UserId
    ORDER BY r.RoleName
    RETURN (0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_FindUsersInRole]    Script Date: 10/07/2014 22:47:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_FindUsersInRole]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256),
    @UserNameToMatch  nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
     DECLARE @RoleId uniqueidentifier
     SELECT  @RoleId = NULL

     SELECT  @RoleId = RoleId
     FROM    dbo.aspnet_Roles
     WHERE   LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId

     IF (@RoleId IS NULL)
         RETURN(1)

    SELECT u.UserName
    FROM   dbo.aspnet_Users u, dbo.aspnet_UsersInRoles ur
    WHERE  u.UserId = ur.UserId AND @RoleId = ur.RoleId AND u.ApplicationId = @ApplicationId AND LoweredUserName LIKE LOWER(@UserNameToMatch)
    ORDER BY u.UserName
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_AddUsersToRoles]    Script Date: 10/07/2014 22:47:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_AddUsersToRoles]
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000),
	@CurrentTimeUtc   datetime
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)
	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames	table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles	table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers	table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num		int
	DECLARE @Pos		int
	DECLARE @NextPos	int
	DECLARE @Name		nvarchar(256)

	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		SELECT TOP 1 Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END

	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1

	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		DELETE FROM @tbNames
		WHERE LOWER(Name) IN (SELECT LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE au.UserId = u.UserId)

		INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
		  SELECT @AppId, NEWID(), Name, LOWER(Name), 0, @CurrentTimeUtc
		  FROM   @tbNames

		INSERT INTO @tbUsers
		  SELECT  UserId
		  FROM	dbo.aspnet_Users au, @tbNames t
		  WHERE   LOWER(t.Name) = au.LoweredUserName AND au.ApplicationId = @AppId
	END

	IF (EXISTS (SELECT * FROM dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr WHERE tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId))
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr, aspnet_Users u, aspnet_Roles r
		WHERE		u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	INSERT INTO dbo.aspnet_UsersInRoles (UserId, RoleId)
	SELECT UserId, RoleId
	FROM @tbUsers, @tbRoles

	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Users_DeleteUser]    Script Date: 10/07/2014 22:47:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Users_DeleteUser]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @TablesToDeleteFrom int,
    @NumTablesDeletedFrom int OUTPUT
AS
BEGIN
    DECLARE @UserId               uniqueidentifier
    SELECT  @UserId               = NULL
    SELECT  @NumTablesDeletedFrom = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
	SET @TranStarted = 0

    DECLARE @ErrorCode   int
    DECLARE @RowCount    int

    SET @ErrorCode = 0
    SET @RowCount  = 0

    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a
    WHERE   u.LoweredUserName       = LOWER(@UserName)
        AND u.ApplicationId         = a.ApplicationId
        AND LOWER(@ApplicationName) = a.LoweredApplicationName

    IF (@UserId IS NULL)
    BEGIN
        GOTO Cleanup
    END

    -- Delete from Membership table if (@TablesToDeleteFrom & 1) is set
    IF ((@TablesToDeleteFrom & 1) <> 0 AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_MembershipUsers') AND (type = 'V'))))
    BEGIN
        DELETE FROM dbo.aspnet_Membership WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
               @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_UsersInRoles table if (@TablesToDeleteFrom & 2) is set
    IF ((@TablesToDeleteFrom & 2) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_UsersInRoles') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_UsersInRoles WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_Profile table if (@TablesToDeleteFrom & 4) is set
    IF ((@TablesToDeleteFrom & 4) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Profiles') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_Profile WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_PersonalizationPerUser table if (@TablesToDeleteFrom & 8) is set
    IF ((@TablesToDeleteFrom & 8) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_WebPartState_User') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationPerUser WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_Users table if (@TablesToDeleteFrom & 1,2,4 & 8) are all set
    IF ((@TablesToDeleteFrom & 1) <> 0 AND
        (@TablesToDeleteFrom & 2) <> 0 AND
        (@TablesToDeleteFrom & 4) <> 0 AND
        (@TablesToDeleteFrom & 8) <> 0 AND
        (EXISTS (SELECT UserId FROM dbo.aspnet_Users WHERE @UserId = UserId)))
    BEGIN
        DELETE FROM dbo.aspnet_Users WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:
    SET @NumTablesDeletedFrom = 0

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
	    ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_DeleteRole]    Script Date: 10/07/2014 22:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Roles_DeleteRole]
    @ApplicationName            nvarchar(256),
    @RoleName                   nvarchar(256),
    @DeleteOnlyIfRoleIsEmpty    bit
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
        SET @TranStarted = 0

    DECLARE @RoleId   uniqueidentifier
    SELECT  @RoleId = NULL
    SELECT  @RoleId = RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId

    IF (@RoleId IS NULL)
    BEGIN
        SELECT @ErrorCode = 1
        GOTO Cleanup
    END
    IF (@DeleteOnlyIfRoleIsEmpty <> 0)
    BEGIN
        IF (EXISTS (SELECT RoleId FROM dbo.aspnet_UsersInRoles  WHERE @RoleId = RoleId))
        BEGIN
            SELECT @ErrorCode = 2
            GOTO Cleanup
        END
    END


    DELETE FROM dbo.aspnet_UsersInRoles  WHERE @RoleId = RoleId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    DELETE FROM dbo.aspnet_Roles WHERE @RoleId = RoleId  AND ApplicationId = @ApplicationId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        COMMIT TRANSACTION
    END

    RETURN(0)

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode
END
GO
/****** Object:  View [dbo].[vw_aspnet_Profiles]    Script Date: 10/07/2014 22:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_Profiles]
  AS SELECT [dbo].[aspnet_Profile].[UserId], [dbo].[aspnet_Profile].[LastUpdatedDate],
      [DataSize]=  DATALENGTH([dbo].[aspnet_Profile].[PropertyNames])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesString])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesBinary])
  FROM [dbo].[aspnet_Profile]
GO
/****** Object:  View [dbo].[vw_aspnet_MembershipUsers]    Script Date: 10/07/2014 22:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_MembershipUsers]
  AS SELECT [dbo].[aspnet_Membership].[UserId],
            [dbo].[aspnet_Membership].[PasswordFormat],
            [dbo].[aspnet_Membership].[MobilePIN],
            [dbo].[aspnet_Membership].[Email],
            [dbo].[aspnet_Membership].[LoweredEmail],
            [dbo].[aspnet_Membership].[PasswordQuestion],
            [dbo].[aspnet_Membership].[PasswordAnswer],
            [dbo].[aspnet_Membership].[IsApproved],
            [dbo].[aspnet_Membership].[IsLockedOut],
            [dbo].[aspnet_Membership].[CreateDate],
            [dbo].[aspnet_Membership].[LastLoginDate],
            [dbo].[aspnet_Membership].[LastPasswordChangedDate],
            [dbo].[aspnet_Membership].[LastLockoutDate],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptWindowStart],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptWindowStart],
            [dbo].[aspnet_Membership].[Comment],
            [dbo].[aspnet_Users].[ApplicationId],
            [dbo].[aspnet_Users].[UserName],
            [dbo].[aspnet_Users].[MobileAlias],
            [dbo].[aspnet_Users].[IsAnonymous],
            [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Membership] INNER JOIN [dbo].[aspnet_Users]
      ON [dbo].[aspnet_Membership].[UserId] = [dbo].[aspnet_Users].[UserId]
GO
/****** Object:  Table [dbo].[Qldh_MatHang]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qldh_MatHang](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaHieu] [nchar](10) NULL,
	[MaDonHang] [int] NULL,
	[TenMatHang] [nvarchar](250) NULL,
	[NgayGiaoHang] [date] NULL,
	[SoLuong] [float] NULL,
	[DonVitinh] [nchar](10) NULL,
	[MauSacMatNgoai] [nvarchar](50) NULL,
	[ChieuDai] [float] NULL,
	[ChieuRong] [float] NULL,
	[ChieuCao] [float] NULL,
	[MaLoaiKichThuoc] [int] NULL,
	[MaLoaiSanPham] [int] NULL,
	[SoLop] [int] NULL,
	[TongDao] [int] NULL,
	[Xa] [float] NULL,
	[KhoGiay] [float] NULL,
	[ChatDai] [float] NULL,
	[Mat] [float] NULL,
	[Day] [float] NULL,
	[LopGiua] [float] NULL,
	[DonGia] [int] NULL,
	[ThanhTien] [float] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qldh_SanPhamDatHang] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetChiTietPhieuNhap]    Script Date: 10/07/2014 22:47:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[GetChiTietPhieuNhap] 
 -- Add the parameters for the stored procedure here
 @ID_PhieuNhap int
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

    -- Insert statements for procedure here
 SELECT qvtn.*,qvt.MaHieuVatTu,qvt.TenVatTu,qlvt.MaHieuLoaiVatTu,qvt.KichThuocVatTu,qvt.DinhLuong
   FROM Qlvt_VatTuNhap qvtn
 INNER JOIN Qlvt_VatTu qvt ON qvt.ID = qvtn.MaVatTu
 INNER JOIN Qlvt_LoaiVatTu qlvt ON qlvt.ID = qvt.MaLoaiVatTu
 WHERE qvtn.MaPhieuNhap = @ID_PhieuNhap AND (qvtn.Xoa =  0 OR qvtn.xoa IS NULL)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_DeleteInactiveProfiles]    Script Date: 10/07/2014 22:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Profile_DeleteInactiveProfiles]
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @InactiveSinceDate      datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
    BEGIN
        SELECT  0
        RETURN
    END

    DELETE
    FROM    dbo.aspnet_Profile
    WHERE   UserId IN
            (   SELECT  UserId
                FROM    dbo.aspnet_Users u
                WHERE   ApplicationId = @ApplicationId
                        AND (LastActivityDate <= @InactiveSinceDate)
                        AND (
                                (@ProfileAuthOptions = 2)
                             OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                             OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
                            )
            )

    SELECT  @@ROWCOUNT
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_UpdateUserInfo]    Script Date: 10/07/2014 22:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UpdateUserInfo]
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @IsPasswordCorrect              bit,
    @UpdateLastLoginActivityDate    bit,
    @MaxInvalidPasswordAttempts     int,
    @PasswordAttemptWindow          int,
    @CurrentTimeUtc                 datetime,
    @LastLoginDate                  datetime,
    @LastActivityDate               datetime
AS
BEGIN
    DECLARE @UserId                                 uniqueidentifier
    DECLARE @IsApproved                             bit
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId,
            @IsApproved = m.IsApproved,
            @IsLockedOut = m.IsLockedOut,
            @LastLockoutDate = m.LastLockoutDate,
            @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
            @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
            @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
            @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m WITH ( UPDLOCK )
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF ( @@rowcount = 0 )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    IF( @IsLockedOut = 1 )
    BEGIN
        GOTO Cleanup
    END

    IF( @IsPasswordCorrect = 0 )
    BEGIN
        IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAttemptWindowStart ) )
        BEGIN
            SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc
            SET @FailedPasswordAttemptCount = 1
        END
        ELSE
        BEGIN
            SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc
            SET @FailedPasswordAttemptCount = @FailedPasswordAttemptCount + 1
        END

        BEGIN
            IF( @FailedPasswordAttemptCount >= @MaxInvalidPasswordAttempts )
            BEGIN
                SET @IsLockedOut = 1
                SET @LastLockoutDate = @CurrentTimeUtc
            END
        END
    END
    ELSE
    BEGIN
        IF( @FailedPasswordAttemptCount > 0 OR @FailedPasswordAnswerAttemptCount > 0 )
        BEGIN
            SET @FailedPasswordAttemptCount = 0
            SET @FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            SET @FailedPasswordAnswerAttemptCount = 0
            SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            SET @LastLockoutDate = CONVERT( datetime, '17540101', 112 )
        END
    END

    IF( @UpdateLastLoginActivityDate = 1 )
    BEGIN
        UPDATE  dbo.aspnet_Users
        SET     LastActivityDate = @LastActivityDate
        WHERE   @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END

        UPDATE  dbo.aspnet_Membership
        SET     LastLoginDate = @LastLoginDate
        WHERE   UserId = @UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END


    UPDATE dbo.aspnet_Membership
    SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
        FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
        FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
        FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
        FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
    WHERE @UserId = UserId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_UpdateUser]    Script Date: 10/07/2014 22:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UpdateUser]
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @Email                nvarchar(256),
    @Comment              ntext,
    @IsApproved           bit,
    @LastLoginDate        datetime,
    @LastActivityDate     datetime,
    @UniqueEmail          int,
    @CurrentTimeUtc       datetime
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId, @ApplicationId = a.ApplicationId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF (@UserId IS NULL)
        RETURN(1)

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  dbo.aspnet_Membership WITH (UPDLOCK, HOLDLOCK)
                    WHERE ApplicationId = @ApplicationId  AND @UserId <> UserId AND LoweredEmail = LOWER(@Email)))
        BEGIN
            RETURN(7)
        END
    END

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
	SET @TranStarted = 0

    UPDATE dbo.aspnet_Users WITH (ROWLOCK)
    SET
         LastActivityDate = @LastActivityDate
    WHERE
       @UserId = UserId

    IF( @@ERROR <> 0 )
        GOTO Cleanup

    UPDATE dbo.aspnet_Membership WITH (ROWLOCK)
    SET
         Email            = @Email,
         LoweredEmail     = LOWER(@Email),
         Comment          = @Comment,
         IsApproved       = @IsApproved,
         LastLoginDate    = @LastLoginDate
    WHERE
       @UserId = UserId

    IF( @@ERROR <> 0 )
        GOTO Cleanup

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN -1
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_UnlockUser]    Script Date: 10/07/2014 22:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UnlockUser]
    @ApplicationName                         nvarchar(256),
    @UserName                                nvarchar(256)
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF ( @UserId IS NULL )
        RETURN 1

    UPDATE dbo.aspnet_Membership
    SET IsLockedOut = 0,
        FailedPasswordAttemptCount = 0,
        FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        FailedPasswordAnswerAttemptCount = 0,
        FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        LastLockoutDate = CONVERT( datetime, '17540101', 112 )
    WHERE @UserId = UserId

    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_SetPassword]    Script Date: 10/07/2014 22:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_SetPassword]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @NewPassword      nvarchar(128),
    @PasswordSalt     nvarchar(128),
    @CurrentTimeUtc   datetime,
    @PasswordFormat   int = 0
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF (@UserId IS NULL)
        RETURN(1)

    UPDATE dbo.aspnet_Membership
    SET Password = @NewPassword, PasswordFormat = @PasswordFormat, PasswordSalt = @PasswordSalt,
        LastPasswordChangedDate = @CurrentTimeUtc
    WHERE @UserId = UserId
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_ResetPassword]    Script Date: 10/07/2014 22:47:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_ResetPassword]
    @ApplicationName             nvarchar(256),
    @UserName                    nvarchar(256),
    @NewPassword                 nvarchar(128),
    @MaxInvalidPasswordAttempts  int,
    @PasswordAttemptWindow       int,
    @PasswordSalt                nvarchar(128),
    @CurrentTimeUtc              datetime,
    @PasswordFormat              int = 0,
    @PasswordAnswer              nvarchar(128) = NULL
AS
BEGIN
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @UserId                                 uniqueidentifier
    SET     @UserId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF ( @UserId IS NULL )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    SELECT @IsLockedOut = IsLockedOut,
           @LastLockoutDate = LastLockoutDate,
           @FailedPasswordAttemptCount = FailedPasswordAttemptCount,
           @FailedPasswordAttemptWindowStart = FailedPasswordAttemptWindowStart,
           @FailedPasswordAnswerAttemptCount = FailedPasswordAnswerAttemptCount,
           @FailedPasswordAnswerAttemptWindowStart = FailedPasswordAnswerAttemptWindowStart
    FROM dbo.aspnet_Membership WITH ( UPDLOCK )
    WHERE @UserId = UserId

    IF( @IsLockedOut = 1 )
    BEGIN
        SET @ErrorCode = 99
        GOTO Cleanup
    END

    UPDATE dbo.aspnet_Membership
    SET    Password = @NewPassword,
           LastPasswordChangedDate = @CurrentTimeUtc,
           PasswordFormat = @PasswordFormat,
           PasswordSalt = @PasswordSalt
    WHERE  @UserId = UserId AND
           ( ( @PasswordAnswer IS NULL ) OR ( LOWER( PasswordAnswer ) = LOWER( @PasswordAnswer ) ) )

    IF ( @@ROWCOUNT = 0 )
        BEGIN
            IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart ) )
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = 1
            END
            ELSE
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1
            END

            BEGIN
                IF( @FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts )
                BEGIN
                    SET @IsLockedOut = 1
                    SET @LastLockoutDate = @CurrentTimeUtc
                END
            END

            SET @ErrorCode = 3
        END
    ELSE
        BEGIN
            IF( @FailedPasswordAnswerAttemptCount > 0 )
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = 0
                SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            END
        END

    IF( NOT ( @PasswordAnswer IS NULL ) )
    BEGIN
        UPDATE dbo.aspnet_Membership
        SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
            FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
            FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
            FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
            FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
        WHERE @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetUserByUserId]    Script Date: 10/07/2014 22:47:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByUserId]
    @UserId               uniqueidentifier,
    @CurrentTimeUtc       datetime,
    @UpdateLastActivity   bit = 0
AS
BEGIN
    IF ( @UpdateLastActivity = 1 )
    BEGIN
        UPDATE   dbo.aspnet_Users
        SET      LastActivityDate = @CurrentTimeUtc
        FROM     dbo.aspnet_Users
        WHERE    @UserId = UserId

        IF ( @@ROWCOUNT = 0 ) -- User ID not found
            RETURN -1
    END

    SELECT  m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate, m.LastLoginDate, u.LastActivityDate,
            m.LastPasswordChangedDate, u.UserName, m.IsLockedOut,
            m.LastLockoutDate
    FROM    dbo.aspnet_Users u, dbo.aspnet_Membership m
    WHERE   @UserId = u.UserId AND u.UserId = m.UserId

    IF ( @@ROWCOUNT = 0 ) -- User ID not found
       RETURN -1

    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetUserByName]    Script Date: 10/07/2014 22:47:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByName]
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @CurrentTimeUtc       datetime,
    @UpdateLastActivity   bit = 0
AS
BEGIN
    DECLARE @UserId uniqueidentifier

    IF (@UpdateLastActivity = 1)
    BEGIN
        -- select user ID from aspnet_users table
        SELECT TOP 1 @UserId = u.UserId
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE    LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                LOWER(@UserName) = u.LoweredUserName AND u.UserId = m.UserId

        IF (@@ROWCOUNT = 0) -- Username not found
            RETURN -1

        UPDATE   dbo.aspnet_Users
        SET      LastActivityDate = @CurrentTimeUtc
        WHERE    @UserId = UserId

        SELECT m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
                m.CreateDate, m.LastLoginDate, u.LastActivityDate, m.LastPasswordChangedDate,
                u.UserId, m.IsLockedOut, m.LastLockoutDate
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE  @UserId = u.UserId AND u.UserId = m.UserId 
    END
    ELSE
    BEGIN
        SELECT TOP 1 m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
                m.CreateDate, m.LastLoginDate, u.LastActivityDate, m.LastPasswordChangedDate,
                u.UserId, m.IsLockedOut,m.LastLockoutDate
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE    LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                LOWER(@UserName) = u.LoweredUserName AND u.UserId = m.UserId

        IF (@@ROWCOUNT = 0) -- Username not found
            RETURN -1
    END

    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetUserByEmail]    Script Date: 10/07/2014 22:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByEmail]
    @ApplicationName  nvarchar(256),
    @Email            nvarchar(256)
AS
BEGIN
    IF( @Email IS NULL )
        SELECT  u.UserName
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                u.UserId = m.UserId AND
                m.LoweredEmail IS NULL
    ELSE
        SELECT  u.UserName
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                u.UserId = m.UserId AND
                LOWER(@Email) = m.LoweredEmail

    IF (@@rowcount = 0)
        RETURN(1)
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetPasswordWithFormat]    Script Date: 10/07/2014 22:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetPasswordWithFormat]
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @UpdateLastLoginActivityDate    bit,
    @CurrentTimeUtc                 datetime
AS
BEGIN
    DECLARE @IsLockedOut                        bit
    DECLARE @UserId                             uniqueidentifier
    DECLARE @Password                           nvarchar(128)
    DECLARE @PasswordSalt                       nvarchar(128)
    DECLARE @PasswordFormat                     int
    DECLARE @FailedPasswordAttemptCount         int
    DECLARE @FailedPasswordAnswerAttemptCount   int
    DECLARE @IsApproved                         bit
    DECLARE @LastActivityDate                   datetime
    DECLARE @LastLoginDate                      datetime

    SELECT  @UserId          = NULL

    SELECT  @UserId = u.UserId, @IsLockedOut = m.IsLockedOut, @Password=Password, @PasswordFormat=PasswordFormat,
            @PasswordSalt=PasswordSalt, @FailedPasswordAttemptCount=FailedPasswordAttemptCount,
		    @FailedPasswordAnswerAttemptCount=FailedPasswordAnswerAttemptCount, @IsApproved=IsApproved,
            @LastActivityDate = LastActivityDate, @LastLoginDate = LastLoginDate
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF (@UserId IS NULL)
        RETURN 1

    IF (@IsLockedOut = 1)
        RETURN 99

    SELECT   @Password, @PasswordFormat, @PasswordSalt, @FailedPasswordAttemptCount,
             @FailedPasswordAnswerAttemptCount, @IsApproved, @LastLoginDate, @LastActivityDate

    IF (@UpdateLastLoginActivityDate = 1 AND @IsApproved = 1)
    BEGIN
        UPDATE  dbo.aspnet_Membership
        SET     LastLoginDate = @CurrentTimeUtc
        WHERE   UserId = @UserId

        UPDATE  dbo.aspnet_Users
        SET     LastActivityDate = @CurrentTimeUtc
        WHERE   @UserId = UserId
    END


    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetPassword]    Script Date: 10/07/2014 22:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetPassword]
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @MaxInvalidPasswordAttempts     int,
    @PasswordAttemptWindow          int,
    @CurrentTimeUtc                 datetime,
    @PasswordAnswer                 nvarchar(128) = NULL
AS
BEGIN
    DECLARE @UserId                                 uniqueidentifier
    DECLARE @PasswordFormat                         int
    DECLARE @Password                               nvarchar(128)
    DECLARE @passAns                                nvarchar(128)
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId,
            @Password = m.Password,
            @passAns = m.PasswordAnswer,
            @PasswordFormat = m.PasswordFormat,
            @IsLockedOut = m.IsLockedOut,
            @LastLockoutDate = m.LastLockoutDate,
            @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
            @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
            @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
            @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m WITH ( UPDLOCK )
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF ( @@rowcount = 0 )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    IF( @IsLockedOut = 1 )
    BEGIN
        SET @ErrorCode = 99
        GOTO Cleanup
    END

    IF ( NOT( @PasswordAnswer IS NULL ) )
    BEGIN
        IF( ( @passAns IS NULL ) OR ( LOWER( @passAns ) <> LOWER( @PasswordAnswer ) ) )
        BEGIN
            IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart ) )
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = 1
            END
            ELSE
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
            END

            BEGIN
                IF( @FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts )
                BEGIN
                    SET @IsLockedOut = 1
                    SET @LastLockoutDate = @CurrentTimeUtc
                END
            END

            SET @ErrorCode = 3
        END
        ELSE
        BEGIN
            IF( @FailedPasswordAnswerAttemptCount > 0 )
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = 0
                SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            END
        END

        UPDATE dbo.aspnet_Membership
        SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
            FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
            FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
            FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
            FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
        WHERE @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    IF( @ErrorCode = 0 )
        SELECT @Password, @PasswordFormat

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetNumberOfUsersOnline]    Script Date: 10/07/2014 22:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetNumberOfUsersOnline]
    @ApplicationName            nvarchar(256),
    @MinutesSinceLastInActive   int,
    @CurrentTimeUtc             datetime
AS
BEGIN
    DECLARE @DateActive datetime
    SELECT  @DateActive = DATEADD(minute,  -(@MinutesSinceLastInActive), @CurrentTimeUtc)

    DECLARE @NumOnline int
    SELECT  @NumOnline = COUNT(*)
    FROM    dbo.aspnet_Users u(NOLOCK),
            dbo.aspnet_Applications a(NOLOCK),
            dbo.aspnet_Membership m(NOLOCK)
    WHERE   u.ApplicationId = a.ApplicationId                  AND
            LastActivityDate > @DateActive                     AND
            a.LoweredApplicationName = LOWER(@ApplicationName) AND
            u.UserId = m.UserId
    RETURN(@NumOnline)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetAllUsers]    Script Date: 10/07/2014 22:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetAllUsers]
    @ApplicationName       nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0


    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
    SELECT u.UserId
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u
    WHERE  u.ApplicationId = @ApplicationId AND u.UserId = m.UserId
    ORDER BY u.UserName

    SELECT @TotalRecords = @@ROWCOUNT

    SELECT u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName
    RETURN @TotalRecords
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_FindUsersByName]    Script Date: 10/07/2014 22:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_FindUsersByName]
    @ApplicationName       nvarchar(256),
    @UserNameToMatch       nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
        SELECT u.UserId
        FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND u.LoweredUserName LIKE LOWER(@UserNameToMatch)
        ORDER BY u.UserName


    SELECT  u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName

    SELECT  @TotalRecords = COUNT(*)
    FROM    #PageIndexForUsers
    RETURN @TotalRecords
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_FindUsersByEmail]    Script Date: 10/07/2014 22:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_FindUsersByEmail]
    @ApplicationName       nvarchar(256),
    @EmailToMatch          nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    IF( @EmailToMatch IS NULL )
        INSERT INTO #PageIndexForUsers (UserId)
            SELECT u.UserId
            FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
            WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND m.Email IS NULL
            ORDER BY m.LoweredEmail
    ELSE
        INSERT INTO #PageIndexForUsers (UserId)
            SELECT u.UserId
            FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
            WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND m.LoweredEmail LIKE LOWER(@EmailToMatch)
            ORDER BY m.LoweredEmail

    SELECT  u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY m.LoweredEmail

    SELECT  @TotalRecords = COUNT(*)
    FROM    #PageIndexForUsers
    RETURN @TotalRecords
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_CreateUser]    Script Date: 10/07/2014 22:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_CreateUser]
    @ApplicationName                        nvarchar(256),
    @UserName                               nvarchar(256),
    @Password                               nvarchar(128),
    @PasswordSalt                           nvarchar(128),
    @Email                                  nvarchar(256),
    @PasswordQuestion                       nvarchar(256),
    @PasswordAnswer                         nvarchar(128),
    @IsApproved                             bit,
    @CurrentTimeUtc                         datetime,
    @CreateDate                             datetime = NULL,
    @UniqueEmail                            int      = 0,
    @PasswordFormat                         int      = 0,
    @UserId                                 uniqueidentifier OUTPUT
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @NewUserId uniqueidentifier
    SELECT @NewUserId = NULL

    DECLARE @IsLockedOut bit
    SET @IsLockedOut = 0

    DECLARE @LastLockoutDate  datetime
    SET @LastLockoutDate = CONVERT( datetime, '17540101', 112 )

    DECLARE @FailedPasswordAttemptCount int
    SET @FailedPasswordAttemptCount = 0

    DECLARE @FailedPasswordAttemptWindowStart  datetime
    SET @FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 )

    DECLARE @FailedPasswordAnswerAttemptCount int
    SET @FailedPasswordAnswerAttemptCount = 0

    DECLARE @FailedPasswordAnswerAttemptWindowStart  datetime
    SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )

    DECLARE @NewUserCreated bit
    DECLARE @ReturnValue   int
    SET @ReturnValue = 0

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    SET @CreateDate = @CurrentTimeUtc

    SELECT  @NewUserId = UserId FROM dbo.aspnet_Users WHERE LOWER(@UserName) = LoweredUserName AND @ApplicationId = ApplicationId
    IF ( @NewUserId IS NULL )
    BEGIN
        SET @NewUserId = @UserId
        EXEC @ReturnValue = dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CreateDate, @NewUserId OUTPUT
        SET @NewUserCreated = 1
    END
    ELSE
    BEGIN
        SET @NewUserCreated = 0
        IF( @NewUserId <> @UserId AND @UserId IS NOT NULL )
        BEGIN
            SET @ErrorCode = 6
            GOTO Cleanup
        END
    END

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @ReturnValue = -1 )
    BEGIN
        SET @ErrorCode = 10
        GOTO Cleanup
    END

    IF ( EXISTS ( SELECT UserId
                  FROM   dbo.aspnet_Membership
                  WHERE  @NewUserId = UserId ) )
    BEGIN
        SET @ErrorCode = 6
        GOTO Cleanup
    END

    SET @UserId = @NewUserId

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  dbo.aspnet_Membership m WITH ( UPDLOCK, HOLDLOCK )
                    WHERE ApplicationId = @ApplicationId AND LoweredEmail = LOWER(@Email)))
        BEGIN
            SET @ErrorCode = 7
            GOTO Cleanup
        END
    END

    IF (@NewUserCreated = 0)
    BEGIN
        UPDATE dbo.aspnet_Users
        SET    LastActivityDate = @CreateDate
        WHERE  @UserId = UserId
        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    INSERT INTO dbo.aspnet_Membership
                ( ApplicationId,
                  UserId,
                  Password,
                  PasswordSalt,
                  Email,
                  LoweredEmail,
                  PasswordQuestion,
                  PasswordAnswer,
                  PasswordFormat,
                  IsApproved,
                  IsLockedOut,
                  CreateDate,
                  LastLoginDate,
                  LastPasswordChangedDate,
                  LastLockoutDate,
                  FailedPasswordAttemptCount,
                  FailedPasswordAttemptWindowStart,
                  FailedPasswordAnswerAttemptCount,
                  FailedPasswordAnswerAttemptWindowStart )
         VALUES ( @ApplicationId,
                  @UserId,
                  @Password,
                  @PasswordSalt,
                  @Email,
                  LOWER(@Email),
                  @PasswordQuestion,
                  @PasswordAnswer,
                  @PasswordFormat,
                  @IsApproved,
                  @IsLockedOut,
                  @CreateDate,
                  @CreateDate,
                  @CreateDate,
                  @LastLockoutDate,
                  @FailedPasswordAttemptCount,
                  @FailedPasswordAttemptWindowStart,
                  @FailedPasswordAnswerAttemptCount,
                  @FailedPasswordAnswerAttemptWindowStart )

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer]    Script Date: 10/07/2014 22:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer]
    @ApplicationName       nvarchar(256),
    @UserName              nvarchar(256),
    @NewPasswordQuestion   nvarchar(256),
    @NewPasswordAnswer     nvarchar(128)
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Membership m, dbo.aspnet_Users u, dbo.aspnet_Applications a
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId
    IF (@UserId IS NULL)
    BEGIN
        RETURN(1)
    END

    UPDATE dbo.aspnet_Membership
    SET    PasswordQuestion = @NewPasswordQuestion, PasswordAnswer = @NewPasswordAnswer
    WHERE  UserId=@UserId
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_AnyDataInTables]    Script Date: 10/07/2014 22:47:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_AnyDataInTables]
    @TablesToCheck int
AS
BEGIN
    -- Check Membership table if (@TablesToCheck & 1) is set
    IF ((@TablesToCheck & 1) <> 0 AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_MembershipUsers') AND (type = 'V'))))
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Membership))
        BEGIN
            SELECT N'aspnet_Membership'
            RETURN
        END
    END

    -- Check aspnet_Roles table if (@TablesToCheck & 2) is set
    IF ((@TablesToCheck & 2) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Roles') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 RoleId FROM dbo.aspnet_Roles))
        BEGIN
            SELECT N'aspnet_Roles'
            RETURN
        END
    END

    -- Check aspnet_Profile table if (@TablesToCheck & 4) is set
    IF ((@TablesToCheck & 4) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Profiles') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Profile))
        BEGIN
            SELECT N'aspnet_Profile'
            RETURN
        END
    END

    -- Check aspnet_PersonalizationPerUser table if (@TablesToCheck & 8) is set
    IF ((@TablesToCheck & 8) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_WebPartState_User') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_PersonalizationPerUser))
        BEGIN
            SELECT N'aspnet_PersonalizationPerUser'
            RETURN
        END
    END

    -- Check aspnet_PersonalizationPerUser table if (@TablesToCheck & 16) is set
    IF ((@TablesToCheck & 16) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'aspnet_WebEvent_LogEvent') AND (type = 'P'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 * FROM dbo.aspnet_WebEvent_Events))
        BEGIN
            SELECT N'aspnet_WebEvent_Events'
            RETURN
        END
    END

    -- Check aspnet_Users table if (@TablesToCheck & 1,2,4 & 8) are all set
    IF ((@TablesToCheck & 1) <> 0 AND
        (@TablesToCheck & 2) <> 0 AND
        (@TablesToCheck & 4) <> 0 AND
        (@TablesToCheck & 8) <> 0 AND
        (@TablesToCheck & 32) <> 0 AND
        (@TablesToCheck & 128) <> 0 AND
        (@TablesToCheck & 256) <> 0 AND
        (@TablesToCheck & 512) <> 0 AND
        (@TablesToCheck & 1024) <> 0)
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Users))
        BEGIN
            SELECT N'aspnet_Users'
            RETURN
        END
        IF (EXISTS(SELECT TOP 1 ApplicationId FROM dbo.aspnet_Applications))
        BEGIN
            SELECT N'aspnet_Applications'
            RETURN
        END
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_ResetUserState]    Script Date: 10/07/2014 22:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_ResetUserState] (
    @Count                  int                 OUT,
    @ApplicationName        NVARCHAR(256),
    @InactiveSinceDate      DATETIME            = NULL,
    @UserName               NVARCHAR(256)       = NULL,
    @Path                   NVARCHAR(256)       = NULL)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationPerUser
        WHERE Id IN (SELECT PerUser.Id
                     FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
                     WHERE Paths.ApplicationId = @ApplicationId
                           AND PerUser.UserId = Users.UserId
                           AND PerUser.PathId = Paths.PathId
                           AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
                           AND (@UserName IS NULL OR Users.LoweredUserName = LOWER(@UserName))
                           AND (@Path IS NULL OR Paths.LoweredPath = LOWER(@Path)))

        SELECT @Count = @@ROWCOUNT
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_ResetSharedState]    Script Date: 10/07/2014 22:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_ResetSharedState] (
    @Count int OUT,
    @ApplicationName NVARCHAR(256),
    @Path NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationAllUsers
        WHERE PathId IN
            (SELECT AllUsers.PathId
             FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
             WHERE Paths.ApplicationId = @ApplicationId
                   AND AllUsers.PathId = Paths.PathId
                   AND Paths.LoweredPath = LOWER(@Path))

        SELECT @Count = @@ROWCOUNT
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_GetCountOfState]    Script Date: 10/07/2014 22:47:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_GetCountOfState] (
    @Count int OUT,
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @Path NVARCHAR(256) = NULL,
    @UserName NVARCHAR(256) = NULL,
    @InactiveSinceDate DATETIME = NULL)
AS
BEGIN

    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
        IF (@AllUsersScope = 1)
            SELECT @Count = COUNT(*)
            FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
            WHERE Paths.ApplicationId = @ApplicationId
                  AND AllUsers.PathId = Paths.PathId
                  AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
        ELSE
            SELECT @Count = COUNT(*)
            FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
            WHERE Paths.ApplicationId = @ApplicationId
                  AND PerUser.UserId = Users.UserId
                  AND PerUser.PathId = Paths.PathId
                  AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
                  AND (@UserName IS NULL OR Users.LoweredUserName LIKE LOWER(@UserName))
                  AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_FindState]    Script Date: 10/07/2014 22:47:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_FindState] (
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @PageIndex              INT,
    @PageSize               INT,
    @Path NVARCHAR(256) = NULL,
    @UserName NVARCHAR(256) = NULL,
    @InactiveSinceDate DATETIME = NULL)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        RETURN

    -- Set the page bounds
    DECLARE @PageLowerBound INT
    DECLARE @PageUpperBound INT
    DECLARE @TotalRecords   INT
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table to store the selected results
    CREATE TABLE #PageIndex (
        IndexId int IDENTITY (0, 1) NOT NULL,
        ItemId UNIQUEIDENTIFIER
    )

    IF (@AllUsersScope = 1)
    BEGIN
        -- Insert into our temp table
        INSERT INTO #PageIndex (ItemId)
        SELECT Paths.PathId
        FROM dbo.aspnet_Paths Paths,
             ((SELECT Paths.PathId
               FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
               WHERE Paths.ApplicationId = @ApplicationId
                      AND AllUsers.PathId = Paths.PathId
                      AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              ) AS SharedDataPerPath
              FULL OUTER JOIN
              (SELECT DISTINCT Paths.PathId
               FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Paths Paths
               WHERE Paths.ApplicationId = @ApplicationId
                      AND PerUser.PathId = Paths.PathId
                      AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              ) AS UserDataPerPath
              ON SharedDataPerPath.PathId = UserDataPerPath.PathId
             )
        WHERE Paths.PathId = SharedDataPerPath.PathId OR Paths.PathId = UserDataPerPath.PathId
        ORDER BY Paths.Path ASC

        SELECT @TotalRecords = @@ROWCOUNT

        SELECT Paths.Path,
               SharedDataPerPath.LastUpdatedDate,
               SharedDataPerPath.SharedDataLength,
               UserDataPerPath.UserDataLength,
               UserDataPerPath.UserCount
        FROM dbo.aspnet_Paths Paths,
             ((SELECT PageIndex.ItemId AS PathId,
                      AllUsers.LastUpdatedDate AS LastUpdatedDate,
                      DATALENGTH(AllUsers.PageSettings) AS SharedDataLength
               FROM dbo.aspnet_PersonalizationAllUsers AllUsers, #PageIndex PageIndex
               WHERE AllUsers.PathId = PageIndex.ItemId
                     AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
              ) AS SharedDataPerPath
              FULL OUTER JOIN
              (SELECT PageIndex.ItemId AS PathId,
                      SUM(DATALENGTH(PerUser.PageSettings)) AS UserDataLength,
                      COUNT(*) AS UserCount
               FROM aspnet_PersonalizationPerUser PerUser, #PageIndex PageIndex
               WHERE PerUser.PathId = PageIndex.ItemId
                     AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
               GROUP BY PageIndex.ItemId
              ) AS UserDataPerPath
              ON SharedDataPerPath.PathId = UserDataPerPath.PathId
             )
        WHERE Paths.PathId = SharedDataPerPath.PathId OR Paths.PathId = UserDataPerPath.PathId
        ORDER BY Paths.Path ASC
    END
    ELSE
    BEGIN
        -- Insert into our temp table
        INSERT INTO #PageIndex (ItemId)
        SELECT PerUser.Id
        FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
        WHERE Paths.ApplicationId = @ApplicationId
              AND PerUser.UserId = Users.UserId
              AND PerUser.PathId = Paths.PathId
              AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              AND (@UserName IS NULL OR Users.LoweredUserName LIKE LOWER(@UserName))
              AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
        ORDER BY Paths.Path ASC, Users.UserName ASC

        SELECT @TotalRecords = @@ROWCOUNT

        SELECT Paths.Path, PerUser.LastUpdatedDate, DATALENGTH(PerUser.PageSettings), Users.UserName, Users.LastActivityDate
        FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths, #PageIndex PageIndex
        WHERE PerUser.Id = PageIndex.ItemId
              AND PerUser.UserId = Users.UserId
              AND PerUser.PathId = Paths.PathId
              AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
        ORDER BY Paths.Path ASC, Users.UserName ASC
    END

    RETURN @TotalRecords
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_DeleteAllState]    Script Date: 10/07/2014 22:47:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_DeleteAllState] (
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @Count int OUT)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        IF (@AllUsersScope = 1)
            DELETE FROM aspnet_PersonalizationAllUsers
            WHERE PathId IN
               (SELECT Paths.PathId
                FROM dbo.aspnet_Paths Paths
                WHERE Paths.ApplicationId = @ApplicationId)
        ELSE
            DELETE FROM aspnet_PersonalizationPerUser
            WHERE PathId IN
               (SELECT Paths.PathId
                FROM dbo.aspnet_Paths Paths
                WHERE Paths.ApplicationId = @ApplicationId)

        SELECT @Count = @@ROWCOUNT
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationPerUser_SetPageSettings]    Script Date: 10/07/2014 22:47:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_SetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @PageSettings     IMAGE,
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CurrentTimeUtc, @UserId OUTPUT
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    IF (EXISTS(SELECT PathId FROM dbo.aspnet_PersonalizationPerUser WHERE UserId = @UserId AND PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationPerUser SET PageSettings = @PageSettings, LastUpdatedDate = @CurrentTimeUtc WHERE UserId = @UserId AND PathId = @PathId
    ELSE
        INSERT INTO dbo.aspnet_PersonalizationPerUser(UserId, PathId, PageSettings, LastUpdatedDate) VALUES (@UserId, @PathId, @PageSettings, @CurrentTimeUtc)
    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationPerUser_ResetPageSettings]    Script Date: 10/07/2014 22:47:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_ResetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        RETURN
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    DELETE FROM dbo.aspnet_PersonalizationPerUser WHERE PathId = @PathId AND UserId = @UserId
    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationPerUser_GetPageSettings]    Script Date: 10/07/2014 22:47:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_GetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        RETURN
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    SELECT p.PageSettings FROM dbo.aspnet_PersonalizationPerUser p WHERE p.PathId = @PathId AND p.UserId = @UserId
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAllUsers_SetPageSettings]    Script Date: 10/07/2014 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_SetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @Path             NVARCHAR(256),
    @PageSettings     IMAGE,
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT
    END

    IF (EXISTS(SELECT PathId FROM dbo.aspnet_PersonalizationAllUsers WHERE PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationAllUsers SET PageSettings = @PageSettings, LastUpdatedDate = @CurrentTimeUtc WHERE PathId = @PathId
    ELSE
        INSERT INTO dbo.aspnet_PersonalizationAllUsers(PathId, PageSettings, LastUpdatedDate) VALUES (@PathId, @PageSettings, @CurrentTimeUtc)
    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAllUsers_ResetPageSettings]    Script Date: 10/07/2014 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_ResetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @Path              NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    DELETE FROM dbo.aspnet_PersonalizationAllUsers WHERE PathId = @PathId
    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAllUsers_GetPageSettings]    Script Date: 10/07/2014 22:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_GetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @Path              NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT p.PageSettings FROM dbo.aspnet_PersonalizationAllUsers p WHERE p.PathId = @PathId
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_SetProperties]    Script Date: 10/07/2014 22:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Profile_SetProperties]
    @ApplicationName        nvarchar(256),
    @PropertyNames          ntext,
    @PropertyValuesString   ntext,
    @PropertyValuesBinary   image,
    @UserName               nvarchar(256),
    @IsUserAnonymous        bit,
    @CurrentTimeUtc         datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
       BEGIN TRANSACTION
       SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    DECLARE @UserId uniqueidentifier
    DECLARE @LastActivityDate datetime
    SELECT  @UserId = NULL
    SELECT  @LastActivityDate = @CurrentTimeUtc

    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId AND LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
        EXEC dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, @IsUserAnonymous, @LastActivityDate, @UserId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    UPDATE dbo.aspnet_Users
    SET    LastActivityDate=@CurrentTimeUtc
    WHERE  UserId = @UserId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF (EXISTS( SELECT *
               FROM   dbo.aspnet_Profile
               WHERE  UserId = @UserId))
        UPDATE dbo.aspnet_Profile
        SET    PropertyNames=@PropertyNames, PropertyValuesString = @PropertyValuesString,
               PropertyValuesBinary = @PropertyValuesBinary, LastUpdatedDate=@CurrentTimeUtc
        WHERE  UserId = @UserId
    ELSE
        INSERT INTO dbo.aspnet_Profile(UserId, PropertyNames, PropertyValuesString, PropertyValuesBinary, LastUpdatedDate)
             VALUES (@UserId, @PropertyNames, @PropertyValuesString, @PropertyValuesBinary, @CurrentTimeUtc)

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
    	SET @TranStarted = 0
    	COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_GetProperties]    Script Date: 10/07/2014 22:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Profile_GetProperties]
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @CurrentTimeUtc       datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN

    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL

    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId AND LoweredUserName = LOWER(@UserName)

    IF (@UserId IS NULL)
        RETURN
    SELECT TOP 1 PropertyNames, PropertyValuesString, PropertyValuesBinary
    FROM         dbo.aspnet_Profile
    WHERE        UserId = @UserId

    IF (@@ROWCOUNT > 0)
    BEGIN
        UPDATE dbo.aspnet_Users
        SET    LastActivityDate=@CurrentTimeUtc
        WHERE  UserId = @UserId
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_GetProfiles]    Script Date: 10/07/2014 22:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Profile_GetProfiles]
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @PageIndex              int,
    @PageSize               int,
    @UserNameToMatch        nvarchar(256) = NULL,
    @InactiveSinceDate      datetime      = NULL
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
        SELECT  u.UserId
        FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p
        WHERE   ApplicationId = @ApplicationId
            AND u.UserId = p.UserId
            AND (@InactiveSinceDate IS NULL OR LastActivityDate <= @InactiveSinceDate)
            AND (     (@ProfileAuthOptions = 2)
                   OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                   OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
                 )
            AND (@UserNameToMatch IS NULL OR LoweredUserName LIKE LOWER(@UserNameToMatch))
        ORDER BY UserName

    SELECT  u.UserName, u.IsAnonymous, u.LastActivityDate, p.LastUpdatedDate,
            DATALENGTH(p.PropertyNames) + DATALENGTH(p.PropertyValuesString) + DATALENGTH(p.PropertyValuesBinary)
    FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p, #PageIndexForUsers i
    WHERE   u.UserId = p.UserId AND p.UserId = i.UserId AND i.IndexId >= @PageLowerBound AND i.IndexId <= @PageUpperBound

    SELECT COUNT(*)
    FROM   #PageIndexForUsers

    DROP TABLE #PageIndexForUsers
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_GetNumberOfInactiveProfiles]    Script Date: 10/07/2014 22:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Profile_GetNumberOfInactiveProfiles]
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @InactiveSinceDate      datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
    BEGIN
        SELECT 0
        RETURN
    END

    SELECT  COUNT(*)
    FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p
    WHERE   ApplicationId = @ApplicationId
        AND u.UserId = p.UserId
        AND (LastActivityDate <= @InactiveSinceDate)
        AND (
                (@ProfileAuthOptions = 2)
                OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
            )
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_DeleteProfiles]    Script Date: 10/07/2014 22:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Profile_DeleteProfiles]
    @ApplicationName        nvarchar(256),
    @UserNames              nvarchar(4000)
AS
BEGIN
    DECLARE @UserName     nvarchar(256)
    DECLARE @CurrentPos   int
    DECLARE @NextPos      int
    DECLARE @NumDeleted   int
    DECLARE @DeletedUser  int
    DECLARE @TranStarted  bit
    DECLARE @ErrorCode    int

    SET @ErrorCode = 0
    SET @CurrentPos = 1
    SET @NumDeleted = 0
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    WHILE (@CurrentPos <= LEN(@UserNames))
    BEGIN
        SELECT @NextPos = CHARINDEX(N',', @UserNames,  @CurrentPos)
        IF (@NextPos = 0 OR @NextPos IS NULL)
            SELECT @NextPos = LEN(@UserNames) + 1

        SELECT @UserName = SUBSTRING(@UserNames, @CurrentPos, @NextPos - @CurrentPos)
        SELECT @CurrentPos = @NextPos+1

        IF (LEN(@UserName) > 0)
        BEGIN
            SELECT @DeletedUser = 0
            EXEC dbo.aspnet_Users_DeleteUser @ApplicationName, @UserName, 4, @DeletedUser OUTPUT
            IF( @@ERROR <> 0 )
            BEGIN
                SET @ErrorCode = -1
                GOTO Cleanup
            END
            IF (@DeletedUser <> 0)
                SELECT @NumDeleted = @NumDeleted + 1
        END
    END
    SELECT @NumDeleted
    IF (@TranStarted = 1)
    BEGIN
    	SET @TranStarted = 0
    	COMMIT TRANSACTION
    END
    SET @TranStarted = 0

    RETURN 0

Cleanup:
    IF (@TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END
    RETURN @ErrorCode
END
GO
/****** Object:  Table [dbo].[Qldh_MatHangTheoSong]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qldh_MatHangTheoSong](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaMatHang] [int] NULL,
	[MaSong] [int] NULL,
	[KichThuocSong] [float] NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qldh_MatHangTheoSong] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qlsx_QuyTrinhSanXuat]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlsx_QuyTrinhSanXuat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaMatHang] [int] NULL,
	[MaCongDoan] [int] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlsx_CongDoanSanXuat_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qlsx_LenhSanXuat]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlsx_LenhSanXuat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaCongDoan] [int] NULL,
	[MaQuyTrinh] [int] NULL,
	[NgaySanXuat] [date] NULL,
	[MaDonHang] [int] NULL,
	[ThuTuUuTien] [int] NULL,
	[SoLuongDatDuoc] [float] NULL,
	[SoLuongLoi] [float] NULL,
	[SoLuongConLai] [float] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlsx_LenhSanXuat] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qlsx_DinhMucVatTu]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlsx_DinhMucVatTu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaQuyTrinh] [int] NULL,
	[MaVatTu] [int] NULL,
	[MucDichSuDung] [nvarchar](250) NULL,
	[HeSoVatTu] [float] NULL,
	[SoLuong] [float] NULL,
	[DonViTinh] [nchar](10) NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlsx_DinhMucVatTu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qlsx_BangKeSanXuat]    Script Date: 10/07/2014 22:46:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qlsx_BangKeSanXuat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaLenhSX] [int] NULL,
	[NgaySanXuat] [date] NULL,
	[MaNguonLuc] [int] NULL,
	[SoLuongDatDuoc] [float] NULL,
	[SoLuongLoi] [float] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[Xoa] [bit] NULL,
	[MaNguoiTao] [uniqueidentifier] NULL,
	[NgayTao] [datetime] NULL,
	[MaNguoiThayDoi] [uniqueidentifier] NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_Qlsx_BangKeSanXuat] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF__aspnet_Ap__Appli__0A338187]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Applications] ADD  DEFAULT (newid()) FOR [ApplicationId]
GO
/****** Object:  Default [DF__aspnet_Me__Passw__24E777C3]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Membership] ADD  DEFAULT ((0)) FOR [PasswordFormat]
GO
/****** Object:  Default [DF__aspnet_Pa__PathI__5D2BD0E6]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Paths] ADD  DEFAULT (newid()) FOR [PathId]
GO
/****** Object:  Default [DF__aspnet_Perso__Id__689D8392]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] ADD  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF__aspnet_Ro__RoleI__46486B8E]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Roles] ADD  DEFAULT (newid()) FOR [RoleId]
GO
/****** Object:  Default [DF__aspnet_Us__UserI__0FEC5ADD]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (newid()) FOR [UserId]
GO
/****** Object:  Default [DF__aspnet_Us__Mobil__10E07F16]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (NULL) FOR [MobileAlias]
GO
/****** Object:  Default [DF__aspnet_Us__IsAno__11D4A34F]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT ((0)) FOR [IsAnonymous]
GO
/****** Object:  Default [DF_Qldh_DanhMucSong_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_DanhMucSong] ADD  CONSTRAINT [DF_Qldh_DanhMucSong_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qldh_DanhMucSong_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_DanhMucSong] ADD  CONSTRAINT [DF_Qldh_DanhMucSong_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qldh_DonHang_DaXuLy]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_DonHang] ADD  CONSTRAINT [DF_Qldh_DonHang_DaXuLy]  DEFAULT ((0)) FOR [TinhTrang]
GO
/****** Object:  Default [DF_Qldh_DonHang_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_DonHang] ADD  CONSTRAINT [DF_Qldh_DonHang_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qldh_KhachHang_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_KhachHang] ADD  CONSTRAINT [DF_Qldh_KhachHang_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qldh_KhachHang_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_KhachHang] ADD  CONSTRAINT [DF_Qldh_KhachHang_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qldh_LoaiKichThuoc_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_LoaiKichThuoc] ADD  CONSTRAINT [DF_Qldh_LoaiKichThuoc_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qldh_LoaiKichThuoc_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_LoaiKichThuoc] ADD  CONSTRAINT [DF_Qldh_LoaiKichThuoc_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qldh_LoaiSanPham_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_LoaiSanPham] ADD  CONSTRAINT [DF_Qldh_LoaiSanPham_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qldh_LoaiSanPham_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_LoaiSanPham] ADD  CONSTRAINT [DF_Qldh_LoaiSanPham_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qldh_MatHang_ChieuDai]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHang] ADD  CONSTRAINT [DF_Qldh_MatHang_ChieuDai]  DEFAULT ((0)) FOR [ChieuDai]
GO
/****** Object:  Default [DF_Qldh_MatHang_ChieuRong]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHang] ADD  CONSTRAINT [DF_Qldh_MatHang_ChieuRong]  DEFAULT ((0)) FOR [ChieuRong]
GO
/****** Object:  Default [DF_Qldh_MatHang_ChieuCao]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHang] ADD  CONSTRAINT [DF_Qldh_MatHang_ChieuCao]  DEFAULT ((0)) FOR [ChieuCao]
GO
/****** Object:  Default [DF_Qldh_MatHang_DonGia]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHang] ADD  CONSTRAINT [DF_Qldh_MatHang_DonGia]  DEFAULT ((0)) FOR [DonGia]
GO
/****** Object:  Default [DF_Qldh_MatHang_ThanhTien]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHang] ADD  CONSTRAINT [DF_Qldh_MatHang_ThanhTien]  DEFAULT ((0)) FOR [ThanhTien]
GO
/****** Object:  Default [DF_Qldh_MatHang_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHang] ADD  CONSTRAINT [DF_Qldh_MatHang_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qldh_MatHangTheoSong_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHangTheoSong] ADD  CONSTRAINT [DF_Qldh_MatHangTheoSong_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qldh_NhomKhachHang_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_NhomKhachHang] ADD  CONSTRAINT [DF_Qldh_NhomKhachHang_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qldh_NhomKhachHang_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_NhomKhachHang] ADD  CONSTRAINT [DF_Qldh_NhomKhachHang_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlnl_DonVi_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlnl_DonVi] ADD  CONSTRAINT [DF_Qlnl_DonVi_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qlnl_DonVi_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlnl_DonVi] ADD  CONSTRAINT [DF_Qlnl_DonVi_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlnl_NguonLuc_TinhTrang]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlnl_NguonLuc] ADD  CONSTRAINT [DF_Qlnl_NguonLuc_TinhTrang]  DEFAULT ((1)) FOR [TinhTrang]
GO
/****** Object:  Default [DF_Qlnl_NguonLuc_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlnl_NguonLuc] ADD  CONSTRAINT [DF_Qlnl_NguonLuc_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qlnl_NguonLuc_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlnl_NguonLuc] ADD  CONSTRAINT [DF_Qlnl_NguonLuc_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlnl_NhatKiDangNhap_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlnl_NhatKiDangNhap] ADD  CONSTRAINT [DF_Qlnl_NhatKiDangNhap_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlsx_BangKeSanXuat_SoLuongDatDuoc]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_BangKeSanXuat] ADD  CONSTRAINT [DF_Qlsx_BangKeSanXuat_SoLuongDatDuoc]  DEFAULT ((0)) FOR [SoLuongDatDuoc]
GO
/****** Object:  Default [DF_Qlsx_BangKeSanXuat_SoLuongLoi]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_BangKeSanXuat] ADD  CONSTRAINT [DF_Qlsx_BangKeSanXuat_SoLuongLoi]  DEFAULT ((0)) FOR [SoLuongLoi]
GO
/****** Object:  Default [DF_Qlsx_BangKeSanXuat_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_BangKeSanXuat] ADD  CONSTRAINT [DF_Qlsx_BangKeSanXuat_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlsx_CongDoan_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_CongDoan] ADD  CONSTRAINT [DF_Qlsx_CongDoan_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qlsx_CongDoan_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_CongDoan] ADD  CONSTRAINT [DF_Qlsx_CongDoan_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlsx_DinhMucVatTu_SoLuong]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_DinhMucVatTu] ADD  CONSTRAINT [DF_Qlsx_DinhMucVatTu_SoLuong]  DEFAULT ((0)) FOR [SoLuong]
GO
/****** Object:  Default [DF_Qlsx_LenhSanXuat_PhanTramHoanThanh]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_LenhSanXuat] ADD  CONSTRAINT [DF_Qlsx_LenhSanXuat_PhanTramHoanThanh]  DEFAULT ((0)) FOR [SoLuongDatDuoc]
GO
/****** Object:  Default [DF_Qlsx_LenhSanXuat_SoLuongLoi]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_LenhSanXuat] ADD  CONSTRAINT [DF_Qlsx_LenhSanXuat_SoLuongLoi]  DEFAULT ((0)) FOR [SoLuongLoi]
GO
/****** Object:  Default [DF_Qlsx_LenhSanXuat_SoLuongConLai]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_LenhSanXuat] ADD  CONSTRAINT [DF_Qlsx_LenhSanXuat_SoLuongConLai]  DEFAULT ((0)) FOR [SoLuongConLai]
GO
/****** Object:  Default [DF_Qlsx_LenhSanXuat_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_LenhSanXuat] ADD  CONSTRAINT [DF_Qlsx_LenhSanXuat_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlsx_QuyTrinhSanXuat_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_QuyTrinhSanXuat] ADD  CONSTRAINT [DF_Qlsx_QuyTrinhSanXuat_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_KhoVatTu_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_KhoVatTu] ADD  CONSTRAINT [DF_Qlvt_KhoVatTu_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qlvt_KhoVatTu_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_KhoVatTu] ADD  CONSTRAINT [DF_Qlvt_KhoVatTu_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_LoaiVatTu_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_LoaiVatTu] ADD  CONSTRAINT [DF_Qlvt_LoaiVatTu_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qlvt_LoaiVatTu_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_LoaiVatTu] ADD  CONSTRAINT [DF_Qlvt_LoaiVatTu_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_NhaCungCap_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_NhaCungCap] ADD  CONSTRAINT [DF_Qlvt_NhaCungCap_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qlvt_NhaCungCap_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_NhaCungCap] ADD  CONSTRAINT [DF_Qlvt_NhaCungCap_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_NhomVatTu_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_NhomVatTu] ADD  CONSTRAINT [DF_Qlvt_NhomVatTu_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qlvt_NhomVatTu_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_NhomVatTu] ADD  CONSTRAINT [DF_Qlvt_NhomVatTu_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_PhieuNhap_TinhTrang]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_PhieuNhap] ADD  CONSTRAINT [DF_Qlvt_PhieuNhap_TinhTrang]  DEFAULT ((1)) FOR [TinhTrang]
GO
/****** Object:  Default [DF_Qlvt_PhieuNhap_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_PhieuNhap] ADD  CONSTRAINT [DF_Qlvt_PhieuNhap_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_PhieuXuat_TinhTrang]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_PhieuXuat] ADD  CONSTRAINT [DF_Qlvt_PhieuXuat_TinhTrang]  DEFAULT ((1)) FOR [TinhTrang]
GO
/****** Object:  Default [DF_Qlvt_PhieuXuat_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_PhieuXuat] ADD  CONSTRAINT [DF_Qlvt_PhieuXuat_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_TinhChatNhapXuat_KichHoat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_TinhChatNhapXuat] ADD  CONSTRAINT [DF_Qlvt_TinhChatNhapXuat_KichHoat]  DEFAULT ((1)) FOR [KichHoat]
GO
/****** Object:  Default [DF_Qlvt_TinhChatNhapXuat_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_TinhChatNhapXuat] ADD  CONSTRAINT [DF_Qlvt_TinhChatNhapXuat_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_VatTu_SoLuongTon]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_VatTu] ADD  CONSTRAINT [DF_Qlvt_VatTu_SoLuongTon]  DEFAULT ((0)) FOR [SoLuongTon]
GO
/****** Object:  Default [DF_Qlvt_VatTu_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_VatTu] ADD  CONSTRAINT [DF_Qlvt_VatTu_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_VatTuNhap_SoLuongNhap]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_VatTuNhap] ADD  CONSTRAINT [DF_Qlvt_VatTuNhap_SoLuongNhap]  DEFAULT ((0)) FOR [SoLuongThucNhap]
GO
/****** Object:  Default [DF_Qlvt_VatTuNhap_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_VatTuNhap] ADD  CONSTRAINT [DF_Qlvt_VatTuNhap_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  Default [DF_Qlvt_VatTuXuat_SoLuongXuat]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_VatTuXuat] ADD  CONSTRAINT [DF_Qlvt_VatTuXuat_SoLuongXuat]  DEFAULT ((0)) FOR [SoLuongThucXuat]
GO
/****** Object:  Default [DF_Qlvt_VatTuXuat_Xoa]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_VatTuXuat] ADD  CONSTRAINT [DF_Qlvt_VatTuXuat_Xoa]  DEFAULT ((0)) FOR [Xoa]
GO
/****** Object:  ForeignKey [FK__aspnet_Me__Appli__22FF2F51]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
/****** Object:  ForeignKey [FK__aspnet_Me__UserI__23F3538A]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
/****** Object:  ForeignKey [FK__aspnet_Pa__Appli__5C37ACAD]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Paths]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
/****** Object:  ForeignKey [FK__aspnet_Pe__PathI__63D8CE75]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
/****** Object:  ForeignKey [FK__aspnet_Pe__PathI__6991A7CB]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
/****** Object:  ForeignKey [FK__aspnet_Pe__UserI__6A85CC04]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
/****** Object:  ForeignKey [FK__aspnet_Pr__UserI__39E294A9]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Profile]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
/****** Object:  ForeignKey [FK__aspnet_Ro__Appli__45544755]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Roles]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
/****** Object:  ForeignKey [FK__aspnet_Us__Appli__0EF836A4]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_Users]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
/****** Object:  ForeignKey [FK__aspnet_Us__RoleI__4C0144E4]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[aspnet_Roles] ([RoleId])
GO
/****** Object:  ForeignKey [FK__aspnet_Us__UserI__4B0D20AB]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
/****** Object:  ForeignKey [FK_Qldh_DonHang_Qldh_KhachHang1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_DonHang]  WITH CHECK ADD  CONSTRAINT [FK_Qldh_DonHang_Qldh_KhachHang1] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[Qldh_KhachHang] ([ID])
GO
ALTER TABLE [dbo].[Qldh_DonHang] CHECK CONSTRAINT [FK_Qldh_DonHang_Qldh_KhachHang1]
GO
/****** Object:  ForeignKey [FK_Qldh_KhachHang_Qldh_NhomKhachHang1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_KhachHang]  WITH CHECK ADD  CONSTRAINT [FK_Qldh_KhachHang_Qldh_NhomKhachHang1] FOREIGN KEY([MaNhomKhachHang])
REFERENCES [dbo].[Qldh_NhomKhachHang] ([ID])
GO
ALTER TABLE [dbo].[Qldh_KhachHang] CHECK CONSTRAINT [FK_Qldh_KhachHang_Qldh_NhomKhachHang1]
GO
/****** Object:  ForeignKey [FK_Qldh_MatHang_Qldh_DonHang]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHang]  WITH CHECK ADD  CONSTRAINT [FK_Qldh_MatHang_Qldh_DonHang] FOREIGN KEY([MaDonHang])
REFERENCES [dbo].[Qldh_DonHang] ([ID])
GO
ALTER TABLE [dbo].[Qldh_MatHang] CHECK CONSTRAINT [FK_Qldh_MatHang_Qldh_DonHang]
GO
/****** Object:  ForeignKey [FK_Qldh_MatHang_Qldh_LoaiKichThuoc]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHang]  WITH CHECK ADD  CONSTRAINT [FK_Qldh_MatHang_Qldh_LoaiKichThuoc] FOREIGN KEY([MaLoaiKichThuoc])
REFERENCES [dbo].[Qldh_LoaiKichThuoc] ([ID])
GO
ALTER TABLE [dbo].[Qldh_MatHang] CHECK CONSTRAINT [FK_Qldh_MatHang_Qldh_LoaiKichThuoc]
GO
/****** Object:  ForeignKey [FK_Qldh_MatHang_Qldh_LoaiSanPham1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHang]  WITH CHECK ADD  CONSTRAINT [FK_Qldh_MatHang_Qldh_LoaiSanPham1] FOREIGN KEY([MaLoaiSanPham])
REFERENCES [dbo].[Qldh_LoaiSanPham] ([ID])
GO
ALTER TABLE [dbo].[Qldh_MatHang] CHECK CONSTRAINT [FK_Qldh_MatHang_Qldh_LoaiSanPham1]
GO
/****** Object:  ForeignKey [FK_Qldh_MatHangTheoSong_Qldh_DanhMucSong1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHangTheoSong]  WITH CHECK ADD  CONSTRAINT [FK_Qldh_MatHangTheoSong_Qldh_DanhMucSong1] FOREIGN KEY([MaSong])
REFERENCES [dbo].[Qldh_DanhMucSong] ([ID])
GO
ALTER TABLE [dbo].[Qldh_MatHangTheoSong] CHECK CONSTRAINT [FK_Qldh_MatHangTheoSong_Qldh_DanhMucSong1]
GO
/****** Object:  ForeignKey [FK_Qldh_MatHangTheoSong_Qldh_MatHang1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qldh_MatHangTheoSong]  WITH CHECK ADD  CONSTRAINT [FK_Qldh_MatHangTheoSong_Qldh_MatHang1] FOREIGN KEY([MaMatHang])
REFERENCES [dbo].[Qldh_MatHang] ([ID])
GO
ALTER TABLE [dbo].[Qldh_MatHangTheoSong] CHECK CONSTRAINT [FK_Qldh_MatHangTheoSong_Qldh_MatHang1]
GO
/****** Object:  ForeignKey [FK_Qlnl_NguonLuc_Qlsx_CongDoan1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlnl_NguonLuc]  WITH CHECK ADD  CONSTRAINT [FK_Qlnl_NguonLuc_Qlsx_CongDoan1] FOREIGN KEY([MaCongDoan])
REFERENCES [dbo].[Qlsx_CongDoan] ([ID])
GO
ALTER TABLE [dbo].[Qlnl_NguonLuc] CHECK CONSTRAINT [FK_Qlnl_NguonLuc_Qlsx_CongDoan1]
GO
/****** Object:  ForeignKey [FK_Qlsx_BangKeSanXuat_Qlsx_LenhSanXuat1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_BangKeSanXuat]  WITH CHECK ADD  CONSTRAINT [FK_Qlsx_BangKeSanXuat_Qlsx_LenhSanXuat1] FOREIGN KEY([MaLenhSX])
REFERENCES [dbo].[Qlsx_LenhSanXuat] ([ID])
GO
ALTER TABLE [dbo].[Qlsx_BangKeSanXuat] CHECK CONSTRAINT [FK_Qlsx_BangKeSanXuat_Qlsx_LenhSanXuat1]
GO
/****** Object:  ForeignKey [FK_Qlsx_CongDoan_Qlnl_DonVi]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_CongDoan]  WITH CHECK ADD  CONSTRAINT [FK_Qlsx_CongDoan_Qlnl_DonVi] FOREIGN KEY([MaDonViPhuTrach])
REFERENCES [dbo].[Qlnl_DonVi] ([ID])
GO
ALTER TABLE [dbo].[Qlsx_CongDoan] CHECK CONSTRAINT [FK_Qlsx_CongDoan_Qlnl_DonVi]
GO
/****** Object:  ForeignKey [FK_Qlsx_DinhMucVatTu_Qlsx_QuyTrinhSanXuat1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_DinhMucVatTu]  WITH CHECK ADD  CONSTRAINT [FK_Qlsx_DinhMucVatTu_Qlsx_QuyTrinhSanXuat1] FOREIGN KEY([MaQuyTrinh])
REFERENCES [dbo].[Qlsx_QuyTrinhSanXuat] ([ID])
GO
ALTER TABLE [dbo].[Qlsx_DinhMucVatTu] CHECK CONSTRAINT [FK_Qlsx_DinhMucVatTu_Qlsx_QuyTrinhSanXuat1]
GO
/****** Object:  ForeignKey [FK_Qlsx_LenhSanXuat_Qlsx_QuyTrinhSanXuat1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_LenhSanXuat]  WITH CHECK ADD  CONSTRAINT [FK_Qlsx_LenhSanXuat_Qlsx_QuyTrinhSanXuat1] FOREIGN KEY([MaQuyTrinh])
REFERENCES [dbo].[Qlsx_QuyTrinhSanXuat] ([ID])
GO
ALTER TABLE [dbo].[Qlsx_LenhSanXuat] CHECK CONSTRAINT [FK_Qlsx_LenhSanXuat_Qlsx_QuyTrinhSanXuat1]
GO
/****** Object:  ForeignKey [FK_Qlsx_QuyTrinhSanXuat_Qldh_MatHang]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_QuyTrinhSanXuat]  WITH CHECK ADD  CONSTRAINT [FK_Qlsx_QuyTrinhSanXuat_Qldh_MatHang] FOREIGN KEY([MaMatHang])
REFERENCES [dbo].[Qldh_MatHang] ([ID])
GO
ALTER TABLE [dbo].[Qlsx_QuyTrinhSanXuat] CHECK CONSTRAINT [FK_Qlsx_QuyTrinhSanXuat_Qldh_MatHang]
GO
/****** Object:  ForeignKey [FK_Qlsx_QuyTrinhSanXuat_Qlsx_CongDoan1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlsx_QuyTrinhSanXuat]  WITH CHECK ADD  CONSTRAINT [FK_Qlsx_QuyTrinhSanXuat_Qlsx_CongDoan1] FOREIGN KEY([MaCongDoan])
REFERENCES [dbo].[Qlsx_CongDoan] ([ID])
GO
ALTER TABLE [dbo].[Qlsx_QuyTrinhSanXuat] CHECK CONSTRAINT [FK_Qlsx_QuyTrinhSanXuat_Qlsx_CongDoan1]
GO
/****** Object:  ForeignKey [FK_Qlvt_PhieuNhap_Qlvt_KhoVatTu1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_Qlvt_PhieuNhap_Qlvt_KhoVatTu1] FOREIGN KEY([MaKhoVatTu])
REFERENCES [dbo].[Qlvt_KhoVatTu] ([ID])
GO
ALTER TABLE [dbo].[Qlvt_PhieuNhap] CHECK CONSTRAINT [FK_Qlvt_PhieuNhap_Qlvt_KhoVatTu1]
GO
/****** Object:  ForeignKey [FK_Qlvt_PhieuNhap_Qlvt_NhaCungCap]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_Qlvt_PhieuNhap_Qlvt_NhaCungCap] FOREIGN KEY([MaNhaCungCap])
REFERENCES [dbo].[Qlvt_NhaCungCap] ([ID])
GO
ALTER TABLE [dbo].[Qlvt_PhieuNhap] CHECK CONSTRAINT [FK_Qlvt_PhieuNhap_Qlvt_NhaCungCap]
GO
/****** Object:  ForeignKey [FK_Qlvt_PhieuNhap_Qlvt_TinhChatNhapXuat1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_Qlvt_PhieuNhap_Qlvt_TinhChatNhapXuat1] FOREIGN KEY([MaTinhChatNhapXuat])
REFERENCES [dbo].[Qlvt_TinhChatNhapXuat] ([ID])
GO
ALTER TABLE [dbo].[Qlvt_PhieuNhap] CHECK CONSTRAINT [FK_Qlvt_PhieuNhap_Qlvt_TinhChatNhapXuat1]
GO
/****** Object:  ForeignKey [FK_Qlvt_PhieuXuat_Qlvt_KhoVatTu1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_PhieuXuat]  WITH CHECK ADD  CONSTRAINT [FK_Qlvt_PhieuXuat_Qlvt_KhoVatTu1] FOREIGN KEY([MaKhoVatTu])
REFERENCES [dbo].[Qlvt_KhoVatTu] ([ID])
GO
ALTER TABLE [dbo].[Qlvt_PhieuXuat] CHECK CONSTRAINT [FK_Qlvt_PhieuXuat_Qlvt_KhoVatTu1]
GO
/****** Object:  ForeignKey [FK_Qlvt_PhieuXuat_Qlvt_TinhChatNhapXuat1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_PhieuXuat]  WITH CHECK ADD  CONSTRAINT [FK_Qlvt_PhieuXuat_Qlvt_TinhChatNhapXuat1] FOREIGN KEY([MaTinhChatNhapXuat])
REFERENCES [dbo].[Qlvt_TinhChatNhapXuat] ([ID])
GO
ALTER TABLE [dbo].[Qlvt_PhieuXuat] CHECK CONSTRAINT [FK_Qlvt_PhieuXuat_Qlvt_TinhChatNhapXuat1]
GO
/****** Object:  ForeignKey [FK_Qlvt_VatTu_Qlvt_LoaiVatTu1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_VatTu]  WITH CHECK ADD  CONSTRAINT [FK_Qlvt_VatTu_Qlvt_LoaiVatTu1] FOREIGN KEY([MaLoaiVatTu])
REFERENCES [dbo].[Qlvt_LoaiVatTu] ([ID])
GO
ALTER TABLE [dbo].[Qlvt_VatTu] CHECK CONSTRAINT [FK_Qlvt_VatTu_Qlvt_LoaiVatTu1]
GO
/****** Object:  ForeignKey [FK_Qlvt_VatTuNhap_Qlvt_PhieuNhap]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_VatTuNhap]  WITH CHECK ADD  CONSTRAINT [FK_Qlvt_VatTuNhap_Qlvt_PhieuNhap] FOREIGN KEY([MaPhieuNhap])
REFERENCES [dbo].[Qlvt_PhieuNhap] ([ID])
GO
ALTER TABLE [dbo].[Qlvt_VatTuNhap] CHECK CONSTRAINT [FK_Qlvt_VatTuNhap_Qlvt_PhieuNhap]
GO
/****** Object:  ForeignKey [FK_Qlvt_VatTuXuat_Qlvt_PhieuXuat1]    Script Date: 10/07/2014 22:46:17 ******/
ALTER TABLE [dbo].[Qlvt_VatTuXuat]  WITH CHECK ADD  CONSTRAINT [FK_Qlvt_VatTuXuat_Qlvt_PhieuXuat1] FOREIGN KEY([MaPhieuXuat])
REFERENCES [dbo].[Qlvt_PhieuXuat] ([ID])
GO
ALTER TABLE [dbo].[Qlvt_VatTuXuat] CHECK CONSTRAINT [FK_Qlvt_VatTuXuat_Qlvt_PhieuXuat1]
GO

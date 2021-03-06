USE [OnlineShop]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [nvarchar](250) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[Status] [bit] NULL CONSTRAINT [DF_Category_Status]  DEFAULT ((1)),
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Content]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Content](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Image] [ntext] NULL,
	[CategoryID] [bigint] NULL,
	[Detail] [ntext] NULL,
	[Status] [bit] NULL CONSTRAINT [DF_Content_Status]  DEFAULT ((1)),
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Footer]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Footer](
	[ID] [varbinary](50) NOT NULL,
	[Content] [ntext] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Footer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](50) NULL,
	[Link] [nvarchar](50) NULL,
	[Icon] [nvarchar](250) NULL,
	[DisplayOrder] [int] NULL,
	[Target] [nvarchar](50) NULL,
	[Status] [bit] NULL,
	[TypeID] [int] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MenuType]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_MenuType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CustomerName] [nvarchar](250) NULL,
	[CustomerMobile] [bigint] NULL,
	[CustomerAddress] [nvarchar](250) NULL,
	[CustomerEmail] [nvarchar](250) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[ProductID] [bigint] NOT NULL,
	[OrderID] [bigint] NOT NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [decimal](18, 0) NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Image] [nvarchar](250) NULL,
	[MoreImages] [ntext] NULL,
	[Price] [decimal](18, 0) NULL CONSTRAINT [DF_Product_Price]  DEFAULT ((0)),
	[CategoryID] [bigint] NULL,
	[Detail] [ntext] NULL,
	[BrandID] [bigint] NULL,
	[Status] [bit] NULL CONSTRAINT [DF_Product_Status]  DEFAULT ((1)),
	[TopHot] [datetime] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[Icon] [nvarchar](250) NULL,
	[Status] [bit] NULL CONSTRAINT [DF_ProductCategory_Status]  DEFAULT ((1)),
	[ShowOnHome] [bit] NULL CONSTRAINT [DF_ProductCategory_ShowOnHome]  DEFAULT ((0)),
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/19/2018 11:35:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[Password] [varchar](255) NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Mail] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_User_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_User_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Brand] ON 

INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (1, N'Sony', N'sony', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (2, N'Apple', N'apple', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (3, N'Samsung', N'samsung', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (4, N'Xiaomi', N'xiaomi', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (5, N'Oppo', N'oppo', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (6, N'Asus', N'asus', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (7, N'HP', N'hp', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (8, N'Dell', N'dell', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (9, N'Canon', N'canon', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (10, N'Kodak', N'kodak', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (11, N'Nikon', N'nikon', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (12, N'Lecia', N'lecia', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (13, N'Panasonic', N'panasonic', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (18, N'Lenovo', N'lenovo', 1)
INSERT [dbo].[Brand] ([ID], [Name], [MetaTitle], [Status]) VALUES (19, N'Acer', N'acer', 1)
SET IDENTITY_INSERT [dbo].[Brand] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name], [MetaTitle], [Status]) VALUES (4, N'Khuyến mãi', N'khuyen-mai', 1)
INSERT [dbo].[Category] ([ID], [Name], [MetaTitle], [Status]) VALUES (6, N'Đánh giá tư vấn', N'danh-gia-tu-van', 1)
INSERT [dbo].[Category] ([ID], [Name], [MetaTitle], [Status]) VALUES (7, N'Góc khách hàng', N'goc-khach-hang', 1)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Content] ON 

INSERT [dbo].[Content] ([ID], [Name], [MetaTitle], [Description], [Image], [CategoryID], [Detail], [Status]) VALUES (6, N'Giảm giá iphone', N'giam-gia-iphone', NULL, N'https://ucarecdn.com/72ab215f-1824-479e-bce0-8e878c994a51/', 4, N'<h1 style="text-align:center"><span style="color:#c0392b"><strong>Từ b&acirc;y giờ, người d&ugrave;ng đ&atilde; c&oacute; thể thay thế pin iPhone cũ với gi&aacute; 29 USD</strong></span></h1>

<p>&nbsp;</p>

<p style="text-align:center"><img alt="Thay pin iPhone" src="https://cdn.tgdd.vn/Files/2018/01/01/1054966/thaypiniphone_800x450.jpg" style="width:550px" title="Thay pin iPhone" /></p>

<p><span style="color:#000000">Sau scandal cố t&igrave;nh l&agrave;m chậm&nbsp;</span><a href="https://www.thegioididong.com/dtdd-apple-iphone" target="_blank"><span style="color:#000000">iPhone</span></a><span style="color:#000000">&nbsp;để tr&aacute;nh t&igrave;nh trạng m&aacute;y tắt nguồn đột ngột v&agrave; đảm bảo tuổi thọ pin, Apple xoa dịu cơn giận dữ của kh&aacute;ch h&agrave;ng bằng việc giảm gi&aacute; thay pin cho những thiết bị hết hạn bảo h&agrave;nh. Kể từ b&acirc;y giờ, chương tr&igrave;nh n&agrave;y đ&atilde; được triển khai, sớm hơn một ch&uacute;t so với dự kiến ban đầu.</span></p>

<p><span style="color:#000000">Đ&acirc;y l&agrave; một tin tốt với những ai đang phải &ldquo;vật lộn&rdquo; với thời lượng pin hoặc hiệu suất của chiếc iPhone m&agrave; m&igrave;nh sở hữu, nhất l&agrave; nh&oacute;m model đời cũ như&nbsp;</span><a href="https://www.thegioididong.com/dtdd/iphone-6-32gb-gold" target="_blank"><span style="color:#000000">iPhone 6</span></a><span style="color:#000000">&nbsp;hay&nbsp;</span><a href="https://www.thegioididong.com/dtdd/iphone-6-plus-32gb" target="_blank"><span style="color:#000000">iPhone 6 Plus</span></a><span style="color:#000000">.</span></p>

<p><span style="color:#000000">Theo đ&oacute;, gi&aacute; thay pin iPhone sẽ giảm hơn 63 %, từ 79 USD (1.8 triệu đồng) xuống chỉ c&ograve;n 29 USD (659 ngh&igrave;n đồng). Song song với việc giảm gi&aacute; thay pin, Apple cho biết họ dự định bổ sung t&iacute;nh năng mới cho hệ điều h&agrave;nh iOS nhằm m&ocirc; tả chi tiết việc pin của một thiết bị cũ c&oacute; ảnh hưởng đến hiệu suất hay kh&ocirc;ng.</span></p>

<p><span style="color:#000000">Mức gi&aacute; mới c&oacute; hiệu lực đến hết th&aacute;ng 12/2018. Hiện nay, vẫn chưa r&otilde; l&agrave; Apple sẽ tiếp tục cung cấp gi&aacute; giảm sau thời điểm n&agrave;y, &aacute;p dụng lại gi&aacute; gốc hay t&igrave;m ra giải ph&aacute;p kh&aacute;c để hỗ trợ những người sở hữu iPhone gặp sự cố với vi&ecirc;n pin cũ.</span></p>

<p><span style="color:#000000">Nếu Apple chuyển gi&aacute; thay pin về mốc ban đầu, người d&ugrave;ng c&oacute; thể sẽ lựa chọn c&aacute;c dịch vụ thay thế từ b&ecirc;n thứ ba, chẳng hạn như iFixit.</span></p>

<p style="text-align:center"><img alt="Bộ thay thế pin của iFixit" src="https://cdn.tgdd.vn/Files/2018/01/01/1054966/bothaythepincuaifixit_800x450.jpg" style="height:309px; width:550px" title="Bộ thay thế pin của iFixit" /></p>

<p><span style="color:#000000">Một bộ dụng cụ thay pin iPhone của iFixit</span></p>

<p><span style="color:#000000">H&agrave;nh động c&oacute; phần l&eacute;n l&uacute;t, lại ảnh hưởng trực tiếp đến trải nghiệm người d&ugrave;ng của Apple đ&atilde; khiến kh&ocirc;ng &iacute;t kh&aacute;ch h&agrave;ng phẫn nộ. Thậm ch&iacute;, nhiều người đ&atilde; l&agrave;m đơn kiện c&ocirc;ng ty ra t&ograve;a v&agrave; đ&ograve;i số tiền đền b&ugrave; l&ecirc;n đến h&agrave;ng tỷ đ&ocirc; la.</span></p>

<p><span style="color:#000000">Hi vọng rằng, chương tr&igrave;nh giảm gi&aacute; thay thế pin cho iPhone cũng sẽ sớm được &aacute;p dụng tại Việt Nam.</span></p>
', 1)
INSERT [dbo].[Content] ([ID], [Name], [MetaTitle], [Description], [Image], [CategoryID], [Detail], [Status]) VALUES (7, N'100 suất cáp xác Lightning', N'100-suat-cap-xac-lightning', NULL, N'https://ucarecdn.com/95cf5f23-b697-4ab9-a319-cb41545e9f3d/', 7, N'<h1 style="text-align:center"><span style="color:#c0392b"><strong>Ng&agrave;y cuối c&ugrave;ng, chỉ 100 suất c&aacute;p Lightning 1m eValu LTL-01 giảm đến 49%</strong></span></h1>

<hr />
<p><img alt="100 suất dây cáp Lightning 1 m eValu LTL-01 đang giảm 49%" src="https://cdn.tgdd.vn/Files/2017/11/07/1039308/daycaplightning1mevalultl-01_800x450.jpg" title="100 suất dây cáp Lightning 1 m eValu LTL-01 đang giảm 49%" /></p>

<p>&nbsp;</p>

<p>Sau 1 tuần triển khai chương tr&igrave;nh b&aacute;n phụ kiện ONLINE giảm gi&aacute; sốc, th&igrave; h&ocirc;m nay sẽ l&agrave; ng&agrave;y cuối c&ugrave;ng. V&agrave; sản phẩm của ch&uacute;ng ta sẽ l&agrave;&nbsp;d&acirc;y c&aacute;p Lightning 1 m eValu LTL-01, vẫn với chỉ 100 suất nhưng được giảm gi&aacute; l&ecirc;n đến&nbsp;49%.</p>

<p>Cụ thể, nếu bạn l&agrave; 1 trong 100 kh&aacute;ch h&agrave;ng đầu ti&ecirc;n đặt mua d&acirc;y c&aacute;p n&agrave;y từ 8:00 h&ocirc;m nay (8/11) th&igrave; chỉ mất 75.000 đồng thay v&igrave; mua với gi&aacute; gốc l&agrave; 150.000 đồng.</p>

<p><strong>Lưu &yacute;:</strong></p>

<ul>
	<li>Chương tr&igrave;nh đặt mua ONLINE sẽ bắt đầu từ 8:00 ng&agrave;y 8/11/2017 đến hết ng&agrave;y hoặc đến khi HẾT 100 suất ưu đ&atilde;i.</li>
	<li>Mỗi số điện thoại chỉ được một 1 sản phẩm.</li>
	<li>Bạn cần gửi tin nhắn đến tổng đ&agrave;i (ph&iacute; 1.000 đồng) để x&aacute;c nhận mua h&agrave;ng v&agrave; đến si&ecirc;u thị để nhận d&acirc;y sạc sau 3 ng&agrave;y.</li>
</ul>

<p>Nếu đ&atilde; &quot;kết&quot; sản phẩm n&agrave;y th&igrave; mời bạn click v&agrave;o n&uacute;t v&agrave;ng ngay dưới đ&acirc;y để tiến h&agrave;nh đặt mua sản phẩm. Hiện đ&atilde; hết 100 suất giảm gi&aacute; rồi bạn nh&eacute;.</p>

<p>Lợi &iacute;ch của&nbsp;d&acirc;y c&aacute;p Lightning 1 m eValu LTL-01 m&agrave; bạn cần biết l&agrave;: Thiết kế đơn giản v&agrave; dễ sử dụng, c&aacute;p&nbsp;thiết kế d&agrave;nh ri&ecirc;ng cho cổng Lightning với đầu c&aacute;p tương th&iacute;ch với thiết bị Apple như iPhone 5 trở l&ecirc;n, iPad&hellip;</p>

<p>&nbsp;</p>
', 1)
INSERT [dbo].[Content] ([ID], [Name], [MetaTitle], [Description], [Image], [CategoryID], [Detail], [Status]) VALUES (13, N'Các gói cước 4G', N'cac-goi-cuoc-4g', N'Tổng hợp các gói cước 4G hấp dẫn nhất hiện nay của Viettel, Mobi, Vina', N'https://ucarecdn.com/fa4d4e3b-9d52-47a3-bcfc-c6a26d8f5e6d/', 4, N'<h1 style="text-align:center">Tổng hợp c&aacute;c g&oacute;i cước 4G hấp dẫn nhất hiện nay của Viettel, Mobi, Vina</h1>

<p style="text-align:center"><img alt="4g" src="https://cdn.tgdd.vn/Files/2018/03/11/1073524/4g-0_800x4492_800x449_800x449.jpg" title="4g" /></p>

<h2 style="text-align:center">Để sử dụng được 3G hay&nbsp;<a href="https://www.thegioididong.com/tin-tuc/tim-kiem?key=4g" target="_blank">4G</a>, điều đầu ti&ecirc;n c&aacute;c bạn cần l&agrave;m l&agrave; đăng k&yacute; g&oacute;i cước. Thế nhưng, để lựa chọn được một g&oacute;i cước tiết kiệm v&agrave; ph&ugrave; hợp với nhu cầu của m&igrave;nh th&igrave; kh&ocirc;ng phải ai cũng biết. B&agrave;i viết n&agrave;y, m&igrave;nh sẽ tổng hợp c&aacute;c g&oacute;i cước 4G đ&aacute;ng sử dụng nhất hiện nay của Mobi, Viettel&nbsp;v&agrave; Vinaphone.</h2>

<h3 style="text-align:center"><strong>1. G&oacute;i 4G Viettel</strong></h3>

<p style="text-align:center">Hi&ecirc;n nay, nh&agrave; mạng Viettel c&oacute; 2 g&oacute;i cước 4G kh&aacute; hấp dẫn đ&oacute; l&agrave; g&oacute;i V90 v&agrave; ST90 với c&ugrave;ng mức gi&aacute; l&agrave; 90.000vnđ/ th&aacute;ng, mỗi ng&agrave;y c&oacute; 2GB Data, li&ecirc;n tục trong 30 ng&agrave;y kể từ ng&agrave;y đăng k&yacute;.&nbsp;</p>

<p style="text-align:center"><strong>ST90</strong>&nbsp;l&agrave; g&oacute;i Si&ecirc;u Tốc 90 c&oacute; 60GB/th&aacute;ng chỉ với 90.000đ/th&aacute;ng, tương ứng với mỗi ng&agrave;y bạn sẽ c&oacute; 2GB data.</p>

<p style="text-align:center">C&aacute;ch đăng k&yacute;: Soạn&nbsp;<strong>ST90&nbsp;</strong>gửi&nbsp;<strong>191</strong>&nbsp;(gi&aacute;: 90.000đ/30 ng&agrave;y). Để tra cứu lưu lượng c&ograve;n lại soạn tin nhắn theo c&uacute; ph&aacute;p:&nbsp;<strong>KTTK</strong>&nbsp;gửi đến&nbsp;<strong>191</strong>.&nbsp;Thời gian hưởng khuyến mại: 12 th&aacute;ng kể từ ng&agrave;y đăng k&yacute; g&oacute;i cước lần đầu ti&ecirc;n.</p>

<p style="text-align:center">&nbsp;</p>

<p style="text-align:center"><img alt="viettel" src="https://cdn.tgdd.vn/Files/2018/03/11/1073524/viettel-0_800x450_800x450.jpg" title="viettel" /></p>

<p style="text-align:center"><strong>V90</strong>&nbsp;l&agrave; g&oacute;i cước mới của Viettel, với gi&aacute; 90.000đ/ th&aacute;ng, bạn sẽ nhận được những ưu đ&atilde;i sau: Miễn ph&iacute; tất cả c&aacute;c cuộc gọi nội mạng dưới 20 ph&uacute;t, miễn ph&iacute; 50 ph&uacute;t ngoại mạng, miễn ph&iacute; 2GB Data/ ng&agrave;y.</p>

<p style="text-align:center">C&aacute;ch đăng k&yacute;: Soạn&nbsp;<strong>V90</strong>&nbsp;gửi&nbsp;<strong>191</strong>. Thời gian hưởng khuyến mại: 12 th&aacute;ng kể từ ng&agrave;y đăng k&yacute; g&oacute;i cước lần đầu ti&ecirc;n.</p>

<p style="text-align:center">Lưu &yacute;: Mỗi thu&ecirc; bao sẽ được hưởng những ưu đ&atilde;i kh&aacute;c nhau theo ch&iacute;nh s&aacute;ch của Viettel, bạn h&atilde;y gọi 198 để xem c&oacute; nằm trong danh s&aacute;ch sử dụng g&oacute;i cước n&agrave;y hay kh&ocirc;ng nh&eacute;!</p>

<h3 style="text-align:center"><strong>2. G&oacute;i 4G Mobifone</strong></h3>

<p style="text-align:center">Mobifone l&agrave; một trong 3 nh&agrave; mạng đầu ti&ecirc;n tại Việt Nam đ&atilde; triển khai 4G cho người d&ugrave;ng sử dụng rộng r&atilde;i, dưới đ&acirc;y l&agrave; 3 g&oacute;i cước kh&aacute; hấp dẫn nếu bạn đang sử dụng dịch vụ của nh&agrave; mạng n&agrave;y:</p>

<p style="text-align:center"><strong>F120WF</strong>&nbsp;l&agrave; g&oacute;i cước si&ecirc;u hấp dẫn d&agrave;nh cho thu&ecirc; bao đang sinh sống tại khu vực miền T&acirc;y Nam Bộ, chỉ với 40.000đ/th&aacute;ng bạn sẽ c&oacute; ngay 4GB dung lượng tốc độ 4G v&agrave; đặc biệt sẽ kh&ocirc;ng bị b&oacute;p băng th&ocirc;ng sau khi hết data.</p>

<p style="text-align:center"><strong>C&aacute;ch đăng k&yacute;:&nbsp;</strong></p>

<p style="text-align:center">Bước 1: Gọi tổng đ&agrave;i kiểm tra t&iacute;nh x&aacute;c thực của g&oacute;i cước&nbsp;F120WF tại nơi bạn sống:&nbsp;1800 1090 hoặc 9090.</p>

<p style="text-align:center">Bước 2: Mang theo CMND (chứng minh nh&acirc;n d&acirc;n) ra&nbsp;cửa h&agrave;ng, trung t&acirc;m chăm s&oacute;c kh&aacute;ch h&agrave;ng ch&iacute;nh thức của&nbsp;MobiFone để đăng k&yacute; g&oacute;i cước F120WF.</p>

<p style="text-align:center">&nbsp;</p>

<p style="text-align:center"><img alt="mobifonea" src="https://cdn.tgdd.vn/Files/2018/03/11/1073524/mobifonea_800x450_800x450_800x450_800x450.jpg" title="mobifonea" /></p>

<p style="text-align:center"><strong>C90</strong>&nbsp;l&agrave; g&oacute;i cước d&agrave;nh cho thu&ecirc; bao trả trước được k&iacute;ch hoạt mới từ ng&agrave;y 10/8 trở về sau v&agrave; thuộc trong danh s&aacute;ch được nhận ưu đ&atilde;i. Với 90.000đ bạn sẽ c&oacute; ngay: 2GB data 4G tốc độ cao mỗi ng&agrave;y, miễn ph&iacute; to&agrave;n bộ cuộc gọi nội mạng dưới 20 ph&uacute;t, tặng 50 ph&uacute;t gọi li&ecirc;n mạng trong nước, nghe một ph&uacute;t ngoại mạng được tặng ngay 1.000đ gọi li&ecirc;n mạng v&agrave; nội mạng.</p>

<p style="text-align:center">C&aacute;ch đăng k&yacute;: Soạn&nbsp;<strong>ON C90</strong>&nbsp;gửi&nbsp;<strong>9084</strong>&nbsp;(90.000/th&aacute;ng).&nbsp;</p>

<p style="text-align:center"><strong>MAXTN</strong>&nbsp;l&agrave; g&oacute;i cước d&agrave;nh cho c&aacute;c khu vực T&acirc;y Nguyen, khi đăng k&yacute; bạn sẽ nhận được 30 GB data tốc độ cao sử dụng trong 30 ng&agrave;y, hết 30 GB dừng truy cập. Số data &quot;tặng th&ecirc;m&quot; 100GB kh&aacute;ch h&agrave;ng được sử dụng thoải m&aacute;i kh&ocirc;ng quy định mỗi ng&agrave;y bao nhi&ecirc;u MB cả, bạn được ph&eacute;p d&ugrave;ng tới khi n&agrave;o hết th&igrave; th&ocirc;i.</p>

<p style="text-align:center">C&aacute;ch đăng k&yacute;: Soạn&nbsp;<strong>DK MAXTN</strong>&nbsp;gửi&nbsp;<strong>789</strong></p>

<p style="text-align:center">Mọi th&ocirc;ng tin thắc mắc li&ecirc;n quan bạn c&oacute; thể li&ecirc;n hệ tổng đ&agrave;i 9090 hoặc 1800.1090 của MobiFone để biết th&ecirc;m th&ocirc;ng tin.</p>

<p style="text-align:center">&nbsp;</p>

<h3 style="text-align:center"><strong>3. G&oacute;i 4G Vinaphone</strong></h3>

<p style="text-align:center">Cũng giống như 2 nh&agrave; mạng tr&ecirc;n, Vinaphone cũng cung cấp cho người d&ugrave;ng những g&oacute;i cước với ưu đ&atilde;i hấp dẫn:</p>

<p style="text-align:center">Từ ng&agrave;y 19/12/2017 VinaPhone ch&iacute;nh thức triển khai g&oacute;i cước c&oacute; t&ecirc;n gọi VD89P với mức gi&aacute; chỉ 89.000đ/th&aacute;ng bạn sẽ nhận được:</p>

<p style="text-align:center">Miễn ph&iacute; c&aacute;c cuộc gọi nội mạng &le; 20 ph&uacute;t + 50 ph&uacute;t ngoại mạng + 4GB/ng&agrave;y (3 chu kỳ đầu).&nbsp;Miễn ph&iacute; c&aacute;c cuộc gọi nội mạng &le; 20 ph&uacute;t + 50 ph&uacute;t ngoại mạng + 2GB/ng&agrave;y (9 chu kỳ tiếp theo).</p>

<p style="text-align:center">C&aacute;ch đăng k&yacute;:&nbsp;<strong>VD89P&nbsp;</strong>gửi&nbsp;<strong>888</strong>. Chỉ &aacute;p dụng cho SIM mới.</p>

<p style="text-align:center">Lưu &yacute;: G&oacute;i cước c&oacute; hạn sử dụng 12 th&aacute;ng. Để biết thu&ecirc; bao của bạn c&oacute; được đăng k&yacute; g&oacute;i cước n&agrave;y hay kh&ocirc;ng, h&atilde;y gọi tổng đ&agrave;i Vinaphone: 1800.1091.</p>

<p style="text-align:center"><img alt="vinaphone" src="https://cdn.tgdd.vn/Files/2018/03/11/1073524/vn_800x450_800x450.jpg" title="vinaphone" /></p>

<p style="text-align:center"><strong>TD5&nbsp;</strong>v&agrave;&nbsp;<strong>TD3</strong>&nbsp;l&agrave; g&oacute;i cước tốc độ cao kh&ocirc;ng giới hạn lưu lượng sử dụng nhưng chỉ c&oacute; hiệu lực từ 0h đến 6h hằng ng&agrave;y.&nbsp;</p>

<p style="text-align:center">C&aacute;ch đăng k&yacute;: Soạn&nbsp;<strong>DK TD5 hoặc TD3&nbsp;</strong>gửi&nbsp;<strong>888&nbsp;</strong>gi&aacute; cước: 5.000đ/ng&agrave;y, g&oacute;i cước tự động gia hạn n&ecirc;n c&aacute;c bạn c&oacute; thể huỷ g&oacute;i bằng c&aacute;ch soạn<strong>&nbsp;HUY TD5</strong>&nbsp;gửi&nbsp;<strong>888</strong>.</p>
', 1)
INSERT [dbo].[Content] ([ID], [Name], [MetaTitle], [Description], [Image], [CategoryID], [Detail], [Status]) VALUES (14, N'Galaxy S10 lộ diện trong bằng sáng chế mới của Samsung', N'galaxy-s10-lo-dien-trong-bang-sang-che-moi-cua-samsung', N'Galaxy S10 còn rất lâu nữa mới trình làng, và mặc dù Galaxy Note 9 mới là smartphone đáng mong đợi nhất sau khi Galaxy S9 lên kệ', N'https://ucarecdn.com/7fc1fd63-0f42-4900-b3ce-0fa90e001e35/', 7, N'<h1 style="text-align:center">Galaxy S10 lộ diện trong bằng s&aacute;ng chế mới của Samsung</h1>

<p style="text-align:center"><img alt="Galaxy S10 lộ diện trong bằng sáng chế mới của Samsung" src="https://cdn.tgdd.vn/Files/2018/03/10/1073367/5aa394ccd4a08_800x420.jpg" title="Galaxy S10 lộ diện trong bằng sáng chế mới của Samsung" /></p>

<h2 style="text-align:center">Galaxy S10 c&ograve;n rất l&acirc;u nữa mới tr&igrave;nh l&agrave;ng, v&agrave; mặc d&ugrave; Galaxy Note 9&nbsp;mới l&agrave; smartphone đ&aacute;ng mong đợi nhất sau khi Galaxy S9&nbsp;l&ecirc;n kệ. Tuy nhi&ecirc;n mới đ&acirc;y, bằng s&aacute;ng chế về Galaxy S10 đ&atilde; bị r&ograve; rỉ, v&agrave; nhờ vậy ch&uacute;ng ta mới thấy được thiết kế của m&aacute;y.</h2>

<p style="text-align:center"><img alt="Galaxy S10 lộ diện trong bằng sáng chế mới của Samsung" src="https://cdn.tgdd.vn/Files/2018/03/10/1073367/dxxpth_wkaawy0o-horz_423x450_600x638.jpg" title="Galaxy S10 lộ diện trong bằng sáng chế mới của Samsung" /></p>

<p style="text-align:center">H&igrave;nh ảnh xuất hiện lần n&agrave;y cho thấy Galaxy S10 c&oacute; thiết kế được n&acirc;ng cấp từ Galaxy S8, viền cạnh tr&aacute;i/phải v&agrave; viền cạnh dưới gần như biến mất. Ở mặt sau, bạn c&oacute; thể thấy bộ camera k&eacute;p nằm ngang ở g&oacute;c tr&ecirc;n b&ecirc;n tr&aacute;i.</p>

<p style="text-align:center">Viền cạnh tr&ecirc;n của Galaxy S10 dường như c&oacute; độ d&agrave;y tương tự như Galaxy S9. Dự kiến Galaxy S10 sẽ được t&iacute;ch hợp cảm biến v&acirc;n tay si&ecirc;u &acirc;m dưới m&agrave;n h&igrave;nh. Nguồn tin c&ograve;n cho biết, v&agrave;o năm sau, cả Galaxy S10 v&agrave; Galaxy S10+ đều được trang bị m&aacute;y ảnh k&eacute;p.</p>
', 1)
INSERT [dbo].[Content] ([ID], [Name], [MetaTitle], [Description], [Image], [CategoryID], [Detail], [Status]) VALUES (15, N'Tin đồn: OPPO R15 sẽ có 2 bản, chip Snapdragon 660 và Helio P60', N'tin-don:-oppo-r15-se-co-2-ban,-chip-snapdragon-660-va-helio-p60', N'OPPO R15 và OPPO R15 Dream Mirror Edition (DME) đã xuất hiện trên TENAA tuần trước, nhiều thông số cấu hình đã được tiết lộ', N'https://ucarecdn.com/1c67edfb-aba8-4827-b294-e1a859c5cf37/', 7, N'<h1 style="text-align:center">Tin đồn: OPPO R15 sẽ c&oacute; 2 bản, chip Snapdragon 660 v&agrave; Helio P60</h1>

<p>&nbsp;</p>

<p style="text-align:center"><img alt="Rò rỉ cấu hình chi tiết OPPO R15 với 2 phiên bản: Snapdragon 660 và Helio P60" src="https://cdn.tgdd.vn/Files/2018/03/11/1073604/fa_800x450.jpg" title="Rò rỉ cấu hình chi tiết OPPO R15 với 2 phiên bản: Snapdragon 660 và Helio P60" /></p>

<h2 style="text-align:center">OPPO R15 v&agrave; OPPO R15 Dream Mirror Edition (DME) đ&atilde; xuất hiện tr&ecirc;n TENAA tuần trước, nhiều th&ocirc;ng số cấu h&igrave;nh đ&atilde; được tiết lộ. Tuy nhi&ecirc;n, tại cơ quan chứng nhận sản phẩm TENAA th&igrave; sẽ kh&ocirc;ng n&ecirc;u r&otilde; m&aacute;y d&ugrave;ng vi xử l&yacute; n&agrave;o.</h2>

<p style="text-align:center">Theo Gimochina, mới đ&acirc;y th&ocirc;ng số kỹ thuật đầy đủ của OPPO R15 đ&atilde; được chia sẻ tr&ecirc;n trang mạng x&atilde; hội Weibo Trung Quốc. H&igrave;nh ảnh được chia sẻ dường như l&agrave; một buổi giới thiệu OPPO R15 trong ph&ograve;ng họp k&iacute;n.</p>

<p style="text-align:center">Được biết, OPPO R15 sẽ c&oacute; 2 phi&ecirc;n bản, R15 v&agrave; R15 Dream Mirror Edition (c&oacute; thể được tung ra để thay thế bản Plus). Cả 2 đều c&oacute; m&agrave;n h&igrave;nh AMOLED 6.28 inch độ ph&acirc;n giải 2.280 x 1.080 px, RAM 6 GB, &nbsp;ROM 128 GB c&ugrave;ng camera selfie 20 MP. Hai smartphone n&agrave;y sẽ c&oacute; c&ugrave;ng độ d&agrave;y, c&ugrave;ng trọng lượng v&agrave; đều t&iacute;ch hợp ColorOS 5.0 dựa tr&ecirc;n Android 8.1 Oreo.</p>

<p style="text-align:center"><img alt="Rò rỉ cấu hình chi tiết OPPO R15 với 2 phiên bản: Snapdragon 660 và Helio P60" src="https://cdn.tgdd.vn/Files/2018/03/11/1073604/oppo-r15-specs_1079x949-800-resize.jpg" title="Rò rỉ cấu hình chi tiết OPPO R15 với 2 phiên bản: Snapdragon 660 và Helio P60" /></p>

<p style="text-align:center">Hai smartphone tr&ecirc;n kh&aacute;c nhau điều g&igrave;? OPPO R15 sử dụng bộ vi xử l&yacute; Helio P60 của MediaTek với tốc độ 2.0 GHz. OPPO R15 DME d&ugrave;ng chip Snapdragon 660 với tốc độ 2.2 GHz v&agrave; t&iacute;ch hợp chip AI.</p>

<p style="text-align:center">Về camera ch&iacute;nh, OPPO R15 sẽ c&oacute; camera k&eacute;p 16 MP f/1.7 + 5 MP f/2.2 để. Phi&ecirc;n bản OPPO R15 DME trang bị camera k&eacute;p 16 MP f/1.7 + 20 MP f/1.7.</p>

<p style="text-align:center">Ngo&agrave;i ra, thiết kế, m&agrave;u sắc v&agrave; dung lượng pin cũng c&oacute; sự kh&aacute;c biệt. OPPO R15 c&oacute; pin 3.450 mAh hỗ trợ sạc nhanh VOOC. N&oacute; cũng c&oacute; thiết kế với mặt sau bằng thủy tinh 2.5D, m&agrave;u sắc gồm: Starry Violet, Thermal Red v&agrave; Snow White.</p>

<p style="text-align:center">OPPO R15 Dream Mirror Edition c&oacute; pin 3. 400 mAh, hỗ trợ sạc nhanh VOOC v&agrave; c&oacute; 2 m&agrave;u. Phi&ecirc;n bản m&agrave;u đỏ c&oacute; mặt lưng bằng k&iacute;nh 3D trong khi bản m&agrave;u đen c&oacute; mặt lưng bằng gốm.</p>
', 1)
INSERT [dbo].[Content] ([ID], [Name], [MetaTitle], [Description], [Image], [CategoryID], [Detail], [Status]) VALUES (16, N'Muốn biến iPhone thành Game Boy', N'muon-bien-iphone-thanh-game-boy', N'Thế hệ 9x hẳn không thể nào quên một thời tuổi thơ dữ dội với máy Game Boy.', N'https://ucarecdn.com/cc01a2b4-0479-4215-8ee7-e553ece6c963/', 7, N'<h1 style="text-align:center">Muốn biến iPhone th&agrave;nh Game Boy, bạn h&atilde;y thử ngay chiếc ốp lưng n&agrave;y!</h1>

<p style="text-align:center">&nbsp;</p>

<p style="text-align:center"><img alt="Đây là chiếc vỏ case biến iPhone của bạn thành máy Game Boy" src="https://cdn.tgdd.vn/Files/2018/03/11/1073439/2_800x450.jpg" title="Đây là chiếc vỏ case biến iPhone của bạn thành máy Game Boy" /></p>

<h2 style="text-align:center">Thế hệ 9x hẳn kh&ocirc;ng thể n&agrave;o qu&ecirc;n một thời tuổi thơ dữ dội với m&aacute;y Game Boy. Kh&aacute; th&uacute; vị khi tr&ecirc;n thị trường đ&atilde; xuất hiện ốp lưng đến từ h&atilde;ng Wanle Gamers Console, biến chiếc Iphone&nbsp;của bạn th&agrave;nh một cỗ m&aacute;y Game Boy cực ngầu.</h2>

<p style="text-align:center">Theo Theverge&nbsp;những chiếc iPhone 6, 6S, 6 Plus, 7, 7 Plus, 8, 8 Plus hoặc iPhone X đều c&oacute; thể tương th&iacute;ch được với loại ốp lưng do&nbsp;Wanle sản xuất. N&oacute; c&oacute; đến 10 tr&ograve; chơi kh&aacute;c nhau v&agrave; c&aacute;ch bố tr&iacute; điều khiển Game Boy quen thuộc.</p>

<p style="text-align:center">Cơ chế hoạt động của chiếc ốp lưng n&agrave;y cũng cực kỳ th&uacute; vị. Ngo&agrave;i chức năng bảo vệ điện thoại, chiếc ốp n&agrave;y c&ograve;n được trang bị m&agrave;n h&igrave;nh cũng như hệ thống ph&iacute;m bấm ri&ecirc;ng để tạo th&agrave;nh cỗ m&aacute;y chơi game độc đ&aacute;o.</p>

<p style="text-align:center"><img alt="" src="https://www.thegioididong.com/tin-tuc/bien-iphone-thanh-game-boy-bang-chiec-op-lung-nay-1073439" /></p>

<p style="text-align:center">Chỉ cần lật ra mặt sau, người d&ugrave;ng c&oacute; thể chơi c&aacute;c tựa game retro (c&oacute; đồ họa xưa cũ) được c&agrave;i đặt sẵn như tr&ograve; chơi xếp h&igrave;nh Tetris, bắn xe tăng Tank, đua xe c&ocirc;ng thức 1 Formula One Racing v&agrave; rắn săn mồi Snake....</p>

<p style="text-align:center">Để sử dụng chiếc ốp lưng th&uacute; vị tr&ecirc;n, bạn chỉ cần lắp một một cục pin nhỏ v&agrave;o g&oacute;c b&ecirc;n trong v&agrave; ngay lập tức bạn c&oacute; thể sử dụng được v&agrave;o mục đ&iacute;ch chơi game.</p>

<p style="text-align:center">Được biết, gi&aacute; b&aacute;n của phụ kiện th&uacute; vị n&agrave;y đang được khuyến m&atilde;i chỉ c&ograve;n 24.95 USD (569 ng&agrave;n đồng) so với gi&aacute; b&aacute;n ban đầu l&agrave; 79.95 USD (1.8 triệu đồng).&nbsp;</p>
', 1)
INSERT [dbo].[Content] ([ID], [Name], [MetaTitle], [Description], [Image], [CategoryID], [Detail], [Status]) VALUES (17, N'Nhận diện khuôn mặt sẽ được sử dụng để cấp phép lên máy bay', N'nhan-dien-khuon-mat-se-duoc-su-dung-de-cap-phep-len-may-bay', N'Theo 9to5mac, không chỉ Apple đầu tư mạnh cho nhận diện khuôn mặt. Các sân bay và hãng hàng không cũng đang thử nghiệm hệ thống sử dụng công nghệ này để phục vụ hành khách', N'https://ucarecdn.com/18e90ea2-b405-425d-8ebd-1fbca1b5fdaf/', 7, N'<h1 style="text-align:center">Nhận diện khu&ocirc;n mặt sẽ được sử dụng để cấp ph&eacute;p l&ecirc;n m&aacute;y bay</h1>

<p style="text-align:center">&nbsp;</p>

<p style="text-align:center"><img alt="Công nghệ nhận dạng gương mặt" src="https://cdn.tgdd.vn/Files/2018/03/10/1073284/congnghenhandangguongmat_800x450.jpg" title="Công nghệ nhận dạng gương mặt" /></p>

<h2 style="text-align:center">Theo&nbsp;<a href="https://9to5mac.com/2018/03/09/facial-recognition-boarding-pass/" target="_blank">9to5mac</a>, kh&ocirc;ng chỉ&nbsp;<a href="https://www.thegioididong.com/dtdd-apple-iphone" target="_blank">Apple</a>&nbsp;đầu tư mạnh cho nhận diện khu&ocirc;n mặt. C&aacute;c s&acirc;n bay v&agrave; h&atilde;ng h&agrave;ng kh&ocirc;ng cũng đang thử nghiệm hệ thống sử dụng c&ocirc;ng nghệ n&agrave;y để phục vụ h&agrave;nh kh&aacute;ch.</h2>

<p style="text-align:center">Apple cho biết, ngay khi nhận ra Face ID&nbsp;tốt như thế n&agrave;o, c&ocirc;ng ty đ&atilde; từ bỏ việc nghi&ecirc;n cứu h&igrave;nh thức t&iacute;ch hợp Touch ID mới, chẳng hạn như nh&uacute;ng v&agrave;o m&agrave;n h&igrave;nh. Ng&agrave;nh h&agrave;ng kh&ocirc;ng c&oacute; vẻ như cũng c&ugrave;ng quan điểm với họ.</p>

<p style="text-align:center">Cụ thể, British Airways đang mở rộng cuộc thử nghiệm d&ugrave;ng nhận dạng khu&ocirc;n mặt để thay thế cho thẻ l&ecirc;n m&aacute;y bay ở cửa khởi h&agrave;nh. H&atilde;ng nhận thấy, việc &aacute;p dụng phương thức mới đ&atilde; giảm thời gian để kh&aacute;ch h&agrave;ng l&ecirc;n m&aacute;y bay xuống c&ograve;n một nửa.</p>

<p style="text-align:center"><img alt="British Airways" src="https://cdn.tgdd.vn/Files/2018/03/10/1073284/britishairways_800x450.jpg" title="British Airways" /></p>

<p style="text-align:center">Thủ tục tại s&acirc;n bay sẽ được thực hiện nhanh hơn với c&ocirc;ng nghệ nhận dạng gương mặt?</p>

<p style="text-align:center">Tương tự như điện thoại di động, cửa khởi h&agrave;nh sinh trắc học sử dụng c&ocirc;ng nghệ m&aacute;y ảnh độ ph&acirc;n giải cao để qu&eacute;t gương mặt. N&oacute; cho ph&eacute;p kh&aacute;ch h&agrave;ng đi qua sau khi nhận ra những n&eacute;t đặc trưng v&agrave; kết hợp ch&uacute;ng với h&igrave;nh ảnh nhập cư, hộ chiếu hoặc visa.</p>

<p style="text-align:center">British Airways c&ograve;n định thử nghiệm thay thế qu&aacute; tr&igrave;nh lấy dấu v&acirc;n tay bằng nhận dạng khu&ocirc;n mặt khi nhập cảnh tại Miami v&agrave; New York, qua đ&oacute; giảm đ&aacute;ng kể thời gian kh&aacute;ch h&agrave;ng phải chờ đợi l&agrave;m thủ tục ở s&acirc;n bay.</p>

<p style="text-align:center">Ngo&agrave;i ra, theo ghi nhận từ&nbsp;Engadget&nbsp;,h&atilde;ng Jet Blue v&agrave; Delta cũng đang thử nghiệm c&aacute;c hệ thống nhận dạng khu&ocirc;n mặt, trong khi s&acirc;n bay quốc tế Dubai c&oacute; &yacute; định sử dụng c&ocirc;ng nghệ n&agrave;y nhằm gi&uacute;p kh&aacute;ch du lịch kh&ocirc;ng phải tr&igrave;nh giấy tờ tại cửa an ninh.</p>
', 1)
INSERT [dbo].[Content] ([ID], [Name], [MetaTitle], [Description], [Image], [CategoryID], [Detail], [Status]) VALUES (18, N'Rò rỉ OPPO F7 với thiết kế "tai thỏ", camera selfie 25 MP', N'ro-ri-oppo-f7-voi-thiet-ke-"tai-tho",-camera-selfie-25-mp', N'PPO đã tung ra chiếc smartphone tỉ lệ màn hình 18:9 đầu tiên của họ là OPPO F5 vào tháng 11 năm ngoái. Và cách đây không lâu, teaser quảng cáo mới về OPPO F7 đã xuất hiện với phần mặt trước của sản phẩm.', N'https://ucarecdn.com/862f72a8-d4ad-4c04-836a-8a711d20056b/', 7, N'<h1 style="text-align:center">R&ograve; rỉ OPPO F7 với thiết kế &quot;tai thỏ&quot;, camera selfie 25 MP</h1>

<p>&nbsp;</p>

<p style="text-align:center"><img alt="Ảnh minh họa" src="https://cdn.tgdd.vn/Files/2018/03/10/1073171/1_800x450.jpg" title="Ảnh minh họa" /></p>

<p style="text-align:center">Ảnh minh họa</p>

<h2 style="text-align:center">OPPO đ&atilde; tung ra chiếc smartphone tỉ lệ m&agrave;n h&igrave;nh 18:9 đầu ti&ecirc;n của họ l&agrave; OPPO F5 v&agrave;o th&aacute;ng 11 năm ngo&aacute;i. V&agrave; c&aacute;ch đ&acirc;y kh&ocirc;ng l&acirc;u, teaser quảng c&aacute;o mới về OPPO F7 đ&atilde; xuất hiện với phần mặt trước của sản phẩm.</h2>

<p style="text-align:center">Theo b&aacute;o c&aacute;o, OPPO F7 sẽ c&oacute; m&agrave;n h&igrave;nh 6.2 inch với độ ph&acirc;n giải Full HD+, viền tr&ecirc;n chứa v&ugrave;ng notch v&agrave; tỉ lệ m&agrave;n h&igrave;nh so với diện t&iacute;ch to&agrave;n mặt trước l&agrave; 89.09%.</p>

<p style="text-align:center"><img alt="Hình ảnh mặt trước OPPO F7" src="https://cdn.tgdd.vn/Files/2018/03/10/1073171/oppo-f7-india_600x346.jpg" title="Hình ảnh mặt trước OPPO F7" /></p>

<p style="text-align:center">H&igrave;nh ảnh mặt trước OPPO F7</p>

<p style="text-align:center">Ngo&agrave;i ra, b&aacute;o c&aacute;o c&ograve;n đề cập OPPO F7 c&ograve;n sở hữu một m&aacute;y ảnh ph&iacute;a trước độ ph&acirc;n giải 25 MP. OPPO lu&ocirc;n tiếp thị sản phẩm của họ l&agrave; chuy&ecirc;n gia selfie, v&igrave; vậy kh&ocirc;ng loại trừ khả năng OPPO F7 cũng sở hữu t&iacute;nh năng selfie ảo diệu, l&agrave;m đẹp bằng tr&iacute; tuệ th&ocirc;ng minh nh&acirc;n tạo AI.</p>

<p style="text-align:center">C&aacute;c t&iacute;nh năng bổ sung kh&aacute;c của thiết bị bao gồm chụp ảnh HDR thời gian thực, chế độ l&agrave;m đẹp n&acirc;ng cao v&agrave; nh&atilde;n d&aacute;n AR.&nbsp;</p>

<p style="text-align:center">Tuy nhi&ecirc;n, dự đo&aacute;n được đưa ra l&agrave; OPPO F7 được trang bị cụm camera k&eacute;p sau v&agrave; cảm biến v&acirc;n tay. Phi&ecirc;n bản được đăng tải l&agrave; phi&ecirc;n bản m&agrave;u đỏ quyến rũ, c&oacute; lẽ sẽ c&oacute; th&ecirc;m phi&ecirc;n bản m&agrave;u đen lịch l&atilde;m.</p>

<p style="text-align:center">Dự kiến, OPPO F7 sẽ được tr&igrave;nh l&agrave;ng trong khoảng khoảng thời gian từ ng&agrave;y 28 đến 30 th&aacute;ng 3.</p>
', 1)
INSERT [dbo].[Content] ([ID], [Name], [MetaTitle], [Description], [Image], [CategoryID], [Detail], [Status]) VALUES (19, N'Để duy trì Thánh SIM Vietnamobile không bị cắt, bạn cần lưu ý điều này', N'de-duy-tri-thanh-sim-vietnamobile-khong-bi-cat,-ban-can-luu-y-dieu-nay', N'Trước sức ép từ Bộ Thông tin và Truyền thông, Vietnamobile (VNM) đang chuẩn bị cập nhật chính sách mới cho các thuê bao sử dụng gói cước Thánh SIM. Cụ thể các thông tin này sẽ được cập nhật sớm trên trang web chính thức của VNM.', NULL, 7, N'<h1 style="text-align:center">Để duy tr&igrave; Th&aacute;nh SIM Vietnamobile kh&ocirc;ng bị cắt, bạn cần lưu &yacute; điều n&agrave;y!</h1>

<p style="text-align:center">&nbsp;</p>

<p style="text-align:center"><img alt="sim_800x450" src="https://cdn.tgdd.vn/Files/2018/03/10/1073175/sim_800x450.jpg" title="sim_800x450" /></p>

<h2 style="text-align:center">Trước sức &eacute;p từ Bộ Th&ocirc;ng tin v&agrave; Truyền th&ocirc;ng, Vietnamobile(VNM) đang chuẩn bị cập nhật ch&iacute;nh s&aacute;ch mới cho c&aacute;c thu&ecirc; bao sử dụng g&oacute;i cước Th&aacute;nh SIM. Cụ thể c&aacute;c th&ocirc;ng tin n&agrave;y sẽ được cập nhật sớm tr&ecirc;n trang web ch&iacute;nh thức của VNM.</h2>

<p style="text-align:center">Hiện tại c&aacute;c thu&ecirc; bao Th&aacute;nh SIM của ch&uacute;ng ta sẽ vẫn nhận được ưu đ&atilde;i như b&igrave;nh thường. Tuy nhi&ecirc;n kể từ ng&agrave;y 8/3, để tiếp tục nhận được ưu đ&atilde;i từ g&oacute;i cước n&agrave;y, c&aacute;c bạn phải thực hiện y&ecirc;u cầu sử dụng tối thiểu 20.000 đồng/th&aacute;ng.</p>

<p style="text-align:center">C&oacute; thể l&agrave; gọi hoặc nhắn tin hay c&aacute;c g&oacute;i cước gi&aacute; trị gia tăng kh&aacute;c. Ngay trong buổi s&aacute;ng h&ocirc;m nay, m&igrave;nh đ&atilde; li&ecirc;n lạc với tổng đ&agrave;i Vietnamobile để x&aacute;c nhận th&ocirc;ng tin tr&ecirc;n. Tức l&agrave; c&aacute;c bạn sẽ phải ph&aacute;t sinh cước tối thiểu l&agrave; 20.000 đồng/th&aacute;ng để tiếp tục được hưởng ưu đ&atilde;i data Th&aacute;nh SIM.</p>

<p style="text-align:center"><img alt="sim " src="https://cdn.tgdd.vn/Files/2018/03/10/1073175/screenshot_20180310-143858_chrome_600x1073.jpg" title="sim " /></p>

<p style="text-align:center">Trong trường hợp th&aacute;ng đ&oacute; bạn kh&ocirc;ng ph&aacute;t sinh tối thiểu 20.000 đồng th&igrave; hệ thống sẽ tự qu&eacute;t t&agrave;i khoản v&agrave; trừ tiền cho đủ 20.000 đồng trong t&agrave;i khoản của bạn.</p>

<p style="text-align:center">Mọi th&ocirc;ng tin chi tiết về việc thay đổi ch&iacute;nh s&aacute;ch sử dụng Th&aacute;nh SIM sẽ được m&igrave;nh cập nhật sớm nhất cho c&aacute;c bạn.</p>
', 1)
SET IDENTITY_INSERT [dbo].[Content] OFF
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([ID], [Text], [Link], [Icon], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (1, N'Login', N'/login', N'fa fa-sign-in', 1, N'_blank', 1, 2)
INSERT [dbo].[Menu] ([ID], [Text], [Link], [Icon], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (2, N'Register', N'/register', N'fa fa-registered', 2, N'_self', 1, 2)
INSERT [dbo].[Menu] ([ID], [Text], [Link], [Icon], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (3, N'Account', N'/account', N'fa fa-user-circle-o', 3, N'_self', 0, 2)
INSERT [dbo].[Menu] ([ID], [Text], [Link], [Icon], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (4, N'About', N'/about', N'fa fa-user-secret', 4, N'_self', 1, 2)
SET IDENTITY_INSERT [dbo].[Menu] OFF
SET IDENTITY_INSERT [dbo].[MenuType] ON 

INSERT [dbo].[MenuType] ([ID], [Name]) VALUES (1, N'main menu')
INSERT [dbo].[MenuType] ([ID], [Name]) VALUES (2, N'top menu')
SET IDENTITY_INSERT [dbo].[MenuType] OFF
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([ID], [CreatedDate], [CustomerName], [CustomerMobile], [CustomerAddress], [CustomerEmail], [Status]) VALUES (6, CAST(N'2018-03-17 14:00:51.480' AS DateTime), N'sadasdsadas', 123, N'Vietnam, Quangbinh, Donghoi', N'dasdsadsa@asds.com', 1)
INSERT [dbo].[Order] ([ID], [CreatedDate], [CustomerName], [CustomerMobile], [CustomerAddress], [CustomerEmail], [Status]) VALUES (7, CAST(N'2018-03-17 17:55:15.793' AS DateTime), N'sadsadsa', 912414929, N'Vietnam, Quangbinh, Donghoi', N'dasdsadsa@asds.com', 1)
INSERT [dbo].[Order] ([ID], [CreatedDate], [CustomerName], [CustomerMobile], [CustomerAddress], [CustomerEmail], [Status]) VALUES (8, CAST(N'2018-03-17 17:57:10.780' AS DateTime), N'sadasdsadas', 21312312321, N'Vietnam, Quangbinh, Donghoi', N'dasdsadsa@asds.com', 1)
INSERT [dbo].[Order] ([ID], [CreatedDate], [CustomerName], [CustomerMobile], [CustomerAddress], [CustomerEmail], [Status]) VALUES (9, CAST(N'2018-03-17 17:59:40.730' AS DateTime), N'sadasdsadas', 21312312321, N'Vietnam, Quangbinh, Donghoi', N'dasdsadsa@asds.com', 1)
SET IDENTITY_INSERT [dbo].[Order] OFF
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (67, 7, 1, CAST(200 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (68, 7, 3, CAST(180 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (69, 7, 1, CAST(345 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (72, 8, 1, CAST(700 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (73, 6, 1, CAST(280 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (73, 8, 3, CAST(280 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (74, 6, 1, CAST(700 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (74, 8, 1, CAST(700 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (79, 6, 1, CAST(1134 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity], [UnitPrice]) VALUES (79, 9, 1, CAST(1134 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (64, N'Asus K555L', N'asus-k555l', NULL, N'https://ucarecdn.com/d1287615-18e9-4e4f-994d-e64bd2599d11/', N'https://ucarecdn.com/67c53596-5950-42a5-82ad-788464a94a6d/|https://ucarecdn.com/5d156a75-b020-4e6b-b552-f2d8e1e81e65/|https://ucarecdn.com/11214e68-fdac-42e9-bd0a-31111b8fd324/', CAST(650 AS Decimal(18, 0)), 2, N'<p>&nbsp;wesfd</p>
', 6, 1, CAST(N'2018-02-28 22:02:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (67, N'Laptop Acer Aspire ES1 432 N3350', N'laptop-acer-aspire-es1-432-n3350', NULL, N'https://ucarecdn.com/f44b4d6f-ead8-41c5-9ddd-63ca58fb340a/', N'||', CAST(200 AS Decimal(18, 0)), 2, NULL, 19, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (68, N'Laptop Lenovo IdeaPad 120S 11IAP N3350', N'laptop-lenovo-ideapad-120s-11iap-n3350', NULL, N'https://ucarecdn.com/831dcda8-bbec-40ea-953a-266c6bbc35e5/', N'||', CAST(180 AS Decimal(18, 0)), 2, NULL, 18, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (69, N'Laptop HP 15 bs578TU N3710', N'laptop-hp-15-bs578tu-n3710', NULL, N'https://ucarecdn.com/b61e79ce-7ce4-48fe-a671-14e2cdb41de4/', N'||', CAST(345 AS Decimal(18, 0)), 2, NULL, 7, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (70, N'Laptop Asus TP203NAH N4200', N'laptop-asus-tp203nah-n4200', NULL, N'https://ucarecdn.com/cef149c7-9074-4243-9853-b5c21f17c4cb/', N'||', CAST(480 AS Decimal(18, 0)), 2, NULL, 6, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (71, N'Laptop Asus X541UA i3 6100U', N'laptop-asus-x541ua-i3-6100u', NULL, N'https://ucarecdn.com/a4bad586-8a7c-4222-91fa-a2812e883556/', N'||', CAST(485 AS Decimal(18, 0)), 2, NULL, 6, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (72, N'Điện thoại Sony Xperia XZ Premium', N'dien-thoai-sony-xperia-xz-premium', NULL, N'https://ucarecdn.com/f936e423-1438-4ada-847f-e0fd4a2132c1/', N'||', CAST(700 AS Decimal(18, 0)), 1, NULL, 1, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (73, N'Điện thoại iPhone 6s 128GB', N'dien-thoai-iphone-6s-128gb', NULL, N'https://ucarecdn.com/c5640de7-d6dc-4b73-b289-002aa6b876fe/', N'||', CAST(280 AS Decimal(18, 0)), 1, NULL, 2, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (74, N'Điện thoại Sony Xperia XZ1', N'dien-thoai-sony-xperia-xz1', N'ádasdasdassadsa', N'https://ucarecdn.com/e0b9e1bc-b7cd-4c67-a2da-987ebed837ce/', N'||', CAST(700 AS Decimal(18, 0)), 1, NULL, 1, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (75, N'Laptop Acer Nitro 5 AN515 51 739L', N'laptop-acer-nitro-5-an515-51-739l', NULL, N'https://ucarecdn.com/3d0ff866-8c0c-407d-8ff4-e292f44541d6/', N'||', CAST(850 AS Decimal(18, 0)), 2, NULL, 19, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (76, N'Laptop Asus FX503VD i7 7700HQ', N'laptop-asus-fx503vd-i7-7700hq', NULL, N'https://ucarecdn.com/49f4eed1-ca02-4928-8d42-5322e19639eb/', N'||', CAST(789 AS Decimal(18, 0)), 2, NULL, 6, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (77, N'Laptop Dell Inspiron 7577A', N'laptop-dell-inspiron-7577a', NULL, N'https://ucarecdn.com/e6637a89-b784-4d09-922a-0d970a96a008/', N'||', CAST(1228 AS Decimal(18, 0)), 2, NULL, 18, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (78, N'Laptop Lenovo Legion Y520 15IKBN', N'laptop-lenovo-legion-y520-15ikbn', NULL, N'https://ucarecdn.com/ff94f580-45f3-4d79-acee-a6929c67a997/', N'||', CAST(1125 AS Decimal(18, 0)), 2, NULL, 18, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (79, N'Laptop Lenovo IdeaPad 720S 13IKB', N'laptop-lenovo-ideapad-720s-13ikb', NULL, N'https://ucarecdn.com/7ac4bd92-cd41-4be5-a875-f0d14bf73c27/', N'||', CAST(1134 AS Decimal(18, 0)), 2, NULL, 18, 1, CAST(N'2018-03-23 17:02:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (80, N'Laptop Lenovo IdeaPad 320 15IKBN', N'laptop-lenovo-ideapad-320-15ikbn', NULL, N'https://ucarecdn.com/628e0d52-6bd6-44c8-907a-f4b88fea02f4/', N'||', CAST(1478 AS Decimal(18, 0)), 2, N'<h3 style="text-align:center">Th&ocirc;ng số kỹ thuật chi tiết Lenovo IdeaPad 320 15IKBN i7 8550U/4GB/1TB/2GB MX150/Win10/(81BG00E1VN)</h3>

<p style="text-align:center"><img alt="Thông số kỹ thuật 139339" src="https://cdn.tgdd.vn/Products/Images/44/139339/Kit/lenovo-ideapad-320-15ikbn-i7-8550u-81bg00e1vn-mo-ta-chuc-nang-1.jpg" style="height:430px; width:500px" /></p>

<p style="text-align:center"><span style="color:#c0392b"><strong>Bộ xử l&yacute;</strong></span></p>

<p style="text-align:center"><span style="color:#000000">C&ocirc;ng nghệ CPU:&nbsp;</span><a href="https://www.thegioididong.com/hoi-dap/cpu-intel-kabylake-refresh-la-gi-1017640" target="_blank"><span style="color:#000000">Intel Core i7 Kabylake Refresh</span></a></p>

<p style="text-align:center"><span style="color:#000000">Loại CPU: 8550U</span></p>

<p style="text-align:center"><span style="color:#000000">Tốc độ CPU: 1.80 GHz</span></p>

<p style="text-align:center"><span style="color:#000000">Tốc độ tối đa:&nbsp;</span><a href="https://www.thegioididong.com/hoi-dap/turbo-boost-la-gi-cai-dat-turbo-boost-nhu-the-nao-884498" target="_blank"><span style="color:#000000">Turbo Boost 4.0 GHz</span></a></p>

<p style="text-align:center"><span style="color:#000000">Tốc độ Bus: 2400 MHz</span></p>

<p style="text-align:center"><strong><span style="color:#c0392b">Bộ nhớ, RAM, Ổ cứng</span></strong></p>

<p style="text-align:center"><span style="color:#000000">RAM: 4 GB</span></p>

<p style="text-align:center"><span style="color:#000000">Loại RAM:&nbsp;</span><a href="https://www.thegioididong.com/hoi-dap/ram-ddr4-la-gi-882173" target="_blank"><span style="color:#000000">DDR4 (On board +1 khe)</span></a></p>

<p style="text-align:center"><span style="color:#000000">Tốc độ Bus RAM: 2133 MHz</span></p>

<p style="text-align:center"><span style="color:#000000">Hỗ trợ RAM tối đa: 16 GB</span></p>

<p style="text-align:center"><span style="color:#000000">Ổ cứng:&nbsp;</span><a href="https://www.thegioididong.com/hoi-dap/hdd-la-gi-922791" target="_blank"><span style="color:#000000">HDD: 1 TB</span></a></p>
', 18, 1, NULL)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Price], [CategoryID], [Detail], [BrandID], [Status], [TopHot]) VALUES (81, N'Smart Tivi Samsung  32 inch UA32J4303D', N'smart-tivi-samsung-32-inch-ua32j4303d', NULL, N'https://ucarecdn.com/e7543a7f-af60-4f2f-be43-17eb32f07ea7/', N'https://ucarecdn.com/7183b0cf-e0a0-4694-b70e-819d1406f54f/|https://ucarecdn.com/2ce6d20a-fab7-4eb6-aa8f-0f5e74fbe79d/|https://ucarecdn.com/ef527414-1da3-46bb-8256-a4caaec92938/', CAST(180 AS Decimal(18, 0)), 8, NULL, 1, 1, CAST(N'2018-03-31 14:20:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([ID], [Name], [MetaTitle], [Icon], [Status], [ShowOnHome]) VALUES (1, N'Smartphone', N'smartphone', N'fa-mobile', 1, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [MetaTitle], [Icon], [Status], [ShowOnHome]) VALUES (2, N'Laptop', N'laptop', N'fa-laptop', 1, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [MetaTitle], [Icon], [Status], [ShowOnHome]) VALUES (3, N'Tablet', N'tablet', N'fa-tablet', 1, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [MetaTitle], [Icon], [Status], [ShowOnHome]) VALUES (8, N'Tivi', N'tivi', N'fa-television', 1, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [MetaTitle], [Icon], [Status], [ShowOnHome]) VALUES (9, N'Camera', N'camera', N'fa-camera', 1, 1)
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Username], [Password], [Name], [Address], [Mail], [Phone], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (6, N'admin', N'202cb962ac59075b964b07152d234b70', N'admin', NULL, NULL, NULL, CAST(N'2018-01-14 00:00:00.000' AS DateTime), NULL, CAST(N'2018-01-14 12:54:55.083' AS DateTime), NULL, 1)
INSERT [dbo].[User] ([ID], [Username], [Password], [Name], [Address], [Mail], [Phone], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (7, N'member1', N'202cb962ac59075b964b07152d234b70', N'member1', N'Vietnam, Quangbinh, Donghoi', N'member1', N'23323243243', CAST(N'2018-01-14 00:00:00.000' AS DateTime), NULL, CAST(N'2018-01-14 13:02:36.657' AS DateTime), NULL, 0)
INSERT [dbo].[User] ([ID], [Username], [Password], [Name], [Address], [Mail], [Phone], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (8, N'member2', N'202cb962ac59075b964b07152d234b70', N'member1', N'Vietnam, Quangbinh, Donghoi', N'member2', N'23323243243', CAST(N'2018-01-14 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[User] ([ID], [Username], [Password], [Name], [Address], [Mail], [Phone], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10, N'member4', N'202cb962ac59075b964b07152d234b70', N'member4', N'Vietnam, Quangbinh, Donghoi', NULL, NULL, CAST(N'2018-01-14 00:00:00.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[User] ([ID], [Username], [Password], [Name], [Address], [Mail], [Phone], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (11, N'member5', N'202cb962ac59075b964b07152d234b70', N'member5', N'Vietnam, Quangbinh, Donghoi', N'member5', NULL, CAST(N'2018-01-14 00:00:00.000' AS DateTime), NULL, CAST(N'2018-01-20 15:00:12.307' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[User] OFF

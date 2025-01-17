USE [master]
GO
/****** Object:  Database [B1805708_NTPhat]    Script Date: 09/12/2021 11:31:27 ******/
CREATE DATABASE [B1805708_NTPhat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'B1805708_NTPhat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\B1805708_NTPhat.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'B1805708_NTPhat_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\B1805708_NTPhat_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [B1805708_NTPhat] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [B1805708_NTPhat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [B1805708_NTPhat] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET ARITHABORT OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [B1805708_NTPhat] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [B1805708_NTPhat] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET  DISABLE_BROKER 
GO
ALTER DATABASE [B1805708_NTPhat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [B1805708_NTPhat] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET RECOVERY FULL 
GO
ALTER DATABASE [B1805708_NTPhat] SET  MULTI_USER 
GO
ALTER DATABASE [B1805708_NTPhat] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [B1805708_NTPhat] SET DB_CHAINING OFF 
GO
ALTER DATABASE [B1805708_NTPhat] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [B1805708_NTPhat] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [B1805708_NTPhat] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [B1805708_NTPhat] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'B1805708_NTPhat', N'ON'
GO
ALTER DATABASE [B1805708_NTPhat] SET QUERY_STORE = OFF
GO
USE [B1805708_NTPhat]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](300) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [datetime] NULL,
	[DateCheckOut] [datetime] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryFood]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'phat', N'Phat', N'37213902101311706410244100199109113607173', 1)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1, CAST(N'2021-12-08T22:02:15.027' AS DateTime), CAST(N'2021-12-08T22:08:11.477' AS DateTime), 2, 1, 0, 50000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (6, CAST(N'2021-12-08T22:21:58.573' AS DateTime), NULL, 2, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1, 1, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (6, 6, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (7, 6, 2, -4)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[CategoryFood] ON 

INSERT [dbo].[CategoryFood] ([id], [name]) VALUES (1, N'Cà phê')
INSERT [dbo].[CategoryFood] ([id], [name]) VALUES (2, N'Trà')
INSERT [dbo].[CategoryFood] ([id], [name]) VALUES (3, N'Sinh tố')
INSERT [dbo].[CategoryFood] ([id], [name]) VALUES (4, N'Nước chai')
SET IDENTITY_INSERT [dbo].[CategoryFood] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Cà phê đá', 1, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Cà phê sữa', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Cà phê nóng', 1, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'Trà đá', 2, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Trà đào', 2, 40000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'Bơ', 3, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Mít', 3, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (8, N'Việt quốc', 3, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (9, N'7Up', 4, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (10, N'Ô long', 4, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (11, N'Sting', 4, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (12, N'Trà sữa', 2, 25000)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 2', N'CÓ KHÁCH')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 10', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn 11', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn 12', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Bàn 13', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn 14', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (15, N'Bàn 15', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (16, N'Bàn 16', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (17, N'Bàn 17', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (18, N'Bàn 18', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (19, N'Bàn 19', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (20, N'Bàn 20', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((1)) FOR [count]
GO
ALTER TABLE [dbo].[CategoryFood] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[CategoryFood] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_CheckOutBillForTable]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CheckOutBillForTable]
@idTable INT, @discount FLOAT, @finalTotalPrice FLOAT
AS
BEGIN
	DECLARE @idBill INT
	SELECT @idBill = id FROM Bill WHERE idTable = @idTable AND status = 0
	IF(@idBill IS NULL)
	BEGIN
		SELECT NULL
	END
	ELSE
	BEGIN
		UPDATE Bill 
		SET discount = @discount, totalPrice = @finalTotalPrice, DateCheckOut = GETDATE(), status = 1
		WHERE id = @idBill
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteBillIdTable]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DeleteBillIdTable]
@table_id INT
AS 
BEGIN
	DECLARE getIdBillCursor CURSOR FOR SELECT id FROM Bill WHERE idTable = @table_id
	OPEN getIdBillCursor
	DECLARE @idBill_delete INT
	FETCH NEXT FROM getIdBillCursor INTO @idBill_delete
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DELETE BillInfo WHERE idBill = @idBill_delete
		FETCH NEXT FROM getIdBillCursor INTO @idBill_delete
	END
	CLOSE getIdBillCursor
	DEALLOCATE getIdBillCursor
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteFoodByIdCategory]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DeleteFoodByIdCategory]
@category_id INT
AS 
BEGIN
	DECLARE getIdFoodCursor CURSOR FOR SELECT id FROM Food WHERE idCategory = @category_id
	OPEN getIdFoodCursor
	DECLARE @idFood_delete INT
	FETCH NEXT FROM getIdFoodCursor INTO @idFood_delete
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DELETE BillInfo WHERE idFood = @idFood_delete;
		DELETE Food WHERE id = @idFood_delete
		FETCH NEXT FROM getIdFoodCursor INTO @idFood_delete
	END
	CLOSE getIdFoodCursor
	DEALLOCATE getIdFoodCursor
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetBillInfoByIdTable]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetBillInfoByIdTable]
@idTable INT
AS
BEGIN
	DECLARE @idBill INT = 0
	SELECT @idBill = id FROM Bill WHERE idTable = @idTable AND status = 0
	IF(@idBill IS NULL)
		SELECT @idBill
	ELSE
	BEGIN
		SELECT f.name as FoodName, bi.count as Amount, f.price as Price, (bi.count*f.price) as TotalPrice
		FROM Food as f  JOIN BillInfo as bi ON f.id = bi.idFood
						JOIN Bill as b ON b.id = bi.idBill
		WHERE b.id = @idBill
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_getListBillByDate]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_getListBillByDate]
@checkIn nvarchar(10), @checkOut nvarchar(10)
AS
BEGIN
	SELECT 
		b.id as [Mã HĐ], 
		t.name as [Tên bàn],
		(CONVERT(VARCHAR(11), DateCheckIn, 103)+' '+CONVERT(VARCHAR(9),DateCheckIn, 108)) as [Tạo lúc],
		(CONVERT(VARCHAR(11), DateCheckOut, 103)+' '+CONVERT(VARCHAR(9),DateCheckOut, 108)) as [Thanh toán lúc], 
		b.discount as [Giảm giá],
		b.totalPrice as [Tổng tiền]
	 FROM Bill b JOIN TableFood t ON t.id = b.idTable
	 WHERE CONVERT(date,DateCheckIn) >= @checkIn AND CONVERT(date,DateCheckOut) <= @checkOut AND b.status = 1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idFood INT, @count INT
AS
BEGIN
	DECLARE @isExitsBillInfo INT = 0
	DECLARE @foodCount INT = 1

	SELECT @isExitsBillInfo = bi.id, @foodCount = bi.count 
	FROM BillInfo as bi
	WHERE bi.idBill = @idBill AND bi.idFood = @idFood

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE BillInfo SET	count = @foodCount + @count WHERE idFood = @idFood AND idBill = @idBill
		ELSE
			DELETE BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		INSERT BillInfo(idBill,idFood,count) VALUES(@idBill, @idFood, @count)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_MergeTable]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_MergeTable]
@idTable1 INT, @idTable2 INT
AS 
BEGIN
	DECLARE @idBill1 INT
	DECLARE @idBill2 INT

	SELECT @idBill1 = id FROM Bill WHERE idTable = @idTable1 AND status = 0
	SELECT @idBill2 = id FROM Bill WHERE idTable = @idTable2 AND status = 0

	IF(@idBill2 IS NULL)
	BEGIN
		UPDATE Bill SET idTable = @idTable2 WHERE id = @idBill1
		UPDATE TableFood SET status = N'Trống' WHERE id = @idTable1
	END
	ELSE
	BEGIN
		DECLARE itemBillInfo1 CURSOR FOR SELECT @idBill2 AS idBill, idFood, count FROM BillInfo WHERE idBill = @idBill1
		OPEN itemBillInfo1
		DECLARE @idBill INT
		DECLARE @idFood INT
		DECLARE @count INT
		FETCH NEXT FROM itemBillInfo1 INTO @idBill, @idFood, @count
		WHILE @@FETCH_STATUS = 0
		BEGIN
			
			EXEC USP_InsertBillInfo @idBill, @idFood, @count
			FETCH NEXT FROM itemBillInfo1 INTO @idBill, @idFood, @count
		END
		CLOSE itemBillInfo1
		DEALLOCATE itemBillInfo1
		UPDATE TableFood SET status = N'Trống' WHERE id = @idTable1
		DELETE BillInfo WHERE idBill = @idBill1
		DELETE Bill WHERE id = @idBill1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 09/12/2021 11:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SwitchTable]
@idTable1 INT, @idTable2 INT
AS BEGIN
	DECLARE @idBill1 INT
	DECLARE @idBill2 INT

	SELECT @idBill1 = id FROM Bill WHERE idTable = @idTable1 AND status = 0
	SELECT @idBill2 = id FROM Bill WHERE idTable = @idTable2 AND status = 0

	UPDATE Bill SET idTable = @idTable2 WHERE id = @idBill1
	UPDATE Bill SET Bill.idTable = @idTable1 WHERE id = @idBill2
	
	DECLARE @isFirstTablEmty INT = 0
	DECLARE @isSecondTablEmty INT = 0
	
	SELECT @isFirstTablEmty = COUNT(*) FROM BillInfo WHERE idBill = @idBill1
	SELECT @isSecondTablEmty = COUNT(*) FROM BillInfo WHERE idBill = @idBill2
	
	IF (@isFirstTablEmty = 0)
		DELETE Bill where id = @idBill1
	IF (@isSecondTablEmty= 0)
		DELETE Bill where id = @idBill2
END
GO
USE [master]
GO
ALTER DATABASE [B1805708_NTPhat] SET  READ_WRITE 
GO

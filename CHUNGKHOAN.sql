USE [CHUNGKHOAN]
GO
/****** Object:  Table [dbo].[LENHKHOP]    Script Date: 4/25/2021 19:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LENHKHOP](
	[IDKHOP] [int] IDENTITY(1,1) NOT NULL,
	[NGAYKHOP] [datetime] NULL,
	[SOLUONGKHOP] [int] NULL,
	[GIAKHOP] [float] NULL,
	[IDLENHDAT] [int] NULL,
 CONSTRAINT [PK_LENHKHOP] PRIMARY KEY CLUSTERED 
(
	[IDKHOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LENHDAT]    Script Date: 4/25/2021 19:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LENHDAT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MACP] [nchar](7) NULL,
	[NGAYDAT] [datetime] NULL,
	[LOAIGD] [nchar](1) NULL,
	[LOAILENH] [nchar](3) NULL,
	[SOLUONG] [int] NULL,
	[GIADAT] [float] NULL,
	[TRANGTHAILENH] [nvarchar](50) NULL,
 CONSTRAINT [PK_LENHDAT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TABLE1]    Script Date: 4/25/2021 19:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TABLE1]
AS
SELECT LENHDAT.MACP, LENHKHOP.GIAKHOP, SUM(SOLUONGKHOP) AS SOLUONG, NGAYKHOP
	FROM LENHKHOP JOIN LENHDAT ON LENHKHOP.IDLENHDAT = LENHDAT.ID 
				  JOIN
                      (SELECT MACP, MAX(GIAKHOP) AS GIAKHOP
							FROM LENHKHOP JOIN LENHDAT ON LENHKHOP.IDLENHDAT = LENHDAT.ID
							WHERE LENHDAT.LOAIGD = 'M' AND TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
							GROUP BY MACP
						) LKM 
					ON LKM.GIAKHOP = LENHKHOP.GIAKHOP AND LKM.MACP = LENHDAT.MACP
	GROUP BY LENHDAT.MACP, LENHKHOP.GIAKHOP, NGAYKHOP
UNION
SELECT LENHDAT.MACP, LENHKHOP.GIAKHOP, SUM(SOLUONGKHOP) AS SOLUONG, NGAYKHOP
FROM     LENHKHOP JOIN
                  LENHDAT ON LENHKHOP.IDLENHDAT = LENHDAT.ID JOIN
                      (SELECT MACP, MIN(GIAKHOP) AS GIAKHOP
                       FROM      LENHKHOP JOIN
                                         LENHDAT ON LENHKHOP.IDLENHDAT = LENHDAT.ID
                       WHERE   LENHDAT.LOAIGD = 'B' AND TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
                       GROUP BY MACP) LKB ON LKB.GIAKHOP = LENHKHOP.GIAKHOP AND LKB.MACP = LENHDAT.MACP
GROUP BY LENHDAT.MACP, LENHKHOP.GIAKHOP, NGAYKHOP
GO
/****** Object:  Table [dbo].[BANGGIATRUCTUYEN]    Script Date: 4/25/2021 19:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGGIATRUCTUYEN](
	[MACP] [nchar](7) NOT NULL,
	[GIAMUA3] [float] NULL,
	[KLM3] [int] NULL,
	[GIAMUA2] [float] NULL,
	[KLM2] [int] NULL,
	[GIAMUA1] [float] NULL,
	[KLM1] [int] NULL,
	[GIAKHOP] [float] NULL,
	[KLKHOP] [int] NULL,
	[GIABAN1] [float] NULL,
	[KLB1] [int] NULL,
	[GIABAN2] [float] NULL,
	[KLB2] [int] NULL,
	[GIABAN3] [float] NULL,
	[KLB3] [int] NULL,
 CONSTRAINT [PK_BANGGIATRUCTUYEN_1] PRIMARY KEY CLUSTERED 
(
	[MACP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BANGGIATRUCTUYEN] ([MACP], [GIAMUA3], [KLM3], [GIAMUA2], [KLM2], [GIAMUA1], [KLM1], [GIAKHOP], [KLKHOP], [GIABAN1], [KLB1], [GIABAN2], [KLB2], [GIABAN3], [KLB3]) VALUES (N'MACP001', 20000, 20, 30000, 50, 40000, 40, 40000, 200, 20000, 50, 50000, 20, 60000, 10)
INSERT [dbo].[BANGGIATRUCTUYEN] ([MACP], [GIAMUA3], [KLM3], [GIAMUA2], [KLM2], [GIAMUA1], [KLM1], [GIAKHOP], [KLKHOP], [GIABAN1], [KLB1], [GIABAN2], [KLB2], [GIABAN3], [KLB3]) VALUES (N'MACP002', NULL, NULL, 50000, 20, 60000, 20, 60000, 200, 70000, 40, NULL, NULL, NULL, NULL)
INSERT [dbo].[BANGGIATRUCTUYEN] ([MACP], [GIAMUA3], [KLM3], [GIAMUA2], [KLM2], [GIAMUA1], [KLM1], [GIAKHOP], [KLKHOP], [GIABAN1], [KLB1], [GIABAN2], [KLB2], [GIABAN3], [KLB3]) VALUES (N'MACP003', NULL, NULL, NULL, NULL, 60000, 30, 60000, 400, 50000, 20, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[LENHDAT] ON 

INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (1, N'MACP001', CAST(N'2022-04-19T00:00:00.000' AS DateTime), N'B', N'ATO', 20, 50000, N'Chờ Khớp                      ')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (2, N'MACP002', CAST(N'2022-04-19T00:00:00.000' AS DateTime), N'B', N'ATO', 40, 70000, N'Chờ Khớp                      ')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (3, N'MACP003', CAST(N'2022-04-19T00:00:00.000' AS DateTime), N'B', N'ATO', 20, 50000, N'Chờ Khớp                      ')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (4, N'MACP001', CAST(N'2022-04-19T00:00:00.000' AS DateTime), N'B', N'ATO', 50, 60000, N'Chờ Khớp                      ')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (8, N'MACP001', CAST(N'2021-03-22T23:26:18.707' AS DateTime), N'B', N'ATO', 10, 20000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (26, N'MACP002', CAST(N'2021-03-23T08:22:12.500' AS DateTime), N'M', N'ATO', 20, 50000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (27, N'MACP002', CAST(N'2021-03-23T08:22:19.870' AS DateTime), N'M', N'ATO', 20, 60000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (28, N'MACP001', CAST(N'2021-04-02T19:50:17.180' AS DateTime), N'M', N'ATO', 10, 10000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (29, N'MACP001', CAST(N'2021-04-02T19:51:06.900' AS DateTime), N'M', N'ATO', 50, 5000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (30, N'MACP001', CAST(N'2021-04-07T12:00:40.270' AS DateTime), N'M', N'ATO', 20, 4000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (31, N'MACP001', CAST(N'2021-04-07T19:33:15.777' AS DateTime), N'M', N'ATO', 20, 20000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (32, N'MACP001', CAST(N'2021-04-07T21:19:34.000' AS DateTime), N'M', N'ATO', 20, 30000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (33, N'MACP001', CAST(N'2021-04-07T21:32:40.560' AS DateTime), N'M', N'ATO', 20, 40000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (34, N'MACP003', CAST(N'2021-04-24T21:42:33.417' AS DateTime), N'M', N'ATO', 30, 60000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (46, N'MACP001', CAST(N'2021-04-25T01:44:12.917' AS DateTime), N'M', N'ATO', 30, 10000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (47, N'MACP001', CAST(N'2021-04-25T18:47:15.077' AS DateTime), N'M', N'ATO', 30, 30000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (48, N'MACP001', CAST(N'2021-04-25T18:50:44.607' AS DateTime), N'M', N'ATO', 20, 40000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (49, N'MACP001', CAST(N'2021-04-25T19:11:03.070' AS DateTime), N'M', N'ATO', 50, 50000, N'Đã hủy')
SET IDENTITY_INSERT [dbo].[LENHDAT] OFF
GO
SET IDENTITY_INSERT [dbo].[LENHKHOP] ON 

INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (1, CAST(N'2021-04-24T21:29:43.350' AS DateTime), 20, 50000, 1)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (2, CAST(N'2021-04-24T21:29:48.023' AS DateTime), 100, 70000, 2)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (3, CAST(N'2021-04-24T21:31:26.043' AS DateTime), 200, 50000, 3)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (4, CAST(N'2021-04-24T21:31:59.510' AS DateTime), 100, 20000, 8)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (5, CAST(N'2021-04-24T21:32:35.550' AS DateTime), 500, 5000, 26)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (6, CAST(N'2021-04-24T21:33:02.060' AS DateTime), 200, 60000, 27)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (7, CAST(N'2021-04-24T21:33:14.617' AS DateTime), 200, 40000, 28)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (8, CAST(N'2021-04-24T21:33:27.127' AS DateTime), 300, 5000, 29)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (9, CAST(N'2021-04-25T00:37:27.557' AS DateTime), 400, 60000, 34)
SET IDENTITY_INSERT [dbo].[LENHKHOP] OFF
GO
ALTER TABLE [dbo].[LENHDAT] ADD  CONSTRAINT [DF_LENHDAT_NGAYDAT]  DEFAULT (getdate()) FOR [NGAYDAT]
GO
ALTER TABLE [dbo].[LENHDAT] ADD  CONSTRAINT [DF_LENHDAT_TRANGTHAILENH]  DEFAULT (N'Chờ khớp') FOR [TRANGTHAILENH]
GO
ALTER TABLE [dbo].[LENHKHOP] ADD  CONSTRAINT [DF_LENHKHOP_NGAYKHOP]  DEFAULT (getdate()) FOR [NGAYKHOP]
GO
ALTER TABLE [dbo].[LENHKHOP]  WITH CHECK ADD  CONSTRAINT [FK_LENHKHOP_LENHDAT] FOREIGN KEY([IDLENHDAT])
REFERENCES [dbo].[LENHDAT] ([ID])
GO
ALTER TABLE [dbo].[LENHKHOP] CHECK CONSTRAINT [FK_LENHKHOP_LENHDAT]
GO
/****** Object:  StoredProcedure [dbo].[TAO_BANG_GIA]    Script Date: 4/25/2021 19:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TAO_BANG_GIA]
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM dbo.BANGGIATRUCTUYEN;
			INSERT INTO dbo.BANGGIATRUCTUYEN
			SELECT MACP,GIAMUA3,KLM3,GIAMUA2,KLM2,GIAMUA1,KLM1,GIAKHOP,KLKHOP,GIABAN1,KLB1,GIABAN2,KLB2,GIABAN3,KLB3 FROM 
			(
				SELECT LD.NAMECOL,LD.MACP AS MACP,LD.VALUE AS [VALUE] FROM
				(
				
					--LAY 3 GIADAT LON NHAT THEO TUNG MACP VOI LOAI M
					SELECT  NAMECOL = 'GIAMUA'+ CAST(MACP_rank AS nvarchar),MACP,GIADAT AS [VALUE] FROM 
					(
						SELECT MACP,GIADAT,LOAIGD,
							ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
						FROM 
							(SELECT MACP,GIADAT,LOAIGD 
								FROM LENHDAT WHERE TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
									AND LOAIGD = 'M' GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					) LDM
					WHERE MACP_rank <= 3
					--	

					UNION
					--LAY 3 KLM LON NHAT THEO TUNG MACP VOI LOAI M
					SELECT  NAMECOL = 'KLM'+ CAST(MACP_rank AS nvarchar), MACP,SOLUONG AS [VALUE] FROM 
					(
						SELECT MACP,LOAIGD,SOLUONG,
							ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
						FROM 
							(SELECT MACP,GIADAT,SUM(SOLUONG) AS SOLUONG,LOAIGD 
								FROM LENHDAT WHERE TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
									AND LOAIGD = 'M' GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					) LDM
					WHERE MACP_rank <= 3
					--

					UNION
					--LAY 3 GIABAN NHO NHAT THEO TUNG MACP VOI LOAI B 
					SELECT  NAMECOL = 'GIABAN'+ CAST(MACP_rank AS nvarchar),MACP,GIADAT AS [VALUE] FROM 
					(
						SELECT MACP,GIADAT,LOAIGD,
							ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT) AS MACP_RANK 
						FROM 
							(SELECT MACP,GIADAT,LOAIGD 
								FROM LENHDAT WHERE TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
									AND LOAIGD = 'B' GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					) LDM
					WHERE MACP_rank <= 3
					--

					UNION
					--LAY 3 KLB NHO NHAT THEO TUNG MACP VOI LOAI B
					SELECT  NAMECOL = 'KLB'+ CAST(MACP_rank AS nvarchar), MACP,SOLUONG AS [VALUE] FROM 
					(
						SELECT MACP,LOAIGD,SOLUONG,
							ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
						FROM 
							(SELECT MACP,GIADAT,SUM(SOLUONG) AS SOLUONG,LOAIGD 
								FROM LENHDAT WHERE TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
									AND LOAIGD = 'B' GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					) LDM
					WHERE MACP_rank <= 3
					--

					UNION
					--LAY 3 GIA KHOP GAN NHAT THEO TUNG MACP
						SELECT NAMECOL = 'GIAKHOP',TABLE1.MACP,GIAKHOP AS [VALUE] FROM TABLE1
						JOIN 
						(
							SELECT MACP,MAX(NGAYKHOP) AS NGAYKHOP FROM TABLE1 GROUP BY MACP
						) LK
						ON TABLE1.NGAYKHOP = LK.NGAYKHOP
					--

					UNION
					--LAY 3 KL KHOP GAN NHAT THEO TUNG MACP
					SELECT NAMECOL = 'KLKHOP',TABLE1.MACP,SOLUONG AS [VALUE] FROM TABLE1
						JOIN 
						(
							SELECT MACP,MAX(NGAYKHOP) AS NGAYKHOP FROM TABLE1 GROUP BY MACP
						) LK
						ON TABLE1.NGAYKHOP = LK.NGAYKHOP
					--
				) AS LD
			) X
			PIVOT 
			(
				MAX(VALUE)
				FOR NAMECOL IN (GIAMUA1,KLM1,GIAMUA2,KLM2,GIAMUA3,KLM3,GIABAN1,KLB1,GIAKHOP,KLKHOP,GIABAN2,KLB2,GIABAN3,KLB3)
			) P
		SELECT @@ROWCOUNT
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		DECLARE @ErrorMessage VARCHAR(2000);
		SELECT @ErrorMessage=ERROR_MESSAGE();
		RAISERROR(@ErrorMessage,16,1);
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_BANG_GIA]    Script Date: 4/25/2021 19:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UPDATE_BANG_GIA]
@MACP nchar(7),
@LOAIGD nchar(1),
@LOAILENH nchar(3),
@SOLUONG INT,
@GIADAT float
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO dbo.LENHDAT (MACP,LOAIGD,LOAILENH,SOLUONG,GIADAT)
				VALUES (@MACP,@LOAIGD,@LOAILENH,@SOLUONG,@GIADAT)

			UPDATE dbo.BANGGIATRUCTUYEN
			SET GIAMUA3=P.GIAMUA3,KLM3=P.KLM3,GIAMUA2=P.GIAMUA2,KLM2=P.KLM2,GIAMUA1=P.GIAMUA1,KLM1=P.KLM1,
				GIAKHOP=P.GIAKHOP,KLKHOP=P.KLKHOP,
				GIABAN1=P.GIABAN1,KLB1=P.KLB1,GIABAN2=P.GIABAN2,KLB2=P.KLB2,GIABAN3=P.GIABAN3,KLB3=P.KLB3
			FROM 
			(
				SELECT LD.NAMECOL,LD.MACP AS MACP,LD.VALUE AS [VALUE] FROM(
				
				--LAY 3 GIADAT LON NHAT THEO TUNG MACP VOI LOAI M
				SELECT  NAMECOL = 'GIAMUA'+ CAST(MACP_rank AS nvarchar),MACP,GIADAT AS [VALUE] 
				FROM (
					SELECT MACP,GIADAT,LOAIGD,
						ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
					FROM 
						(SELECT MACP,GIADAT,LOAIGD 
								FROM LENHDAT WHERE TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
									AND LOAIGD = 'M' GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					WHERE MACP=@MACP
				) LDM
				WHERE MACP_rank <= 3
				--	

				UNION
				--LAY 3 KLM LON NHAT THEO TUNG MACP VOI LOAI M
				SELECT  NAMECOL = 'KLM'+ CAST(MACP_rank AS nvarchar), MACP,SOLUONG AS [VALUE] 
				FROM (
					SELECT MACP,LOAIGD,SOLUONG,
						ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
					FROM 
						(SELECT MACP,GIADAT,SUM(SOLUONG) AS SOLUONG,LOAIGD 
								FROM LENHDAT WHERE TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
									AND LOAIGD = 'M' GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					WHERE MACP=@MACP
				) LDM
				WHERE MACP_rank <= 3
				--

				UNION
				--LAY 3 GIABAN NHO NHAT THEO TUNG MACP VOI LOAI B
				SELECT  NAMECOL = 'GIABAN'+ CAST(MACP_rank AS nvarchar),MACP,GIADAT AS [VALUE] 
				FROM (
					SELECT MACP,GIADAT,LOAIGD,
						ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT) AS MACP_RANK 
					FROM 
						(SELECT MACP,GIADAT,LOAIGD 
								FROM LENHDAT WHERE TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
									AND LOAIGD = 'B' GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					WHERE MACP=@MACP
				) LDM
				WHERE MACP_rank <= 3
				--

				UNION
				--LAY 3 KLB NHO NHAT THEO TUNG MACP VOI LOAI B
				SELECT  NAMECOL = 'KLB'+ CAST(MACP_rank AS nvarchar), MACP,SOLUONG AS [VALUE] 
				FROM (
					SELECT MACP,LOAIGD,SOLUONG,
						ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
					FROM 
						(SELECT MACP,GIADAT,SUM(SOLUONG) AS SOLUONG,LOAIGD 
								FROM LENHDAT WHERE TRANGTHAILENH !=N'Đã hủy' AND TRANGTHAILENH !=N'Chưa khớp'
									AND LOAIGD = 'B' GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					WHERE MACP=@MACP
				) LDM
				WHERE MACP_rank <= 3
				--

				UNION
				--LAY 3 GIA KHOP GAN NHAT THEO TUNG MACP
				SELECT NAMECOL = 'GIAKHOP',TABLE1.MACP,GIAKHOP AS [VALUE] FROM TABLE1
					JOIN 
						(
							SELECT MACP,MAX(NGAYKHOP) AS NGAYKHOP FROM TABLE1 WHERE MACP=@MACP GROUP BY MACP
						) LK
					ON TABLE1.NGAYKHOP = LK.NGAYKHOP
				--

				UNION
				--LAY 3 KL KHOP GAN NHAT THEO TUNG MACP
				SELECT NAMECOL = 'KLKHOP',TABLE1.MACP,SOLUONG AS [VALUE] FROM TABLE1
					JOIN 
						(
							SELECT MACP,MAX(NGAYKHOP) AS NGAYKHOP FROM TABLE1 WHERE MACP=@MACP GROUP BY MACP
						) LK
					ON TABLE1.NGAYKHOP = LK.NGAYKHOP
				--	

			) AS LD
		) X
		PIVOT 
		(
			MAX(VALUE)
			FOR NAMECOL IN (GIAMUA1,KLM1,GIAMUA2,KLM2,GIAMUA3,KLM3,GIABAN1,KLB1,GIAKHOP,KLKHOP,GIABAN2,KLB2,GIABAN3,KLB3)
		) P
		WHERE BANGGIATRUCTUYEN.MACP=@MACP
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		DECLARE @ErrorMessage VARCHAR(2000);
		SELECT @ErrorMessage=ERROR_MESSAGE();
		RAISERROR(@ErrorMessage,16,1);
	END CATCH
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[16] 2[46] 3) )"
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TABLE1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TABLE1'
GO

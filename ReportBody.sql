
--// Master Report table
IF OBJECT_ID('tempdb..#Report',N'U') IS NOT NULL
BEGIN
	DROP TABLE #Report
END

CREATE TABLE #Report(
	SnapshotDate DateTime CONSTRAINT [DF_TBL_DAILY_SALES_SnapshotDate]  
	DEFAULT (CONVERT([varchar](8),getdate(),(112))),
	Province varchar(10),
	ActivationTag varchar(50),
	OnlineSales Int,
	OtherSales int
)

--// Support Province Table 
IF OBJECT_ID('tempdb..#Province',N'U') IS NOT NULL
BEGIN
	DROP TABLE #Province
END

CREATE TABLE #Province(
ID INT IDENTITY(1,1),
Provice Varchar(10)
)
--QC
INSERT INTO #Province(Provice)
VALUES('QC')
--NOT QC
INSERT INTO #Province(Provice)
VALUES('Others')

--// Support ActivationTag table
IF OBJECT_ID('tempdb..#ActivationTag',N'U') IS NOT NULL
BEGIN
	DROP TABLE #ActivationTag
END

CREATE TABLE #ActivationTag( 
ID INT IDENTITY(1,1) NOT NULL,
ActivationTag varchar(50)
)

INSERT INTO #ActivationTag(ActivationTag)
SELECT DISTINCT ActivationTag FROM Portal_Import.dbo.TBL_DAILY_SALES 
WHERE (ActivationTag IS NOT NULL AND ActivationTag <> 'None')

--//THE LOOP TABLE
IF OBJECT_ID('tempdb..#Loop',N'U') IS NOT NULL
BEGIN
	DROP TABLE #Loop
END 

CREATE TABLE #Loop
(
ID int IDENTITY(1,1) NOT NULL,
ActivationTag varchar(50),
Province varchar(10)
)

INSERT INTO #Loop(ActivationTag,Province)
SELECT ActivationTag,Provice FROM #ActivationTag A CROSS JOIN #Province B



--//Day of interests
DECLARE @StartDate AS DATETIME 
DECLARE @EndDate as DATETIME  --2018-04-06 
SET @StartDate = '2018-04-03'
SET @EndDate = '2018-04-09'
SET @StartDate = CONVERT([varchar](8),@StartDate,(112))
--//Report fields
DECLARE @OnlineSales as int
DECLARE @OtherSales as int
--//Province
DECLARE @Province as varchar(10)
--//Activation Tag
DECLARE @ActivationTag as varchar(50)
--//Iterator
DECLARE @i AS INT
--//Reporting
WHILE @StartDate <= CONVERT([varchar](8),@EndDate,(112))--3
BEGIN
	SET @i = 1
	WHILE @i <= (SELECT MAX(ID) FROM #Loop)--12
	BEGIN
		SET @Province = (SELECT Province from #Loop WHERE ID = @i)
		SET @ActivationTag = (SELECT  ActivationTag FROM #Loop WHERE ID = @i)
			IF @Province <> 'QC' 
				BEGIN
					SET @OtherSales = (SELECT COUNT(*) FROM Portal_Import.dbo.TBL_DAILY_SALES S	
						INNER JOIN [SCORECARD_DB].[DBO].[EMPLOYEE] E
						ON S.[USERID] = E.EMPLOYEEID
						INNER JOIN [Portal_Import].[dbo].[tbl_account_addressInfo] C
						ON  S.CLIENTID = C.CLIENTID
							WHERE E.ACTIVATION_SOURCE <> 'Web-Consumer'
							AND S.SnapshotDate = @StartDate
							AND [STATE] <> 'QC'
							AND ADDRESS_TYPE =2
							AND ActivationTag = @ActivationTag
							) ;

				END
			ELSE
				BEGIN
					SET @OtherSales = (SELECT COUNT(*) FROM Portal_Import.dbo.TBL_DAILY_SALES S	
						INNER JOIN [SCORECARD_DB].[DBO].[EMPLOYEE] E
						ON S.[USERID] = E.EMPLOYEEID
						INNER JOIN [Portal_Import].[dbo].[tbl_account_addressInfo] C
						ON  S.CLIENTID = C.CLIENTID
							WHERE E.ACTIVATION_SOURCE <> 'Web-Consumer'
							AND S.SnapshotDate = @StartDate
							AND [STATE] = @Province
							AND ADDRESS_TYPE =2
							AND ActivationTag = @ActivationTag
							) ;
				END
			IF @Province <> 'QC'
				BEGIN
					SET @OnlineSales = (SELECT COUNT(*) FROM Portal_Import.dbo.TBL_DAILY_SALES S
							INNER JOIN [SCORECARD_DB].[DBO].[EMPLOYEE] E
							ON S.[USERID] = E.EMPLOYEEID
							INNER JOIN [Portal_Import].[dbo].[TBL_ACCOUNT_ADDRESSINFO] C
							ON  S.CLIENTID = C.CLIENTID
								WHERE E.ACTIVATION_SOURCE ='Web-Consumer'
								AND ActivationTag = @ActivationTag
								AND SnapshotDate = @StartDate
								AND [STATE] <> 'QC'
								AND ADDRESS_TYPE =2
								) 
				END
			ELSE
				BEGIN
					SET @OnlineSales = (SELECT COUNT(*) FROM Portal_Import.dbo.TBL_DAILY_SALES S
							INNER JOIN [SCORECARD_DB].[DBO].[EMPLOYEE] E
							ON S.[USERID] = E.EMPLOYEEID
							INNER JOIN [Portal_Import].[dbo].[TBL_ACCOUNT_ADDRESSINFO] C
							ON  S.CLIENTID = C.CLIENTID
								WHERE E.ACTIVATION_SOURCE ='Web-Consumer'
								AND ActivationTag = @ActivationTag
								AND SnapshotDate = @StartDate
								AND [STATE] = @Province
								AND ADDRESS_TYPE =2
								) 
				END
		INSERT INTO #Report
			VALUES(@StartDate,@Province,@ActivationTag,@OnlineSales,@OtherSales)
		SET @i = @i + 1 --step + 1
	END
	SET @StartDate = DATEADD(Day,1,@StartDate)--Day + 1
END	


SELECT * FROM #Report
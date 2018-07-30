USE [Portal_Import]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TBL_DAILY_SALES](
	[CLIENTID] [bigint] NULL,
	[service_id0] [bigint] NULL,
	[userid] [bigint] NULL,
	[product_obj_id0] [bigint] NULL,
	[deal_obj_id0] [bigint] NULL,
	[PLAN_DESCR] [varchar](255) NULL,
	[PLAN_START_DATE] [datetime] NULL,
	[PLAN_END_DATE] [datetime] NULL,
	[ORDER_DATE] [datetime] NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SnapshotDate] [datetime] NULL CONSTRAINT [DF_TBL_DAILY_SALES_SnapshotDate]  DEFAULT (CONVERT([varchar](8),getdate(),(112))),
	[plan_obj_id0] [bigint] NULL,
	[ActivationTag] [varchar](50) NULL,
	[RecordTypeName] [varchar](50) NULL,
 CONSTRAINT [PK_TBL_Daily_Sales_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [Scorecard_DB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Employee](
	[EMPLOYEEID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[NAMELAST] [varchar](50) NULL,
	[NAMEFIRST] [varchar](50) NULL,
	[NAMEMIDDLE] [varchar](50) NULL,
	[NAMESUFFIX] [varchar](5) NULL,
	[USERID] [varchar](50) NULL,
	[PASSWORD] [varchar](20) NULL,
	[EMAILADDRESS] [varchar](80) NULL,
	[DEFAULTLISTSIZE] [decimal](38, 0) NULL,
	[REPORTGROUPS] [varchar](80) NULL,
	[WOLOCATIONS] [varchar](255) NULL,
	[WOORGANIZATIONS] [varchar](255) NULL,
	[ACCESSGROUPS] [varchar](255) NULL,
	[FLAGSALES] [varchar](1) NULL,
	[FLAGADMINISTRATOR] [varchar](1) NULL,
	[FLAGWORKORDERS] [varchar](1) NULL,
	[ORGANIZATIONID] [decimal](38, 0) NULL,
	[TIMEZONE] [decimal](38, 0) NULL,
	[STATUS] [varchar](1) NULL,
	[PHOTOTYPE] [varchar](50) NULL,
	[ACTIVATION_SOURCE] [varchar](50) NULL,
	[RoleDescr] [varchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[LastLoginDate] [datetime] NULL,
	[ReasonCode] [varchar](255) NULL,
	[ReasonDescr] [varchar](255) NULL,
	[LastStatusDate] [datetime] NULL,
	[UserSource] [varchar](50) NULL,
	[UserPartner] [varchar](50) NULL,
	[UserLocation] [varchar](50) NULL,
 CONSTRAINT [PK_Employee_EmployeeID] PRIMARY KEY CLUSTERED 
(
	[EMPLOYEEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [Portal_Import]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TBL_ACCOUNT_ADDRESSINFO](
	[CLIENTID] [bigint] NOT NULL,
	[ADDRESS_TYPE] [int] NOT NULL,
	[FIRST_NAME] [varchar](90) NULL,
	[LAST_NAME] [varchar](90) NULL,
	[ADDRESS] [varchar](255) NULL,
	[CITY] [varchar](90) NULL,
	[COMPANY] [varchar](90) NULL,
	[CONTACT_TYPE] [varchar](255) NULL,
	[COUNTRY] [varchar](60) NULL,
	[EMAIL_ADDR] [varchar](1023) NULL,
	[STATE] [varchar](90) NULL,
	[POSTAL_CODE] [varchar](60) NULL,
	[PHONE] [varchar](75) NULL,
	[SVCNAME] [varchar](500) NULL,
	[SNAPSHOT_DATE] [datetime] NULL,
 CONSTRAINT [PK_TBL_Account_AddressInfo_ClientIDAddress_Type] PRIMARY KEY CLUSTERED 
(
	[CLIENTID] ASC,
	[ADDRESS_TYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




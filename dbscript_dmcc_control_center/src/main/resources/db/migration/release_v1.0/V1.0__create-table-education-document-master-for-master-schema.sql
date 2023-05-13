/****** Object:  Table [Master].[EDUCATION_DOCUMENT_MASTER]    Script Date: 11-05-2023 15:57:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Master].[EDUCATION_DOCUMENT_MASTER](
	[education_document_code] [int] IDENTITY(1,1) NOT NULL,
	[document_name] [varchar](32) NULL,
	[is_active] [bit] NULL,
	[apps_code] [tinyint] NULL,
	[created_datetime] [datetime] NULL,
	[created_by] [smallint] NULL,
	[created_iplocation_id] [int] NULL,
	[modified_datetime] [datetime] NULL,
	[modified_by] [smallint] NULL,
	[modified_iplocation_id] [int] NULL,
	[row_version] [timestamp] NOT NULL,
	[is_delete] [bit] NULL,
 CONSTRAINT [PK_EDUCATION_DOCUMENT_MASTER] PRIMARY KEY CLUSTERED
(
	[education_document_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
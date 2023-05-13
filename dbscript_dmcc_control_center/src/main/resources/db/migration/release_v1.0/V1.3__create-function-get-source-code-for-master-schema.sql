/****** Object:  UserDefinedFunction [Master].[getSourceCode]    Script Date: 11-05-2023 16:04:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
/*************************************************************************
*
* SRKAY CG
* __________________
*
* 2017 - SRKAY CG
* All Rights Reserved.
*
* NOTICE: All information contained herein is, and remains the property of SRKAY CG.
* The intellectual and technical concepts contained herein are proprietary to SRKAY CG.
* Dissemination of this information or reproduction of this material is strictly forbidden unless prior written permission is obtained from SRKAY CG.
*
* FUNCTION 			: Master.getSourceCode
* DESCRIPTION		: NULL
*
** Change History
**************************
** PR   Date        	    Author  			Description
** --   --------   		-------   			------------------------------------
** 1    11-05-2023			Kartik Patel  		adding function getSourceCode for dmcc-control-center
-- =============================================
*******************************/
CREATE   FUNCTION [Master].[getSourceCode]
(
	@SOURCE_TYPE_NAME VARCHAR(64)
)
RETURNS INT
AS
BEGIN
	declare @SOURCE_TYPE_CODE TINYINT = 0
	declare @SOURCE_TYPE_NAME_tmp VARCHAR(64)=@SOURCE_TYPE_NAME
	Select @SOURCE_TYPE_CODE = SOURCE_TYPE_CODE From Master.SOURCE_TYPE_MASTER WITH(NOLOCK) Where SOURCE_TYPE_KEY = @SOURCE_TYPE_NAME_tmp and is_active = 1
	return @SOURCE_TYPE_CODE
	RETURN -1;
END
GO
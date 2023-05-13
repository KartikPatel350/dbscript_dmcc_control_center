/****** Object:  View [Master].[View_User_Master_Details]    Script Date: 11-05-2023 16:20:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************************
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
* VIEW				: [Master].[View_User_Master_Details]
* DESCRIPTION       : NULL
* Remark            : start History from date 11-05-2023
** Change History
**************************
** PR   Date                Author              Description
** --   --------            -------             ------------------------------------
** 1    11-05-2023          Kartik Patel        Add view View_User_Master_Details for dmcc-control-center
-- ====================================================================================================
*******************************************************************************************************/


CREATE   VIEW [Master].[View_User_Master_Details]
AS
SELECT DISTINCT
                         um.user_code, um.is_active, usd.employee_id, usd.joining_date, usd.access_card_number, cm.COMPANY_CODE, cm.COMPANY_NAME, um.location_code, NULL AS location_short_name, cim.CITY_NAME AS location_name, um.is_permission_denied as is_permission_denied,
                         um.department_code, dm.department_short_name, dm.department_name, um.category_code, ucm.CATEGORY_NAME, um.is_control_center_login_allowed, um.is_delete, um.user_loginname, dm.department_key,
                             (SELECT        STRING_AGG(urm.role_name, ',') AS role_name
                               FROM            Master.USER_ROLE_MASTER AS urm WITH (NOLOCK)
							   LEFT OUTER JOIN Master.USER_ROLE_DETAILS AS urd WITH (NOLOCK) ON urd.user_role_code = urm.user_role_code
                               WHERE        (urd.user_code = um.user_code)) AS role_name, um.first_name, um.middle_name, um.last_name, um.dob AS date_of_birth,
                             (SELECT        TOP (1) ISNULL(EMAIL_ADDRESS, '') AS EMAIL_ADDRESS
                               FROM            Sales.EMAILS WITH (NOLOCK)
                               WHERE        (SOURCE_CODE = um.user_code) AND (SOURCE_TYPE_CODE = Master.getSourceCode('solitaire_user_mail')) AND (IS_ACTIVE = 1)) AS office_mail,
                             (SELECT        TOP (1) ISNULL(PHONE_NUMBER, '') AS PHONE_NUMBER
                               FROM            Sales.PHONE WITH (NOLOCK)
                               WHERE        (SOURCE_CODE = um.user_code) AND (SOURCE_TYPE_CODE = Master.getSourceCode('solitaire_user_phone')) AND (IS_ACTIVE = 1)) AS mobile_number, 0 AS is_mobile_verified, um.user_short_name,
                         um.user_fullname, NULL AS punchin_date_time, ISNULL(in_house_access.access_type_value, 0) AS inhouse_pure_system, in_house_access.computer_name AS inhouse_computer_name,
                         in_house_access.ip_address AS inhouse_ip_address, in_house_access.lan_mac_address AS inhouse_lan_mac_address, in_house_access.wifi_mac_address AS inhouse_wifi_mac_address,
                         ISNULL(out_side_access.access_type_value, 0) AS outside_pure_system, out_side_access.computer_name AS outside_computer_name, out_side_access.ip_address AS outside_ip_address,
                         out_side_access.lan_mac_address AS outside_lan_mac_address, out_side_access.wifi_mac_address AS outside_wifi_mac_address, ISNULL(out_side_access.skip_condition, 0) AS outside_skip_condition,
                         ISNULL(pure_mobile.access_type_value, 0) AS mobile_pure_system, pure_mobile.mobile_device_name, pure_mobile.wifi_mac_address AS mobile_wifi_mac_address,
                         custom_notification.access_type_value AS custom_notification, voice_of_srk.access_type_value AS voice_of_srk,
                             (SELECT        code_value
                               FROM            Master.STATIC_VALUE_MASTER AS stm WITH (NOLOCK)
                               WHERE        (um.computer_knowledge_level_code = static_value_code)) AS computer_knowledge, edm.document_name AS education, um.is_verified
FROM            Master.USER_MASTER AS um WITH (NOLOCK) LEFT OUTER JOIN
                         Master.COMPANY_MASTER AS cm WITH (NOLOCK) ON cm.COMPANY_CODE = um.company_code AND cm.IS_ACTIVE = 1 LEFT OUTER JOIN
                         Master.CITY_MASTER AS cim WITH (NOLOCK) ON cim.CITY_CODE = um.location_code AND cim.is_delete = 0 LEFT OUTER JOIN
                         Master.DEPARTMENT_MASTER AS dm WITH (NOLOCK) ON dm.department_code = um.department_code AND dm.is_active = 1 LEFT OUTER JOIN
                         Master.USER_CATEGORY_MASTER AS ucm WITH (NOLOCK) ON ucm.CATEGORY_CODE = um.category_code AND ucm.IS_ACTIVE = 1 LEFT OUTER JOIN
                         Master.USER_SRK_DETAILS AS usd WITH (NOLOCK) ON usd.user_code = um.user_code
						 Outer Apply (
										SELECT  Top 1 user_code, access_type_value, computer_name, ip_address, lan_mac_address, wifi_mac_address
										FROM            Master.USER_DEVICE_DETAILS AS udd WITH (NOLOCK)
										WHERE        (access_type_code = Master.getStaticValueCode('In House Pure Access')) AND (ISNULL(is_delete,0) = 0)
										And udd.user_code = um.user_code
									 ) AS in_house_access
						 Outer Apply (
										SELECT  Top 1 user_code, access_type_value, computer_name, ip_address, lan_mac_address, wifi_mac_address, skip_condition
										FROM Master.USER_DEVICE_DETAILS AS udd WITH (NOLOCK)
										WHERE  (access_type_code = Master.getStaticValueCode('Out Side Pure Access')) AND (ISNULL(is_delete,0) = 0)
										And udd.user_code = um.user_code
									 ) AS out_side_access
						OUTER Apply
									(
										SELECT   Top 1 user_code, access_type_value, mobile_device_name, wifi_mac_address
										FROM Master.USER_DEVICE_DETAILS AS udd WITH (NOLOCK)
										WHERE  (access_type_code = Master.getStaticValueCode('Mobile Pure Access')) AND (ISNULL(is_delete,0) = 0)
									) AS pure_mobile
						OUTER Apply
									(
										SELECT top 1 user_code, access_type_value
										FROM            Master.USER_DEVICE_DETAILS AS udd WITH (NOLOCK)
										WHERE        (access_type_code = Master.getStaticValueCode('Custom Notification')) AND (ISNULL(is_delete,0) = 0)
									) AS custom_notification
						OUTER Apply
									(
										SELECT top 1 user_code, access_type_value
										FROM Master.USER_DEVICE_DETAILS AS udd WITH (NOLOCK)
										WHERE (access_type_code = Master.getStaticValueCode('Voice Of SRK')) AND (ISNULL(is_delete,0) = 0)
									) AS voice_of_srk
						LEFT OUTER JOIN
									(
										SELECT top 1 source_code, MAX(education_document_code) AS education_code
										FROM Master.USER_DOCUMENT_DETAILS AS udoc WITH (NOLOCK)
										WHERE (university_name <> '')
                               GROUP BY source_code) AS education ON education.source_code = um.user_code LEFT OUTER JOIN
                         Master.EDUCATION_DOCUMENT_MASTER AS edm WITH (NOLOCK) ON edm.education_document_code = education.education_code
WHERE        (um.user_code <> 1) and um.is_delete = 0

GO
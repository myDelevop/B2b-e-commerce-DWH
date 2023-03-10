/*
Run the following script in the locahost (or servername) instance in the SQL Server DB.
This allow us to create the databases in SQL Server that will contain our datawarehouse.

Another important think, it should be enable the login with username and password rather
than the Windows authentication in order to create connectors from Visual Studio

Run also DDL in readme2
*/

CREATE DATABASE IM_B2BECOMMERCE;
CREATE DATABASE SA_B2BECOMMERCE;
CREATE DATABASE DM_B2BECOMMERCE;


USE [master]
GO
CREATE LOGIN [b2bUserDWH] WITH PASSWORD=N'b2bUserDWH' MUST_CHANGE, DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=OFF
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [b2bUserDWH]
GO
use [tempdb];
GO
USE [DM_B2BECOMMERCE]
GO
CREATE USER [b2bUserDWH] FOR LOGIN [b2bUserDWH]
GO
use [DM_B2BECOMMERCE];
GO
USE [IM_B2BECOMMERCE]
GO
CREATE USER [b2bUserDWH] FOR LOGIN [b2bUserDWH]
GO
use [IM_B2BECOMMERCE];
GO
USE [master]
GO
CREATE USER [b2bUserDWH] FOR LOGIN [b2bUserDWH]
GO
use [master];
GO
USE [model]
GO
CREATE USER [b2bUserDWH] FOR LOGIN [b2bUserDWH]
GO
use [model];
GO
USE [msdb]
GO
CREATE USER [b2bUserDWH] FOR LOGIN [b2bUserDWH]
GO
use [msdb];
GO
USE [SA_B2BECOMMERCE]
GO
CREATE USER [b2bUserDWH] FOR LOGIN [b2bUserDWH]
GO
use [SA_B2BECOMMERCE];
GO
USE [tempdb]
GO
CREATE USER [b2bUserDWH] FOR LOGIN [b2bUserDWH]
GO

@echo off

rem ** SET THE VALUE FOR THE OFFLINE_CAPTURE_COLUMN_DELIMITER
rem ** echoed through bcp to COLUMN.TXT
set OFFLINE_CAPTURE_COLUMN_DELIMITER="OMwB_Column"

rem ** SET THE VALUE FOR THE OFFLINE_CAPTURE_ROW_DELIMITER
rem ** echoed through bcp to ROW.TXT
set OFFLINE_CAPTURE_ROW_DELIMITER="OMwB_Row"

rem ** SET THE SCRIPT VERSION ENVIRONMENT VARIABLE
set OMWB_SCRIPT_VERSION=105

rem ** SET THE VALUE FOR THE OMWB FILE ENVIRONMENT VARIABLE
set OMWB_SCRIPT_FILE=%3\%3_INFO.TXT

rem ** DISPLAY THE HELP PAGE IF THE USER REQUESTS IT

if "%1"=="-h"   goto help
if "%1"=="help" goto help
if "%1"=="?"    goto help
if "%1"=="-?"   goto help


rem *** DISPLAY THE SCRIPT VERSION IF THE USER REQUESTS IT

if "%1"=="-ver" goto version
if "%1"=="version" goto version

rem *** CHECK THAT THREE PARAMETERS HAVE BEEN ENTERED
rem *** THE PASSWORD CAN BE "", SO WE DON't DO THE SAME CHECK FOR THAT

if "%1"=="" goto input_error
if "%3"=="" goto input_error
if "%4"=="" goto input_error

rem *** START THE EXECUTION OF THE SCRIPT INSTRUCTIONS

goto start

:start

rem ** CREATE THE OUTPUT DIRECTORIES

mkdir master 
mkdir %3     

rem *** CALL THE BCP SCRIPT TO CREATE THE METADATA FILES

call SS2K5_BCP_SCRIPT.BAT %1 %2 %3 %4 %OFFLINE_CAPTURE_COLUMN_DELIMITER% %OFFLINE_CAPTURE_ROW_DELIMITER% 

rem *** CHECK THAT ALL OF THE OUTPUT FILES HAVE BEEN CREATED

goto checkoutput


:help
echo -----------------------------------------------------------------------
echo ---------------------  Oracle Migration Workbench ---------------------
echo ---------------------         Release %OMWB_SCRIPT_VERSION%       ---------------------
echo -----------------------------------------------------------------------
echo ---- This script will generate delimited flat files containing     ---- 
echo ---- schema metadata from the database you wish to migrate. This   ----
echo ---- script will envoke the Bulk Copy Program (BCP) that should be ----
echo ---- part of your SQL Server install base.                         ----
echo ---- Please ensure that your path points to the version of BCP     ----
echo ---- that is installed with the SQL Server from which you wish     ----
echo ---- to migrate. Your current path setting is listed below:        ----
echo ----
PATH
echo ----
echo ----
echo ---- To run this script, enter the following command at the prompt ----
echo ----
echo ---- OMWB_OFFLINE_CAPTURE login_id password database_name server_name
echo ---- where,
echo ---- dba_login_id is a login id which has been granted db_datareader 
echo ---- and view definition on database_name
echo ---- password is the password for the login id
echo ---- database_name is the name of the database you wish to capture
echo ---- server_name is the name of the server on which the database resides
echo ---- For example,
echo ----      OMWB_OFFLINE_CAPTURE sa sapwd employeeDB DEPT1_SERVER
echo ---- 
echo -----------------------------------------------------------------------
goto exit

:input_error
echo ---- ** Error executing the script
echo ----
echo ---- To run this script, enter the following command at the prompt ----
echo ----
echo ---- OMWB_OFFLINE_CAPTURE login_id password database_name server_name
echo ---- where,
echo ---- login_id is a login id which has been granted db_datareader 
echo ---- and view definition on database_name
echo ---- password is the password for the login id
echo ---- database_name is the name of the database you wish to capture
echo ---- server_name is the name of the server on which the database resides
echo ---- For example,
echo ----      OMWB_OFFLINE_CAPTURE sa sapwd employeeDB DEPT1_SERVER
echo ---- 
echo -----------------------------------------------------------------------
goto exit


:version
echo -----------------------------------------------------------------------
echo ---- This is the Oracle Migration Workbench offline capture script
echo ---- version %OMWB_SCRIPT_VERSION% for Microsoft SQL Server 2000
echo -----------------------------------------------------------------------
goto exit

:omwbfile
echo OMWB REPORT FOR %3                            >  %OMWB_SCRIPT_FILE%
echo ____________________________________________  >> %OMWB_SCRIPT_FILE%
echo * SCRIPT EXECUTION DATE AND TIME:             >> %OMWB_SCRIPT_FILE%
date /t                                            >> %OMWB_SCRIPT_FILE%
time /t                                            >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo SYSTEM PROPERTIES                             >> %OMWB_SCRIPT_FILE%
echo _______________________                       >> %OMWB_SCRIPT_FILE%
echo * PLATFORM VERSION:                           >> %OMWB_SCRIPT_FILE% 
ver                                                >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo * PLATFORM CODEPAGE:                          >> %OMWB_SCRIPT_FILE%
mode con codepage /sta                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo SOURCE DATABASE SERVER PROPERTIES             >> %OMWB_SCRIPT_FILE%
echo __________________________________            >> %OMWB_SCRIPT_FILE%
echo * BCP VERSION:                                >> %OMWB_SCRIPT_FILE%
bcp -v                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo * DATABSE SERVER COLLATION AND VERSION:       >> %OMWB_SCRIPT_FILE%
osql -U%1 -P%2 -S%4 -i%3  -i properties.sql        >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo DIRECTORY LISTING for %3                      >> %OMWB_SCRIPT_FILE%
echo __________________________________            >> %OMWB_SCRIPT_FILE%
dir %3                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo DIRECTORY LISTING FOR MASTER                  >> %OMWB_SCRIPT_FILE%
echo _______________________________               >> %OMWB_SCRIPT_FILE%
dir master                                         >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo ATTRIBUTES OF SCRIPT:                         >> %OMWB_SCRIPT_FILE%
echo _______________________                       >> %OMWB_SCRIPT_FILE%
attrib OMWB_OFFLINE_CAPTURE.bat                    >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo CONTENTS OF EXECUTED SCRIPT                   >> %OMWB_SCRIPT_FILE%
echo ____________________________________          >> %OMWB_SCRIPT_FILE%
type OMWB_OFFLINE_CAPTURE.BAT                      >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo CONTENTS OF BCP SCRIPT                        >> %OMWB_SCRIPT_FILE%
echo ____________________________________          >> %OMWB_SCRIPT_FILE%
type SS2K5_BCP_SCRIPT.BAT                           >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%
echo -                                             >> %OMWB_SCRIPT_FILE%

echo ** END REPORT FOR %3                          >> %OMWB_SCRIPT_FILE%

rem *** DISPLAY THE FINAL INSTRUCTIONS TO THE USER
goto finalinstructions


:checkoutput

rem *** CHECK THAT ALL DATABASE META FILES HAVE BEEN CREATED
if not exist %3\SS2K5_SCHEMATA.dat          echo ** ERROR %3\SS2K5_SCHEMATA.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_TABLE_PRIVILEGES.dat  echo ** ERROR %3\SS2K5_TABLE_PRIVILEGES.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_CHECK_CONSTRAINTS.dat echo ** ERROR %3\SS2K5_CHECK_CONSTRAINTS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_COLUMNS.dat          echo ** ERROR %3\SS2K5_COLUMNS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_DATABASE_PRINCIPALS.dat echo ** ERROR %3\SS2K5_DATABASE_PRINCIPALS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_DATABASE_ROLE_MEMBERS.dat echo ** ERROR %3\SS2K5_DATABASE_ROLE_MEMBERS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_FOREIGN_KEY_COLUMNS.dat echo ** ERROR %3\SS2K5_FOREIGN_KEY_COLUMNS.dat.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_FOREIGN_KEYS.dat      echo ** ERROR %3\SS2K5_FOREIGN_KEYS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_IDENTITY_COLUMNS.dat  echo ** ERROR %3\SS2K5_IDENTITY_COLUMNS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_INDEX_COLUMNS.dat     echo ** ERROR %3\SS2K5_INDEX_COLUMNS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_INDEXES.dat           echo ** ERROR %3\SS2K5_INDEXES.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_OBJECTS.dat           echo ** ERROR %3\SS2K5_OBJECTS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_SCHEMAS.dat           echo ** ERROR %3\SS2K5_SCHEMAS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_SERVER_PRINCIPALS.dat echo ** ERROR %3\SS2K5_SERVER_PRINCIPALS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_SQL_MODULES.dat       echo ** ERROR %3\SS2K5_SQL_MODULES.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_DEFAULT_CONSTRAINTS.dat       echo ** ERROR %3\SS2K5_DEFAULT_CONSTRAINTS.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_TABLES.dat            echo ** ERROR %3\SS2K5_TABLES.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.
if not exist %3\SS2K5_TYPES.dat             echo ** ERROR %3\SS2K5_TYPES.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.

rem *** CHECK THAT ALL MASTER META FILES HAVE BEEN CREATED
if not exist master\SS2K5_DATABASES.dat      echo ** ERROR master\SS2K5_DATABASES.dat has not been created. Please check the screen output and .err files to detect the problem. Execute the script again when the problem is fixed or contact your Oracle representative if the problem persists.


rem ** UPDATE THE OMWB FILE - THIS HOLDS SCRIPT AND PERTINENT SOURCE DATABASE SERVER INFO

goto omwbfile


:finalinstructions
echo **************************************************************************
echo ** The offline capture script has completed execution.                                    
echo ** Please review the screen output and .err files (if any) in the output       
echo ** directories for any irregularities. You may need to execute the             
echo ** script again to resolve any irregularities.                                 
echo **                                                                              
echo ** Finally, please archive the directory containing the sqlserver2005.ocp file.
echo ** This contains master and %3 directories (preserve the         
echo ** directory structure in the archive) the ROW.TXT, the COLUMN.TXT, and the 
echo ** sqlserver2005.ocp file. Return the archive file to          
echo ** your Oracle representative.                                                   
echo **************************************************************************
goto exit

:exit
rem ** REMOVE THE SCRIPT VERSION ENVIRONMENT VARIABLE
set OMWB_SCRIPT_VERSION=
rem ** REMOVE THE VALUE FOR THE OMWB FILE ENVIRONMENT VARIABLE
set OMWB_SCRIPT_FILE=
rem ** REMOVE THE VALUE FOR THE END OF ROW DELIMITER ENVIRONMENT VARIABLE
set OFFLINE_CAPTURE_ROW_DELIMITER=
rem ** REMOVE THE VALUE FOR THE END OF COLUMN ENVIRONMENT VARIABLE
set OFFLINE_CAPTURE_COLUMN_DELIMITER=

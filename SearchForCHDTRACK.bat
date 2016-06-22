@ECHO OFF

ECHO [+] Original Author: Travis Lee
ECHO [+] Modified by: Kelvin Medina
ECHO [+] Last Update v 1.0, 06-21-2016
REM
REM Description: Script to search an existing memory dump with grep for 
REM		 credit card track 1 and 2 data, track 1 only, track 2 only data, and PAN.
REM
REM Usage: SearchForCC.bat <memory dump file> <output file>
REM
REM Example: SearchForCC.bat memory.dmp results.txt
REM Ver 1.0, forked from Travis L., now able to search PAN from VISA, MasterCard, and AMEX.

SET memdmp=%1
SET resultfile=%2
SET value=%3

IF "%memdmp%"=="" GOTO error
IF "%resultfile%"=="" GOTO error
IF NOT EXIST grep.exe GOTO error

REM Search with grep
:search
IF NOT EXIST %memdmp% GOTO error

ECHO.
ECHO Input file: %memdmp%
ECHO Output file: %resultfile%

ECHO.
ECHO [+] Searching for Track 1 and 2 strings. Please wait...
echo Track 1 and 2 strings: > %resultfile%
grep.exe -aoE "(((%%?[Bb`]?)[0-9]{13,19}\^[A-Za-z\s]{0,26}\/[A-Za-z\s]{0,26}\^(1[2-9]|2[0-9])(0[1-9]|1[0-2])[0-9\s]{3,50}\?)[;\s]{1,3}([0-9]{13,19}=(1[2-9]|2[0-9])(0[1-9]|1[0-2])[0-9]{3,50}\?))" %memdmp% >> %resultfile%

ECHO.
ECHO [+] Searching for Track 1 strings only. Please wait...
echo. >> %resultfile%
echo Track 1 strings: >> %resultfile%
grep.exe -aoE "((%%?[Bb`]?)[0-9]{13,19}\^[A-Za-z\s]{0,26}\/[A-Za-z\s]{0,26}\^(1[2-9]|2[0-9])(0[1-9]|1[0-2])[0-9\s]{3,50}\?)" %memdmp% >> %resultfile%

ECHO.
ECHO [+] Searching for Track 2 strings only. Please wait...
echo. >> %resultfile%
echo Track 2 strings: >> %resultfile%
grep.exe -aoE "([0-9]{13,19}=(1[2-9]|2[0-9])(0[1-9]|1[0-2])[0-9]{3,50}\?)" %memdmp% >> %resultfile%

ECHO.
ECHO [+] Searching for PAN only VISA, MasterCard, and AMEX. Please wait...

echo. >> %resultfile%
echo PAN string (VISA): >> %resultfile%
grep.exe -aoE "(4[0-9]{15})" %memdmp% >> %resultfile%

echo. >> %resultfile%
echo PAN string (MasterCard): >> %resultfile%
grep.exe -aoE "(5[1-5][0-9]{14})" %memdmp% >> %resultfile%

echo. >> %resultfile%
echo PAN string (American Express): >> %resultfile%
grep.exe -aoE "(3[47]{1}[0-9]{13})" %memdmp% >> %resultfile%

:done
ECHO.
ECHO [+] Search completed! Results have been stored in: %resultfile%
GOTO end

:error
ECHO.
ECHO [-] An error has occured! Ensure all files exist.
ECHO [-] Usage: SearchForCC.bat ^<memory dump file^> ^<output file^>
ECHO.

:end
